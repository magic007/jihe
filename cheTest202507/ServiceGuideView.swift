import SwiftUI

struct GuideSection: View {
    let title: String
    let content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .padding(.bottom, 4)
            Text(content)
                .font(.system(size: 15))
                .foregroundColor(.black.opacity(0.8))
                .lineSpacing(6)
            Divider()
                .padding(.vertical, 12)
        }
    }
}

struct ServiceGuideView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // 顶部导航栏
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 20) {
                    // 标题
                    Text("会飞的小猪APP服务指南")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.bottom, 8)
                    
                    // 开场白
                    Text("亲爱的车主：\n\n欢迎使用会飞的小猪APP！为了让您更好地了解和使用我们的服务，我们为您准备了详细的服务指南。")
                        .font(.system(size: 15))
                        .foregroundColor(.black.opacity(0.8))
                        .lineSpacing(6)
                        .padding(.bottom, 20)
                    
                    // 基础服务
                    VStack(alignment: .leading, spacing: 16) {
                        Text("一、基础服务")
                            .font(.system(size: 18, weight: .bold))
                        
                        serviceItem(
                            title: "1. 车辆绑定",
                            description: "• 支持多车辆绑定管理\n• 自动识别车辆型号\n• 提供详细的车辆信息展示\n• 实时状态监控"
                        )
                        
                        serviceItem(
                            title: "2. 智能诊断",
                            description: "• 实时故障检测\n• 智能故障分析\n• 维修建议推送\n• 历史记录查询"
                        )
                        
                        serviceItem(
                            title: "3. 保养提醒",
                            description: "• 智能保养周期提醒\n• 自定义保养计划\n• 保养项目推荐\n• 保养记录管理"
                        )
                    }
                    Divider()
                        .padding(.vertical, 12)
                    
                    // 增值服务
                    VStack(alignment: .leading, spacing: 16) {
                        Text("二、增值服务")
                            .font(.system(size: 18, weight: .bold))
                        
                        serviceItem(
                            title: "1. 专业保险",
                            description: "• 多家保险公司对比\n• 专属优惠方案\n• 一键投保服务\n• 理赔协助支持"
                        )
                        
                        serviceItem(
                            title: "2. 紧急救援",
                            description: "• 24小时救援服务\n• 全国救援网络\n• 实时位置定位\n• 专业技师支持"
                        )
                        
                        serviceItem(
                            title: "3. 预约服务",
                            description: "• 在线预约保养\n• 上门取送车\n• 快速保养通道\n• 服务进度跟踪"
                        )
                    }
                    Divider()
                        .padding(.vertical, 12)
                    
                    // 社交功能
                    VStack(alignment: .leading, spacing: 16) {
                        Text("三、社交功能")
                            .font(.system(size: 18, weight: .bold))
                        
                        serviceItem(
                            title: "1. 车友圈",
                            description: "• 分享骑行体验\n• 互动点赞评论\n• 精选内容推荐\n• 话题活动参与"
                        )
                        
                        serviceItem(
                            title: "2. 车友活动",
                            description: "• 线下聚会活动\n• 骑行路线推荐\n• 技术交流分享\n• 专属福利抽奖"
                        )
                    }
                    Divider()
                        .padding(.vertical, 12)
                    
                    // 会员权益
                    VStack(alignment: .leading, spacing: 16) {
                        Text("四、会员权益")
                            .font(.system(size: 18, weight: .bold))
                        
                        serviceItem(
                            title: "1. 积分奖励",
                            description: "• 签到得积分\n• 活动加倍奖励\n• 积分商城兑换\n• 会员等级提升"
                        )
                        
                        serviceItem(
                            title: "2. 专属优惠",
                            description: "• 配件购买折扣\n• 保养套餐优惠\n• 节日专属福利\n• VIP专属客服"
                        )
                    }
                    
                    // 使用提示
                    VStack(alignment: .leading, spacing: 16) {
                        Text("温馨提示")
                            .font(.system(size: 16, weight: .bold))
                            .padding(.top, 20)
                        
                        bulletPoint("所有服务请在APP内进行预约和支付，避免线下私自交易。")
                        bulletPoint("紧急救援服务请保持电话畅通，以便救援人员与您联系。")
                        bulletPoint("参与社区互动请遵守社区规范，共同维护良好的交流环境。")
                        bulletPoint("如遇到问题请及时联系在线客服或拨打服务热线：400-888-8888")
                    }
                    
                    // 结束语
                    VStack(alignment: .leading, spacing: 16) {
                        Text("我们期待为您提供更好的服务！")
                            .font(.system(size: 16, weight: .bold))
                            .padding(.top, 20)
                        
                        Text("如需了解更多服务详情，请点击各服务板块的\"详情\"按钮查看具体介绍。")
                            .font(.system(size: 15))
                            .foregroundColor(.black.opacity(0.8))
                        
                        Text("会飞的小猪APP团队")
                            .font(.system(size: 15, weight: .medium))
                            .padding(.top, 8)
                            .padding(.bottom, 20)
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color(UIColor.systemGray6))
        .navigationBarHidden(true)
    }
    
    private func serviceItem(title: String, description: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
            Text(description)
                .font(.system(size: 15))
                .foregroundColor(.black.opacity(0.7))
                .lineSpacing(6)
        }
        .padding(.leading, 16)
    }
    
    private func bulletPoint(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .font(.system(size: 15))
            Text(text)
                .font(.system(size: 15))
                .foregroundColor(.black.opacity(0.8))
                .lineSpacing(6)
        }
        .padding(.leading, 16)
    }
}

struct ServiceGuideView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceGuideView()
    }
} 