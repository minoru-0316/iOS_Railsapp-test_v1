
module Api
    module V1
        class PostsController < ApplicationController

          # before_action :authenticate_user!

            def index
                @post = Post.all.search(params[:search])
                # 日付のフォーマットを変更する一連の処理
                  # 1:投稿を格納する配列を用意する
                  response_data = []
                  # 2:日付のフォーマットを作成し、eachで廻す
                  @post.each do |data|
      
                    # 3:1の配列に入れる各カラムのデータを指定し、日付のフォーマットを指定
                    _data = {
                      id: data[:id],
                      title: data[:title],
                      memo: data[:memo],
                      user_id: data[:user_id],
                      created_at: data[:created_at].strftime("%Y年%-m月%-d日 %H:%M:%S"),
                      updated_at: data[:updated_at].strftime("%Y年%-m月%-d日 %H:%M:%S")
                    }
                   response_data.push(_data)
                  end
                    # 4:dataの内容を　＠postから respose_dataに修正する。
                render json: { status: 'SUCCESS', message: 'Loaded posts', data: response_data }
              end
        
              def show
                render json: { status: 'SUCCESS', message: 'Loaded the post', data: @post }
              end
      
              def create
                @post = Post.new(post_params)
                if @post.save
                  render json: { status: 'SUCCESS', data: @post }
                else
                  render json: { status: 'ERROR', data: @post.errors }
                end
              end
        
              def destroy
                @post.destroy
                render json: { status: 'SUCCESS', message: 'Deleted the post', data: @post }
              end
        
              def update
                if @post.update(post_params)
                  render json: { status: 'SUCCESS', message: 'Updated the post', data: @post }
                else
                  render json: { status: 'SUCCESS', message: 'Not updated', data: @post.errors }
                end
              end
        
              private
        
              def set_post
                @post = Post.find(params[:id])
              end
        
              def post_params
                params.require(:post).permit(:title,:memo,:user_id)
              end
            end
          end
        end
