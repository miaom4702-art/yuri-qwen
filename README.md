# yuri-qwen

> 把日系百合轻小说的文风蒸馏成一个可注入的 skill，给本地 Ollama 上的 Qwen2.5 用。

一个 `Modelfile` + 一份中文写作规则，用最小成本让本地 7B 模型写出口吻克制、身体感强、暧昧留白的日系百合轻小说段落。

- 基座模型：`qwen2.5:7b`（Qwen2.5-7B-Instruct，Apache-2.0）
- 运行方式：Ollama 本地推理，无需联网、无需微调、无需显卡也行（CPU 可跑）
- 体积：只分发配方，`ollama create` 时复用本地已有底模

## 特性

- **第一人称限知**：只写「我」能感知到的，不写上帝视角。
- **情绪转译**：不直接写「害羞/难过」，落到心跳、耳后温度、气味、指尖、呼吸。
- **句式指纹**：短句与长内省交替，省略号、破折号、自问自答、词语重复。
- **关系张力**：契约、禁忌、期限、不对等；靠近与后退之间反复。
- **格式约束**：对白统一用「」；只输出正文。
- **防照抄**：提示词中不放示例段落，避免小模型整段搬运。

## 快速开始

前置：[Ollama](https://ollama.com/) 已安装。

```bash
# 1. 拉取底模
ollama pull qwen2.5:7b

# 2. 克隆本仓库
git clone https://github.com/miaom4702-art/yuri-qwen.git
cd yuri-qwen

# 3. 构建本地模型
ollama create yuri-qwen -f Modelfile
```

### 使用

直接运行：

```bash
ollama run yuri-qwen "写一段：放学后的天台，她把耳朵贴在我背上听心跳。第一人称。"
```

推荐走包装器（自动把对白引号规范成「」）：

Windows PowerShell：

```powershell
.\write.ps1 "写一段：放学后的天台，她把耳朵贴在我背上听心跳。第一人称。"
```

macOS / Linux：

```bash
chmod +x write.sh
./write.sh "写一段：放学后的天台，她把耳朵贴在我背上听心跳。第一人称。"
```

> 为什么需要包装器：7B 底模对中文引号有强先验，常回落到“”。包装器在调用后做一次标点规范化，保证输出稳定使用「」。

## 文件说明

| 文件 | 作用 |
| --- | --- |
| `Modelfile` | Ollama 模型定义：`FROM qwen2.5:7b` + SYSTEM 文风规则 + 采样参数 |
| `SYSTEM.md` | 人类可读的完整文风 skill（视角、情绪、节奏、比喻、对话、结构、格式、禁忌） |
| `write.ps1` | Windows 调用包装器（引号规范化） |
| `write.sh` | macOS / Linux 调用包装器（引号规范化） |
| `examples/` | 模型输出样例 |

## 训练素材声明（重要）

本项目的写作规则由以下**日系百合轻小说中文译版**的文本风格分析蒸馏而来：

| 文件 | 作品 | 作者 |
| --- | --- | --- |
| `1683.txt` | 《安达与岛村》 | 入间人间（Hitoma Iruma） |
| `3128.txt` | 《我的初恋对象与人接吻了》 | 入间人间（Hitoma Iruma） |
| `3872.txt` | 《人妻教师与班上女高中生陷入爱恋》 | 入间人间（Hitoma Iruma） |
| `周次.txt` | 《我买下了与她的每周密会～以五千圆为借口，共度两人时光～》（又译《一周一次买下同班同学的那些事》） | 以原书版权页为准（素材文本未标注） |

需要明确的是：

1. **原始小说文本不包含在本仓库中，也不随本仓库分发。**
2. 上述作品的著作权归原作者、译者、出版社及相关权利人所有。
3. 本项目仅从文本中归纳**写作技法与风格特征**（视角、节奏、句式、情绪表达方式等），不复制、不复述原文段落。
4. 若你需要使用这些作品，请通过合法渠道获取。
5. 使用本项目生成的内容时，请自行确保不侵犯他人权利，并遵守你所在地区的法律法规。

## 模型与开源许可

- **本仓库原创内容**（`SYSTEM.md`、`Modelfile` 中的系统提示与参数、`write.ps1`、`write.sh`、文档）：[Apache License 2.0](./LICENSE)。
- **基座模型 Qwen2.5-7B-Instruct**：Apache License 2.0，Copyright © Alibaba Cloud。见 [Qwen 官方仓库](https://github.com/QwenLM/Qwen2.5)。
- **由本 Modelfile 构建的 `yuri-qwen`**：作为 Qwen2.5 的衍生模型，同样遵循 Apache License 2.0。修改说明：仅新增系统提示（SYSTEM）与采样参数，**未修改模型权重**。
- 本项目与阿里巴巴（Alibaba Cloud）及上述小说的作者、译者、出版社**没有关联、未获其背书**。

Apache-2.0 允许商用与再分发，但要求保留版权与许可声明。详见 [`NOTICE`](./NOTICE) 与 [`LICENSE`](./LICENSE)。

## 已知限制

- 7B 模型能力有限，长文容易出现套路化比喻与情绪总结；建议一次 300–800 字，并给出具体场景。
- 对白引号可能漂移，使用 `write.ps1` / `write.sh` 兜底。
- 无法保证还原特定作者的独特笔力，本 skill 提炼的是**共性风格**，不是某一位作者的模仿。
- 不适合生成违法、侵权或伤害性内容。

## 标签 / Topics

`ollama` · `qwen` · `qwen2.5` · `llm` · `creative-writing` · `light-novel` · `yuri` · `chinese` · `prompt-engineering` · `modelfile` · `ai-writing` · `text-generation`

## 致谢

- [Qwen](https://github.com/QwenLM/Qwen2.5) 与 [Ollama](https://ollama.com/)。
- 上述轻小说的作者、译者与出版方——本项目的风格分析建立在他们作品的基础上。

## License

[Apache-2.0](./LICENSE)
