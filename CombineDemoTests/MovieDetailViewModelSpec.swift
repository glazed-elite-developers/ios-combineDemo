//
//  MovieListViewModelSpec.swift
//  CombineDemoTests
//
//  Created by João Barbosa on 30/09/2020.
//  Copyright © 2020 Glazed Solutions. All rights reserved.
//

import Nimble
import Quick
import Combine
import CombineDemo

@testable import CombineDemo

final class MovieDetailViewModelSpec: QuickSpec {

    override func spec() {

        var sceneFactory: SceneFactory!
        var appContext: AppContext!
        var moviesModel: MoviesAPIModel!
        var router: MovieDetailRouter!
        var mockMovie: Movie!
        var cancellables: [AnyCancellable] = []

        beforeEach {
            appContext = AppContext.mock()
            sceneFactory = CombineDemoSceneFactory(context: appContext)
            router = MovieDetailRouter(appRouter: appContext.appRouter,
                                     sceneFactory: sceneFactory)
            let mockAPI = MockMoviesAPIModel()
            mockMovie = mockAPI.movieArray.first!
            moviesModel = mockAPI
        }

        describe("Movie Detail View Model") {
            it("Should update the state properly") {
                let viewModel = MovieDetailViewModel(router: router, moviesAPI: moviesModel, movieId: 1)
                let expectedState = MovieDetailViewModel.State.results(MovieViewData.mapMovieToMovieViewData(movie: mockMovie))

                let loadMovie = PassthroughSubject<Int, APIError>()
                viewModel.bindPublisher(loadMovie: loadMovie.eraseToAnyPublisher())

                loadMovie.send(1)

                viewModel.$state.sink { state in
                    expect(state).to(equal(expectedState))
                }.store(in: &cancellables)
            }
        }
    }
}
