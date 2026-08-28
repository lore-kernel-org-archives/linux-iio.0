Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010017.outbound.protection.outlook.com [52.101.229.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB3E4746BA;
	Fri, 28 Aug 2026 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929292; cv=fail; b=aVZ/cxczmEFxedT4bsZ5RJ65f5mc/T7YFyrJyELudIz03Z8qrol6TeEXyneap/8Dbmw3+0unsO8kuF/r3YywJVQ++/gzsJ7OzU3JN5/OEElst75Ydg7IiMc6kcdhTM0SCnMEyEHYvE6mHrHOTPQXMxSmz5yNF4Xk/nGQocTLjzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929292; c=relaxed/simple;
	bh=c4hLos7XUF1ogAnLG82DrbmWK9GlnSq1SUE5kS9Ayl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cizLtSFGuUpIIGiXDLQ0RYEvALToaobzYKhDKFX2FSncY+T2iXDsaxv6QHmRsHmHuG34QJqru75eo5twyfVgXjnXIOvr9PP9n+TGqH03uBNYUqyK3GJIWO6sJS7vQGpW80oLpywKpsPch/Xkdn0O8MBOHCCGv/gE/BN+QFH+3Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=LJHU3GR4; arc=fail smtp.client-ip=52.101.229.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="LJHU3GR4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JLM8kHMVaRsiVxcooNvc5wmLYrzywvpPrKALlwrTWMVqA3vTr9XjBuRjK41IgRdSdLiqrUQdHaC3PIteZFLj1BAl5a9KGV1/qzReK5nNaUGchsO1Eh6DeSwsw9xW0U6WfFbbJIINxOtTySC4mPuUBnfM+3tHSUcc1quxAWIPfS3PhFMMFz2dpikihfy4Pv9p6vR3oif84VDt62JqFVA8vUZ3WWz22UpcTg2gPYDtwDOjhUXXQrvQZXQcbl7fVzlYtCiT236e+chsZV7JBhbwomHXPjauW5nRWITUq4Fxa/A3B9aTiT6KMZI1z+Ll6UWtRjtOleBL78uYhN/pgT6qCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ph4qVJGbYA2CKAapsQj6lrcZIAPn3Cwri48KFw9W2+s=;
 b=RklZ+lInb4eoDcEJ3op+sHCG9X34R2plsYLvG7eoAHzCWaj9yg4/6W4Z9zBaBpq+hyiifsTAeJV3BrVOfGNz+5ljHlN22B5+/m69+7Nmwf/jRxkAFxZbKuSUz/0qnliajstcC6Kmym7B/t7S6ijC4PK16wH8UjwB+SoaTG4i6dnym+NzlR+gSx2dOvv1orIZ9fJS3dir/gtpfj3uO/T/hyE3GIiJuzMAy8AOdxr6STjIHHDdodtvfucdPyinLpMUT9fVLtp0foo7mU/eBiyj4tOUYb9Fsy6URg9xSHK3THYpJw4nElLZx42F7XpdoFojTqhdTWUef5BGJQSPFRh1tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ph4qVJGbYA2CKAapsQj6lrcZIAPn3Cwri48KFw9W2+s=;
 b=LJHU3GR4t9C7qFCRzN5pYv0mjqoCku6Ha7HhQnQduNXjvw49RNs5IddPzMogvqvIy3+KtXH/Ktad+Y9/nUmPSp9A1uL2d1FGdmjNQjSwKY3JpdGTl6o8ANpYd53TopWv89KApT7bL1higFb6sHJn2DQarsOT5juwqVz/h5SFdMk=
Received: from OS3PR01CA0039.jpnprd01.prod.outlook.com (2603:1096:604:dd::8)
 by TYYPR01MB8094.jpnprd01.prod.outlook.com (2603:1096:400:fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:01:24 +0000
Received: from OS1PEPF0000D214.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:dd:cafe::41) by OS3PR01CA0039.outlook.office365.com
 (2603:1096:604:dd::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 15:01:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D214.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 28 Aug 2026 15:01:23 +0000
Received: from demon-pc (REE-0055761.adwin.renesas.com [10.226.92.7])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 9AF13300036C;
	Sat, 29 Aug 2026 00:01:18 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Jonathan Cameron <jic23@kernel.org>,
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
	linux-kernel@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH 6/9] iio: adc: rzt2h: expose sampling frequency
Date: Fri, 28 Aug 2026 17:59:39 +0300
Message-ID: <20260828145943.2077589-7-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828145943.2077589-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260828145943.2077589-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D214:EE_|TYYPR01MB8094:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b0095ca7-ef9f-48b9-22db-08df051539d1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|7416014|376014|1800799024|23010399003|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jJiy5NYQZyPR8wq7oK6xJV9IOPdambjxYVXhhtHKSxQby/Vd7S7kqVJOX5Mk89M30PITaUD3t12F74jrlc7DeaQO4EBwm9mmjDDUA58/FUEGEMm7vc5NvhFumru/mZWy+WTcplRp9l79ArfqDKZ2Z3Z4JAlw0gV5tgXI4T7qVhjF6BQw/ZEL7d85boYGwWxA3lMLhqNAkmEhkpm3tQYkRntB+fdhueosgB2HGdb/t2V4zc6iVL45s5RKo5fKWSUMLO+kNml8xxAuGb++Bg6IjVah7WoU8DZQNJxQ2pMhCXan6xj7Cpbfwm+xo3mxvfj2s5zm9cc5CFWo6/GLlqkvkX6ycgVLeIkGTzoU2SHrw3gpyvbldeTAHgFTwoysTgoMUMUM46N5r7qme4P7N30z+BjCDqcy0Y4q0h4f+h0NKawWSfCUZEJTC6O35oAVaH/FVoBCodpktv9/h8LBZorK1EhZeoHDPpyZLJeWD+2Bliiv4Ibxq2ZSqjJmrUKCfEK/e2aDnrHtP7z/zgpNdMD5k0leqzf4s/3FC9ngUce2v1Xn7n1xg4q75kAFrCkncPXA1e5uQ05wBeZ1/kE/En00ovRfrl+WM7ZnuOvLTWDbYyYZNy52KaSLu+YF8gD0NTR+fj4WnNByi7SiKV3iBCkp4/asJYbI7Qj87fNBEw9GzU6HR7euYgiSSG6RuB3x5k6RQVZNCbLXQvKRZKVGK/X6nQ==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(7416014)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tHaO6OqBvsB3I9AJqWvgOpSPyZTS5mg06idJ2VykPtS5+efaPpcLLFTGarI+vvhD9GjoxMWXWQS5/nsVhWtblxniGCfaopW1WCc7LgR7BxJZ0HYJEMDa2454xHMxC6lfA+jHuzNFYR+Drqie5PEH4mOJJUiKwmpBscZRWkPx3m8pA49tUoCF3PaMlMXhKjDmd3Wx73WL4KZ5OqDy4ItEPckEsouzQiqtjn4iJz52eOVzawOu9obS1Znv7Z3YBdTOMp7aymCCcGbnxoXadhM4cStyAE7N1vvdk2ufM/yI7EyrklWEsg5MExRBlVqm/FrW+YAptuuKAkgk7YyJdJg7lOaPT0HkUlt8D/Dxd+sh9qLkkKTrwdiB8MhlzJNgWR1r2QNZ2lxIvxOoMzamTy2f8l2fVjBAxxbw0a1NS8H0r31lP5BiisJS8JiYjCoAwjcW
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:01:23.1623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0095ca7-ef9f-48b9-22db-08df051539d1
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D214.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8094

Expose the sampling frequency as a per-channel IIO_CHAN_INFO_SAMP_FREQ
to let userspace control conversion time.

Each channel conversion takes a fixed 13 ADCLK cycles plus the sample
time programmed in ADSSTRn, giving a rate of ADCLK / (13 + ADSSTRn).

Read the ADCLK rate from the "adclk" clock to derive the frequency.

Claim direct mode while writing so the rate cannot change during a
capture.

Program the sample time into ADSSTRn for each enabled channel on single
reads and on buffer enable.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/iio/adc/rzt2h_adc.c | 111 +++++++++++++++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index d76226375f22..2e13f931a2e9 100644
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
@@ -124,6 +146,8 @@ static int rzt2h_adc_read_single(struct rzt2h_adc *adc, unsigned int ch, int *va
 	/* Enable a single channel */
 	writew(RZT2H_ADANSA0_CH_MASK(ch), adc->base + RZT2H_ADANSA0_REG);
 
+	rzt2h_adc_set_sst(adc, ch, adc->sst[ch]);
+
 	rzt2h_adc_start(adc, RZT2H_ADCSR_ADCS_SINGLE);
 
 	/*
@@ -397,6 +421,7 @@ static int rzt2h_adc_buffer_postenable(struct iio_dev *indio_dev)
 	iio_for_each_active_channel(indio_dev, scan_index) {
 		chan = &indio_dev->channels[scan_index];
 		val |= RZT2H_ADANSA0_CH_MASK(chan->channel);
+		rzt2h_adc_set_sst(adc, chan->channel, adc->sst[chan->channel]);
 	}
 
 	writew(val, adc->base + RZT2H_ADANSA0_REG);
@@ -433,6 +458,23 @@ static int rzt2h_adc_buffer_predisable(struct iio_dev *indio_dev)
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
@@ -451,6 +493,51 @@ static int rzt2h_adc_read_raw(struct iio_dev *indio_dev,
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
@@ -463,6 +550,8 @@ static const struct iio_buffer_setup_ops rzt2h_adc_buffer_setup_ops = {
 
 static const struct iio_info rzt2h_adc_iio_info = {
 	.read_raw = rzt2h_adc_read_raw,
+	.write_raw = rzt2h_adc_write_raw,
+	.read_avail = rzt2h_adc_read_avail,
 };
 
 static irqreturn_t rzt2h_adc_isr(int irq, void *private)
@@ -477,7 +566,9 @@ static irqreturn_t rzt2h_adc_isr(int irq, void *private)
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
@@ -502,8 +593,11 @@ static int rzt2h_adc_parse_properties(struct rzt2h_adc *adc)
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
@@ -552,6 +646,7 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 	struct iio_dev *indio_dev;
 	struct rzt2h_adc *adc;
 	struct resource *res;
+	struct clk *adclk;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
@@ -579,6 +674,18 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 
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

