package api

import (
	"fmt"

	"github.com/aceld/zinx/ziface"
	"github.com/aceld/zinx/zinx_app_demo/mmo_game/core"
	"github.com/aceld/zinx/zinx_app_demo/mmo_game/pb"
	"github.com/aceld/zinx/znet"
	"github.com/golang/protobuf/proto"
)

//世界聊天 路由业务
type WorldChatApi struct {
	znet.BaseRouter
}

func (*WorldChatApi) Handle(request ziface.IRequest) {
	fmt.Println("1. 将客户端传来的proto协议解码")
	msg := &pb.Talk{}
	fmt.Println("world chat: ", msg)
	err := proto.Unmarshal(request.GetData(), msg)
	if err != nil {
		fmt.Println("Talk Unmarshal error ", err)
		return
	}

	fmt.Println("2. 得知当前的消息是从哪个玩家传递来的,从连接属性Pid中获取")
	Pid, err := request.GetConnection().GetProperty("pid")
	if err != nil {
		fmt.Println("GetProperty Pid error", err)
		request.GetConnection().Stop()
		return
	}
	fmt.Println("3. 根据Pid得到player对象")
	player := core.WorldMgrObj.GetPlayerByPid(Pid.(int32))

	fmt.Println("4. 让player对象发起聊天广播请求")
	player.Talk(msg.Content)
}
