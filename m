Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D9B3955EB;
	Tue, 30 Jun 2026 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812268; cv=none; b=IWy48V9BcTiisNYXylAxnIoxXj3qQe2DQV0ijgjcJEykzVjFagj0blWswtQ05npH/+sbK1xNDOxK/4DmiQtOGRpiQmQuAhxGj+cgxvSWDVzJsM4TVdSNrLWGjlRWCl3eL11as7bKq38BetPmCXCHkADyIlUKt4kYrqL5eGZO3CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812268; c=relaxed/simple;
	bh=xo5iwXFK0E9pHQdJ+Y5ZSzvvpbR4uPF2/cc1u7E9VuE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NARK7kVUFN5ub8/EGSS2uxmvXaWPqYPTCpHq19DGjoOMWYuebiI3oqduWqmkjxSD0C0K+tGwQewfAReAxqCyAFMEHPnYWdYvzy9auX58+yEOphCKrQyRS1zDsmg5w/zQsRjDxau5FCW5zIB+uYfpSQJZ7i4ott6vqqQSAvqZezE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=1zsTCZal; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="1zsTCZal"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1782812267; x=1814348267;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=xo5iwXFK0E9pHQdJ+Y5ZSzvvpbR4uPF2/cc1u7E9VuE=;
  b=1zsTCZalU2sZ0H+l/e4QU5JIkYk4IIk/h3s+yHTu6MGsxp1eaw/vAw6g
   80chB6ptqwG4T27sdCfagB91sBo/ISyvLC9m+KMWkAIgNyJWabLS64dxw
   BPQIDNhbkK+oZ2bDefZRNbJ/0HxYbTdfKpkXUMXZeci7GP5TlLbl6D0V1
   5QwNVwMrUoknWjagCWsQT1uZyAFoUALyuTaUmIpuUPCUaVWWqGG4WBVsK
   ypad192JMnJleuu5Dd7QWQwqwz6hH0S1wF1iO75yivmaxkiwKtMH9vUJJ
   SKlESpefDd3X8r6WHawtOp+ZM/kRr7hnNFwD8z63dg52ZYMHhiFLiYgyq
   A==;
X-CSE-ConnectionGUID: 5NSbx0ugQlGUH4HUi6SY8Q==
X-CSE-MsgGUID: +jhzn51+QtmI8wL9vHWJMg==
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="60234280"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 02:37:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.43; Tue, 30 Jun 2026 02:37:46 -0700
Received: from che-ll-i67070.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 30 Jun 2026 02:37:37 -0700
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
Subject: [PATCH v3 07/13] ARM: dts: microchip: sama7d65: add cpu opps
Date: Tue, 30 Jun 2026 15:05:57 +0530
Message-ID: <20260630093603.38663-8-varshini.rajendran@microchip.com>
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

Add CPU OPPs table for SAMA7D65.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 arch/arm/boot/dts/microchip/sama7d65.dtsi | 36 +++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/microchip/sama7d65.dtsi b/arch/arm/boot/dts/microchip/sama7d65.dtsi
index 67253bbc08df..94d49e20dc79 100644
--- a/arch/arm/boot/dts/microchip/sama7d65.dtsi
+++ b/arch/arm/boot/dts/microchip/sama7d65.dtsi
@@ -35,6 +35,7 @@ cpu0: cpu@0 {
 			d-cache-size = <0x8000>;	// L1, 32 KB
 			i-cache-size = <0x8000>;	// L1, 32 KB
 			next-level-cache = <&L2>;
+			operating-points-v2 = <&cpu_opp_table>;
 
 			L2: l2-cache {
 				compatible = "cache";
@@ -45,6 +46,41 @@ L2: l2-cache {
 		};
 	};
 
+	cpu_opp_table: opp-table {
+		compatible = "operating-points-v2";
+
+		opp-90000000 {
+			opp-hz = /bits/ 64 <90000000>;
+			opp-microvolt = <1050000 1050000 1225000>;
+			clock-latency-ns = <320000>;
+		};
+
+		opp-250000000 {
+			opp-hz = /bits/ 64 <250000000>;
+			opp-microvolt = <1050000 1050000 1225000>;
+			clock-latency-ns = <320000>;
+		};
+
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1050000 1050000 1225000>;
+			clock-latency-ns = <320000>;
+			opp-suspend;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1150000 1125000 1225000>;
+			clock-latency-ns = <320000>;
+		};
+
+		opp-1000000002 {
+			opp-hz = /bits/ 64 <1000000002>;
+			opp-microvolt = <1250000 1225000 1300000>;
+			clock-latency-ns = <320000>;
+		};
+	};
+
 	clocks {
 		main_xtal: clock-mainxtal {
 			compatible = "fixed-clock";
-- 
2.34.1

