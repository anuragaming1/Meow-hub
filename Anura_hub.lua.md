loadstring(game:HttpGet(("https://raw.githubusercontent.com/daucobonhi/Ui-Redz-V2/refs/heads/main/UiREDzV2.lua")))()

       local Window = MakeWindow({
                 Hub = {
                             Title = "ANURA HUB 1.0",
                                      Animation = "2001"
                 },
                         Key = {
                                    KeySystem = true,
                                            Title = "Hệ thống key",
                                                    Description = "https://www.youtube.com/@Anura-gaming-real",
                                                            KeyLink = "https://pastefy.app/IbEcXNl6",
                                                                    Keys = {"1234"},
                                                                            Notifi = {
                                                                                        Notifications = true,
                                                                                                CorrectKey = "Script đang load...đợi",
                                                                                                       Incorrectkey = "sai key rồi kìa",
                                                                                                              CopyKeyLink = "Đã copy key"
                                                                            }
                         }
       })

              MinimizeButton({
                       Image = "rbxassetid://14190262721",
                              Size = {60, 60},
                                     Color = Color3.fromRGB(10, 10, 10),
                                            Corner = true,
                                                   Stroke = false,
                                                          StrokeColor = Color3.fromRGB(255, 0, 0)
              })
                    
                    ------ Tab
                         local Tab1o = MakeTab({Name = "trung tâm"})
                              local Tab2o = MakeTab({Name = "a"})
                                   local Tab3o = MakeTab({Name = "a"})
                                        
                                             
                                             -------TOGGLE 

                                                  Toggle = AddToggle(Tab1o, {
                                                          Name = "Cute vl",
                                                                Default = false,
                                                                      Callback = function()
                                                                           end
                                                  })
                                                      
                                                      ------- BUTTON
                                                          
                                                              AddButton(Tab1o, {
                                                                     Name = "ANURA FIX LAG",
                                                                         Callback = function()
                                                                               loadstring(game:HttpGet("https://raw.githubusercontent.com/TurboLite/Script/main/FixLag.lua"))()
                                                                                 end
                                                              })
                                                                   AddButton(Tab1o, {
                                                                         Name = "no name",
                                                                             Callback = function()
                                                                                   loadstring(game:HttpGet("https://raw.githubusercontent.com/AZYsGithub/chillz-workshop/main/Arceus%20X%20V3"))()
                                                                                     end
                                                                   })   AddButton(Tab1o, {
                                                                         Name = "2",
                                                                             Callback = function()
                                                                                   loadstring(game:HttpGet("https://raw.githubusercontent.com/TurboLite/Script/main/FixLag.lua"))()
                                                                                     end
                                                                   })   AddButton(Tab1o, {
                                                                         Name = "3",
                                                                             Callback = function()
                                                                                   loadstring(game:HttpGet("https://raw.githubusercontent.com/TurboLite/Script/main/FixLag.lua"))()
                                                                                     end
                                                                   })   AddButton(Tab1o, {
                                                                         Name = "4",
                                                                             Callback = function()
                                                                                   loadstring(game:HttpGet("https://raw.githubusercontent.com/TurboLite/Script/main/FixLag.lua"))()
                                                                                     end
                                                                   })   AddButton(Tab1o, {
                                                                         Name = "FIX LAG",
                                                                             Callback = function()
                                                                                   loadstring(game:HttpGet("https://raw.githubusercontent.com/TurboLite/Script/main/FixLag.lua"))()
                                                                                     end
                                                                   })
                                                                   ----- Dropdown 

                                                                     Dropdown = AddDropdown(Tab1o, {
                                                                             Name = "token",
                                                                                  Options = {"Test 1", "Test 2", "Test 3", "Test 4"},
                                                                                       Default = "Melee",
                                                                                            Callback = function()
                                                                                                 end
                                                                     })

                                                                     ----- Section 
                                                                        
                                                                           Section = AddSection(Tab1o, {"a"})          

                                                                           ----- Paragraph 
                                                                                               
                                                                                                  Paragraph = AddParagraph(Farm, {"a", ""})

                                                                                                  
                                                                     })
                                                                   })
                                                                   })
                                                                   })
                                                                   })
                                                                   })
                                                              })
                                                  })
              })
                                                                            }
                         }
                 }
       })
