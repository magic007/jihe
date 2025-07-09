import SwiftUI

struct RuleSection: View {
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
            Divider()
                .padding(.vertical, 12)
        }
    }
}

struct PointsRuleView: View {
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
                    Text("会飞的小猪APP积分规则说明")
                        .font(.system(size: 22, weight: .bold))
                        .padding(.bottom, 8)
                    
                    // 开场白
                    Text("亲爱的用户：\n\n感谢您使用会飞的小猪APP！为了鼓励您积极参与社区互动、享受平台服务，我们推出了积分奖励计划。以下是详细的积分规则说明，帮助您快速了解如何获取和使用积分。")
                        .font(.system(size: 15))
                        .foregroundColor(.black.opacity(0.8))
                        .lineSpacing(6)
                        .padding(.bottom, 20)
                    
                    // 当前积分
                    RuleSection(
                        title: "一、当前可用积分",
                        content: "您的账户当前可用积分为：227。"
                    )
                    
                    // 获取方式
                    VStack(alignment: .leading, spacing: 16) {
                        Text("二、积分获取方式")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.bottom, 4)
                        Text("您可以通过完成以下任务获得积分奖励：")
                            .font(.system(size: 15))
                            .foregroundColor(.black.opacity(0.8))
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Group {
                                pointsRule(
                                    title: "1. 首次绑定车辆",
                                    points: "1000~3000分（具体数值根据车型而定）",
                                    description: "首次成功绑定您的爱车后，系统将自动发放相应积分。"
                                )
                                
                                pointsRule(
                                    title: "2. 车主生日奖励",
                                    points: "200分",
                                    description: "仅限车主用户，在生日当天系统会自动发放积分。"
                                )
                                
                                pointsRule(
                                    title: "3. 推荐注册",
                                    points: "10分/次",
                                    description: "每成功推荐一位新用户注册APP，您将获得10积分。"
                                )
                                
                                pointsRule(
                                    title: "4. 优质图文",
                                    points: "500分/次",
                                    description: "发布的原创内容若被官方推荐，即可获得500积分奖励。"
                                )
                                
                                pointsRule(
                                    title: "5. 每日首次发帖",
                                    points: "1分/天",
                                    description: "每天首次发帖可获得1积分，每日仅限一次。"
                                )
                                
                                pointsRule(
                                    title: "6. 分享内容",
                                    points: "1分/次（每日上限1次）",
                                    description: "每日首次分享内容可获得1积分，超出部分不计分。"
                                )
                                
                                pointsRule(
                                    title: "7. 点赞内容",
                                    points: "1分/次",
                                    description: "每次给他人内容点赞可获得1积分。"
                                )
                            }
                        }
                        .padding(.leading, 16)
                    }
                    Divider()
                        .padding(.vertical, 12)
                    
                    // 积分使用
                    VStack(alignment: .leading, spacing: 12) {
                        Text("三、积分使用")
                            .font(.system(size: 18, weight: .bold))
                        Text("积分可用于兑换平台提供的各类福利，包括但不限于：")
                            .font(.system(size: 15))
                            .foregroundColor(.black.opacity(0.8))
                        
                        VStack(alignment: .leading, spacing: 8) {
                            bulletPoint("兑换优惠券（如洗车券、保养折扣券等）")
                            bulletPoint("参与抽奖活动")
                            bulletPoint("提升账号等级")
                            bulletPoint("其他专属权益（具体以平台活动为准）")
                        }
                        .padding(.leading, 16)
                    }
                    Divider()
                        .padding(.vertical, 12)
                    
                    // 注意事项
                    VStack(alignment: .leading, spacing: 12) {
                        Text("四、注意事项")
                            .font(.system(size: 18, weight: .bold))
                        
                        VStack(alignment: .leading, spacing: 8) {
                            bulletPoint("积分有效期：部分积分可能设有有效期，请及时使用。")
                            bulletPoint("违规行为：如发现刷分等作弊行为，平台有权取消积分并采取相应措施。")
                            bulletPoint("规则调整：积分规则可能根据运营情况优化，请以最新公告为准。")
                        }
                        .padding(.leading, 16)
                    }
                    
                    // 结束语
                    VStack(alignment: .leading, spacing: 16) {
                        Text("立即参与，赚取积分！")
                            .font(.system(size: 16, weight: .bold))
                            .padding(.top, 20)
                        
                        Text("点击各任务后的\"前往\"按钮，即可快速完成任务，累积积分兑换好礼！")
                            .font(.system(size: 15))
                            .foregroundColor(.black.opacity(0.8))
                        
                        Text("如有疑问，请联系客服或查看\"帮助中心\"。")
                            .font(.system(size: 15))
                            .foregroundColor(.black.opacity(0.8))
                            .padding(.bottom, 20)
                        
                        Text("会飞的小猪APP团队")
                            .font(.system(size: 15, weight: .medium))
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(Color(UIColor.systemGray6))
        .navigationBarHidden(true)
    }
    
    private func pointsRule(title: String, points: String, description: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
            Text("奖励积分：\(points)")
                .font(.system(size: 15))
                .foregroundColor(.blue)
            Text("说明：\(description)")
                .font(.system(size: 15))
                .foregroundColor(.black.opacity(0.7))
        }
    }
    
    private func bulletPoint(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Text("•")
                .font(.system(size: 15))
            Text(text)
                .font(.system(size: 15))
                .foregroundColor(.black.opacity(0.8))
        }
    }
}

struct PointsRuleView_Previews: PreviewProvider {
    static var previews: some View {
        PointsRuleView()
    }
} 