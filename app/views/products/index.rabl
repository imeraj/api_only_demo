cache "products_index", expires_in: 1.minute
object false
child(:meta) {
  child(:pagination) {
    node(:per_page) { @per_page }
    node(:total_pages) { @products.total_pages }
    node(:total_objects) { @products.total_count }
  }
}

# collection @products => :products, object_root: false
child @products => :products do
  extends "products/show"
end
