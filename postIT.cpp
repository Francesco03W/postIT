#include <iostream>

#include "imgui.h"
#include "imgui_impl_sdl2.h"
#include "imgui_impl_sdlrenderer2.h"

#include "SDL.h"
#include "SDL_events.h"
#include "SDL_error.h"
#include "SDL_render.h"


int main()
{
	std::cout<<"COMPILA! Console per debug\n";

	// ----SDL INIT----

	if(SDL_Init(SDL_INIT_VIDEO | SDL_INIT_EVENTS)==1)
	{
		std::cout << "Errore" << SDL_GetError();
		return -1;
	}

	SDL_WindowFlags winFlags= (SDL_WindowFlags)(SDL_WINDOW_RESIZABLE);
	//struct representing the window properties
	SDL_Window* sdl_win=SDL_CreateWindow("TEST",SDL_WINDOWPOS_CENTERED,SDL_WINDOWPOS_CENTERED,800,600,winFlags);
	if(sdl_win==NULL)
	{
		std::cout << "Errore creazione finestra\n" << SDL_GetError();
		return -1;
	}

	//struct representing the rendering state
	SDL_Renderer* sdl_win_renderer=SDL_CreateRenderer(sdl_win,-1,SDL_RENDERER_PRESENTVSYNC | SDL_RENDERER_ACCELERATED);
	if(sdl_win_renderer==NULL)
	{
		std::cout << "Errore creazione renderer\n" << SDL_GetError();
		return -1;
	}


	IMGUI_CHECKVERSION();
	//structure containing all contextual information, like a container of all elements
	ImGuiContext* win_context= ImGui::CreateContext();
	ImGuiIO& io = ImGui::GetIO(); (void)io;
    io.ConfigFlags |= ImGuiConfigFlags_NavEnableKeyboard;     // Enable Keyboard Controls

	ImGui::StyleColorsDark();

	//init of ImGui backends
	if(ImGui_ImplSDL2_InitForSDLRenderer(sdl_win,sdl_win_renderer)==false)
	{
		std::cout << "Errore Inizializzazione platform SDL2\n" << SDL_GetError();
		return -1;
	}
	if(ImGui_ImplSDLRenderer2_Init(sdl_win_renderer)==false)
	{
		std::cout << "Errore inizializzazione renderer SDL2\n" << SDL_GetError();
		return -1;
	}

	std::cout << "inizio ciclo finestra\n";
	ImVec4 clear_color = ImVec4(0.45f, 0.55f, 0.60f, 1.00f);
	int quit=false;
	while(quit==false)
	{
		//check if some event is pending,
		// if SDL_Event is NULL, then 1 is returned if there's an event in queue (not removed from it)
		// otherwise, SDL_Event is NOT NULL, then 1 is returned, the first event in queue is fetched to the
		// 	SDL_Event struct and removed from queue.
		SDL_Event event;
		while(SDL_PollEvent(&event)) //poll until the event queue is empty
		{
			ImGui_ImplSDL2_ProcessEvent(&event);
			//manage event
			switch(event.type)
			{
				case SDL_MOUSEBUTTONDOWN:
					//test
					quit=true;
				case SDL_QUIT:
					quit=true;
			}

		}
	
		// new frame generation
		ImGui_ImplSDL2_NewFrame();
		ImGui_ImplSDLRenderer2_NewFrame();
		ImGui::NewFrame();
		ImGui::ShowDemoWindow();
		

		ImGui::Render();
		SDL_RenderSetScale(sdl_win_renderer, io.DisplayFramebufferScale.x, io.DisplayFramebufferScale.y);
        SDL_SetRenderDrawColor(sdl_win_renderer, (Uint8)(clear_color.x * 255), (Uint8)(clear_color.y * 255), (Uint8)(clear_color.z * 255), (Uint8)(clear_color.w * 255));
        SDL_RenderClear(sdl_win_renderer);
        ImGui_ImplSDLRenderer2_RenderDrawData(ImGui::GetDrawData());
        SDL_RenderPresent(sdl_win_renderer);

	}
	std::cout << "Chiusura finestra\n";
	ImGui_ImplSDLRenderer2_Shutdown();
	ImGui_ImplSDL2_Shutdown();
	ImGui::DestroyContext(win_context);

	SDL_DestroyWindow(sdl_win);
	SDL_DestroyRenderer(sdl_win_renderer);
	SDL_Quit();

	return 0;
}
