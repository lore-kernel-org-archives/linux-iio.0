Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795015091;
	b=YGV6t1FMk2FtwXRpuzV8GnaeYrncc5ACFBWA9tGEguOR5cZ2FdIRBpE0PhKlBQ7xA1qx
	 pEvcZDgp9KDmbqQSpsu/x/3wRt+V+g0OWZeYoGi6ZFju1HPe/5nZlEfi9WaIS7bCFGE9n
	 xykaJB7Qfpkd15dsQE5DclcMLRM69HJAdLvwIbxja9x0UksUysu3bF/j1jSSMNh3Rhks2
	 3kWuDXJrT4BH/sUXcs8mimpH6PrgFZ22cmB1F+pw5M2FXNKF92IESi4W79qM7mG++bvVl
	 CsJN6aMupWabFgbU4zUNaHtS/VCnJBp9j2AmGAfVTDHfFyC+SvKWKk3n8W49DxdN2sQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015091;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
	 X-Mailer:X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=5/apfe6ZSUpael6tbmztgMY9njgpjW9dtz0USWVmYMg=;
	b=U4jbdUd0ef3x/MsOnKtIqw0ZHsjWKGpPCgSP8M+cHNVXM+fAwq450cuMW4aJH6azKcGQ
	 FudLazEM75YoMsGTGpjaZO3jGfxVFI3BDfnSU8wvuCwOseoPxHvc+IPmM4QaHoDvUCU0z
	 5nX7uueSr1qxCwMKP/AiDjc80Fs5X2OiuqKM49xiBeBDkhorDoOVi6lo8Qt/ZEf5iNEbY
	 CQCOqJx58wNTDvxAr0a+SKqtcQoSvfb77ErXIaBHDcmo6rf/gbFROKBBxV2snR1s/3ua5
	 UuF9jVHVE3N0aCJmvJFOicQ4uVGYB0ht3ydTFVkmmRc7B6ufPlYkJhWamal2w9SgiIA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=oSVPKfEv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.8
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011008.outbound.protection.outlook.com [52.101.70.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA2B606A338;
	Wed, 18 Nov 2026 15:18:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7AA2B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=oSVPKfEv
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lfH15P8lhsOzuzEpol+u/W09xqmvt5y+9/ob3rEK+aOnm1ThciIm1eWF7lwRYLjSaOTim5JzHU0y7uGBb9Nj6j/J1rCYo0pqfVeajoqkw+7Z07KYbpAPlxupMe7pUNVkv7MaB0yTalnEj7x2UprQplBIRtGws/cFZhUkqrqyydBbfJ6tN73ggEqauYTx9HokJDKc9Rj1upLMxvGT5Rw8rN7MbB9ezQKVpPKvNPtT33tFopaKnzRHZafe68W8p1P1Md4hIqIJvGem2N48YVTM7PIypfUmBhL6d+XRBo1cWp/BpaR0BbuFdc2pkgFOKag8yU3tn0mwO98DE9UNht5FLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/apfe6ZSUpael6tbmztgMY9njgpjW9dtz0USWVmYMg=;
 b=Dh1STb3x9MIkJ/tN6KbCsrcolego9wh8X5L6JsAftjXyiM63n/NYgNafHzViaadEgQvQdDL49t5y1ae2SN9iPlvxM0UaEPez+yw6Iu9jHdq40QeBm+L6UuLcuaBNNU3DwAvaGOb7kf90wLc51qiYD4NbNz6UdqGu9zl8wgnh6o3PDG/1NPhpdfiWZlVm20lxMN2XzYb2zgprCANZ+zQg7iyP2swgC9QGtkZYuGFeRm2KyBRAO06Jo5+bRXgTlA60jLrW5ucMCMBMZVDons2PalY+b7CkHPYRsjvUW7VGEGmYVZKZ7UXjFJ8CsUlwqDfSrpuEOnRyIGVqF+XQmHAnjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=amd.com smtp.mailfrom=foss.st.com; dmarc=fail
 (p=none sp=none pct=100) action=none header.from=foss.st.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5/apfe6ZSUpael6tbmztgMY9njgpjW9dtz0USWVmYMg=;
 b=oSVPKfEvJk5tetF/iR/r9h37tQEEiL64dfFcv2KmxFbei6FTPAXD0K06u9CGYOB9iP5f2Kp8cyGZNqUtLshxEHCcbNTR/7QWxbIPjQNOpMJI7MC0xuyIG/q9gwFCyY6Wv84JhHHyrbwi5L3a/JpeZnHVa7Z53cq+u0zH138dTkomofUmcJ+BCmoCYEbV+dgwyVorq2g99PVsAijIAOOu+f4Gz9+adhiCsrf+IZMOpx3STugKkl+S4KuuZ12MAui3J1vgcVQfsoJ6KM5R20RKaPMd5a5H3D8ZtZDeAK7y2KhNb4bIqpGyGZHt2WKINmpKlFoedQ/LTjAQ4snV+tBOOg==
Received: from DUZPR01CA0018.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::6) by PAVPR10MB7012.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:303::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Wed, 18 Nov
 2026 15:18:03 +0000
Received: from MA3PEPF00000408.eurprd04.prod.outlook.com
 (2603:10a6:10:46b:cafe::82) by DUZPR01CA0018.outlook.office365.com
 (2603:10a6:10:46b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 15:18:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MA3PEPF00000408.mail.protection.outlook.com (10.167.241.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:18:02 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 18 Nov
 2026 16:19:03 +0100
Received: from localhost (10.252.16.78) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 18 Nov
 2026 16:18:01 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
Date: Wed, 18 Nov 2026 16:17:48 +0100
Subject: [PATCH v2 03/11] iio: adc: stm32-mdf: add cck clocks provider
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261118-upstream_mdf_v2-v2-3-7939d3c3720a@foss.st.com>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
In-Reply-To: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>,
	"Sumit Semwal" <sumit.semwal@linaro.org>, =?utf-8?q?Christian_K=C3=B6nig?=
	<christian.koenig@amd.com>, Philipp Stanner <phasta@kernel.org>, "Arnaud
 Pouliquen" <arnaud.pouliquen@foss.st.com>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-media@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
	<linaro-mm-sig@lists.linaro.org>, <linux-sound@vger.kernel.org>, "Olivier
 Moysan" <olivier.moysan@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA3PEPF00000408:EE_|PAVPR10MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 661dd2db-3e62-4ea7-7477-08df45872332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|921020|10067099003|11063799006|5023799004|56012099006|261021121427099003|261021123027099003|261102130727099003|261102123227099003|261009223027099003|261009221227099003|261028144727099003|261026140227099003|261022105027099003|261022075727099003|261026121527099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	zfaIeF7StOS5I4DX26/waZYy9/q8Ws1yxa56kPIQQ3QqnlK/S8s1MadTbtlfIDvsvLYbnvoorE129am/uGGsInmgThsAhKTg7BnJBlrUfE2BOAAG8BeOpnBW0Qi7JzPkinfITsP0VlYxxVi7KdhG8MFc+dwCVY/zkFNhMn6qFHriZFrllViOUetSiAbcAUGgDalRZNLZVq+v8uVTHyZdg5RqQelNlEAuYTkbgbgqa1wbL+j6g62xn+FpaPzIAZdosIx4+YU/jOhJRLSU42onUq45sVt6a0o7tW5PqAOA7SBhZBuUnh/IBBgoNuNnAcju5XxHS6NnluGvSbHxBMYMgXpgabW4oa4OdvFD9afgCsRVMn2lVU+LAwsET24K/NnQG9LmJozy6HYptrpUmElM2Q43Ugb60/3HY9LKvGvsseaUMCtPJBAF1Yus1GyzQ8YCti9wxWPeG4ozXFMX0dmhZvJgbB2zBPbabjGIfeDrlIcsD6w2Q3NuN7eee3BPPLhIqSDCXeHYDvw9tj3M/WshxUdhDrvI/jxn4m2Q0WLTxCdePmMK2mnRCipwiT9zeYtFCNsfkopifrqo/V5jjkyGZczLT8sIH3F/PHF9bqjRrzGFmHCyXdkAYjUGMsb0HzGI6m2lRdBcQP6zi7gkTBc615WbrhLVWxZGBLq/MfzbY9YmB3lsynZG60vmrZMGf9R5tIaiFBaeRPvJ2sEcXbUFuOaSyIF9bgl2BpaBcmgx6Vy82NNgcGfX4bQ/l/XIT3S2
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(921020)(10067099003)(11063799006)(5023799004)(56012099006)(261021121427099003)(261021123027099003)(261102130727099003)(261102123227099003)(261009223027099003)(261009221227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261022075727099003)(261026121527099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KJ66mNR7bohJAUHgSpK31aNycBsSM4YByswPKFf7jsG7DvorCsMbFZ4n6phVd+1facVpN7eNOE6zJyP5VH3xjdpcoVGQan+OC7apvhVZU1SWeHw+8VTtRCK2grTMQ8QsEM/cpzH9mtLxSXOvKIJWiLuaya8yQZlLOq4txMpJUQt5CuGP0bZ0EBrxliET+egs9/UcDfcJDPgytT50bGmPaLft8YOKWEfjt2XtQBzmliTDynE7+94IFFdHl5+wTVJGN5WBSMas5YLB5QgqnPESO8O0yrsPwYWUvpyGEuwUtu5w4WcCcOO4FjqTPiTVNo4T2QjhLsAgx5+Kya2hOWYFPsH0Dq1a+zLpdX3dMDesZXbL8ZNvOIaiYmjUsvpwxxbcy+NqZrUeZXk/UQWq32maoP6sJ/nss7QgIeuU7ZUf1wzzO3BaF9FzcbEnnoHuusI1
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:18:02.2180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 661dd2db-3e62-4ea7-7477-08df45872332
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MA3PEPF00000408.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB7012

MDF clock outputs can supply the serial interfaces and their external
converters. Register CCK0 and CCK1 with the common clock framework so that
consumers can configure and gate these outputs through the clock API.

Implement rate selection using the processing and CCK dividers, checking
the hardware limits and clock accuracy.

Expose helpers for child drivers to retrieve the CCK rate and restore its
configuration.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 drivers/iio/adc/stm32-mdf-core.c | 398 ++++++++++++++++++++++++++++++++++++++-
 drivers/iio/adc/stm32-mdf.h      |   5 +
 2 files changed, 402 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-mdf-core.c b/drivers/iio/adc/stm32-mdf-core.c
index ca50ce566a43..4e462c6c42bc 100644
--- a/drivers/iio/adc/stm32-mdf-core.c
+++ b/drivers/iio/adc/stm32-mdf-core.c
@@ -8,6 +8,7 @@
 
 #include <linux/cleanup.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/device.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -82,6 +83,7 @@ static const struct regmap_config stm32_mdf_regmap_cfg = {
  * @n_active_ch: number of active channels
  * @lock: lock to manage common resources
  * @kclk_rate: save kclk rate at probe
+ * @cck_freq_actual: actual output cck clocks frequency
  * @exclusive_flg: exclusive rate request flag
  */
 struct stm32_mdf_priv {
@@ -94,10 +96,24 @@ struct stm32_mdf_priv {
 	atomic_t n_active_ch;
 	spinlock_t lock; /* Manage common resources race conditions */
 	unsigned long kclk_rate;
+	unsigned long cck_freq_actual;
 	bool exclusive_flg;
 };
 
+#define STM32_MDF_MAX_CCK 2
 #define STM32_MDF_MP23_FILTER_NB 4
+#define STM32_MDF_MAX_CCK_RATE 25000000
+
+struct clk_mdf_cck {
+	struct clk_hw	hw;
+	struct stm32_mdf_priv *priv;
+};
+
+static const struct clk_parent_data clk_cck_parent_data[] = {
+	{ .index = 0 },
+};
+
+#define to_clk_mdf_cck(_hw) container_of(_hw, struct clk_mdf_cck, hw)
 
 static inline struct stm32_mdf_priv *to_stm32_mdf_priv(struct stm32_mdf *mdf)
 {
@@ -194,6 +210,96 @@ int stm32_mdf_core_trigger(struct stm32_mdf *mdf)
 }
 EXPORT_SYMBOL_GPL(stm32_mdf_core_trigger);
 
+/**
+ * stm32_mdf_core_get_cck() - Get the configured CCK frequency
+ * @mdf: MDF instance
+ *
+ * Return: The actual CCK frequency, in Hz.
+ */
+unsigned long stm32_mdf_core_get_cck(struct stm32_mdf *mdf)
+{
+	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
+
+	return priv->cck_freq_actual;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_core_get_cck);
+
+/**
+ * stm32_mdf_core_lock_kclk_rate() - Prevent changes to the MDF kernel clock rate
+ * @mdf: MDF instance
+ *
+ * Request an exclusive rate on the kernel clock when no MDF channels are
+ * active. While channels are active, the rate is already held exclusive by
+ * the start operation.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int stm32_mdf_core_lock_kclk_rate(struct stm32_mdf *mdf)
+{
+	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
+	struct device *dev = &priv->pdev->dev;
+	int ret;
+
+	if (!atomic_read(&priv->n_active_ch)) {
+		/* Request rate exclusivity on kernel clock right now */
+		ret = clk_rate_exclusive_get(priv->kclk);
+		if (ret < 0) {
+			dev_err(dev, "Failed to get exclusive rate on kernel clock: [%d]\n", ret);
+			return ret;
+		}
+
+		priv->exclusive_flg = true;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_core_lock_kclk_rate);
+
+/**
+ * stm32_mdf_core_unlock_kclk_rate() - Release the MDF kernel clock rate lock
+ * @mdf: MDF instance
+ *
+ * Release an exclusive rate acquired by stm32_mdf_core_lock_kclk_rate() when
+ * no MDF channels are active. The lock is retained while channels are active.
+ */
+void stm32_mdf_core_unlock_kclk_rate(struct stm32_mdf *mdf)
+{
+	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
+
+	if (!atomic_read(&priv->n_active_ch)) {
+		clk_rate_exclusive_put(priv->kclk);
+		priv->exclusive_flg = false;
+	}
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_core_unlock_kclk_rate);
+
+/**
+ * stm32_mdf_core_restore_cck() - Restore the MDF kernel clock rate
+ * @mdf: MDF instance
+ *
+ * Set the kernel clock to the rate recorded when the MDF core was probed.
+ *
+ * Return: 0 on success, or a negative error code on failure.
+ */
+int stm32_mdf_core_restore_cck(struct stm32_mdf *mdf)
+{
+	struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
+	struct device *dev = &priv->pdev->dev;
+	int ret;
+
+	ret = clk_set_rate(priv->kclk, priv->kclk_rate);
+	if (ret) {
+		dev_err(dev, "Failed to change kernel clock rate from [%lu]Hz to [%lu]Hz: [%d]\n",
+			clk_get_rate(priv->kclk), priv->kclk_rate, ret);
+		return ret;
+	}
+
+	dev_dbg(dev, "MDF kernel clock rate changed to [%lu]Hz.\n", priv->kclk_rate);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(stm32_mdf_core_restore_cck);
+
 /**
  * stm32_mdf_core_stop_mdf() - Stop an MDF channel
  * @mdf: MDF instance
@@ -223,11 +329,301 @@ int stm32_mdf_core_stop_mdf(struct stm32_mdf *mdf)
 }
 EXPORT_SYMBOL_GPL(stm32_mdf_core_stop_mdf);
 
+static int stm32_mdf_core_cck_divider_set_rate(struct platform_device *pdev,
+					       struct stm32_mdf_priv *priv,
+					       unsigned long rate,
+					       unsigned long parent_rate)
+{
+	struct device *dev = &pdev->dev;
+	unsigned long ratio, delta, delta_ppm, procdiv;
+	unsigned int cckdiv;
+	int ret;
+
+	if (!rate || rate > STM32_MDF_MAX_CCK_RATE || !parent_rate)
+		return -EINVAL;
+
+	ratio = DIV_ROUND_CLOSEST(parent_rate, rate);
+	if (!ratio) {
+		dev_err(dev, "CCK frequency above kernel frequency\n");
+		return -EINVAL;
+	}
+
+	delta = abs(parent_rate - (ratio * rate));
+
+	delta_ppm = (1000000 * delta) / parent_rate;
+	if (delta_ppm > 1000) {
+		/* If frequency deviation is higher than 1000 ppm return error */
+		dev_dbg(dev, "CCK clock deviation [%lu] ppm too large: [%lu] vs [%lu] Hz\n",
+			delta_ppm, DIV_ROUND_CLOSEST(parent_rate, ratio), rate);
+		return -EINVAL;
+	} else if (delta_ppm) {
+		dev_dbg(dev, "CCK clock frequency not accurate: [%lu] ppm deviation\n", delta_ppm);
+	}
+
+	/*
+	 * The total divider ratio must be split between proc divider and
+	 * cck divider. Try to maximize cck divider first, to help fulfilling
+	 * frequency ratio requirements between fproc and fcck.
+	 */
+	cckdiv = min_t(unsigned long, ratio, MDF_CKG_CCKDIV_MAX);
+	while (ratio % cckdiv)
+		cckdiv--;
+	procdiv = ratio / cckdiv;
+
+	if (procdiv > MDF_PROCDIV_MAX) {
+		dev_err(dev, "Proc divider out of range: %lu > %lu\n", procdiv,
+			MDF_PROCDIV_MAX);
+		return -EINVAL;
+	}
+
+	priv->mdf.fproc = DIV_ROUND_CLOSEST(parent_rate, procdiv);
+
+	/* Configure CKGCR register */
+	dev_dbg(dev, "Set MDF dividers: CCKDIV [%u], PROCDIV [%lu]\n", cckdiv, procdiv);
+	ret = regmap_update_bits(priv->regmap, MDF_CKGCR_REG,
+				 MDF_CKG_CCKDIV_MASK | MDF_CKG_PROCDIV_MASK,
+				 FIELD_PREP(MDF_CKG_CCKDIV_MASK, cckdiv - 1) |
+				 FIELD_PREP(MDF_CKG_PROCDIV_MASK, procdiv - 1));
+	if (!ret)
+		priv->cck_freq_actual = DIV_ROUND_CLOSEST(parent_rate, ratio);
+
+	return ret;
+}
+
+static int stm32_mdf_core_cck_set_rate(struct clk_hw *hw, unsigned long rate,
+				       unsigned long parent_rate)
+{
+	struct clk_mdf_cck *clk = to_clk_mdf_cck(hw);
+	struct stm32_mdf_priv *priv = clk->priv;
+
+	return stm32_mdf_core_cck_divider_set_rate(priv->pdev, priv, rate, parent_rate);
+}
+
+static int stm32_mdf_core_cck_determine_rate(struct clk_hw *hw,
+					     struct clk_rate_request *req)
+{
+	struct clk_mdf_cck *clk = to_clk_mdf_cck(hw);
+	struct stm32_mdf_priv *priv = clk->priv;
+	struct platform_device *pdev = priv->pdev;
+	unsigned long ratio;
+
+	if (!req->rate || req->rate > STM32_MDF_MAX_CCK_RATE || !req->best_parent_rate)
+		return -EINVAL;
+
+	ratio = DIV_ROUND_CLOSEST(req->best_parent_rate, req->rate);
+	if (!ratio) {
+		dev_err(&pdev->dev, "CCK frequency above kernel frequency\n");
+		return -EINVAL;
+	}
+
+	req->rate = DIV_ROUND_CLOSEST(req->best_parent_rate, ratio);
+
+	return 0;
+}
+
+static unsigned long stm32_mdf_core_cck_divider_recalc_rate(struct clk_hw *hw,
+							    unsigned long parent_rate)
+{
+	struct clk_mdf_cck *clk = to_clk_mdf_cck(hw);
+	struct stm32_mdf_priv *priv = clk->priv;
+	unsigned int val;
+	unsigned int ratio;
+	int ret;
+
+	ret = regmap_read(priv->regmap, MDF_CKGCR_REG, &val);
+	if (ret)
+		/* Gives a hint that something is wrong */
+		return 0;
+
+	ratio = (FIELD_GET(MDF_CKG_PROCDIV_MASK, val) + 1) *
+		(FIELD_GET(MDF_CKG_CCKDIV_MASK, val) + 1);
+
+	return DIV_ROUND_CLOSEST_ULL((u64)parent_rate, ratio);
+};
+
+static const struct clk_ops clk_cck_ops = {
+	.recalc_rate = stm32_mdf_core_cck_divider_recalc_rate,
+	.set_rate = stm32_mdf_core_cck_set_rate,
+	.determine_rate = stm32_mdf_core_cck_determine_rate,
+};
+
+static struct clk_mdf_cck clk_cck;
+
+struct clk_cckx_gate {
+	struct clk_hw hw;
+	struct regmap	*map;
+	u32		map_offset;
+	u8		bit_idx;
+	u8		flags;
+	spinlock_t	*lock; /* Protect cckx gating */
+};
+
+#define to_clk_cckx_gate(_hw) container_of(_hw, struct clk_cckx_gate, hw)
+
+static inline u32 clk_cckx_gate_readl(struct clk_cckx_gate *gate)
+{
+	u32 val;
+
+	regmap_read(gate->map, gate->map_offset, &val);
+
+	return val;
+}
+
+static inline void clk_cckx_gate_writel(struct clk_cckx_gate *gate, u32 val)
+{
+	regmap_write(gate->map, gate->map_offset, val);
+}
+
+static void clk_cckx_gate_endisable(struct clk_hw *hw, int enable)
+{
+	struct clk_cckx_gate *gate = to_clk_cckx_gate(hw);
+	unsigned long flags = 0;
+	u32 reg;
+
+	if (gate->lock)
+		spin_lock_irqsave(gate->lock, flags);
+	else
+		__acquire(gate->lock);
+
+	reg = clk_cckx_gate_readl(gate);
+
+	if (enable)
+		reg |= BIT(gate->bit_idx);
+	else
+		reg &= ~BIT(gate->bit_idx);
+
+	clk_cckx_gate_writel(gate, reg);
+
+	if (gate->lock)
+		spin_unlock_irqrestore(gate->lock, flags);
+	else
+		__release(gate->lock);
+}
+
+static int clk_cckx_gate_enable(struct clk_hw *hw)
+{
+	clk_cckx_gate_endisable(hw, 1);
+
+	return 0;
+}
+
+static void clk_cckx_gate_disable(struct clk_hw *hw)
+{
+	clk_cckx_gate_endisable(hw, 0);
+}
+
+static int clk_cckx_gate_is_enabled(struct clk_hw *hw)
+{
+	struct clk_cckx_gate *gate = to_clk_cckx_gate(hw);
+	u32 reg;
+
+	reg = clk_cckx_gate_readl(gate);
+
+	reg &= BIT(gate->bit_idx);
+
+	return reg ? 1 : 0;
+}
+
+static const struct clk_ops clk_cckx_gate_ops = {
+	.enable = clk_cckx_gate_enable,
+	.disable = clk_cckx_gate_disable,
+	.is_enabled = clk_cckx_gate_is_enabled,
+};
+
+static struct clk_cckx_gate clk_cck0 = {
+	.map_offset = MDF_CKGCR_REG,
+	.bit_idx = 1,
+};
+
+static struct clk_cckx_gate clk_cck1 = {
+	.map_offset = MDF_CKGCR_REG,
+	.bit_idx = 2,
+};
+
+static int stm32_mdf_core_register_clock_provider(struct platform_device *pdev,
+						  struct stm32_mdf_priv *priv)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct clk_hw_onecell_data *clk_data;
+	struct property *prop;
+	const char *clk_name;
+	u32 ckgcr = 0;
+	int index = 0, ret, clk_id;
+	struct clk_hw *mdf_hw[] = { &clk_cck0.hw, &clk_cck1.hw };
+	struct clk_cckx_gate *gate;
+
+	clk_cck.hw.init = CLK_HW_INIT_PARENTS_DATA("clk_cck", clk_cck_parent_data,
+						   &clk_cck_ops, 0);
+	clk_cck0.hw.init = CLK_HW_INIT_HW(STM32_MDF_CCK0, &clk_cck.hw, &clk_cckx_gate_ops,
+					  CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED);
+	clk_cck1.hw.init = CLK_HW_INIT_HW(STM32_MDF_CCK1, &clk_cck.hw, &clk_cckx_gate_ops,
+					  CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED);
+
+	clk_cck.priv = priv;
+
+	ret = devm_clk_hw_register(dev, &clk_cck.hw);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register clk_cck");
+
+	clk_data = devm_kzalloc(dev, struct_size(clk_data, hws, STM32_MDF_MAX_CCK), GFP_KERNEL);
+	if (!clk_data)
+		return -ENOMEM;
+
+	of_property_for_each_string(node, "clock-output-names", prop, clk_name) {
+		if (index >= STM32_MDF_MAX_CCK) {
+			dev_err(dev, "Too many cck providers defined\n");
+			return -EINVAL;
+		}
+
+		if (!strncmp(clk_name, "cck0", 4)) {
+			clk_id = 0;
+		} else if (!strncmp(clk_name, "cck1", 4)) {
+			clk_id = 1;
+		} else {
+			dev_err(dev, "Unexpected cck clock provider name [%s]\n", clk_name);
+			return -EINVAL;
+		}
+
+		gate = to_clk_cckx_gate(mdf_hw[clk_id]);
+		gate->map = priv->regmap;
+
+		ret = devm_clk_hw_register(dev, mdf_hw[clk_id]);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to register %s clock provider",
+					     clk_name);
+
+		clk_data->hws[index] = mdf_hw[clk_id];
+
+		/* Configure the CCKx clock as output */
+		ckgcr |= clk_id ? MDF_CKG_CCK1DIR : MDF_CKG_CCK0DIR;
+
+		index++;
+	}
+
+	/*
+	 * Set num to max number of clock. This allows any clocks indice below maximum
+	 * in of_clk_hw_onecell_get, whatever the actual number of providers.
+	 */
+	clk_data->num = STM32_MDF_MAX_CCK;
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_data);
+	if (ret) {
+		dev_err(dev, "Failed to add %s clock provider: %d\n",
+			clk_name ? clk_name : "", ret);
+		return ret;
+	}
+
+	/* Configure CKGCR register */
+	return regmap_update_bits(priv->regmap, MDF_CKGCR_REG,
+				  MDF_CKG_CCK1DIR | MDF_CKG_CCK0DIR, ckgcr);
+}
+
 static int stm32_mdf_core_parse_clocks(struct platform_device *pdev, struct stm32_mdf_priv *priv)
 {
 	priv->kclk_rate = clk_get_rate(priv->kclk);
 
-	return 0;
+	/* The consumer assigns the CCK rate after the provider is registered. */
+	return stm32_mdf_core_register_clock_provider(pdev, priv);
 }
 
 static int stm32_mdf_core_parse_of(struct platform_device *pdev, struct stm32_mdf_priv *priv)
diff --git a/drivers/iio/adc/stm32-mdf.h b/drivers/iio/adc/stm32-mdf.h
index b334769f8b17..e3617b181e28 100644
--- a/drivers/iio/adc/stm32-mdf.h
+++ b/drivers/iio/adc/stm32-mdf.h
@@ -174,6 +174,9 @@
 
 #define STM32MP25_MDF_IPIDR_NUMBER 0x00110032
 
+#define STM32_MDF_CCK0 "clk_cck0"
+#define STM32_MDF_CCK1 "clk_cck1"
+
 /*
  * struct stm32_mdf - STM32 MDF driver common data (for all instances)
  * @filter_list: pointer to filter interfaces list
@@ -216,6 +219,8 @@ static inline struct regmap *stm32_mdf_regmap_init(struct device *dev, struct cl
 int stm32_mdf_core_start_mdf(struct stm32_mdf *mdf);
 int stm32_mdf_core_stop_mdf(struct stm32_mdf *mdf);
 int stm32_mdf_core_trigger(struct stm32_mdf *mdf);
+int stm32_mdf_core_restore_cck(struct stm32_mdf *mdf);
 int stm32_mdf_core_lock_kclk_rate(struct stm32_mdf *mdf);
 void stm32_mdf_core_unlock_kclk_rate(struct stm32_mdf *mdf);
+unsigned long stm32_mdf_core_get_cck(struct stm32_mdf *mdf);
 

-- 
2.43.0

