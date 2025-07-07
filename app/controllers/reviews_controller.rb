require 'json'
require_relative '../../config/database'

class ReviewsController
  def delete(params, current_user)
    id = params['id']

    return [400, { error: 'ID requerido' }.to_json] if id.nil?

    review = DB[:reviews][id: id.to_i]

    return [404, { error: 'Comentario no encontrado' }.to_json] unless review

    # Verificación de propiedad (opcional si quieres que solo el autor lo borre)
    if review[:email] != current_user['email'] && !current_user['roles'].include?('admin')
      return [403, { error: 'No autorizado para eliminar esta reseña' }.to_json]
    end

    DB[:reviews].where(id: id.to_i).delete
    [200, { message: 'Comentario eliminado' }.to_json]
  end
end
