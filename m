Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E81E35E1AE;
	Tue,  4 Aug 2026 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785843343; cv=none; b=b86dAszzLWIBWO8SGfMds3pDFLaqo99NN1918bhTKRLrBkgk0pgaTHPPxA2U8K9nXCaZGVtVBK7yhMnKx9KLdRlYvaquekogAXpxniIbLzCFsXbITKiM9V08O43iZYEKAG5jRnRqo4fVGs1WQUNlfIWohGuRmEP3xksdQa8n/kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785843343; c=relaxed/simple;
	bh=Av6eeg2ekqj+HOs2zrQPFQA1RnGOcXg/+B9uTPlD7J8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pz1FTmhOrXZrbca3/zbN+vyuHnkXjqdxiuksou7GhX3HBuQNpH/xLeodoyXybaBanZB8ZolL4nANVIbM7vSx56OXYaRTW3y1k8CZBns4CcQ7rdhmzhb73bxdsPO0ecewxiFcO7KdTP1huGUVgLDEQWFTMDrgzW2IFvDfP4w4SSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Xg91NT6A; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Xg91NT6A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1785843342; x=1817379342;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Av6eeg2ekqj+HOs2zrQPFQA1RnGOcXg/+B9uTPlD7J8=;
  b=Xg91NT6AyBAYlf0RVQN5Mr8pt/VAsA/24Hh34mLm5Llfq/xoD6tQy0qk
   53Va7NQpakbUqnL89clH6fgxk2FnhWjyiBAAuGmIiSj4KlJwXhbhl3CBf
   LG/Eox2uo7bRQR9ZFNZigwPQ4t74XwbkDPR2maP97mIQQ4S5j/JjEphD8
   auKD7jVxbVXRU3oYpwGBwuAp7EP0m4CB8vsu0UH7toDInpOXrbR2k4Ngh
   8/ja6p7SpqDtL9bDvBteX3mRl8KHEO5ndmXZCfMQ55P8rCofdJDDQjg/2
   R3x29Mgk3AOa09udn074aM97AOAiB/YI3bjfMBBLiNy2PIUp7PpYG8ESp
   w==;
X-CSE-ConnectionGUID: 9Xxrn/ddQv+JEDEp8rZysg==
X-CSE-MsgGUID: d0CaX/zIS2mlZGcQFiIrqA==
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="228765807"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 04:35:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Tue, 4 Aug 2026 04:35:40 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 4 Aug 2026 04:35:30 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <marcelo.schmitt@analog.com>, <radu.sabau@analog.com>,
	<joshua.crofts1@gmail.com>, <jorge.marques@analog.com>,
	<Jonathan.Santos@analog.com>, <jishnu.prakash@oss.qualcomm.com>,
	<antoniu.miclaus@analog.com>, <duje@dujemihanovic.xyz>,
	<mazziesaccount@gmail.com>, <varshini.rajendran@microchip.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 10/17] nvmem: microchip-otpc: nvmem: add emulation mode and OTP access validation
Date: Tue, 4 Aug 2026 17:03:31 +0530
Message-ID: <20260804113338.261782-11-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260804113338.261782-1-varshini.rajendran@microchip.com>
References: <20260804113338.261782-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add validation of OTP memory accessibility and emulation mode status
during probe.

When the boot packet is not configured, emulation mode allows access to
the other packets. When both are not available an informational message
is logged to help with debugging.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 drivers/nvmem/microchip-otpc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/microchip-otpc.c b/drivers/nvmem/microchip-otpc.c
index a17f82afdc37..6b0184423463 100644
--- a/drivers/nvmem/microchip-otpc.c
+++ b/drivers/nvmem/microchip-otpc.c
@@ -18,6 +18,7 @@
 #define MCHP_OTPC_CR_READ		BIT(6)
 #define MCHP_OTPC_MR			(0x4)
 #define MCHP_OTPC_MR_ADDR		GENMASK(31, 16)
+#define MCHP_OTPC_MR_EMUL		BIT(7)
 #define MCHP_OTPC_AR			(0x8)
 #define MCHP_OTPC_SR			(0xc)
 #define MCHP_OTPC_SR_READ		BIT(6)
@@ -343,7 +344,8 @@ static int mchp_otpc_probe(struct platform_device *pdev)
 {
 	struct nvmem_device *nvmem;
 	struct mchp_otpc *otpc;
-	u32 size;
+	bool emul_enable;
+	u32 size, mr_val;
 	int ret;
 
 	otpc = devm_kzalloc(&pdev->dev, sizeof(*otpc), GFP_KERNEL);
@@ -355,10 +357,22 @@ static int mchp_otpc_probe(struct platform_device *pdev)
 		return PTR_ERR(otpc->base);
 
 	otpc->dev = &pdev->dev;
+
+	mr_val = readl_relaxed(otpc->base + MCHP_OTPC_MR);
+	emul_enable = mr_val & MCHP_OTPC_MR_EMUL;
+	if (emul_enable)
+		dev_info(otpc->dev, "Emulation mode enabled\n");
+
 	ret = mchp_otpc_init_packets_list(otpc, &size);
 	if (ret)
 		return ret;
 
+	if (!size) {
+		dev_warn(otpc->dev, "Cannot access OTP memory\n");
+		if (!emul_enable)
+			dev_info(otpc->dev, "Boot packet not programmed and emulation mode disabled\n");
+	}
+
 	mchp_nvmem_config.dev = otpc->dev;
 	mchp_nvmem_config.add_legacy_fixed_of_cells = true;
 	mchp_nvmem_config.size = size;
-- 
2.34.1

