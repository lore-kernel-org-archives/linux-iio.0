Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010069.outbound.protection.outlook.com [52.101.229.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B520826ED3E;
	Thu, 10 Sep 2026 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030579; cv=fail; b=sd+AGGtzUBdWA+sxp8X7vinyfBSO3K6Op2r2XHi272OYSIvabVaJ4EShbGO/mR5CJDzy8PzjffWELIXdyqtS9OX/2sKqELhDLAB2xiIgl9hl8hF+DdsVVEf717qwIpVXpq1ZOBR4cw7MdAUgNempqAZJJR34NBwc/xDc34wKg1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030579; c=relaxed/simple;
	bh=DouRX1+/i+eceTMr3qy4mhHGiG1Svh1YDLBQXeQS5cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gh/rwfeq9q+WIQp2fQuLfMUnmAmp1fDlz7HO2gzGZCIpybQv+x4YA9HvQIwj4S8sCQsN5O/24Ag4miAA0eDzRrmAM10uNGXJntpUUS4HDxCOclTl6g5yQXd9adV3LA6TlbC4VimdS14/9qb64QUHKlhbwZu4xv8L0R8Wspy4Pcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=A6O90P60; arc=fail smtp.client-ip=52.101.229.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="A6O90P60"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s/RMvw7Ae98LD5L+PPGS1l+xOsHzflyew8bh96CVlB9IbBVQHCtCJAoLe9TQfVJrdWNbGpouVNtnIwhfE1BBN/BC4MtHxWpQnD0nh5vp+RJAoQbYrp0i9x8zNJ2oyp9wPfhFDzRKxH27uEv8EWBoLssfEA+K7TTcCK7d4kYorNjG2i8Zt7Q1V7x/JucMauJXVP8lnmImObP7ETmqsb2oozm1/iIKi1FX2WGqmNeAH3L6nB6CLw/WN8FP1JVvrWNUYq+xXljURC147sZiH1cEGax0pyhq9hdIicKLJpMJza9xFL8Ubt7VrkgKW3N2Lyp0dQx5zPDkxPig3NNdMWzG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsIjheF/vgrsbQysY/QyGkep4JDhQvy7IvmRY0oQ9pA=;
 b=B0L+BNruanazo6JlU2W3STyyL+gM2ToaG9G2piCX755GNHV7tHq3o/1ApK4lVmAXf2tbBB4Bxw/256dZZTn+dx5qkhdVQx7O4InbQNIEN8gPlKL8XuyoIzL4qKdlX+kMqkL89IFj2xvgz3yh29xKLoBhXwURRM6gadR9bARP4pHtIGNAp8jIJEVLGNsek9BUiIX3eHOp+JN40kS5zPzK7Xb+GlmaMlvUnDXUxtzyNnyyrgjK7OCkffbI+deMTg2f8uBMuKKgi22VS3LdgJoCzwBZx42L++KJZwe3uh4UXR/rGcZ0Di9ymNljoGcPM3Aty/UA3ncAmjZRzDcmcEkI7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NsIjheF/vgrsbQysY/QyGkep4JDhQvy7IvmRY0oQ9pA=;
 b=A6O90P602hIt306Mp5XYM/wmBj9ra1/f/uXeiY42H4xgaoJj7VGmBgDMCgRKgH/IUTpUYwCd2qLxkUTfcxq1xDDuV0M31rjf5X9IkiVkOfZ5Ytaj5hhxqKh0tRsbq/iMewNUgNo0rVtsOLJYxVpWMF3tJU31P6VYNfGFfDc64RI=
Received: from OS3P286CA0026.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f4::9)
 by OSZPR01MB9345.jpnprd01.prod.outlook.com (2603:1096:604:1d9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 08:56:11 +0000
Received: from OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f4:cafe::32) by OS3P286CA0026.outlook.office365.com
 (2603:1096:604:1f4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 08:56:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20F.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Thu, 10 Sep 2026 08:56:10 +0000
Received: from demon-pc (REE-0064895.adwin.renesas.com [10.226.92.160])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id B2CF7300037A;
	Thu, 10 Sep 2026 17:56:06 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/9] iio: adc: rzt2h: expose sampling frequency
Date: Thu, 10 Sep 2026 11:54:27 +0300
Message-ID: <20260910085430.3173166-7-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910085430.3173166-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260910085430.3173166-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20F:EE_|OSZPR01MB9345:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f54193be-6690-4cf8-0ff1-08df0f195c81
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|7416014|6133799003|10067099003|22082099003|11063799006|18002099003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	/6P8VmhZSDSMT/n3iH5fV5HyDJknosRzTbg6V66pTkyOixmMuI/gJ8OMvSuuxQr3dXKFvLsn3I1E1zbf5XxYLR5D6lTF0pfOWEPPHHsP09fdvAsODkx8k6Ko79p7WUo/W+JuHZKAlc54HR+fCUODPl871bgWK8P42vWvGTnX0kLqfqnYlbOyNNzVg0dSt3EawOYmvQfPzEDZz9Hz+rLVESi5v216oC/lqbCNh3QTSnaYDH/5KkzoeQgu33vw7l3BVdAWQ1dGwOwiHAlgp8g8TWyU4II72mSW/reeca5f8VRTRSxCIWPpT/kZWZGcVVpCRO0dvdM5eIw51VOxmYU+f1Ai10q+Jk53X0v4b4JLZgFUs+Uac7szvxPQPChmx7/5wJ5J55RfTZBIzju9cUB5/+HZHsz74eyPD26ntr7vx2aEnOod5vqTV6Mg+gBPx+iMd1maUn+87aTs4fA3a9sfBlwASrK7wljNj/VduWtUHQ+MBpF5Nt773/AjJ+BPJ77YUsZ/UjnAYl4J+fl0ZL+pgLeEkK8xeaJAS92C1L/o9fa6alAdoG8krG+Tt6mzvPO1dsF0sPa55JFeDPDkEdsXv0cI4jz5eXJJPk6ypwqlmJf26dGrakHihDHcws1OCQwgYdfEofjp/xsGQTsvfpayYnR/eUneVkOsr90rwawN3f5LEo4gDLTJunR/iTtQI7kNIbb2DOFR4sqGs2z8Ldws30Bd4psKJTsamWkK6VUeIHDbz5JZlLAKyJ916U1jO8h7
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(7416014)(6133799003)(10067099003)(22082099003)(11063799006)(18002099003)(56012099006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CH2pnxC3rIwlTWHiXgWLz6424rRV4gQpYz6GunKCHHX4u7Z9MjCf0PvsnZYAhTYi80ZT5PLlRSUAuqAjfcpQwafq/vxf1HeiXUwzsRhvxTRtwMlc9w4N0CujNL3KYpTgaD58BGuqXS/Nx4QjKwK07ewxa8Yn12KsnTaAPAG+7LhVv02+oGekoukDm6MBNkkMK7wuWZtqx+OzuBSrANWCv4e7ZFHk9pBbrGlKLEXLH8zY5H+ZjH7RPRhHWmYRCsHM5alGLwaSjfCo2P7IH9xIKnHv5jCtbhXrKpfhuDf2kUloGYLx+qDl/iIW0DJ8IrccXocmu0NVQyAOFpuLlGvsGkD7UrzcD4/yzqmdY8H8jQLmpCejr/YFMEs+Rce/Ig9FQMZiw1fADJ30Fxuy3xKMQB39wQYKKks6ZPVCmC1yRXQLgtOjtwxRJX5YhGdrxOKY
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 08:56:10.9805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f54193be-6690-4cf8-0ff1-08df0f195c81
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9345

Expose the sampling frequency as a per-channel IIO_CHAN_INFO_SAMP_FREQ
to let userspace control conversion time.

Each channel conversion takes a fixed 13 ADCLK cycles plus the sample
time programmed in ADSSTRn, giving a rate of ADCLK / (13 + ADSSTRn).

Read the ADCLK rate from the "adclk" clock to derive the frequency.

Claim direct mode while writing so the rate cannot change during a
capture.

Program the sample time into ADSSTRn for each enabled channel on single
reads and on buffer enable.

Wait for the maximum amount of time a conversion can take + 1 jiffy for
the completion event to come after triggering a single read.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * extend the single read completion timeout to maximum possible
   conversion time + 1 jiffy

 drivers/iio/adc/rzt2h_adc.c | 120 ++++++++++++++++++++++++++++++++++--
 1 file changed, 115 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 0460dffe189e..8ba7b0fde8a1 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -2,6 +2,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/cleanup.h>
+#include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
@@ -31,6 +32,18 @@
 
 #define RZT2H_ADDR_REG(x)		(0x20 + 0x2 * (x))
 
+#define RZT2H_ADSSTRn(n)		(0xe0 + 0x1 * (n))
+
+/*
+ * Each A/D channel conversion takes a fixed base of 13 ADCLK cycles plus the
+ * sample time programmed in ADSSTRn, giving a conversion rate of
+ * ADCLK / (13 + ADSSTRn).
+ */
+#define RZT2H_ADC_CONV_CYCLES_BASE	13
+#define RZT2H_ADC_SST_MIN		0x7
+#define RZT2H_ADC_SST_MAX		0xff
+#define RZT2H_ADC_SST_DEFAULT		0xb
+
 #define RZT2H_ADCALCTL_REG		0x1f0
 #define RZT2H_ADCALCTL_CAL_MASK		BIT(0)
 #define RZT2H_ADCALCTL_CAL_RDY_MASK	BIT(1)
@@ -79,6 +92,10 @@ struct rzt2h_adc {
 	unsigned int num_channels;
 	u16 buf[RZT2H_ADC_MAX_CHANNELS];
 
+	unsigned long adclk_rate;
+	int samp_freq_avail[3];
+	u8 sst[RZT2H_ADC_MAX_CHANNELS];
+
 	int irq;
 };
 
@@ -109,6 +126,11 @@ static void rzt2h_adc_stop(struct rzt2h_adc *adc)
 	writew(reg, adc->base + RZT2H_ADCSR_REG);
 }
 
+static void rzt2h_adc_set_sst(struct rzt2h_adc *adc, unsigned int ch, u8 sst)
+{
+	writeb(sst, adc->base + RZT2H_ADSSTRn(ch));
+}
+
 static int rzt2h_adc_read_single(struct rzt2h_adc *adc, unsigned int ch, int *val)
 {
 	int ret;
@@ -124,13 +146,18 @@ static int rzt2h_adc_read_single(struct rzt2h_adc *adc, unsigned int ch, int *va
 	/* Enable a single channel */
 	writew(RZT2H_ADANSA0_CH_MASK(ch), adc->base + RZT2H_ADANSA0_REG);
 
+	rzt2h_adc_set_sst(adc, ch, adc->sst[ch]);
+
 	rzt2h_adc_start(adc, RZT2H_ADCSR_ADCS_SINGLE);
 
 	/*
-	 * Datasheet Page 2770, Table 41.1:
-	 * 0.32us per channel when sample-and-hold circuits are not in use.
+	 * Conversion can take up to ~4.3us at the maximum configurable ADSSTRn
+	 * (ADSSTRn + 13 cycles at 62.5 MHz), which rounds up to 1 jiffy. A bare
+	 * 1-jiffy timeout can expire almost immediately if it's armed right
+	 * before a tick, so add one more jiffy to guarantee the conversion time
+	 * actually elapses.
 	 */
-	ret = wait_for_completion_timeout(&adc->completion, usecs_to_jiffies(1));
+	ret = wait_for_completion_timeout(&adc->completion, usecs_to_jiffies(5) + 1);
 	if (!ret) {
 		ret = -ETIMEDOUT;
 		goto disable;
@@ -407,6 +434,7 @@ static int rzt2h_adc_buffer_postenable(struct iio_dev *indio_dev)
 	iio_for_each_active_channel(indio_dev, scan_index) {
 		chan = &indio_dev->channels[scan_index];
 		val |= RZT2H_ADANSA0_CH_MASK(chan->channel);
+		rzt2h_adc_set_sst(adc, chan->channel, adc->sst[chan->channel]);
 	}
 
 	writew(val, adc->base + RZT2H_ADANSA0_REG);
@@ -443,6 +471,23 @@ static int rzt2h_adc_buffer_predisable(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static int rzt2h_adc_sst_to_freq(struct rzt2h_adc *adc, u8 sst)
+{
+	return adc->adclk_rate / (RZT2H_ADC_CONV_CYCLES_BASE + sst);
+}
+
+static u8 rzt2h_adc_freq_to_sst(struct rzt2h_adc *adc, int freq)
+{
+	unsigned int cycles;
+
+	cycles = DIV_ROUND_CLOSEST(adc->adclk_rate, freq);
+	cycles = clamp_val(cycles,
+			   RZT2H_ADC_CONV_CYCLES_BASE + RZT2H_ADC_SST_MIN,
+			   RZT2H_ADC_CONV_CYCLES_BASE + RZT2H_ADC_SST_MAX);
+
+	return cycles - RZT2H_ADC_CONV_CYCLES_BASE;
+}
+
 static int rzt2h_adc_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int *val, int *val2, long mask)
@@ -461,6 +506,51 @@ static int rzt2h_adc_read_raw(struct iio_dev *indio_dev,
 		*val = 1800;
 		*val2 = 12;
 		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = rzt2h_adc_sst_to_freq(adc, adc->sst[chan->channel]);
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int rzt2h_adc_write_raw(struct iio_dev *indio_dev,
+			       struct iio_chan_spec const *chan,
+			       int val, int val2, long mask)
+{
+	struct rzt2h_adc *adc = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		if (val <= 0)
+			return -EINVAL;
+
+		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+		if (IIO_DEV_ACQUIRE_FAILED(claim))
+			return -EBUSY;
+
+		adc->sst[chan->channel] = rzt2h_adc_freq_to_sst(adc, val);
+
+		return 0;
+	}
+	default:
+		return -EINVAL;
+	}
+}
+
+static int rzt2h_adc_read_avail(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				const int **vals, int *type, int *length,
+				long mask)
+{
+	struct rzt2h_adc *adc = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*vals = adc->samp_freq_avail;
+		*type = IIO_VAL_INT;
+		*length = ARRAY_SIZE(adc->samp_freq_avail);
+		return IIO_AVAIL_RANGE;
 	default:
 		return -EINVAL;
 	}
@@ -473,6 +563,8 @@ static const struct iio_buffer_setup_ops rzt2h_adc_buffer_setup_ops = {
 
 static const struct iio_info rzt2h_adc_iio_info = {
 	.read_raw = rzt2h_adc_read_raw,
+	.write_raw = rzt2h_adc_write_raw,
+	.read_avail = rzt2h_adc_read_avail,
 };
 
 static irqreturn_t rzt2h_adc_isr(int irq, void *private)
@@ -487,7 +579,9 @@ static irqreturn_t rzt2h_adc_isr(int irq, void *private)
 static const struct iio_chan_spec rzt2h_adc_chan_template = {
 	.indexed = 1,
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-			      BIT(IIO_CHAN_INFO_SCALE),
+			      BIT(IIO_CHAN_INFO_SCALE) |
+			      BIT(IIO_CHAN_INFO_SAMP_FREQ),
+	.info_mask_separate_available = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	.type = IIO_VOLTAGE,
 	.scan_type = {
 		.sign = 'u',
@@ -512,8 +606,11 @@ static int rzt2h_adc_parse_properties(struct rzt2h_adc *adc)
 	adc->num_channels = ret;
 	adc->channels = chan_array;
 
-	for (unsigned int i = 0; i < adc->num_channels; i++)
+	for (unsigned int i = 0; i < adc->num_channels; i++) {
+		adc->sst[chan_array[i].channel] = RZT2H_ADC_SST_DEFAULT;
+
 		chan_array[i].scan_index = i;
+	}
 
 	return 0;
 }
@@ -565,6 +662,7 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct rzt2h_adc *adc;
 	struct resource *res;
+	struct clk *adclk;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
@@ -592,6 +690,18 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 
 	adc->phys_base = res->start;
 
+	adclk = devm_clk_get(dev, "adclk");
+	if (IS_ERR(adclk))
+		return dev_err_probe(dev, PTR_ERR(adclk), "failed to get adclk\n");
+
+	adc->adclk_rate = clk_get_rate(adclk);
+	if (!adc->adclk_rate)
+		return dev_err_probe(dev, -EINVAL, "invalid adclk rate\n");
+
+	adc->samp_freq_avail[0] = rzt2h_adc_sst_to_freq(adc, RZT2H_ADC_SST_MAX);
+	adc->samp_freq_avail[1] = 1;
+	adc->samp_freq_avail[2] = rzt2h_adc_sst_to_freq(adc, RZT2H_ADC_SST_MIN);
+
 	pm_runtime_set_autosuspend_delay(dev, 300);
 	pm_runtime_use_autosuspend(dev);
 	ret = devm_pm_runtime_enable(dev);
-- 
2.55.0
