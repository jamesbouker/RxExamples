platform :ios, '10.0'
inhibit_all_warnings!

target 'RxExamples' do
  use_frameworks!
  pod 'RxSwift', '~> 4.1'
  pod 'RxCocoa', '~> 4.1'
  pod 'RxFeedback', '~> 1.0'

  target 'RxExamplesTests' do
    inherit! :search_paths
	pod 'RxBlocking', '~> 4.0'
	pod 'RxTest',     '~> 4.0'
  end
end
