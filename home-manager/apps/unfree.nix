{ pkgs, ... }:

{
	home.packages = with pkgs; [

		discord
		slack
   	google-chrome
		meld
		insync
		zoom-us
		
	];
}
