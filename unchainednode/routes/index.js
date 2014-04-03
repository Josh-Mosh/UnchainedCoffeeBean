module.exports = function Route(app){

 app.io.route('new_favorite', function(req){
 	var message = "New Favorite Added";
 	app.io.broadcast('updated_favorite', req.data)
 })
}
