Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2510399357;
	Tue, 30 Jun 2026 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812303; cv=none; b=p+sgkadGRRcBorbgpKb1x3sKEpktxHnrisDUA0hsfCCXybKtlnXDLBx4TU0i7Nlh+Mz7bTyWCh8X9/GtSOmuJlYLQTV9BUhq4/VDrpmrHOgklEuxTRYzPu82E41CHG36X7XIORKvxzoqLWGUjqC7xVNHgYkvmajNAkqYResGFlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812303; c=relaxed/simple;
	bh=qPxtI+f+BE5aWVid8LOQEajXcJY4oSXCvUiv/NY6ixY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHeOZMyF9oLPqH6l/cjgDghUXC8omr2CahKLka5ZsmkHrD0dIijpgKIi5LuyVQhSHXnd7QdY6nvhRJ1fw4ID7TJ3nJK0/z8W2O4zkDLhv3i513CoyxhSl+VVuKvH253rueAQ9PkJEytuqJRF1QUWIWpTCpYAcpTAS7IKvxuAgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=EGKMhbw1; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="EGKMhbw1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782812301; x=1814348301;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=qPxtI+f+BE5aWVid8LOQEajXcJY4oSXCvUiv/NY6ixY=;
  b=EGKMhbw1DqyQ0g4WNq5jNCEL+1g9wc7nQeL+g2zOYsBce7L4WV1Qi7Dj
   aKxVNWtavPqdZPMfh2+at5W4nAJ5l23eIsIf/jXnczv3XeXioyn/Sqjeq
   toOiCNF+3n8cWbzHCJTs+KczP2kISk9Id5T3JVuV0o488261dQNbHv2qu
   o71/Q4vHRHoV452QNxwoDHKNyGZ1IzATNE9qUoEKFckJu864DbzDNv1h0
   nmhzOGyjlDtdBVkBXKSaiMqMbu7i6A2OwdnIGZ8Qihfd3Y/cXrI6ayjM4
   Ak2S5NwVy0q7CmxE52x16KCm9VW7+UIBw0jOyxeNro7TVVm8FGSj1auaN
   Q==;
X-CSE-ConnectionGUID: DMe9/CRHQ/yCFfdCFRbxVQ==
X-CSE-MsgGUID: P4Zsrn08TZebKbn4DPHosg==
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="59032715"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 02:38:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Tue, 30 Jun 2026 02:38:20 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 30 Jun 2026 02:38:12 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <marcelo.schmitt@analog.com>, <jorge.marques@analog.com>,
	<mazziesaccount@gmail.com>, <Jonathan.Santos@analog.com>,
	<jishnu.prakash@oss.qualcomm.com>, <antoniu.miclaus@analog.com>,
	<duje@dujemihanovic.xyz>, <varshini.rajendran@microchip.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 11/13] ARM: dts: microchip: sama7d65: add cells for temperature calibration
Date: Tue, 30 Jun 2026 15:06:01 +0530
Message-ID: <20260630093603.38663-12-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260630093603.38663-1-varshini.rajendran@microchip.com>
References: <20260630093603.38663-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Add NVMEM cell to ADC for temperature calibration data.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index 5867fda378b1..c336f863406d 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -323,6 +323,8 @@ adc: adc@e1000000 {
 			atmel,trigger-edge-type = <IRQ_TYPE_EDGE_RISING>;
 			atmel,startup-time-ms = <4>;
 			#io-channel-cells = <1>;
+			nvmem-cells = <&temperature_calib>;
+			nvmem-cell-names = "temperature_calib";
 			status = "disabled";
 		};
 
-- 
2.34.1

