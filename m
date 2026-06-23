Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255DA3D34B1;
	Tue, 23 Jun 2026 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212474; cv=none; b=bylVWTim88Q+v/auybeVqrSH5QD75uR9nG2g34rtyuL3f6uUM+PQCshcSTDVv4jlCOWU3WVDaNgeAf5qq6VTXLQj/xlLPgwK8fnM/rDI0l18vzelGEdtrNCBOeyi8KW1BElkHjJCFdzgvB967enZR5ZjO0QvzhC2lqOqPaYAO1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212474; c=relaxed/simple;
	bh=qPxtI+f+BE5aWVid8LOQEajXcJY4oSXCvUiv/NY6ixY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kJLVxAq/huaz09INlGFAbsl4TRBcz/4OLBaOb9aELyy0ZKNI3SaxNB2lNn14BSSfGhUzq2f4Tk82LMOorsfnpQ9FfL4BVQpfsYErjefnEKic4/XTEUzQ3JF0HWzRhHFrwiA5UJm1h6psXV0YY/QiHjqzmtcLkYTSpHccEA7Dibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=efCuYhLh; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="efCuYhLh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782212472; x=1813748472;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qPxtI+f+BE5aWVid8LOQEajXcJY4oSXCvUiv/NY6ixY=;
  b=efCuYhLhyG+pzHeh5UGLiIgcLxU9AhK0EKen6UozrMD7dHaULygmK/Vn
   fsPsivIxr5sctD1R0/DD5p0NDbAV0bTdPXns885SywM4LpCkNs0bkEmz1
   MXV9561mipsEZTlm/5CYtVO30jz3RA2txOCX0cz3NYPYYGxbmapiTVebD
   lBIDy2/qs+/hIQUQE88HZe/26V1F+Cafzr5fyU4BSBg5tBkKsUu/SQK0A
   Od37AhKMwcWDrcBNn80wtuDa+ByYzJcLonLMoZ9fQ5EYkfsMsNeEdrt6a
   ZfvNMcHF96tQGfEUf8oZMsloIP8B1SIJ0lWA9Oknw/9hNguVm+21vDTlc
   A==;
X-CSE-ConnectionGUID: 4POnpGtHRLiGc+NdSWIhnA==
X-CSE-MsgGUID: hyW3mxo3RASj/mLsfCm05g==
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="59914604"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jun 2026 04:01:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 23 Jun 2026 04:01:11 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 23 Jun 2026 04:01:06 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <ehristev@kernel.org>, <jic23@kernel.org>, <dlechner@baylibre.com>,
	<nuno.sa@analog.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<srini@kernel.org>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <varshini.rajendran@microchip.com>
Subject: [PATCH v2 10/12] ARM: dts: microchip: sama7d65: add cells for temperature calibration
Date: Tue, 23 Jun 2026 16:29:42 +0530
Message-ID: <20260623105944.128840-11-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623105944.128840-1-varshini.rajendran@microchip.com>
References: <20260623105944.128840-1-varshini.rajendran@microchip.com>
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

