Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012048.outbound.protection.outlook.com [52.101.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98E84EF154;
	Thu, 17 Sep 2026 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789677437; cv=fail; b=LmNlHAQpNPt9xZT7K+EsLs4Gajid4lGiCHG+5D7pOoC3Vo/ruSg9vG5xmgzo2J9ZjZh6KIc4/Fsrrej9VjO5dFLsgoASPiaPwMToZPSpb+7JtQoq5NIHjPgEHRyj/z0dGAGEZe5e+GmM9YKU/UwRz8r37Ly2Xy/y0eVAYhVTOYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789677437; c=relaxed/simple;
	bh=dLxNWFn2ZYFj6hDkZFElJlpMVfQ7jRRWAUDTH5ZQWdo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tkjfcC9vkOOqbSobw4W1w9C9hsjMaQxPB63rySp8WKRwdGnuSPwSxkshpOpebHCwDdxUy1T7+UH+Rsy5ziWW/UP+rjZkoOTiS4m0shmaW8xgnnVCT37rEAPEctMpOrdrw4AhxK82rGiTpyH4jYKGXV2Fo7Zu0ZLinDQHRLGX2ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=W+RC0DAo; arc=fail smtp.client-ip=52.101.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="W+RC0DAo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WW935KeyteNnjacHVtOeTSpT9tFknk3b0/kCEdcl8ds1RuRRgcMgdm6tk1Y1prNPaXKiafkPpKSxwu86GnFyHh8RdM9RH4UgNoAa6sl9ALJDaxwIiqTXlqbGhoiWATTpcGP7PIdg+13xKWFtS8QLjiqrSQuajLpvx1/0FxJf1WQa13+x3mh+BK209sGHb15DOG9Ytpbmw6PB96ibTV540EpitUY3pNtu7JU0SLWdrcr8wmHFi7a+PeTyYPbZCRVXlwhDy8kuIXIDODBlLe8Wku2D/OxxOcSc17UIfzx9Nuv2Ok+mvr+og873r4mxPYo1vXC7VV6tDiV5Pt2UL2edgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oq3SjdBk2Nepu96joOftu2EI7Z7HYjdpdMiG9+LVz60=;
 b=tyOskFdu6MC27vw7W4o75R9nicLMzitnJXecBps2f2mclROI11awa63W3dEtlquLGTjvSnCilM0Qu2ZvkdMnGVyZ2ryQAnKY14Hp+xpwHyteAYaJh8rGMKMmnCi4f7JL0aAz36EVPe1gdSRsp5Bx/iWPe7kRklcaLZtSsqCFC6irpONpTkx2fqEHMJr6JIJ8BurPFoQ7k4pEijG+kEpKylpuyJYvFN1fZXGkeEb6xNEhp6heFOigKcZPSqfU5SzBKhfJkK3lPyCpZqihqUgKrr2xU1cT88Fp9jOwOqf659wsNh8cpF1Nzv0UjuZy8Hvuio3Evm3LsZAfq9mMBO5vpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oq3SjdBk2Nepu96joOftu2EI7Z7HYjdpdMiG9+LVz60=;
 b=W+RC0DAoObD79b4yMmlAmHu8XEVhdEiE81ToNOggPl5dto+2JX3LrtIO0O7MGrJzN/fVT7oJyP9w2xIyTf4bcDp/kKsfcjwXtQEZA4tZBa/YbGllWvErwE1abjzK8wii1TpGVl1bTZfkPgkUVAZZ0c8PudcIHcDLapzcSjmZFuoUicGCH7QuLVWmP1zPMcxMxA72OCy+dubGdhLJnbTRKwPdk1Pq5YncFHdKe8Xz5iD+EA0nXTXn1Y1EAc2HneY0Vg6D9NyxpqLBe+xaLesPbykq/v0u5jO3fbPn5KBjj/dEpCCF7zapYgGmq2TMeBAuzLOfMft5mx+2ZonKARhc2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com (2603:10a6:10:623::11)
 by AM9PR04MB8413.eurprd04.prod.outlook.com (2603:10a6:20b:3ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.16; Thu, 17 Sep
 2026 20:37:12 +0000
Received: from DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de]) by DU4PR04MB11791.eurprd04.prod.outlook.com
 ([fe80::11ca:6b74:3234:d7de%5]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 20:37:12 +0000
From: Frank.Li@oss.nxp.com
To: Eugen Hristev <ehristev@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Felix Gu <ustc.gu@gmail.com>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Frank Li <Frank.Li@nxp.com>,
	Piyush Patle <piyushpatle228@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Shi Hao <i.shihao.999@gmail.com>,
	Kees Cook <kees+treewide@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org (open list:MICROCHIP SAMA5D2-COMPATIBLE ADC DRIVER),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Microchip (AT91) SoC support),
	linux-kernel@vger.kernel.org (open list),
	linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32 ARCHITECTURE)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org
Subject: [PATCH 1/1] iio: use dmaengine_get_dma_device() instead of chan->device->dev
Date: Thu, 17 Sep 2026 16:36:26 -0400
Message-ID: <20260917203652.1279059-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CY8P222CA0003.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:930:6b::27) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU4PR04MB11791:EE_|AM9PR04MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: 749f4562-671a-4c24-502b-08df14fb6cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|23010399003|1800799024|7416014|376014|921020|18002099003|6133799003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	5LEFv+xklyRQZhDJaHooVMeePN0cw/LkpiL+t1CpA9+dMEMhP0z+8+LOoqW7j9TcbF6n32YLSA65j4hol9EDtB23W6ljeCYqx00JzhjieCm8kHVUBrq7vxZtRJpouXHvY1UQdqTcU4M8K1KxIiCM1kjh7HOK81Jrl7UByBkmMzlVMLm8QToMvSgLvgPoXVAsbLia4N3htsdmxkLVuCGN63LSg9Pb5ugLsVGEE+LQXlMwpYB/N3PmgTiLXxylhiW+TY81oU67MhqATxk6AhUBLHSxgU5tBQcRNCZ3w50mLRhD9GkhjmpYCjHR5V+zKmb/WZCReYiqTEBv3a9IlTZrbHlLolbah8OTrrF5jRCk/Hy70Q0oyB4IDCvc7qc+BE5EKqIOimvLV3YYZW7Wf1Wpcxeak7EA4sSr4grY79LxCqrcofr2PIS+W7IeHuTqDOvdi1kJiUIDAZCKk65fm9JdyS1g+2TegQxuyV4TB09Q9tHlYZtMOmhUS2QEwhad+UVt3qC/YB38xrKHvtqeUmEqmfB25Z+aZ77086Lbn1TOXluFKOEBaLBNCyJAg8vEH/9aAsAlFPW+5n8nYyh1kvJwY4k8xvOVHgkf17VcuBe2fH0+TmWzdLlscLKyAPfcFjfgTP7ESxoORgZ2W46rhEzj64YbYJ2cNalUFkTdy85Fp6JnPvTeeUk0ykn469zyIpSUpfmG0qqpeYdAAk815J7ekg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR04MB11791.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(23010399003)(1800799024)(7416014)(376014)(921020)(18002099003)(6133799003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Rr7lPpo4ZDV1JGuRIcKNKPhjrzs3h9HQ8lMEgebwTlluRQ0qjrRgWBrGTMkz?=
 =?us-ascii?Q?Mq6S/q+cBbJmC2cK9Kg2Qaq3NCdJaHf0IRD5+9XqDQpRLAQ85zeP8VUDPDsT?=
 =?us-ascii?Q?IUbi8HU8eJpwCOjOKRt8UseD3Iy1eAd2u1jtfTnO973fDV1DIq6MJa094yfD?=
 =?us-ascii?Q?ze/ZvrFrHdSNTW+mGZZDE6Pe+9xj+gzGUT18Bg19vtKFgniSoNlFJPIojCKL?=
 =?us-ascii?Q?D8EUtOjtzkzyjqxhIaQZaJeuuJg/T4UJ4c6D4Jzx6dacMpKNEAuM6lieyIns?=
 =?us-ascii?Q?ddvFUUww8SCeM00kp0mVQcAnJYvgtSJJ1COHa8ZLN3U4iEUyLMUf9VuUILRl?=
 =?us-ascii?Q?7dtOnbRJeZl18vjIGEt6/5+GIp20gmFOCtS2rhN/tHshs0ijruubCH+hMeg2?=
 =?us-ascii?Q?w+iV1Y8ZLN0GGfRhAaVU4FAC9N3VOhCLTWEuLdvbPPJ1qmvUz6qGS2Vu60m+?=
 =?us-ascii?Q?fJ9iy/XJdxzBb/OSkbOnrRDqpbr/fjpRBOMkXY52sk/pi0kbci28gcbVBsKw?=
 =?us-ascii?Q?yTy+xwGpF1Vn4uDM8IOhOZRhMLkh0kJ/pFsmEO4lap2NbklRgmnm2i9s2Otl?=
 =?us-ascii?Q?8Iii6qbCKn6GiJabhrbJ8BaPc2Fj6uTkyzuMBpqOSa7QX0mhw9BhIyEJazDA?=
 =?us-ascii?Q?a7dIlt94oODGgHAWndlw9bFTLd3CUbK769fUO4PdQS1LyuVDquNKDe5KNs1z?=
 =?us-ascii?Q?eJHJQ9uqzlX9XbUeBkgjKoqK6jb9PBlOTEMn2E6Ouc2nLVRf/aRTNGRdmMOz?=
 =?us-ascii?Q?r8ZcD4NmAZuBX3efnMiDCyjYZdTGTHpZpzRnVHPqD+F0K2C2IK8r7+6PtR8I?=
 =?us-ascii?Q?8GRSDeKD2cIq3UgwYNQmOEETDZDbFw1uYKTXLe4gWDbtR/nh/PTLtt+Cv+Tb?=
 =?us-ascii?Q?zyX/kLwMQ7CM4qUfT7PHKINUewJAOa8Fjmrm+psSutz8QkWPizIax0RyfJ1J?=
 =?us-ascii?Q?N0RU+RO9RQEXJ8aJ+3bwMpmESD1/X9oiUnnTTexecSAkHe/X1y3vTaYszbnW?=
 =?us-ascii?Q?S2yjnquQEyZgbh6iDiTyByWshAbKm1/j2COzsre/TtWbn2lM1S/IgSvlKzci?=
 =?us-ascii?Q?u1IRVHA8g/Bl2av2RXCQhCILnBshaWeNtGeqPHvytNdQZ3WOYD0aC/fMVnqP?=
 =?us-ascii?Q?wtZZoxHc9IGLJlFSZZjVnXlStmt5UidjlG5ve2qwP95R+NpMB9VU+cmXvxMG?=
 =?us-ascii?Q?7HwZGWKC7HXmpMIuVEHHYZu8Tab9L+AczRRySLYbZTZymG9sp3CMXvAdoJaq?=
 =?us-ascii?Q?Ys64ZFp3MEsTJQi5urQJ4VvCeWDoPClmJn9szbZJPXf/Loc8+znTa9foNabJ?=
 =?us-ascii?Q?UGGcI+s5aml82QrzzV/7AJHqz/hjBcMauTWTQBskAu/JCYtIEo9gMbJsl9+o?=
 =?us-ascii?Q?we2kzpPtP/NKuC+04cXUia9T+ObNcO0G5QkuBeXcrUyg0Lq2v0wHfz6VFHBD?=
 =?us-ascii?Q?MHjgSLrEoDQbGEKijFq+txwntlN+RRwGrre/zlOqweGY34O/GYjXm3ROd+Im?=
 =?us-ascii?Q?NS3wzetyHtU/36PMOLI3PRtLarLF4/U36k+AwmFtChO2vnGn++GhHAI2wy7A?=
 =?us-ascii?Q?4hhUKLtGFK1BA8xecd1MdCoesu/emi6SCjen0FFt3A3/1qOQL/ivk1OMjZEo?=
 =?us-ascii?Q?qfgDVOFa3PTN/CIN+BIpbrWnl6lR/z1Jq/Iut60R7MPBXjbQLvs9kzbwQvHU?=
 =?us-ascii?Q?tP8U7gTh/i2UZvXC6lr8GXqSfx4E+pqhv6E5zAZW5H4D96MFPe1Wc/yCoa2C?=
 =?us-ascii?Q?JvIdonwAz3HZmgRJAsnIWT5BRyZ+XnOh/PH0XJiJvdNrRARd45y1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749f4562-671a-4c24-502b-08df14fb6cbb
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 20:37:12.4779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qIw5PyU0s6JWeYG+v+kAmyUmsYefedpAUXTYEdU24FhK1l2WZfSV5EAhCf5jlLzi3UGiRgmWm0PFh1mjnA2wJjt1I0WwNcOYpL0TIilqBl7hOqIYZVDb274FVUN7ehnz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8413

From: Frank Li <Frank.Li@nxp.com>

Replace direct dma_chan::device::dev access with the proper
dmaengine_get_dma_device() accessor in IIO DMA consumers.

chan->device->dev is not always the device used for DMA mapping.
Some DMA engines support per-channel IOMMU mappings, so different
channels may use different DMA devices.  dmaengine_get_dma_device()
returns the correct device for each channel.

This also prepares for making the DMA engine provider data structures
private. DMA consumers should not access DMA engine internals directly.

Assisted-by: LLM
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Cc: imx@lists.linux.dev
Cc: vkoul@kernel.org
---
 drivers/iio/adc/at91-sama5d2_adc.c                 |  9 ++++++---
 drivers/iio/adc/nxp-sar-adc.c                      |  2 +-
 drivers/iio/adc/stm32-adc.c                        | 10 ++++++----
 drivers/iio/adc/stm32-dfsdm-adc.c                  |  4 ++--
 drivers/iio/adc/ti_am335x_adc.c                    |  4 ++--
 drivers/iio/buffer/industrialio-buffer-dmaengine.c |  5 +++--
 6 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index e8a5285bb6d4f..0e7d07fb27ca7 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -2016,6 +2016,8 @@ static void at91_adc_dma_init(struct at91_adc_state *st)
 	unsigned int pages = DIV_ROUND_UP(AT91_HWFIFO_MAX_SIZE *
 					  sample_size * 2, PAGE_SIZE);
 
+	struct device *dma_dev;
+
 	if (st->dma_st.dma_chan)
 		return;
 
@@ -2026,7 +2028,8 @@ static void at91_adc_dma_init(struct at91_adc_state *st)
 		goto dma_exit;
 	}
 
-	st->dma_st.rx_buf = dma_alloc_coherent(st->dma_st.dma_chan->device->dev,
+	dma_dev = dmaengine_get_dma_device(st->dma_st.dma_chan);
+	st->dma_st.rx_buf = dma_alloc_coherent(dma_dev,
 					       pages * PAGE_SIZE,
 					       &st->dma_st.rx_dma_buf,
 					       GFP_KERNEL);
@@ -2054,7 +2057,7 @@ static void at91_adc_dma_init(struct at91_adc_state *st)
 	return;
 
 dma_free_area:
-	dma_free_coherent(st->dma_st.dma_chan->device->dev, pages * PAGE_SIZE,
+	dma_free_coherent(dma_dev, pages * PAGE_SIZE,
 			  st->dma_st.rx_buf, st->dma_st.rx_dma_buf);
 dma_chan_disable:
 	dma_release_channel(st->dma_st.dma_chan);
@@ -2078,7 +2081,7 @@ static void at91_adc_dma_disable(struct at91_adc_state *st)
 	/* wait for all transactions to be terminated first*/
 	dmaengine_terminate_sync(st->dma_st.dma_chan);
 
-	dma_free_coherent(st->dma_st.dma_chan->device->dev, pages * PAGE_SIZE,
+	dma_free_coherent(dmaengine_get_dma_device(st->dma_st.dma_chan), pages * PAGE_SIZE,
 			  st->dma_st.rx_buf, st->dma_st.rx_dma_buf);
 	dma_release_channel(st->dma_st.dma_chan);
 	st->dma_st.dma_chan = NULL;
diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
index 894d3211b2838..2f716a2f97b80 100644
--- a/drivers/iio/adc/nxp-sar-adc.c
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -604,7 +604,7 @@ static void nxp_sar_adc_dma_cb(void *data)
 
 	dma_buf = &info->dma_buf;
 	dma_samples = (u32 *)dma_buf->buf;
-	dev_dma = info->dma_chan->device->dev;
+	dev_dma = dmaengine_get_dma_device(info->dma_chan);
 
 	/*
 	 * DMA in some corner cases might have already be charged for
diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index 5c6c06b269be6..6aa672177970a 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -2456,6 +2456,7 @@ static int stm32_adc_dma_request(struct device *dev, struct iio_dev *indio_dev)
 {
 	struct stm32_adc *adc = iio_priv(indio_dev);
 	struct dma_slave_config config = { };
+	struct device *dma_dev;
 	int ret;
 
 	adc->dma_chan = dma_request_chan(dev, "rx");
@@ -2470,7 +2471,8 @@ static int stm32_adc_dma_request(struct device *dev, struct iio_dev *indio_dev)
 		return 0;
 	}
 
-	adc->rx_buf = dma_alloc_coherent(adc->dma_chan->device->dev,
+	dma_dev = dmaengine_get_dma_device(adc->dma_chan);
+	adc->rx_buf = dma_alloc_coherent(dma_dev,
 					 STM32_DMA_BUFFER_SIZE,
 					 &adc->rx_dma_buf, GFP_KERNEL);
 	if (!adc->rx_buf) {
@@ -2490,7 +2492,7 @@ static int stm32_adc_dma_request(struct device *dev, struct iio_dev *indio_dev)
 	return 0;
 
 err_free:
-	dma_free_coherent(adc->dma_chan->device->dev, STM32_DMA_BUFFER_SIZE,
+	dma_free_coherent(dma_dev, STM32_DMA_BUFFER_SIZE,
 			  adc->rx_buf, adc->rx_dma_buf);
 err_release:
 	dma_release_channel(adc->dma_chan);
@@ -2617,7 +2619,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
 
 err_dma_disable:
 	if (adc->dma_chan) {
-		dma_free_coherent(adc->dma_chan->device->dev,
+		dma_free_coherent(dmaengine_get_dma_device(adc->dma_chan),
 				  STM32_DMA_BUFFER_SIZE,
 				  adc->rx_buf, adc->rx_dma_buf);
 		dma_release_channel(adc->dma_chan);
@@ -2640,7 +2642,7 @@ static void stm32_adc_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(&pdev->dev);
 	iio_triggered_buffer_cleanup(indio_dev);
 	if (adc->dma_chan) {
-		dma_free_coherent(adc->dma_chan->device->dev,
+		dma_free_coherent(dmaengine_get_dma_device(adc->dma_chan),
 				  STM32_DMA_BUFFER_SIZE,
 				  adc->rx_buf, adc->rx_dma_buf);
 		dma_release_channel(adc->dma_chan);
diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 00f05e167afc9..674767da3ac37 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -1484,7 +1484,7 @@ static void stm32_dfsdm_dma_release(struct iio_dev *indio_dev)
 	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
 
 	if (adc->dma_chan) {
-		dma_free_coherent(adc->dma_chan->device->dev,
+		dma_free_coherent(dmaengine_get_dma_device(adc->dma_chan),
 				  DFSDM_DMA_BUFFER_SIZE,
 				  adc->rx_buf, adc->dma_buf);
 		dma_release_channel(adc->dma_chan);
@@ -1504,7 +1504,7 @@ static int stm32_dfsdm_dma_request(struct device *dev,
 		return ret;
 	}
 
-	adc->rx_buf = dma_alloc_coherent(adc->dma_chan->device->dev,
+	adc->rx_buf = dma_alloc_coherent(dmaengine_get_dma_device(adc->dma_chan),
 					 DFSDM_DMA_BUFFER_SIZE,
 					 &adc->dma_buf, GFP_KERNEL);
 	if (!adc->rx_buf) {
diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
index 1516dd332f905..e53c839e87ef3 100644
--- a/drivers/iio/adc/ti_am335x_adc.c
+++ b/drivers/iio/adc/ti_am335x_adc.c
@@ -548,7 +548,7 @@ static int tiadc_request_dma(struct platform_device *pdev,
 	}
 
 	/* RX buffer */
-	dma->buf = dma_alloc_coherent(dma->chan->device->dev, DMA_BUFFER_SIZE,
+	dma->buf = dma_alloc_coherent(dmaengine_get_dma_device(dma->chan), DMA_BUFFER_SIZE,
 				      &dma->addr, GFP_KERNEL);
 	if (!dma->buf)
 		goto err;
@@ -688,7 +688,7 @@ static void tiadc_remove(struct platform_device *pdev)
 	u32 step_en;
 
 	if (dma->chan) {
-		dma_free_coherent(dma->chan->device->dev, DMA_BUFFER_SIZE,
+		dma_free_coherent(dmaengine_get_dma_device(dma->chan), DMA_BUFFER_SIZE,
 				  dma->buf, dma->addr);
 		dma_release_channel(dma->chan);
 	}
diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 559880e0cad72..b9f8b5b3aa6b6 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -254,6 +254,7 @@ static const struct iio_dev_attr *iio_dmaengine_buffer_attrs[] = {
  */
 static struct iio_buffer *iio_dmaengine_buffer_alloc(struct dma_chan *chan)
 {
+	struct device *dma_dev = dmaengine_get_dma_device(chan);
 	struct dmaengine_buffer *dmaengine_buffer;
 	unsigned int width, src_width, dest_width;
 	struct dma_slave_caps caps;
@@ -281,9 +282,9 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct dma_chan *chan)
 	INIT_LIST_HEAD(&dmaengine_buffer->active);
 	dmaengine_buffer->chan = chan;
 	dmaengine_buffer->align = width;
-	dmaengine_buffer->max_size = dma_get_max_seg_size(chan->device->dev);
+	dmaengine_buffer->max_size = dma_get_max_seg_size(dma_dev);
 
-	iio_dma_buffer_init(&dmaengine_buffer->queue, chan->device->dev,
+	iio_dma_buffer_init(&dmaengine_buffer->queue, dma_dev,
 			    &iio_dmaengine_default_ops);
 
 	dmaengine_buffer->queue.buffer.attrs = iio_dmaengine_buffer_attrs;
-- 
2.43.0

