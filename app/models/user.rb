class User < ApplicationRecord
	has_many :goals, dependent: :destroy

	validates :user_id, :uniqueness => {message: "이미 존재하는 아이디입니다"}
	validates :nick, :presence => true, :length => {:in => 2..15, message: "이름은 15자리 이하로 작성해주세요"}
	validates :password, :confirmation => {message: "비밀번호가 일치하지 않습니다"}
end
