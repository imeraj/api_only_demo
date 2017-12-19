cache "users_index", expires_in: 1.minute
object false
collection @users => :users
extends "users/show"
