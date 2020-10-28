Tx={

}

Tx.DrawTx=function(x,y,Tx)
	if(Tx~=nil)
		love.graphics.draw( Tx, x, y )
	end
end

Tx.LoadTx=function(filepath)
	if(not exist(filepath))
		return nil
	end
	return love.graphics.newImage(filepath)
end

Tx.TextureFolder=love.filesystem.getSourceBaseDirectory().."/Skins"