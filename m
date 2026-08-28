Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011063.outbound.protection.outlook.com [52.101.125.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28534746B3;
	Fri, 28 Aug 2026 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929287; cv=fail; b=IV8wZpEwwaM5/CJGfy2Yy3/lEdDqSx/QN/gCM6SBrqYruj/4onHk4fbaEUWSwNrkwPDUNgwBxhfwwYv7WzKkp74tmljj0bftWxzot4U1MyXQ1o/A/tjPLLHkV7LQvUzdmepkSLnFRiSV4YjwU2kpdHJJ6QurNICv2WUz8BQRFVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929287; c=relaxed/simple;
	bh=atvDQwHlcC3IKXJn82VKjgfQQLYERC0j9BsS5+IT9oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sa+KTnB4MaRe9YcPwFCDmv4r4zF91g3KX8r3ne6rFYNOzS2YqfSt+mNJKJhvxRgU99L65hnkS5tka28IoRV3iDSV8GVVe6LQVir+wtp1Rtt/C8DDIUY+Xue4xLAJMJa1AJqHsgXFbapfue0MyizFUKwnfvfMUVuRr7ghTKmbx/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=QG9Ca5XE; arc=fail smtp.client-ip=52.101.125.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="QG9Ca5XE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YX/pvm5Rf2nybE8HhkjApFxRAmVmrSVVquhWHQtNWnEVm2R6e6l27Id0voBjNZeLFU/WInxTko1nFRZhGlVT2MmFbNax/dDaQx3yjWq61tHB7LZ3M94r76DTlqcuBw4vS8b7tG3NVTQ+ZsMUnp+JwoE8db7hGKuVnVu9f++xKfrYf27OuVbouB5MGUm1Ok0jDViFRpn2q6JMKA5oaE3KuP03f/ty1JkNgjxRUnBb627XLFXMGXhe94YcJMP2QINw7oqBeGoYqfFm/LXc7Bwayw5HBdA+rvzFH7GRUGmL8v8fnzGW0uzeOMyiGedd/Qmh21ywZPDbLPwyskbdHkpdww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oITNkf9ls0OapWqIlqpzrYLcG2WXSTYcKeYl1YsLksc=;
 b=Mqj4ZXiTX41mIYTUqSfcg4uALUW1wa/nzmjMfUfK2R/3BWkmNzy4rA0u2HaPcTIiAgqW2VWcCsZGNZ3iZn0W7F5mT0LDKHqi9DxnFhUInRhNIOo2vZ1DDdZlYsc4T6tuOKdoPjRMbkiAh4BmcC9b2Mz/0/rbvs7Dy5kCJ15bTxjW0byTNqbvn3+crEe4NX0EZzmTu/+4R12adTM/6C/nOicdE45b3aYKDeUGTJkdvOZsJdm3kwDChFUoe9iDXg1siK+I5q3l07UV1rkEBgKHw8zfPN6bV/DC4AmrGosQAKC3+bIyXEI9mnEJ25ZDRC32SgQD3cMz7KOcfzHN7clzjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oITNkf9ls0OapWqIlqpzrYLcG2WXSTYcKeYl1YsLksc=;
 b=QG9Ca5XEoReLHkd0TmG9Qaj+zrUjO8ClK+yIRrkYKSRxOvahbKePx4k4+1b1aswgVBgHNMhyBc4xPedPK3MJodE3RzgTgHg4y0Zamh6n37rYmjfjZanxv0fw5VP+7aLjQRiUCLOHAtYz0xL+j+lB452D1FYboqJ1KktQqUEuWJI=
Received: from TYCP286CA0143.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:31b::19)
 by TYCPR01MB8326.jpnprd01.prod.outlook.com (2603:1096:400:15b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:01:18 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b:cafe::4d) by TYCP286CA0143.outlook.office365.com
 (2603:1096:400:31b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.11 via Frontend Transport; Fri,
 28 Aug 2026 15:01:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 28 Aug 2026 15:01:17 +0000
Received: from demon-pc (REE-0055761.adwin.renesas.com [10.226.92.7])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 5486A3000349;
	Sat, 29 Aug 2026 00:01:12 +0900 (JST)
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
Subject: [PATCH 5/9] iio: adc: rzt2h: implement DMA buffer support
Date: Fri, 28 Aug 2026 17:59:38 +0300
Message-ID: <20260828145943.2077589-6-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|TYCPR01MB8326:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1a7f750d-25b3-4d9e-852b-08df0515367c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|1800799024|23010399003|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	itRVB+HY3qJ/CrKRxudLnGlsR37I0/SVm/i5f9SxtYmvUCfsQsWkVkQwpX0dcguAXMDCh835IN/2AMeSPgoegdjsoiuOUfUWNf+RcGoo0v3JtLfqDoG93DU0TAUd9zNsRjCAjnoNijxMzv0m/VH57lpNbSruV98AQCr6Wh8EGB5rrpmczVLZpwL64OGo3mbXQdnjHTcth9fQA7JGQQNli+T44hzNe11Za47r95/MF9z5hcXlHe2RxdmP8F2bnJM8opIi8QQGo3VbOSP+Zgz+OIYYPZsW83FVl29w7UJ60pWuV9oUDGCivHwfRNtr8OrfRjXq7eFoG4aIcxVwfEE0fyq/AVq4czFGDkW8jyB78th7qq/giBMX445jypnsePWM9dr4/5dLPYiy37VuVOU4FhdzOnhWZ2Z9xNVCBOw8dKXKkHgdLeTM0deVKmpwu8RN2ZV6TsvqU4KEXRQFnsCjEm7CQz7c3eG6/m0JWTpeQtLKDOCaGjwTh620XE9g34s7uVoTiIkmJ0272eXnXhx+2PFQ1Vm+IxL9Er6/U0tiJy7Iy9wId+kx6j2NDhxo4Ap1O1qrQ+oSKmud57XoPztnWc23o94uYSwZlNy/BKXTSnLrpmAnvw7KG210r/vX6fHmHCYgBsvemB3GKAxEG33u3/4FVfJc2s+5Bwugd/Dr3N6Drjg4PPzCZLJSgyGOyjViOyaLfZdgz1EyVoafUNQR8Q==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	AeFKJ58CIqMHwECR+MyO9QTJUhdTIAInYzttUssTYSLtQ5BawbH9MeEKirNRxnObymSwRqQRFCX92/CnFoxYLZBqPtcHP3DTKClFHcg8MJmOiPmcdi3L6QgDRgSlrhNJ0QibjlJdSZYl0J2tYCrS2jo5KxPqMOW7brqLNAKpluAsBnHomP+jDnAlB0ypAtjdngciNlTSroZEX0lOqX7DE2xXJ/64jYCAKqLNDoGsr2Q79PLQJedZGWLibfXJ6Pkcl3AlTdGV/eFlnZ3k1mgaodokEGLiniKKqJ/ZkX5iYIlI2sCnOxfhU/vKgdwgn0tzDzxkx/NjS8vhPaHmJESKInXzDpj3YFieC0hb/Ny7aVpiIKemXkcDIafyHKNSkSThWI7qMHZkozEwkN289qd6iAqtVwGjORebhQGJM/oe5+GE0d/gr82IENNwEE5Quf6X
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:01:17.5960
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7f750d-25b3-4d9e-852b-08df0515367c
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8326

Implement buffered capture using a cyclic DMA transfer into a kfifo
buffer to support continuous high-rate sampling.

On buffer enable, switch the ADC to continuous conversion mode and start
a cyclic DMA transfer over the active channels.

Because the DMA controller does not support native scatter-gather, and
because of the cyclic DMA setup, transfers must be done in widths
covering all the enabled channels.

Since DMA transfer width must be a power of two and aligned to its size,
cover the smallest power-of-two-aligned group of channel registers
spanning the enabled channels.

Split the cyclic buffer into fixed-size periods. On each period
completion, bump a pending counter and wake a consumer kthread from the
DMA callback.

For every completed period, gather the enabled channels out of the DMA
layout into the scan layout the IIO core expects and push each scan
with iio_push_to_buffers().

If the consumer kthread falls behind by a full buffer, drop the oldest
periods.

Because the DMA transfer must cover all channels between the first and
last enabled ones, skip disabled channels while compacting.

Also, the DMA controller transfers data in 32-bit words, but the ADC's
data registers are 16-bit wide, causing adjacent channel data to be
swapped. Swap consecutive channels while compacting to account for this.

Allocate the DMA buffer via dma_alloc_noncoherent() and synchronise it
per period to allow it to be cached by the CPU while compacting.

Disable the completion IRQ for the duration of the DMA transfer, as the
ICU does not mask this event from reaching the GIC even if it is being
used to drive the DMA capture.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 drivers/iio/adc/Kconfig     |   2 +
 drivers/iio/adc/rzt2h_adc.c | 339 ++++++++++++++++++++++++++++++++++++
 2 files changed, 341 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 415e519ad4eb..6c7b30d2b6e7 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1551,6 +1551,8 @@ config RZT2H_ADC
 	tristate "Renesas RZ/T2H / RZ/N2H ADC driver"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select IIO_ADC_HELPER
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
 	help
 	  Say yes here to build support for the ADC found in Renesas
 	  RZ/T2H / RZ/N2H SoCs.
diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 95bcebdc02cb..d76226375f22 100644
--- a/drivers/iio/adc/rzt2h_adc.c
+++ b/drivers/iio/adc/rzt2h_adc.c
@@ -4,11 +4,16 @@
 #include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
 #include <linux/iio/adc-helpers.h>
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
+#include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -18,6 +23,7 @@
 #define RZT2H_ADCSR_ADIE_MASK		BIT(12)
 #define RZT2H_ADCSR_ADCS_MASK		GENMASK(14, 13)
 #define RZT2H_ADCSR_ADCS_SINGLE		0b00
+#define RZT2H_ADCSR_ADCS_CONTINUOUS	0b10
 #define RZT2H_ADCSR_ADST_MASK		BIT(15)
 
 #define RZT2H_ADANSA0_REG		0x04
@@ -31,18 +37,47 @@
 #define RZT2H_ADCALCTL_CAL_ERR_MASK	BIT(2)
 
 #define RZT2H_ADC_MAX_CHANNELS		16
+#define RZT2H_ADC_CHANNEL_BYTES		sizeof(u16)
+#define RZT2H_ADC_DMA_PERIOD_SAMPLES	128
+#define RZT2H_ADC_DMA_PERIODS		64
+#define RZT2H_ADC_DMA_BUFFER_SAMPLES	(RZT2H_ADC_DMA_PERIODS * \
+					 RZT2H_ADC_DMA_PERIOD_SAMPLES)
+#define RZT2H_ADC_DMA_BUFFER_SIZE	(RZT2H_ADC_DMA_BUFFER_SAMPLES * \
+					 RZT2H_ADC_MAX_CHANNELS * \
+					 RZT2H_ADC_CHANNEL_BYTES)
+
+struct rzt2h_adc_dma {
+	struct dma_chan *chan;
+	u16 *buf;
+	dma_addr_t addr;
+
+	unsigned int period_index;
+	unsigned int period_bytes;
+	unsigned int first_chan;
+	unsigned int sample_chans;
+
+	u8 gather[RZT2H_ADC_MAX_CHANNELS];
+	unsigned int gather_len;
+
+	atomic_t pending_periods;
+
+	wait_queue_head_t wq;
+	struct task_struct *thread;
+};
 
 struct rzt2h_adc {
 	void __iomem *base;
 	struct device *dev;
 
 	phys_addr_t phys_base;
+	struct rzt2h_adc_dma dma;
 	struct completion completion;
 	/* lock to protect against multiple access to the device */
 	struct mutex lock;
 
 	const struct iio_chan_spec *channels;
 	unsigned int num_channels;
+	u16 buf[RZT2H_ADC_MAX_CHANNELS];
 
 	int irq;
 };
@@ -151,6 +186,253 @@ static int rzt2h_adc_calibrate(struct rzt2h_adc *adc)
 	return 0;
 }
 
+static void rzt2h_adc_push_period(struct iio_dev *indio_dev, u16 *period,
+				  dma_addr_t addr)
+{
+	struct rzt2h_adc *adc = iio_priv(indio_dev);
+	u16 *dst = adc->buf;
+	u16 *src = period;
+
+	dma_sync_single_for_cpu(adc->dev, addr, adc->dma.period_bytes,
+				DMA_FROM_DEVICE);
+
+	for (unsigned int sample = 0; sample < RZT2H_ADC_DMA_PERIOD_SAMPLES; sample++) {
+		for (unsigned int i = 0; i < adc->dma.gather_len; i++)
+			dst[i] = src[adc->dma.gather[i]];
+
+		src += adc->dma.sample_chans;
+
+		iio_push_to_buffers(indio_dev, adc->buf);
+	}
+}
+
+static void rzt2h_adc_advance_period_index(struct rzt2h_adc *adc, unsigned int i)
+{
+	adc->dma.period_index += i;
+	adc->dma.period_index %= RZT2H_ADC_DMA_PERIODS;
+}
+
+static void rzt2h_adc_dma_thread_loop(struct iio_dev *indio_dev)
+{
+	struct rzt2h_adc *adc = iio_priv(indio_dev);
+	int pending, drop;
+	dma_addr_t addr;
+	u16 *period;
+
+	pending = atomic_xchg(&adc->dma.pending_periods, 0);
+
+	if (pending >= RZT2H_ADC_DMA_PERIODS) {
+		drop = pending - RZT2H_ADC_DMA_PERIODS + 1;
+
+		rzt2h_adc_advance_period_index(adc, drop);
+		pending -= drop;
+	}
+
+	for (unsigned int i = 0; i < pending; i++) {
+		unsigned int backlog = atomic_read(&adc->dma.pending_periods) +
+				       pending - i;
+
+		/*
+		 * Bail if enough new periods have completed since reading the
+		 * pending_periods that the next period about to be read is at
+		 * risk of being overwritten.
+		 */
+		if (backlog >= RZT2H_ADC_DMA_PERIODS)
+			break;
+
+		period = adc->dma.buf + adc->dma.period_index *
+			 RZT2H_ADC_DMA_PERIOD_SAMPLES * adc->dma.sample_chans;
+		addr = adc->dma.addr + adc->dma.period_index *
+		       adc->dma.period_bytes;
+
+		rzt2h_adc_push_period(indio_dev, period, addr);
+		rzt2h_adc_advance_period_index(adc, 1);
+	}
+}
+
+static int rzt2h_adc_dma_thread(void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct rzt2h_adc *adc = iio_priv(indio_dev);
+
+	while (!kthread_should_stop()) {
+		wait_event_interruptible(adc->dma.wq,
+					 atomic_read(&adc->dma.pending_periods) ||
+					 kthread_should_stop());
+
+		if (kthread_should_stop())
+			break;
+
+		rzt2h_adc_dma_thread_loop(indio_dev);
+	}
+
+	return 0;
+}
+
+static void rzt2h_adc_dma_callback(void *data)
+{
+	struct iio_dev *indio_dev = data;
+	struct rzt2h_adc *adc = iio_priv(indio_dev);
+
+	atomic_inc(&adc->dma.pending_periods);
+	wake_up(&adc->dma.wq);
+}
+
+static void rzt2h_adc_dma_calc_layout(struct iio_dev *indio_dev)
+{
+	struct rzt2h_adc *adc = iio_priv(indio_dev);
+	unsigned int hi = 0, lo = RZT2H_ADC_MAX_CHANNELS - 1;
+	const struct iio_chan_spec *chan;
+	unsigned int sample_chans;
+	unsigned int first_chan;
+	unsigned int scan_index;
+	unsigned int swap;
+	unsigned int idx;
+
+	/* Find the lowest and highest enabled channel. */
+	iio_for_each_active_channel(indio_dev, scan_index) {
+		chan = &indio_dev->channels[scan_index];
+
+		lo = min_t(unsigned int, lo, chan->channel);
+		hi = max_t(unsigned int, hi, chan->channel);
+	}
+
+	/*
+	 * The DMA has no scatter-gather and transfers must have a power-of-two
+	 * width, so pick the smallest power-of-two-aligned block of channels
+	 * that covers all enabled channels.
+	 */
+	for (sample_chans = 1; sample_chans < RZT2H_ADC_MAX_CHANNELS; sample_chans <<= 1) {
+		first_chan = round_down(lo, sample_chans);
+
+		if (first_chan + sample_chans > hi)
+			break;
+	}
+
+	/*
+	 * Build a table to map each enabled channel to its position in the
+	 * transferred block, it will be used later to extract only the enabled
+	 * channels out of it.
+	 * The DMA moves data in 32-bit words, which swaps each pair of adjacent
+	 * 16-bit channels. Undo it.
+	 */
+	adc->dma.gather_len = 0;
+	swap = sample_chans > 1;
+	iio_for_each_active_channel(indio_dev, scan_index) {
+		chan = &indio_dev->channels[scan_index];
+		idx = chan->channel - first_chan;
+
+		adc->dma.gather[adc->dma.gather_len++] = idx ^ swap;
+	}
+
+	adc->dma.first_chan = first_chan;
+	adc->dma.sample_chans = sample_chans;
+	adc->dma.period_bytes = RZT2H_ADC_DMA_PERIOD_SAMPLES * sample_chans *
+				RZT2H_ADC_CHANNEL_BYTES;
+}
+
+static int rzt2h_adc_start_dma(struct iio_dev *indio_dev)
+{
+	struct rzt2h_adc *adc = iio_priv(indio_dev);
+	struct dma_async_tx_descriptor *desc;
+	struct dma_slave_config config = {};
+	unsigned int buffer_bytes;
+	dma_cookie_t cookie;
+	int ret;
+
+	rzt2h_adc_dma_calc_layout(indio_dev);
+
+	config.src_addr = adc->phys_base + RZT2H_ADDR_REG(adc->dma.first_chan);
+	config.src_addr_width = adc->dma.sample_chans * RZT2H_ADC_CHANNEL_BYTES;
+
+	buffer_bytes = RZT2H_ADC_DMA_PERIODS * adc->dma.period_bytes;
+
+	ret = dmaengine_slave_config(adc->dma.chan, &config);
+	if (ret)
+		return ret;
+
+	desc = dmaengine_prep_dma_cyclic(adc->dma.chan, adc->dma.addr,
+					 buffer_bytes, adc->dma.period_bytes,
+					 DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
+	if (!desc)
+		return -EBUSY;
+
+	desc->callback = rzt2h_adc_dma_callback;
+	desc->callback_param = indio_dev;
+
+	cookie = dmaengine_submit(desc);
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dmaengine_terminate_sync(adc->dma.chan);
+		return ret;
+	}
+
+	adc->dma.thread = kthread_run(rzt2h_adc_dma_thread, indio_dev,
+				      "rzt2h-adc-dma");
+	if (IS_ERR(adc->dma.thread)) {
+		dmaengine_terminate_sync(adc->dma.chan);
+		return PTR_ERR(adc->dma.thread);
+	}
+
+	disable_irq(adc->irq);
+
+	dma_async_issue_pending(adc->dma.chan);
+
+	return 0;
+}
+
+static int rzt2h_adc_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct rzt2h_adc *adc = iio_priv(indio_dev);
+	const struct iio_chan_spec *chan;
+	struct device *dev = adc->dev;
+	unsigned int scan_index;
+	u16 val = 0;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dev);
+	if (ret)
+		return ret;
+
+	iio_for_each_active_channel(indio_dev, scan_index) {
+		chan = &indio_dev->channels[scan_index];
+		val |= RZT2H_ADANSA0_CH_MASK(chan->channel);
+	}
+
+	writew(val, adc->base + RZT2H_ADANSA0_REG);
+
+	adc->dma.period_index = 0;
+	atomic_set(&adc->dma.pending_periods, 0);
+
+	ret = rzt2h_adc_start_dma(indio_dev);
+	if (ret) {
+		pm_runtime_put_autosuspend(dev);
+		return ret;
+	}
+
+	rzt2h_adc_start(adc, RZT2H_ADCSR_ADCS_CONTINUOUS);
+
+	return 0;
+}
+
+static int rzt2h_adc_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct rzt2h_adc *adc = iio_priv(indio_dev);
+	struct device *dev = adc->dev;
+
+	rzt2h_adc_stop(adc);
+
+	dmaengine_terminate_sync(adc->dma.chan);
+
+	kthread_stop(adc->dma.thread);
+
+	enable_irq(adc->irq);
+
+	pm_runtime_put_autosuspend(dev);
+
+	return 0;
+}
+
 static int rzt2h_adc_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
 			      int *val, int *val2, long mask)
@@ -174,6 +456,11 @@ static int rzt2h_adc_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static const struct iio_buffer_setup_ops rzt2h_adc_buffer_setup_ops = {
+	.postenable = rzt2h_adc_buffer_postenable,
+	.predisable = rzt2h_adc_buffer_predisable,
+};
+
 static const struct iio_info rzt2h_adc_iio_info = {
 	.read_raw = rzt2h_adc_read_raw,
 };
@@ -192,6 +479,12 @@ static const struct iio_chan_spec rzt2h_adc_chan_template = {
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
 			      BIT(IIO_CHAN_INFO_SCALE),
 	.type = IIO_VOLTAGE,
+	.scan_type = {
+		.sign = 'u',
+		.realbits = 12,
+		.storagebits = 16,
+		.endianness = IIO_CPU,
+	},
 };
 
 static int rzt2h_adc_parse_properties(struct rzt2h_adc *adc)
@@ -209,9 +502,50 @@ static int rzt2h_adc_parse_properties(struct rzt2h_adc *adc)
 	adc->num_channels = ret;
 	adc->channels = chan_array;
 
+	for (unsigned int i = 0; i < adc->num_channels; i++)
+		chan_array[i].scan_index = i;
+
 	return 0;
 }
 
+static void rzt2h_adc_free_dma_buf(void *p)
+{
+	struct rzt2h_adc *adc = p;
+
+	dma_free_noncoherent(adc->dev, RZT2H_ADC_DMA_BUFFER_SIZE,
+			     adc->dma.buf, adc->dma.addr, DMA_FROM_DEVICE);
+}
+
+static int rzt2h_adc_setup_dma(struct iio_dev *indio_dev)
+{
+	struct rzt2h_adc *adc = iio_priv(indio_dev);
+	struct device *dev = adc->dev;
+	int ret;
+
+	adc->dma.chan = devm_dma_request_chan(adc->dev, "rx");
+	if (IS_ERR(adc->dma.chan)) {
+		ret = PTR_ERR(adc->dma.chan);
+		if (ret != -ENODEV)
+			return dev_err_probe(adc->dev, ret, "DMA channel request failed\n");
+
+		adc->dma.chan = NULL;
+		return 0;
+	}
+
+	adc->dma.buf = dma_alloc_noncoherent(adc->dev, RZT2H_ADC_DMA_BUFFER_SIZE,
+					     &adc->dma.addr, DMA_FROM_DEVICE,
+					     GFP_KERNEL);
+	if (!adc->dma.buf)
+		return -ENOMEM;
+
+	ret = devm_add_action_or_reset(adc->dev, rzt2h_adc_free_dma_buf, adc);
+	if (ret)
+		return ret;
+
+	return devm_iio_kfifo_buffer_setup_ext(dev, indio_dev,
+					       &rzt2h_adc_buffer_setup_ops, NULL);
+}
+
 static int rzt2h_adc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -227,6 +561,7 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 	adc = iio_priv(indio_dev);
 	adc->dev = dev;
 	init_completion(&adc->completion);
+	init_waitqueue_head(&adc->dma.wq);
 
 	ret = devm_mutex_init(dev, &adc->lock);
 	if (ret)
@@ -264,6 +599,10 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 	indio_dev->channels = adc->channels;
 	indio_dev->num_channels = adc->num_channels;
 
+	ret = rzt2h_adc_setup_dma(indio_dev);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 
-- 
2.55.0

