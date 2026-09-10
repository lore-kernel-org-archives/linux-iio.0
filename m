Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011029.outbound.protection.outlook.com [40.107.74.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77123DDAE6;
	Thu, 10 Sep 2026 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030578; cv=fail; b=t2i9WkSWd35AquWJMgt75tAM8+1s6Zab0S0arnbI7CKjCmng6r6ubwnbiIEyjzXm9AUmM9F/KFD5CDGTPS6273rlAD2Xd75dt4q/nLqg203LPYZxqiLXVGsG0hVcaiX7kLEa90BjT/DS0bfbXtZgEYbYdtuPXWzIlPf/WENdB5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030578; c=relaxed/simple;
	bh=9O2ykiRSf0JptRZp0xe1CNNV0Y/ItmtLtEBaXlYdOBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iV9L/kGgFOU8UIgYeULNgX/XnW9phJiZw9VUVdk9R5pXLY2lqHk9qlWzTScozt0m/XZ1NuPHAF7VYJWlDdOiTbry7HnbqM3sxt/9NRGw6ifakNlktdBzIAD0Zmyzvv2NWOLo4udyZ/4XzzhLIERJcpmMnbf6SvXP3zI9NTZuzS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=JdbzyhLA; arc=fail smtp.client-ip=40.107.74.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="JdbzyhLA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=el4xt/lmLLmw8RfNPs7uc6sk1DKegeC83DwF1D+pXqIj7enF58S/hedyXcQZ+2ycYFZa54aaA59iBXjDoWx7C488HMiSM22b2+cDFQWc9kEhzOovb7azDSqVu+2i9+sB0qSp9fCD6DKrFhH8OQLb/Sc1WB6m8CIDSDKkHfq4Dr4hFWAAXuG9le9RiG0Vwbzi+Udx4DGMI+gxdw5pkU7jNXR8yiR6wsAL6RYVTuMyZocZrepo2OHhVSAmIxBNVpu5359G4QOfnSkB2mKzFkiKKC1Zytoyp7itQdPuRF/S7xbUTgsHCrxYR0czzv/ss/JG5dfP58ou1EfU5zRfnxlw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6VStpGZbngN1VOMbilLwxlcdS943EK7e7Z6jdgMvFA=;
 b=D2rJp9hMmW8K0U5DGVsfeg0lclgPM0J27c3a/RwcOBBFpmdQPavLlQL1A9acVfcqgH9M7wiooOuj66ty4vjUvzBtJYehWS7/vdOU6rE+tLEf7qrlFqs+0LAxHAdWDwN15WSYjHwGLdhpQtUy5EM9AcZzkhXN1h1cXs3x+n5WcGGCI/Tosuy6r8muia6pKMUQiZrDOAkaaTpXW4FEpSXvBaZsbezJ7pCgc7DAa0RjBp7CBrui6VXugVbXONIceJ+FU1BPttoLTth8bPt5kefYODie7NLPGQp4GwCz3Dc5KOHmJ37NdmsOcpjUZXuLad/JZk0vkJGaqLka/nfbf1aOCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=analog.com smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6VStpGZbngN1VOMbilLwxlcdS943EK7e7Z6jdgMvFA=;
 b=JdbzyhLA4zGIPdUZ15qsUYxAPIovDsUYvdGzoqC7K9wQ3WYowAwI8FXSm85zwK5t9nFXoIPLqJHunnEKXAt0EYghgss/XCUH2ZfEcZVK4KOmOeORYsQILt7vIZ0cn/McEVD0cp6mqfw1ap3Z8vYmzhHnpdYSredsIikGRO7loz4=
Received: from TYCP286CA0186.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:382::14)
 by OSCPR01MB12816.jpnprd01.prod.outlook.com (2603:1096:604:33b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 08:56:08 +0000
Received: from TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382:cafe::4e) by TYCP286CA0186.outlook.office365.com
 (2603:1096:400:382::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Thu, 10
 Sep 2026 08:56:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TY1PEPF0000BAD9.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Thu, 10 Sep 2026 08:56:05 +0000
Received: from demon-pc (REE-0064895.adwin.renesas.com [10.226.92.160])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 4F6253000203;
	Thu, 10 Sep 2026 17:56:01 +0900 (JST)
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
Subject: [PATCH v2 5/9] iio: adc: rzt2h: implement DMA buffer support
Date: Thu, 10 Sep 2026 11:54:26 +0300
Message-ID: <20260910085430.3173166-6-cosmin-gabriel.tanislav.xa@renesas.com>
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
X-MS-TrafficTypeDiagnostic: TY1PEPF0000BAD9:EE_|OSCPR01MB12816:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 28706ea8-5916-4c8a-e989-08df0f19594f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|23010399003|921020|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	wZWRZEPQQPTc6KqgCy4cI2j5jOieX4QLSZ+EtjUrcvm3XR71Oq9NnzZom+Ej5vs7iEA8tXgpOE69ykE2hhS3+RlRtQgLJvESnn/LnWoieSCR4wN9pbZ7PpSw20fUibZ8tbDHYnuUmgJdJjllySUpSCwFiOB/1K9GOhR6KAhILr12afyJXnfusqw8akVQBXYcTW1LXJnsC4mOWTeLXOOR83BtHntkuUvNvIP30JcXJEv7Tz0Etl4iFWJoN2seszx8+ZjpE5s2iqGr6l1BS4xx5IG9VooxVx5u+B2CTdSy64qoPCE14cp0I0RFumlfBQOIDsg76rZaXuz7yJkTL+HR1tvZUmDeSILuhuMhfKFl/ylz4i6UHjWTc/Lx0C36UsrLHq9rCXliaoh52YqkhmXaLunRwEn40ageqVzNZFUwy/IQ4V/PfDWm9ewWk/K15JqZkW3CWhGbO20oJNuS9+WQqVNawDCHyQB9twPNY7COmTp+YIEigWhF6NtoDMp7AZNwliLNRbe4snR6aoTXrzUEJG8/pBV2zp0ye7e0VE/Mw4KtJLI9VTj7b717L1yKAyhC3LnqsNd9SihW9F2/1yPJBeDy8enpEuxDpMDsHNPczoDuJ9WVe9QjG1mqSx32UL1q2YuQ8G5lrUQxUpv7P7i+PB7QtQmg9cWqNUZE+Da4+WwG8Fhka7e3Ct69TtgXf/b0cOmOt/DposzWgL72dorH2SM7HdQ0Btnw3eeBSuy8l4mAwEAt6kgCF07T71vCaN32
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(23010399003)(921020)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XHUmZht1+tfolMsCWGRndmkeQP0Xa27Nkft6Fwp9pYye+5KMpNrnj651LFlWcosSvihgE/pgXdjPGM8mJvOvzkt2JH0bRLlSsVtvVO0rOcPtvaaNZ9T9ZRhNm7K+j9m/wl+/ltFloi2ZYHoClDKY+1wgC3FSVrsZHJufyyzydIrDcsFldqYjeMfXv9e456IUfTRA5wX47q4WJmDR5cEqxtmOyqRYlu9Ov+WRGIoJioUR1oZDJn/Fgx61GgA/Dr+acK9OECd0OcziEtzXQzxaE9SKsM/LlKRFFx3BN4i9LN6fnuxxOqtAtCjGjrYz/fStvrct41XUmC3cW6LJ3WstFFs6XZdsIRzJMwhAyXcvYPyZrQqvZmCFSpt5HPb/IHJ7YLY1COjzp0N/m4z8ntxo7H0WeeboQ7VHxK1FTvHUggxvFvZEZWIJlypbSg1b2/Fm
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 08:56:05.6420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28706ea8-5916-4c8a-e989-08df0f19594f
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TY1PEPF0000BAD9.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12816

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

V2:
 * advance period index on backlog overflow
 * add a comment describing the logic for dropping already overwritten
   periods
 * build dma_slave_config as a compound literal
 * use the local dev instead of adc->dev in rzt2h_adc_setup_dma()
 * sync the DMA buffer to device immediately after allocation to handle
   the zero-fill done by the CPU

 drivers/iio/adc/Kconfig     |   2 +
 drivers/iio/adc/rzt2h_adc.c | 352 ++++++++++++++++++++++++++++++++++++
 2 files changed, 354 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 7a60ffd0ddd8..0aca02962947 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -1575,6 +1575,8 @@ config RZT2H_ADC
 	tristate "Renesas RZ/T2H / RZ/N2H ADC driver"
 	depends on ARCH_RENESAS || COMPILE_TEST
 	select IIO_ADC_HELPER
+	select IIO_BUFFER
+	select IIO_KFIFO_BUF
 	help
 	  Say yes here to build support for the ADC found in Renesas
 	  RZ/T2H / RZ/N2H SoCs.
diff --git a/drivers/iio/adc/rzt2h_adc.c b/drivers/iio/adc/rzt2h_adc.c
index 95bcebdc02cb..0460dffe189e 100644
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
@@ -151,6 +186,263 @@ static int rzt2h_adc_calibrate(struct rzt2h_adc *adc)
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
+		/*
+		 * The consumer fell a full buffer behind and the oldest periods
+		 * have already been overwritten by the cyclic DMA transfer.
+		 * Drop them and jump straight to the oldest period that has
+		 * not been overwritten.
+		 */
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
+		if (backlog >= RZT2H_ADC_DMA_PERIODS) {
+			rzt2h_adc_advance_period_index(adc, pending - i);
+			break;
+		}
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
+	struct dma_slave_config config;
+	unsigned int buffer_bytes;
+	dma_cookie_t cookie;
+	int ret;
+
+	rzt2h_adc_dma_calc_layout(indio_dev);
+
+	config = (struct dma_slave_config) {
+		.src_addr = adc->phys_base + RZT2H_ADDR_REG(adc->dma.first_chan),
+		.src_addr_width = adc->dma.sample_chans * RZT2H_ADC_CHANNEL_BYTES,
+	};
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
@@ -174,6 +466,11 @@ static int rzt2h_adc_read_raw(struct iio_dev *indio_dev,
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
@@ -192,6 +489,12 @@ static const struct iio_chan_spec rzt2h_adc_chan_template = {
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
@@ -209,9 +512,53 @@ static int rzt2h_adc_parse_properties(struct rzt2h_adc *adc)
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
+	adc->dma.chan = devm_dma_request_chan(dev, "rx");
+	if (IS_ERR(adc->dma.chan)) {
+		ret = PTR_ERR(adc->dma.chan);
+		if (ret != -ENODEV)
+			return dev_err_probe(dev, ret, "DMA channel request failed\n");
+
+		adc->dma.chan = NULL;
+		return 0;
+	}
+
+	adc->dma.buf = dma_alloc_noncoherent(dev, RZT2H_ADC_DMA_BUFFER_SIZE,
+					     &adc->dma.addr, DMA_FROM_DEVICE,
+					     GFP_KERNEL);
+	if (!adc->dma.buf)
+		return -ENOMEM;
+
+	dma_sync_single_for_device(dev, adc->dma.addr, RZT2H_ADC_DMA_BUFFER_SIZE,
+				   DMA_FROM_DEVICE);
+
+	ret = devm_add_action_or_reset(dev, rzt2h_adc_free_dma_buf, adc);
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
@@ -227,6 +574,7 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
 	adc = iio_priv(indio_dev);
 	adc->dev = dev;
 	init_completion(&adc->completion);
+	init_waitqueue_head(&adc->dma.wq);
 
 	ret = devm_mutex_init(dev, &adc->lock);
 	if (ret)
@@ -264,6 +612,10 @@ static int rzt2h_adc_probe(struct platform_device *pdev)
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
