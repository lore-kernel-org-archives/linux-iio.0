Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5894A468C3B;
	Mon,  5 Oct 2026 09:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193386; cv=fail; b=B/ioihTS2iGz6i1AcHiYejuxFZss5xWgOegGGioUlfU8S3G9UL/gYnP1NVGY8Q1xjEb2zapICbzJg/1ajt2rq35wKkzpkQyaHcO5owg6glD0x6pU5HVl6pavyolE+3rVIAMUQCAIyt6bJu04Y8xE0n5k+Szb3iGxLXRE5tBHOxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193386; c=relaxed/simple;
	bh=B4D18rJcRxvr8xxziRiaaoX0war7BPfrSSGpNm9Y/HM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XbgVgYvL7lpjKO7kdGoDZl6VFhUN8cd4c1c8uyXxU4HI2ttp59XPWBsaJ4TFzWECc/cKehcmt7X4IPKHypsvJeq/rFTR5T2CtUOj18wtB+Me+iE/OlK1NiIkI7TNk1hjL/28MPC1N6A8mONBCu9qVK95ewCR7+luuEeoT2IKxo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wMgODd/R; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wMgODd/R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwSwDkWSoIVBR1ygkIIGVw1T/xRuh46OoRPQuE1vl+PJ42fL8DhPNcCXzMTrVRIwsyjK4W4ONlOZ/Li5+SAT32eFHAsuU6bzHKdYS91qLTex/2AwZlgqtliV1N4Msr4cL5bTPJta4SK391pCpTuFqyfnOLbXqhu4PwhrE0Cd0gPHKMQeZYSeBD+/qmtsSRw/WDS+URE7yaKcfrC82dLXhrVaWGpql4LVZ8JMRnxHn6VwJUQ8ZjBAA89RNDrjJupdlxadOf9/H4kNRIm3D6hspHY9DpZx3IrQIvgIyQGNQ4VSgEizaVaEGL46liFlHzPqKOuzbJym+9I97pz44lcfQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ppgXNqWBkklL5gNKRKSdhRZdT2dhCMhbQLu7Ee7nOlo=;
 b=Y9QeSAs2LQKIX5ivydFoRgJyH+zI4XmMqNjlW8c68iG8y1pikrwpPXZi7iF/kii/Uz6SjwLGGH2wzMt/O8X6NQ38RwU9pnfnBx25CYLHr2eVYaFK/PqQ1t8GDgMRU8T7uTMqgzMnZeIcpUPfgIXevi2iyWEa8D5e9ZOWKBJV1tq0IOKTvQnF/JFDscITpGRJNqcUkKr/j/T1dbA2hRXiYGlXgDc3pFQv1DRScwTJnE3iPpbyTeINaLTJLYsxq5zwBCEZaIz3UYKmE/4FZrR/OkvChHNEQNR07MVbGEHPvO7brI0aDZfNOARhtoljt+5NxfIN9T9K8fDnazU3GI9SPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ppgXNqWBkklL5gNKRKSdhRZdT2dhCMhbQLu7Ee7nOlo=;
 b=wMgODd/RN0R/kqDoavBLUgryxCEighKfuJ0BdpeAXvpLWSHTlnOKI1J01uV8OoZLdv4+PS82JOjdqOFYUIr8m4IBIMFg1r43D4KEFYxDDLiVYCAjvyU7K+rGxxv7QDJQiBMOX7xcLmJTrL4sNlcCvSkij534M7O5pNr2hIokC94=
Received: from CH0PR13CA0022.namprd13.prod.outlook.com (2603:10b6:610:b1::27)
 by SN7PR12MB7834.namprd12.prod.outlook.com (2603:10b6:806:34d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 09:42:50 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::5d) by CH0PR13CA0022.outlook.office365.com
 (2603:10b6:610:b1::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.19 via Frontend Transport; Mon, 5
 Oct 2026 09:42:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 09:42:50 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:42:48 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 04:42:45 -0500
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v4 08/15] iio: adc: xilinx-xadc: Add unit suffixes to macro names
Date: Mon, 5 Oct 2026 15:11:58 +0530
Message-ID: <20261005094205.1045874-9-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
References: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|SN7PR12MB7834:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c2e3e6c-c901-4ceb-201b-08df22c5052f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2mprL7FYxgWcM5MA5PkGSv5ZSEjduYyCMlRmHt1cKOzMza9yHHSkMpTul/oDQMpsdNhLud5YIFdp8MD1o/7EE/XXB6E+qLbBERUN7El8x0WCq1J4+nB8hzh0vxstliPc8/pTmNpVO/Uv6miBLf3ppVoZrUPRY8ErBC2CNBfoygHgNyT0I5PeUO78bO69p5hg3tx9k2ntMKiCtZQffhMDLt/X0Ma5xmi5yC0Nf6i0tX4lr/O2sGr2KP91N+G3vlFZmXirdaIGgC2IbBSbj5LuBUlCMr7/kZBxJQfw9IbyfJu/diaUt/20sDFaQ1XKKioQ8iJQC192pxm5WebslQ56BXKQGICBNYifNg1E2sbsFGftJWnWaeyX5QYGX+OYEJ9Tu30xaCMyjn9U6sJe4LSlnP7fSOTuuBu8OIfcpsiGeIJ93wGHZh+JGqgVcLlgzLT4ZNx1nFng8GA2/yjMwtyH/jZVGm/QnpJe+uo2Qt99a7D5M+RhVGHlFouxts8tGaIzfq2TcTKIQ7Frgjpp93nhAJAqyWe3GGJ4dfbfYwISv6cMDS7ThldQ4CxsRdWPugeGa7UL2ASriODD2LzAr1kHEIq6tnucqqBBPLDBpojhV3H27OYDHPIfaI5L4C09XUujkm/Ww6M/6t0Fp3y4TE9IHWAoWZ1EqWbToz/8pR5MRGGJazuFiIzTvqQHc4OOsidDvU0IYi4AmXtqfFowk0K5sA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yMwQbv/5K1Iu0mXucSqKD6JWCrodVrkt9qoxPOvpew45ZGbf6o0mmYdM3aX8M2sMTKxdtznc81CncVtioZl1O5YJP6dPqjiBpcy6yOckdTpuKi90jmKoqL0jm1AZTDlUjpL7+i7GpDnFwk7s+b9q4LEHowmzMpvBk2H2IlJRJU5C6sg3I3z5hsVV2rrb7eQUWpe1pJqiGyQ+WdeDIwg8VpmQJWWySNojRuW9iZV5N8RipIOJjsB8hPV847fSLy7lyHle+goUP9n8sWP2ZVe/3nNyo/z2N/lPOqnW4+f1z3cDan/sgOI9oOo/bfa5MCLSd5n4QH57Lw+FxjeKIGNJwayJLsEBF7UOj/IgSAVYUGkHbikQGKaumGmCbRQTDQYm/DhlVUX90rCXm6FS//UcbsHBVQfUzCUt2kJvNXsUV/WDpHMFVmqNsHcOWXgt8M39
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:42:50.0338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c2e3e6c-c901-4ceb-201b-08df22c5052f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7834

Append the unit to the relevant macro names (_HZ, _MS, _CYCLES, _SPS)
so that the expected unit of each value is clear at the point of use
and to avoid ambiguity.

No functional change intended

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 36 +++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 43d3fc46c05f..65fcefa07516 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -38,7 +38,7 @@
 
 #include "xilinx-xadc.h"
 
-static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
+static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT_MS = 500;
 
 /* ZYNQ register definitions */
 #define XADC_ZYNQ_REG_CFG	0x00
@@ -101,7 +101,7 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
  * limits the maximum samplerate 150kSPS. At this rate the CPU is fairly busy,
  * but still responsive.
  */
-#define XADC_MAX_SAMPLERATE 150000
+#define XADC_MAX_SAMPLERATE_SPS 150000
 
 static void xadc_write_reg(struct xadc *xadc, unsigned int reg, u32 val)
 {
@@ -254,7 +254,7 @@ static void xadc_zynq_unmask_worker(struct work_struct *work)
 	/* if still pending some alarm re-trigger the timer */
 	if (xadc->zynq_masked_alarm) {
 		schedule_delayed_work(&xadc->zynq_unmask_work,
-				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
+				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT_MS));
 	}
 }
 
@@ -293,15 +293,15 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 
 		/* unmask the required interrupts in timer. */
 		schedule_delayed_work(&xadc->zynq_unmask_work,
-				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
+				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT_MS));
 	}
 
 	return IRQ_HANDLED;
 }
 
-#define XADC_ZYNQ_TCK_RATE_MAX 50000000
-#define XADC_ZYNQ_IGAP_DEFAULT 20
-#define XADC_ZYNQ_PCAP_RATE_MAX 200000000
+#define XADC_ZYNQ_TCK_RATE_MAX_HZ	50000000
+#define XADC_ZYNQ_IGAP_DEFAULT_CYCLES	20
+#define XADC_ZYNQ_PCAP_RATE_MAX_HZ	200000000
 
 static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_dev, int irq)
 {
@@ -314,8 +314,8 @@ static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_d
 	int ret;
 
 	/* TODO: Figure out how to make igap and tck_rate configurable */
-	igap = XADC_ZYNQ_IGAP_DEFAULT;
-	tck_rate = XADC_ZYNQ_TCK_RATE_MAX;
+	igap = XADC_ZYNQ_IGAP_DEFAULT_CYCLES;
+	tck_rate = XADC_ZYNQ_TCK_RATE_MAX_HZ;
 
 	xadc->zynq_intmask = ~0;
 
@@ -323,8 +323,8 @@ static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_d
 	if (!pcap_rate)
 		return -EINVAL;
 
-	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
-		ret = clk_set_rate(xadc->clk, (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX);
+	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX_HZ) {
+		ret = clk_set_rate(xadc->clk, (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX_HZ);
 		if (ret)
 			return ret;
 	}
@@ -333,7 +333,7 @@ static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_d
 		div = 2;
 	} else {
 		div = pcap_rate / tck_rate;
-		if (pcap_rate / div > XADC_ZYNQ_TCK_RATE_MAX)
+		if (pcap_rate / div > XADC_ZYNQ_TCK_RATE_MAX_HZ)
 			div++;
 	}
 
@@ -353,7 +353,7 @@ static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_d
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, XADC_ZYNQ_CFG_ENABLE |
 		       XADC_ZYNQ_CFG_REDGE | tck_div | XADC_ZYNQ_CFG_IGAP(igap));
 
-	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
+	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX_HZ) {
 		ret = clk_set_rate(xadc->clk, pcap_rate);
 		if (ret)
 			return ret;
@@ -934,8 +934,8 @@ static int xadc_write_samplerate(struct xadc *xadc, int val)
 		return -EINVAL;
 
 	/* Max. 150 kSPS */
-	if (val > XADC_MAX_SAMPLERATE)
-		val = XADC_MAX_SAMPLERATE;
+	if (val > XADC_MAX_SAMPLERATE_SPS)
+		val = XADC_MAX_SAMPLERATE_SPS;
 
 	val *= 26;
 
@@ -948,7 +948,7 @@ static int xadc_write_samplerate(struct xadc *xadc, int val)
 	 * limit.
 	 */
 	div = clk_rate / val;
-	if (clk_rate / div / 26 > XADC_MAX_SAMPLERATE)
+	if (clk_rate / div / 26 > XADC_MAX_SAMPLERATE_SPS)
 		div++;
 	if (div < 2)
 		div = 2;
@@ -1325,8 +1325,8 @@ static int xadc_probe(struct platform_device *pdev)
 		if (ret < 0)
 			return ret;
 
-		if (ret > XADC_MAX_SAMPLERATE) {
-			ret = xadc_write_samplerate(xadc, XADC_MAX_SAMPLERATE);
+		if (ret > XADC_MAX_SAMPLERATE_SPS) {
+			ret = xadc_write_samplerate(xadc, XADC_MAX_SAMPLERATE_SPS);
 			if (ret < 0)
 				return ret;
 		}
-- 
2.34.1

