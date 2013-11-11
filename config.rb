# Require any additional compass plugins here.

# Set this to the root of your project when deployed:
http_path = "/"
css_dir = "stylesheets"
sass_dir = "sass"
images_dir = "images_sprite"
javascripts_dir = "javascripts"

# You can select your preferred output style here (can be overridden via the command line):
# output_style = :expanded or :nested or :compact or :compressed

# To enable relative paths to assets via compass helper functions. Uncomment:
# relative_assets = true

# To disable debugging comments that display the original location of your selectors. Uncomment:
# line_comments = false


# If you prefer the indented syntax, you might want to regenerate this
# project again passing --syntax sass, or you can uncomment this:
# preferred_syntax = :sass
# and then run:
# sass-convert -R --from scss --to sass sass scss && rm -rf sass && mv scss sass

sprites = Array.new

# スプライト画像が保存された直後のコールバック
on_sprite_saved do |filename|
    sprites << filename
end

on_stylesheet_saved do |filename|
    #スプライト画像のファイル末に付くランダムな文字列を削除する
    for sprite in sprites do
        if File.exists?(sprite)
            FileUtils.cp sprite, sprite.gsub(%r{-s[a-z0-9]{10}\.png$}, '.png')
            FileUtils.rm_rf(sprite)
        end
    end

    # スタイルシート内のスプライト画像のファイル末に付くランダムな文字列を削除する
    if File.exists?(filename)
        css = File.read(filename, :encoding => Encoding::UTF_8)
        File.open(filename, 'w+:utf-8') do |f|
            f << css.gsub(/@charset.*;\n/, '').gsub(%r{-s[a-z0-9]{10}\.png}, '.png')
        end
    end
end
