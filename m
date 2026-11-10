Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794287334;
	b=jcOb//vafgWHPhA/7KoQwmOrerXVUYkfdNSJEVAK3eWGMts6USQHeYFs/1/exm6n3gs8
	 Ulko3Priakb9OvAP/038BSCTQD7MLJ0mPA9u59gxDi2JB63tEk3k0RkoU3UaBRKq66iJF
	 RTRG1BYwsNOQjWRgrN2JzErOxfIKSyf+zWB4MlOH7nwba0K3Eo9bdb5cxQsoQ4gphMrpY
	 a5DgZdQBFECss90IF3AcbrV7NbgaHLulmwMZw2WqxbiyIYpPCWWL7zsdDAcLCVxsClhPy
	 N67r/RUgJl0/LTdbl3y95i8gdhoABlF/uVbgMcty8a9mXNl2ubMl0BdlsPxhVHP0NXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287334;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3bzzu0Cfnb2vj7zdVTVxPfus86EQVnRwIArn8L7veT0=;
	b=b2jwsQA6AfNM8KRERQLStZkujU7pGoUbnTvovd+BCTyQCMi8lOAesyfMEZICVEobzEnP
	 iTmDaxPLYZyIZXp6aayT0LR3OOIyIArPRCtCs3J4fgPO9hyGpMeRLY4vdF/6Ebek2R8Lq
	 FOMQP+G0ot1Phaw8wUA+tjxypo9xW4RyqU/L5+5al40y4P+Nd8ekEiXNhuRAC1B8cwsSp
	 y+VMKTaqxJfGX3+LvsnKzCC//QNii4bkrxjY1AceS1jvwOKeDgV8Rxna9kaDhPJPZkVEo
	 g4vLzHOFUCXy1f8wL0rlohAnONhJcRgm7N4L8/ARLE4PwTz6Z/eAivLerS6TKSnA+sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Wenp77to;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.3
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012003.outbound.protection.outlook.com [40.93.195.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6689606A33D;
	Tue, 10 Nov 2026 05:08:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6689606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Wenp77to
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBzACReTFqxWjwHaMMBhdHYTH9gdBbDmhxoD48P19X0t9ZQFEpQGLvjG4K84f8qOAQwJTy3A3sCe4rSZVjri0lNZglkHvUyqyugjjypk2P7I03AaKl+WlKMUA6PbkVqecvpyFI/JZ1qDIRIz+Ezhh5fl7xQsBW7OrzGL074zaprhUMsNnG74Di6DWtUIS7ibjYGUFv4V1fVeydRutbcEciyKFp3Dy5HdV/NNy9VMr1JThoabnO4KuEIljHDp3DWV4s190rSxZzh0aBz2jHvqs+BblgEJ6EtQEsc/lbDWGR5HBPIl60mupNJMsaYoXmf4jUNYZwrw2nZrW2/hFDS2cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bzzu0Cfnb2vj7zdVTVxPfus86EQVnRwIArn8L7veT0=;
 b=suPGIPOgjISN51ls4tUDlQCXgRzwYSucjOBWG79OUVc5hRUqeto4kgFROZH/7G4lKF1UqO4JzrJTqOAH0qxzzlqDrQLlrXvVJv8+0HybZCrRRthSR6gbx17i/Ovh3U7uoCd7yK4S7sQCNLbaP9Fw24mxVW0b2Ai7W+FO+6ejb7/2kWfU4u0vzOi4pX2HTIrBZmjr08tQgEIA6Yv3rupr0gVBASzIMeGUVFZmxfE9lPjVsGn3M+U7Dsa9IRIgrQPFLtHFw7kmXYRstJNytpZjGB7GrUsEpQL4aNtSWu3Zjf9tC9vLJvKNPwCiwSnVbWVYk4msS/vS6fUi6oA5Y9eBtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bzzu0Cfnb2vj7zdVTVxPfus86EQVnRwIArn8L7veT0=;
 b=Wenp77to+95dlJMibsDnZlvnkRvGVMdAWvZlb+R+2oHmC47LoAwjdE5ZMa/l2b8DNHsc6vfXBlITlictHbZAU27okZyCPkJdIv4KKqQ0fiDcucQrEfz0ra+4ufjzC8elPbb6O8bC6ZXg4L71nBy/V5oYL0kwkKP2cISwmuiSEbw=
Received: from BN9PR03CA0474.namprd03.prod.outlook.com (2603:10b6:408:139::29)
 by CHBPR12MB047581.namprd12.prod.outlook.com (2603:10b6:610:369::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 05:08:46 +0000
Received: from IA0PEPF0000003B.namprd03.prod.outlook.com
 (2603:10b6:408:139:cafe::49) by BN9PR03CA0474.outlook.office365.com
 (2603:10b6:408:139::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Tue,
 10 Nov 2026 05:08:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF0000003B.mail.protection.outlook.com (10.167.249.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 05:08:46 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:08:37 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 23:08:34 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v5 02/16] iio: adc: xilinx-xadc: Fix coding style issues
Date: Tue, 10 Nov 2026 10:31:47 +0530
Message-ID: <20261110050201.1850399-3-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003B:EE_|CHBPR12MB047581:EE_
X-MS-Office365-Filtering-Correlation-Id: e99d01c9-117a-4615-9c24-08df3ee8b2e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|11063799006|56012099006|261022105027099003|261022075727099003|261022113327099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	aaRcKCmysCydVsYQkbUwHcHXhOxQKcI7ziTOvwZTUzoFaZ/yBAqLykl3l8XgQYT3jZAIJAk/vVVGwFi5Kqij1r3eWtHxn5UhE2AX2UcKtQGoTYqXJ1DAJA5+EHAmpW9JmPkJaA2L2DQMHVhlXwo7gLZRSrTVZkpnQGN0pqdConvU/cdpSTqWzEz6N5ESCHNnKIw4vrvL0oaG+KrwduroP256wu66zGYr13jjRq36w5ptQfXYExLf+dmUqug3/OmS/6OkdUkEc7mZYfX5tpis6pErQrqSLPC5ILUFZoXqVd2UL/0CtXc0IUMsWDbdBuaZdwhe1BkAVsiDfE0ozXvXL196f3wTaI9JwfU+G1q0MaCZ04PHQUQhj/hrwwp2ObrgPPBL5gx/JEzRWBuagJeItXAlamkCTqZ4N/XyZYq9FMoGwA8CEFBtJnb4dk0R6soQ2Jj4T/TYCIZqAHbN35dRowxljQOEyyz7qhkEuJlSb2qBG0ppYvVDB9FyC+O94QuS/CaLZqUjmcuZV2vnL50ZuHFcSPfegTyno7a7ahhw2SEEcLaCAWbwtMQCFuNgKDjr6MXWtNRyHsExOJfDbVC7nVYgswWjXelXavJLYzoCTmKaDxRf+oRfCYzbnX+BEz51LePwn0fNfmOH+PHb7jUOjXeDLC4hKiorjpsIu2qfsnzK61qTP0wAc8cVk4fVCGVopXmPC0VC+T0xjjTNxKCWKw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261022113327099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gp9azFqpX2S9S0K7FFAWmBTOySVWy8qFdzyFuVSKL5pPj2JGfOaA1gd3fTlMHbxUS00j6bCuuLa+Rf5rJ/sB1XWJRhEmW6lX2O/RnudOjmdaeHG19fMTf3lCHB913s/f0qfSKDZlem7tnNcR1ehvJezaMpWsiIIuL8HEcWzCClhR3yA8SKoKkretkSrBeZp/1bjS5oPqJaFbc50I9y9j3nw3C2FxDQpoQG/WX0UCwP6DID8Dt3bKRna3W35U+p/dBrBXW9RFoJo62ql019FMtZloCg3Ip8NIE493ukJ/iIIMTGrJsXSVePlFYhda4QvIITVb7widGiTt6/ebfqXhEM49vSHVZKi+kMCdC8S95tBrAETLGjqJEnylz9fN9COZHvTpkzmzdLXnQKt0SqHVYdC19H2mZqqJEixAe0AwrRtieAqvhgsGf+5ENpNxKu4p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 05:08:46.4344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e99d01c9-117a-4615-9c24-08df3ee8b2e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR12MB047581

Address checkpatch.pl warnings in the XADC driver:
- function prototypes/definitions split across lines that now
  fit within the line length limit
- Realign remaining multi-line statements to the opening parenthesis
- Add a missing space around a binary operator
- Fix pointer/const spacing ("*const" vs "* const")
- Adjust blank lines around a few statements
- Reorder the local declarations (size_t n and void *data) in
  xadc_update_scan_mode(), the only token-order change
  (not a checkpatch warning)

No functional changes intended.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c   | 143 ++++++++++-----------------
 drivers/iio/adc/xilinx-xadc-events.c |  50 +++++-----
 drivers/iio/adc/xilinx-xadc.h        |  40 +++-----
 3 files changed, 90 insertions(+), 143 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 222571e75cb3..502aecb2a8b0 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -119,14 +119,12 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
  */
 #define XADC_MAX_SAMPLERATE 150000
 
-static void xadc_write_reg(struct xadc *xadc, unsigned int reg,
-	uint32_t val)
+static void xadc_write_reg(struct xadc *xadc, unsigned int reg, uint32_t val)
 {
 	writel(val, xadc->base + reg);
 }
 
-static void xadc_read_reg(struct xadc *xadc, unsigned int reg,
-	uint32_t *val)
+static void xadc_read_reg(struct xadc *xadc, unsigned int reg, uint32_t *val)
 {
 	*val = readl(xadc->base + reg);
 }
@@ -140,9 +138,7 @@ static void xadc_read_reg(struct xadc *xadc, unsigned int reg,
  * sleep and wait for an interrupt that signals that a response is available in
  * the data FIFO.
  */
-
-static void xadc_zynq_write_fifo(struct xadc *xadc, uint32_t *cmd,
-	unsigned int n)
+static void xadc_zynq_write_fifo(struct xadc *xadc, uint32_t *cmd, unsigned int n)
 {
 	unsigned int i;
 
@@ -162,26 +158,22 @@ static void xadc_zynq_drain_fifo(struct xadc *xadc)
 	}
 }
 
-static void xadc_zynq_update_intmsk(struct xadc *xadc, unsigned int mask,
-	unsigned int val)
+static void xadc_zynq_update_intmsk(struct xadc *xadc, unsigned int mask, unsigned int val)
 {
 	xadc->zynq_intmask &= ~mask;
 	xadc->zynq_intmask |= val;
 
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK,
-		xadc->zynq_intmask | xadc->zynq_masked_alarm);
+	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask | xadc->zynq_masked_alarm);
 }
 
-static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t val)
+static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t val)
 {
 	uint32_t cmd[1];
 	uint32_t tmp;
 	int ret;
 
 	spin_lock_irq(&xadc->lock);
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,
-			XADC_ZYNQ_INT_DFIFO_GTH);
+	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
 
 	reinit_completion(&xadc->completion);
 
@@ -206,8 +198,7 @@ static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg,
 	return ret;
 }
 
-static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t *val)
+static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t *val)
 {
 	uint32_t cmd[2];
 	uint32_t resp, tmp;
@@ -217,8 +208,7 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg,
 	cmd[1] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_NOP, 0, 0);
 
 	spin_lock_irq(&xadc->lock);
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,
-			XADC_ZYNQ_INT_DFIFO_GTH);
+	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
 	xadc_zynq_drain_fifo(xadc);
 	reinit_completion(&xadc->completion);
 
@@ -246,9 +236,7 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg,
 
 static unsigned int xadc_zynq_transform_alarm(unsigned int alarm)
 {
-	return ((alarm & 0x80) >> 4) |
-		((alarm & 0x78) << 1) |
-		(alarm & 0x07);
+	return ((alarm & 0x80) >> 4) | ((alarm & 0x78) << 1) | (alarm & 0x07);
 }
 
 /*
@@ -287,9 +275,8 @@ static void xadc_zynq_unmask_worker(struct work_struct *work)
 	/* if still pending some alarm re-trigger the timer */
 	if (xadc->zynq_masked_alarm) {
 		schedule_delayed_work(&xadc->zynq_unmask_work,
-				msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
+				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
 	}
-
 }
 
 static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
@@ -310,8 +297,7 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status);
 
 	if (status & XADC_ZYNQ_INT_DFIFO_GTH) {
-		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,
-			XADC_ZYNQ_INT_DFIFO_GTH);
+		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
 		complete(&xadc->completion);
 	}
 
@@ -324,12 +310,11 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 		 */
 		xadc_zynq_update_intmsk(xadc, 0, 0);
 
-		xadc_handle_events(indio_dev,
-				xadc_zynq_transform_alarm(status));
+		xadc_handle_events(indio_dev, xadc_zynq_transform_alarm(status));
 
 		/* unmask the required interrupts in timer. */
 		schedule_delayed_work(&xadc->zynq_unmask_work,
-				msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
+				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
 	}
 	spin_unlock(&xadc->lock);
 
@@ -340,8 +325,7 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 #define XADC_ZYNQ_IGAP_DEFAULT 20
 #define XADC_ZYNQ_PCAP_RATE_MAX 200000000
 
-static int xadc_zynq_setup(struct platform_device *pdev,
-	struct iio_dev *indio_dev, int irq)
+static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_dev, int irq)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 	unsigned long pcap_rate;
@@ -362,8 +346,7 @@ static int xadc_zynq_setup(struct platform_device *pdev,
 		return -EINVAL;
 
 	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
-		ret = clk_set_rate(xadc->clk,
-				   (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX);
+		ret = clk_set_rate(xadc->clk, (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX);
 		if (ret)
 			return ret;
 	}
@@ -390,7 +373,7 @@ static int xadc_zynq_setup(struct platform_device *pdev,
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, ~0);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, XADC_ZYNQ_CFG_ENABLE |
-			XADC_ZYNQ_CFG_REDGE | tck_div | XADC_ZYNQ_CFG_IGAP(igap));
+		       XADC_ZYNQ_CFG_REDGE | tck_div | XADC_ZYNQ_CFG_IGAP(igap));
 
 	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
 		ret = clk_set_rate(xadc->clk, pcap_rate);
@@ -440,8 +423,7 @@ static void xadc_zynq_update_alarm(struct xadc *xadc, unsigned int alarm)
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_INTSTS, &status);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status & alarm);
 
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_ALARM_MASK,
-		~alarm & XADC_ZYNQ_INT_ALARM_MASK);
+	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_ALARM_MASK, ~alarm & XADC_ZYNQ_INT_ALARM_MASK);
 
 	spin_unlock_irqrestore(&xadc->lock, flags);
 }
@@ -464,29 +446,24 @@ static const unsigned int xadc_axi_reg_offsets[] = {
 	[XADC_TYPE_US] = XADC_US_AXI_ADC_REG_OFFSET,
 };
 
-static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t *val)
+static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t *val)
 {
 	uint32_t val32;
 
-	xadc_read_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4,
-		&val32);
+	xadc_read_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4, &val32);
 	*val = val32 & 0xffff;
 
 	return 0;
 }
 
-static int xadc_axi_write_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t val)
+static int xadc_axi_write_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t val)
 {
-	xadc_write_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4,
-		val);
+	xadc_write_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4, val);
 
 	return 0;
 }
 
-static int xadc_axi_setup(struct platform_device *pdev,
-	struct iio_dev *indio_dev, int irq)
+static int xadc_axi_setup(struct platform_device *pdev, struct iio_dev *indio_dev, int irq)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 
@@ -542,8 +519,7 @@ static void xadc_axi_update_alarm(struct xadc *xadc, unsigned int alarm)
 	 * passed the alarm mask in the same order as in the XADC alarm enable
 	 * register.
 	 */
-	alarm = ((alarm & 0x07) << 1) | ((alarm & 0x08) >> 3) |
-			((alarm & 0xf0) << 6);
+	alarm = ((alarm & 0x07) << 1) | ((alarm & 0x08) >> 3) | ((alarm & 0xf0) << 6);
 
 	spin_lock_irqsave(&xadc->lock, flags);
 	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
@@ -589,8 +565,7 @@ static const struct xadc_ops xadc_us_axi_ops = {
 	.temp_offset = 280231,
 };
 
-static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t mask, uint16_t val)
+static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t mask, uint16_t val)
 {
 	uint16_t tmp;
 	int ret;
@@ -602,8 +577,7 @@ static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
 	return _xadc_write_adc_reg(xadc, reg, (tmp & ~mask) | val);
 }
 
-static int xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t mask, uint16_t val)
+static int xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t mask, uint16_t val)
 {
 	int ret;
 
@@ -619,17 +593,16 @@ static unsigned long xadc_get_dclk_rate(struct xadc *xadc)
 	return xadc->ops->get_dclk_rate(xadc);
 }
 
-static int xadc_update_scan_mode(struct iio_dev *indio_dev,
-	const unsigned long *mask)
+static int xadc_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *mask)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
-	size_t n;
 	void *data;
+	size_t n;
 
 	n = bitmap_weight(mask, iio_get_masklength(indio_dev));
 
-	data = devm_krealloc_array(indio_dev->dev.parent, xadc->data,
-				   n, sizeof(*xadc->data), GFP_KERNEL);
+	data = devm_krealloc_array(indio_dev->dev.parent, xadc->data, n,
+				   sizeof(*xadc->data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -715,8 +688,7 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 			else
 				convst = 0;
 		}
-		ret = _xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF0_EC,
-					convst);
+		ret = _xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF0_EC, convst);
 		if (ret)
 			goto err_out;
 	} else {
@@ -743,8 +715,7 @@ static const struct iio_trigger_ops xadc_trigger_ops = {
 	.set_trigger_state = &xadc_trigger_set_state,
 };
 
-static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev,
-	const char *name)
+static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev, const char *name)
 {
 	struct device *dev = indio_dev->dev.parent;
 	struct iio_trigger *trig;
@@ -789,8 +760,7 @@ static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
 		break;
 	}
 
-	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_PD_MASK,
-		val);
+	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_PD_MASK, val);
 }
 
 static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
@@ -804,8 +774,7 @@ static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
 	if (xadc->external_mux_mode == XADC_EXTERNAL_MUX_DUAL)
 		return XADC_CONF1_SEQ_SIMULTANEOUS;
 
-	if ((aux_scan_mode & 0xff00) == 0 ||
-		(aux_scan_mode & 0x00ff) == 0)
+	if ((aux_scan_mode & 0xff00) == 0 || (aux_scan_mode & 0x00ff) == 0)
 		return XADC_CONF1_SEQ_CONTINUOUS;
 
 	return XADC_CONF1_SEQ_SIMULTANEOUS;
@@ -838,8 +807,7 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
-				  seq_mode);
+	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK, seq_mode);
 	if (ret)
 		return ret;
 
@@ -854,7 +822,7 @@ static int xadc_preenable(struct iio_dev *indio_dev)
 	int ret;
 
 	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
-		XADC_CONF1_SEQ_DEFAULT);
+				  XADC_CONF1_SEQ_DEFAULT);
 	if (ret)
 		goto err;
 
@@ -883,8 +851,7 @@ static int xadc_preenable(struct iio_dev *indio_dev)
 	if (ret)
 		goto err;
 
-	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
-		seq_mode);
+	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK, seq_mode);
 	if (ret)
 		goto err;
 
@@ -917,7 +884,7 @@ static int xadc_read_samplerate(struct xadc *xadc)
 }
 
 static int xadc_read_raw(struct iio_dev *indio_dev,
-	struct iio_chan_spec const *chan, int *val, int *val2, long info)
+			 struct iio_chan_spec const *chan, int *val, int *val2, long info)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 	unsigned int bits = chan->scan_type.realbits;
@@ -1017,11 +984,11 @@ static int xadc_write_samplerate(struct xadc *xadc, int val)
 		div = 0xff;
 
 	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_DIV_MASK,
-		div << XADC_CONF2_DIV_OFFSET);
+				   div << XADC_CONF2_DIV_OFFSET);
 }
 
 static int xadc_write_raw(struct iio_dev *indio_dev,
-	struct iio_chan_spec const *chan, int val, int val2, long info)
+			  struct iio_chan_spec const *chan, int val, int val2, long info)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 
@@ -1035,9 +1002,8 @@ static const struct iio_event_spec xadc_temp_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_RISING,
-		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
-				BIT(IIO_EV_INFO_VALUE) |
-				BIT(IIO_EV_INFO_HYSTERESIS),
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) | BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_HYSTERESIS),
 	},
 };
 
@@ -1293,9 +1259,8 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 	}
 
 	indio_dev->num_channels = num_channels;
-	indio_dev->channels = devm_krealloc_array(dev, channels,
-						  num_channels, sizeof(*channels),
-						  GFP_KERNEL);
+	indio_dev->channels = devm_krealloc_array(dev, channels, num_channels,
+						  sizeof(*channels), GFP_KERNEL);
 	/* If we can't resize the channels array, just use the original */
 	if (!indio_dev->channels)
 		indio_dev->channels = channels;
@@ -1303,7 +1268,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 	return 0;
 }
 
-static const char * const xadc_type_names[] = {
+static const char *const xadc_type_names[] = {
 	[XADC_TYPE_S7] = "xadc",
 	[XADC_TYPE_US] = "xilinx-system-monitor",
 };
@@ -1332,8 +1297,7 @@ static int xadc_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	irq = platform_get_irq_optional(pdev, 0);
-	if (irq < 0 &&
-	    (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL)))
+	if (irq < 0 && (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL)))
 		return irq;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*xadc));
@@ -1360,10 +1324,8 @@ static int xadc_probe(struct platform_device *pdev)
 		return ret;
 
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
-		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-						      &iio_pollfunc_store_time,
-						      &xadc_trigger_handler,
-						      &xadc_buffer_ops);
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev, &iio_pollfunc_store_time,
+						      &xadc_trigger_handler, &xadc_buffer_ops);
 		if (ret)
 			return ret;
 
@@ -1372,8 +1334,7 @@ static int xadc_probe(struct platform_device *pdev)
 			if (IS_ERR(xadc->convst_trigger))
 				return PTR_ERR(xadc->convst_trigger);
 
-			xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev,
-				"samplerate");
+			xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev, "samplerate");
 			if (IS_ERR(xadc->samplerate_trigger))
 				return PTR_ERR(xadc->samplerate_trigger);
 		}
@@ -1417,8 +1378,7 @@ static int xadc_probe(struct platform_device *pdev)
 		return ret;
 
 	for (i = 0; i < 16; i++)
-		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i),
-			&xadc->threshold[i]);
+		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i), &xadc->threshold[i]);
 
 	ret = xadc_write_adc_reg(xadc, XADC_REG_CONF0, conf0);
 	if (ret)
@@ -1434,8 +1394,7 @@ static int xadc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(1),
-		bipolar_mask >> 16);
+	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(1), bipolar_mask >> 16);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
index c188d3dcab48..f92776cd90c0 100644
--- a/drivers/iio/adc/xilinx-xadc-events.c
+++ b/drivers/iio/adc/xilinx-xadc-events.c
@@ -12,8 +12,8 @@
 
 #include "xilinx-xadc.h"
 
-static const struct iio_chan_spec *xadc_event_to_channel(
-	struct iio_dev *indio_dev, unsigned int event)
+static const struct iio_chan_spec *xadc_event_to_channel(struct iio_dev *indio_dev,
+							 unsigned int event)
 {
 	switch (event) {
 	case XADC_THRESHOLD_OT_MAX:
@@ -23,7 +23,7 @@ static const struct iio_chan_spec *xadc_event_to_channel(
 	case XADC_THRESHOLD_VCCAUX_MAX:
 		return &indio_dev->channels[event];
 	default:
-		return &indio_dev->channels[event-1];
+		return &indio_dev->channels[event - 1];
 	}
 }
 
@@ -43,9 +43,10 @@ static void xadc_handle_event(struct iio_dev *indio_dev, unsigned int event)
 		 * events.
 		 */
 		iio_push_event(indio_dev,
-			IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
-				IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
-			iio_get_time_ns(indio_dev));
+			       IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       iio_get_time_ns(indio_dev));
 	} else {
 		/*
 		 * For other channels we don't know whether it is a upper or
@@ -53,9 +54,10 @@ static void xadc_handle_event(struct iio_dev *indio_dev, unsigned int event)
 		 * channel value if it wants to know.
 		 */
 		iio_push_event(indio_dev,
-			IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
-				IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),
-			iio_get_time_ns(indio_dev));
+			       IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_EITHER),
+			       iio_get_time_ns(indio_dev));
 	}
 }
 
@@ -68,7 +70,7 @@ void xadc_handle_events(struct iio_dev *indio_dev, unsigned long events)
 }
 
 static unsigned int xadc_get_threshold_offset(const struct iio_chan_spec *chan,
-	enum iio_event_direction dir)
+					      enum iio_event_direction dir)
 {
 	unsigned int offset;
 
@@ -110,18 +112,16 @@ static unsigned int xadc_get_alarm_mask(const struct iio_chan_spec *chan)
 	}
 }
 
-int xadc_read_event_config(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir)
+int xadc_read_event_config(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+			   enum iio_event_type type, enum iio_event_direction dir)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 
 	return (bool)(xadc->alarm_mask & xadc_get_alarm_mask(chan));
 }
 
-int xadc_write_event_config(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, bool state)
+int xadc_write_event_config(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+			    enum iio_event_type type, enum iio_event_direction dir, bool state)
 {
 	unsigned int alarm = xadc_get_alarm_mask(chan);
 	struct xadc *xadc = iio_priv(indio_dev);
@@ -155,10 +155,9 @@ int xadc_write_event_config(struct iio_dev *indio_dev,
 	return ret;
 }
 
-int xadc_read_event_value(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, enum iio_event_info info,
-	int *val, int *val2)
+int xadc_read_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+			  enum iio_event_type type, enum iio_event_direction dir,
+			  enum iio_event_info info, int *val, int *val2)
 {
 	unsigned int offset = xadc_get_threshold_offset(chan, dir);
 	struct xadc *xadc = iio_priv(indio_dev);
@@ -180,10 +179,9 @@ int xadc_read_event_value(struct iio_dev *indio_dev,
 	return IIO_VAL_INT;
 }
 
-int xadc_write_event_value(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, enum iio_event_info info,
-	int val, int val2)
+int xadc_write_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+			   enum iio_event_type type, enum iio_event_direction dir,
+			   enum iio_event_info info, int val, int val2)
 {
 	unsigned int offset = xadc_get_threshold_offset(chan, dir);
 	struct xadc *xadc = iio_priv(indio_dev);
@@ -227,9 +225,9 @@ int xadc_write_event_value(struct iio_dev *indio_dev,
 			xadc->threshold[offset + 4] = 0;
 		else
 			xadc->threshold[offset + 4] = xadc->threshold[offset] -
-					xadc->temp_hysteresis;
+				xadc->temp_hysteresis;
 		ret = _xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(offset + 4),
-			xadc->threshold[offset + 4]);
+					  xadc->threshold[offset + 4]);
 		if (ret)
 			goto out_unlock;
 	}
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index b4d9d4683117..b36510450982 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -19,21 +19,16 @@ struct xadc_ops;
 struct platform_device;
 
 void xadc_handle_events(struct iio_dev *indio_dev, unsigned long events);
-
-int xadc_read_event_config(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir);
-int xadc_write_event_config(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, bool state);
-int xadc_read_event_value(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, enum iio_event_info info,
-	int *val, int *val2);
-int xadc_write_event_value(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, enum iio_event_info info,
-	int val, int val2);
+int xadc_read_event_config(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+			   enum iio_event_type type, enum iio_event_direction dir);
+int xadc_write_event_config(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+			    enum iio_event_type type, enum iio_event_direction dir, bool state);
+int xadc_read_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+			  enum iio_event_type type, enum iio_event_direction dir,
+			  enum iio_event_info info, int *val, int *val2);
+int xadc_write_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+			   enum iio_event_type type, enum iio_event_direction dir,
+			   enum iio_event_info info, int val, int val2);
 
 enum xadc_external_mux_mode {
 	XADC_EXTERNAL_MUX_NONE,
@@ -77,8 +72,7 @@ enum xadc_type {
 struct xadc_ops {
 	int (*read)(struct xadc *xadc, unsigned int reg, uint16_t *val);
 	int (*write)(struct xadc *xadc, unsigned int reg, uint16_t val);
-	int (*setup)(struct platform_device *pdev, struct iio_dev *indio_dev,
-			int irq);
+	int (*setup)(struct platform_device *pdev, struct iio_dev *indio_dev, int irq);
 	void (*update_alarm)(struct xadc *xadc, unsigned int alarm);
 	unsigned long (*get_dclk_rate)(struct xadc *xadc);
 	irqreturn_t (*interrupt_handler)(int irq, void *devid);
@@ -89,22 +83,19 @@ struct xadc_ops {
 	int temp_offset;
 };
 
-static inline int _xadc_read_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t *val)
+static inline int _xadc_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t *val)
 {
 	lockdep_assert_held(&xadc->mutex);
 	return xadc->ops->read(xadc, reg, val);
 }
 
-static inline int _xadc_write_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t val)
+static inline int _xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t val)
 {
 	lockdep_assert_held(&xadc->mutex);
 	return xadc->ops->write(xadc, reg, val);
 }
 
-static inline int xadc_read_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t *val)
+static inline int xadc_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t *val)
 {
 	int ret;
 
@@ -114,8 +105,7 @@ static inline int xadc_read_adc_reg(struct xadc *xadc, unsigned int reg,
 	return ret;
 }
 
-static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t val)
+static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t val)
 {
 	int ret;
 
-- 
2.34.1

