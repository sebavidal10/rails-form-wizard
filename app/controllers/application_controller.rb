class ApplicationController < ActionController::Base

  #
  # Wrapper para llamar directo un cell desde el controlador
  #
  # @param [String|Symbo] cell_name El nombre del cell. Puede estar con namespace: "namespace/cell"
  # @param [<Type>] model El modelo a utilizar en el cell. Puede ser nil si el cell lo soporta
  # @param [String|Symbol] action La acción a ejecutar. Por default es :show
  # @param [Hash] **args Otros parametros a pasar a #cell
  # @yield [Object] Bloque a pasar a cell. Opcional
  #
  def render_cell cell_name, model, action: :show, **args, &block
    layout = args.key?(:layout) ? args[:layout] : true
    args.except! :layout
    the_cell = cell(cell_name, model, **args, &block)
    @html_head_title = the_cell.try :title
    html_content = the_cell.send(action)
    render html: html_content, layout: layout
  end

  # debe seguir el formato de [cells-rails]/lib/cell/rails.rb
  # Modificado para pasar automaticamente parametros y tratar de no usar
  # parent_controller: es dificil de testear
  def cell(name, model = nil, options = {}, constant = ::Cell::ViewModel, &block)
    options[:context] ||= {}
    # options[:context][:current_user] ||= current_user
    # options[:context][:current_ability] ||= current_ability
    super(name, model, options, constant, &block)
  end

end
