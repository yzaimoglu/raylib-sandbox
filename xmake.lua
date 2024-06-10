add_rules("mode.debug")

add_requires("raylib master", {system = false})
set_defaultmode("debug")

set_policy("build.warning", true)
set_warnings("all", "extra", "pedantic")

target("raylib-sandbox")
    set_kind("binary")
    add_files("src/*.c")
    add_packages("raylib")
    set_languages("c99")
    --    add_cflags("-fanalyzer")

    after_build(function (target)
        print("Copying assets folder where build is...")
        os.cp("$(projectdir)/src/assets/*", "$(buildir)/$(plat)/$(arch)/$(mode)/assets/")
        -- Run the binary after building
        print("Running the binary...")
        os.execv(path.join(target:targetdir(), target:basename()))
    end)
