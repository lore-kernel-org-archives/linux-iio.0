Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338DE4B7A2F;
	Fri, 18 Sep 2026 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722484; cv=none; b=cpbOQSw0ljuE+7n/7C2WDbVWUM0oSJYmdH6q0bRZGT823sF5U0H4G/WR9WgDYO8irAhuo4QIL8V0zJUJQ+cmWC6s9Op3ZxRseh6Nhz4JGJ+nucM8XW2AKlnZByB6j3ijkRQc/3fVHb/UkAO0a+WFq8XhwFuukyTnT6zpKoBDgWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722484; c=relaxed/simple;
	bh=uQpyhEiAgb5Nn6OJCO6UkZhc3AbVe3PsA1yiSkG5Uh8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RhrnY3W0roEAq3qcna4+LMH3MBz5CkEpRO1pOHG9WjLQgBlntF+SamImPkyAhH5b4/ByTW6l9ITd3zVAHqSRpPekaIarF+Ak45zY4JzhNeA0FpdoaAf/w/AfJwm85QbZ3qBC05bHNB4Kh/7DF5MlVMPsq68ttRStQBkpDlax10Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=xh4A5f2j; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="xh4A5f2j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1789722483; x=1821258483;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=uQpyhEiAgb5Nn6OJCO6UkZhc3AbVe3PsA1yiSkG5Uh8=;
  b=xh4A5f2jshzCCETmwXHpbPOTCklhTap5aOMCntLfXa6uYr2/Jyi9UV8J
   fwz6udkvmX3cslb5r+WRAMjtS5Qm6/lN/iWJLXrNgPu6QqMBVDACy0P2V
   adTgR6IVZ1uLLnezBNgwacZPGUre95PFaU41G0+CHLYUWs77frTg4fqfI
   JEpuiFqmjtBSypUWJFKBl/4rHLPOSXm4KsW5D0bLk8hMpGsNIQ1F776xk
   JkWkE+Ilj9wbOjTr1/NJqYt8ar+BO5NNoMp+J0OtjSeqObJtNaB2TvHDR
   E4ZyeIeiXHxyFyvMacpvPAHYlr8KH11jNooH+V/3BqgmxbL62MtSPMXeA
   g==;
X-CSE-ConnectionGUID: AVrST4qOQv6+ZMcOqWxz6Q==
X-CSE-MsgGUID: 8mZaeW6mQsi0yNAbTpcU3A==
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="63800317"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 02:08:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex2.mchp-main.com (10.10.87.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.45; Fri, 18 Sep 2026 02:08:02 -0700
Received: from [127.0.1.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 18 Sep 2026 02:07:59 -0700
From: Ariana Lazar <ariana.lazar@microchip.com>
Date: Fri, 18 Sep 2026 12:06:33 +0300
Subject: [PATCH v7 07/11] iio: dac: mcp47feb02: correct typo from a comment
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260918-mcp47feb02_refactor-v7-7-82ca794eafe2@microchip.com>
References: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
In-Reply-To: <20260918-mcp47feb02_refactor-v7-0-82ca794eafe2@microchip.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789722457; l=1005;
 i=ariana.lazar@microchip.com; s=20250825; h=from:subject:message-id;
 bh=uQpyhEiAgb5Nn6OJCO6UkZhc3AbVe3PsA1yiSkG5Uh8=;
 b=99WWBhmvufeXWd/QcL+U039GQxpIie3soUQCL7MdY5HRhXxBeFH/cqBPQLHg/JIM75O5YyRGD
 tqoNmkVDU9QCCC2mfdf717nL0xxm8/4nADKrSZrrRHns556YSmf6ss8
X-Developer-Key: i=ariana.lazar@microchip.com; a=ed25519;
 pk=jmvf1fSxcnzZmXfITM3L94IwutM+wqA1POQHiYyD6Dk=

Typo corrected to 'Register' in the comment regarding defined masks for the
gain register.

Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
Link: https://lore.kernel.org/all/20260723231859.03f92ce6@systembl0wer/
Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
---
 drivers/iio/dac/mcp47feb02.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
index 43cf69e43a41e3555e37d1351328912dffb84a3c..8019d398fbbbc866303ed7e9280f30acef4d6cc7 100644
--- a/drivers/iio/dac/mcp47feb02.c
+++ b/drivers/iio/dac/mcp47feb02.c
@@ -51,7 +51,7 @@
 #define DAC_CTRL_MASK(ch)				(GENMASK(1, 0) << (2 * (ch)))
 #define DAC_CTRL_VAL(ch, val)				((val) << (2 * (ch)))
 
-/* Gain Control and I2C Slave Address Reguster fields */
+/* Gain Control and I2C Slave Address Register fields */
 #define DAC_GAIN_MASK(ch)				(BIT(0) << (8 + (ch)))
 #define DAC_GAIN_VAL(ch, val)				((val) << (8 + (ch)))
 

-- 
2.43.0

