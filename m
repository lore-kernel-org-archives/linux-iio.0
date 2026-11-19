Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795087531;
	b=FzcEoJ3qTvGrK3di7qW2cNuWAoZXqCkzk2t81JZ70EHWK3hZ0BcVRtzDyS52LA1otX1l
	 Wkaz49g8O3wkqw37OdOmTlO28l7PDVPAJ5H8WtKM5HugCNZD0jZECjn1wUrZxRCXiihm0
	 ZaTLciQgouFEzvYoX+xVGDaPWU2unvDg6Apm5SNWpsEmkOnh0jxblk9x2DAtj19jGXh9x
	 piShnqm43eQcA2XKXmNih1kbDsOuAmSifScqr2/T/e6xe6LEoZkn9kx6OBF6WzECCWUT3
	 c7FYY/t085iFjGfKqCjkIU/x5h41EOH8SVbIHwvtDAsLmngjmskcnhoYkJZVZhjaIlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795087531;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=03le848viogE6kv0vw5YmgwjSqThQrvVCki47dLaLPE=;
	b=nsMsoFbE7FdPyEUyko3poyWknzrsNt9SmNJNM98x1MHWDB/GXP3PJuv7rHAqzYdpB9S5
	 aaW2129P8jUN+eKW5VOBQCe6HtX9/QHst51i6/BzVWY50cDEvkPJErlQDDl8jEvI6Yd7/
	 +4IxlfwygLgvCuMCsxzLvYtRLsJK9cL6OmndHM04KatDiNSdvmQ7HDKzgDp4pZ1VFh3UE
	 9k7cXfkSTXoCTHjISpn8W0uDlq5FZFGt0TiWTf7Zu/iqoKhsXuqeLmeIrtCncrKSf/0jp
	 UUENvTngErn73NTj+gCnzZS/4Uyx3JJl+Wx4l/uPklrKiUHp0fBByIZqQN8uQ9/v9Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=mWUj3f6y;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Sc2RaAL0;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5AE606A326;
	Thu, 19 Nov 2026 11:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD5AE606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=mWUj3f6y;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Sc2RaAL0
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJB08l41583022;
	Thu, 19 Nov 2026 06:25:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=03le848viogE6kv0vw5YmgwjSqThQrvVCki47dLaLPE=; b=mWUj3f6
	yfv9+I08gOPuOS2NUuQ2b2x6x76KgunmyUmNMC0O28VxGraWm3hkxNNHPgKcVawg
	akRzUOZb9bnFaBTVLISfHJJglHraoS0iWGFqM86NTC+JzRttBYRQ+201LZl4JFHD
	8C+7Y4ci2WTRLubhlIbm+jnFLFhmKLu09lY6y07RZ3+wMXW0a5kLRGgq+jcYMnQ+
	QySRq/K/FeDvbIEh04aN2pf3bHE7MmMTLLY2WahAkgG5czYO5oK98nYHDgssUGgU
	tw9npcuD/TLyAlw8fgVfjjEEE/HXgb6xH6J7hSLHN4AGmSnpvokf792Kw+jL3r9H
	88i8xgDWzAuX3Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=03le8
	48viogE6kv0vw5YmgwjSqThQrvVCki47dLaLPE=; b=Sc2RaAL0Hv2rcB8lWK8QH
	6Ui1r62gBeI3Eon4pwmGXVp6mmWGX4ibMDjh4GcNWnlIHKyZYguhwQnx01pYtMT2
	kevJJLdRIkKDHUvu6dlNytqNpndMf+VTjt76ufQckIN2yOc39lA6PNeQIf3Mt6zu
	k0XgMxPQQdfw83FiaXjlZZq3/+wH79yuDWmao9uUPKRUEtPsMIYkjak2OybTdXWR
	udaSawKY8eg8pWJz7S57NfOrbJXI7i5zFhvuAobqSFe7XUxy2I9eLriBp03oxal8
	xBjLgOBJD9V3NUjBm8MYLnhCbWYjXWi66BTNni5CKBe7LV9VHbxW18tcskOqArLx
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j138j1m55-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 06:25:25 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6AJBPO9A023290
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 19 Nov 2026 06:25:24 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 06:25:24 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 06:25:23 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.2562.56 via Frontend
 Transport; Thu, 19 Nov 2026 06:25:23 -0500
Received: from arch ([10.135.2.95])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6AJBOocN010881;
	Thu, 19 Nov 2026 06:25:18 -0500
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring
	<robh@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        "Trevor
 Gamblin" <tgamblin@baylibre.com>,
        Joshua Crofts <crofts@kernel.org>,
        "Sergiu
 Cuciurean" <sergiu.cuciurean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Nicolae-Daniel
 Deaconescu" <Nicolae-daniel.Deaconescu@analog.com>
Subject: [PATCH v4 6/6] iio: adc: ad7625: add LTC2387 and ADAQ2387x support
Date: Thu, 19 Nov 2026 13:24:20 +0200
Message-ID: <20261119112437.197306-7-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119112437.197306-1-Nicolae-daniel.Deaconescu@analog.com>
References: <20261119112437.197306-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: zcFXE3scyxE0_FRTCHqxWmH1qjkniDaN
X-Proofpoint-ORIG-GUID: zcFXE3scyxE0_FRTCHqxWmH1qjkniDaN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX2pPEawuZ3Pbt
 fT3n9buIHTDhI1PhtRU2HgycDUmO1OPRe97Tas5dDit4WjhAQ9d9j36VSzkecebch5lvD5zZpPc
 9p2bOoutZDRjQcKN1ICyiKzdwTBCqJI/cgOaEaxqS95OuW5VC5PwoR5KYRIi9OZdzDBJJTLA8xm
 LFMDhCEypTSikH0Fk3Z8Xg0szW9Yfwzm21iwdBy4LWq5EUWTOHglIiYNCS9Ej94Fqvw3TlyzH7I
 zJQiI534speK4bARL25DosJ0kiWu2Jz9A8WHG+YamgJ1iexUaUNOyZIgFEIDVMzhxImD1sBwF/X
 b3umzeZKt2rOgCrh5A4kkusANs4bSfibmh5/7O23HxGJuH+r/NQd+LBoEWdJb2/4u4XiUbqZN/G
 jTupljZ9rDzcG7miaJfcCaRcCA71tuqQhIutNomv6nXg4FcQx00OJD5H2KnlP86CcLAduTBjGC9
 c9gZPmWQNPD5ZAK8Cgw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0NSBTYWx0ZWRfX+6lZS9rEZxzd
 xqeBnnwohcAWjvY6QuN/0tHVTqGBuYYmVlb2wVji1bsB42Xc3/S4sBDBqtkJ+DY3HO9HxBNXLxl
 EbQ0PQfNaP0ypvREybSHvObrqQJFes0n8tI40O4xrjJ8MFYNhQIZ
X-Authority-Analysis: v=2.4 cv=PdVqFShd c=1 sm=1 tr=0 ts=6afedca5 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=wI1k2SEZAAAA:8 a=IpJZQVW2AAAA:8 a=h1Fcq-iXiXXcpCbiyl4A:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6HWbV-4b7c7AdzY24d_u:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_03,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190045

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

Add the LTC2387-16, LTC2387-18, ADAQ23875, ADAQ23876 and ADAQ23878 as chip
data of this driver. The same two PWMs and IIO backend are used to read
from them. See the binding patch for how they differ from the existing
parts.

The CLK burst of a conversion starts at least t_FIRSTCLK after its CNV and
ends at most t_LASTCLK after the next CNV, so the sampling period is raised
until the burst fits, instead of being clamped to 10 MSPS. Waveforms are
built in whole PWM steps, read with pwm_get_waveform_step_might_sleep().

The scale is divided by the gain of the ADAQ front end.

Add new maintainer entries.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Co-developed-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
---
 Documentation/iio/ad7625.rst |  34 ++-
 MAINTAINERS                  |   2 +
 drivers/iio/adc/Kconfig      |   7 +-
 drivers/iio/adc/ad7625.c     | 406 ++++++++++++++++++++++++++++++++++-
 4 files changed, 439 insertions(+), 10 deletions(-)

diff --git a/Documentation/iio/ad7625.rst b/Documentation/iio/ad7625.rst
index 61761e3b75c3..c9dbd5c631ba 100644
--- a/Documentation/iio/ad7625.rst
+++ b/Documentation/iio/ad7625.rst
@@ -4,8 +4,8 @@
 AD7625 driver
 ====================
 
-ADC driver for Analog Devices Inc. AD7625, AD7626, AD7960, and AD7961
-devices. The module name is ``ad7625``.
+ADC driver for Analog Devices Inc. AD7625 and fairly similar devices. The module
+name is ``ad7625``.
 
 Supported devices
 =================
@@ -16,8 +16,14 @@ The following chips are supported by this driver:
 * `AD7626 <https://www.analog.com/AD7626>`_
 * `AD7960 <https://www.analog.com/AD7960>`_
 * `AD7961 <https://www.analog.com/AD7961>`_
+* `ADAQ23875 <https://www.analog.com/ADAQ23875>`_
+* `ADAQ23876 <https://www.analog.com/ADAQ23876>`_
+* `ADAQ23878 <https://www.analog.com/ADAQ23878>`_
+* `LTC2387-16 <https://www.analog.com/LTC2387-16>`_
+* `LTC2387-18 <https://www.analog.com/LTC2387-18>`_
 
-The driver requires use of the Pulsar LVDS HDL project:
+The driver requires use of the Pulsar LVDS HDL project for the AD7625, AD7626,
+AD7960 and AD7961:
 
 * `Pulsar LVDS HDL <http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html>`_
 
@@ -65,6 +71,28 @@ The source is determined by the device tree. If ``ref-supply`` is present, then
 the external reference is used. If ``refin-supply`` is present, then the internal
 buffer is used. If neither is present, then the internal reference is used.
 
+LTC2387 and ADAQ2387x
+---------------------
+
+These parts output data on one or two lanes at double data rate, selected by
+the TWOLANES pin, which the ``adi,use-two-lanes`` property describes. They have no
+EN pins and no ``clocks`` property. The driver asks the two PWMs for their
+step with ``pwm_get_waveform_step_might_sleep()`` and builds the CNV and CLK
+waveforms in whole steps, so that the burst of CLK pulses starts at least
+t\ :sub:`FIRSTCLK` after CNV and ends at most t\ :sub:`LASTCLK` after the
+next CNV. The burst can run into the next conversion period, which limits the
+sampling frequency in one-lane mode. The ADAQ parts divide the scale by the
+gain of their front end. It is fixed on the ADAQ23875 and given by
+``adi,gain-milli`` on the ADAQ23876 and ADAQ23878.
+
+The driver counts every cycle of the clock that the PWM reports as one pulse
+of the CLK input, so the clock gated onto CLK has to be the one the PWM
+counts. They need an AXI ADC design of their own, not the Pulsar LVDS one: the
+DDR capture and the lane count have to match it, as the AXI ADC backend has no
+DDR operation to select it, and for two lanes it has to implement
+``num_lanes_set``. The first sample after the buffer is enabled can be stale,
+as the CLK burst of a conversion may fall into the next conversion period.
+
 Unimplemented features
 ----------------------
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 9d07f1f47c6f..7c419c285e0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1653,6 +1653,8 @@ F:	include/dt-bindings/iio/addac/adi,ad74413r.h
 ANALOG DEVICES INC AD7625 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 M:	Nuno Sá <nuno.sa@analog.com>
+M:	Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
+M:	Sergiu Cuciurean <sergiu.cuciurean@analog.com>
 R:	Trevor Gamblin <tgamblin@baylibre.com>
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 02de4809ae31..3a79e5ff84f5 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -404,7 +404,7 @@ config AD7606_IFACE_SPI
 	  module will be called ad7606_spi.
 
 config AD7625
-	tristate "Analog Devices AD7625/AD7626 High Speed ADC driver"
+	tristate "Analog Devices high speed LVDS ADCs similar to the AD7625"
 	depends on PWM
 	select IIO_BACKEND
 	help
@@ -413,6 +413,11 @@ config AD7625
 	  * AD7626 16-Bit, 10 MSPS PulSAR Analog-to-Digital Converter
 	  * AD7960 18-Bit, 5 MSPS PulSAR Analog-to-Digital Converter
 	  * AD7961 16-Bit, 5 MSPS PulSAR Analog-to-Digital Converter
+	  * ADAQ23875 and ADAQ23876 16-Bit, 15 MSPS uModule Data Acquisition
+	    Systems
+	  * ADAQ23878 18-Bit, 15 MSPS uModule Data Acquisition System
+	  * LTC2387-16 16-Bit, 15 MSPS SAR Analog-to-Digital Converter
+	  * LTC2387-18 18-Bit, 15 MSPS SAR Analog-to-Digital Converter
 
 	  The driver requires the assistance of the AXI ADC IP core to operate.
 
diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
index 127441050687..8ddd18e45c8a 100644
--- a/drivers/iio/adc/ad7625.c
+++ b/drivers/iio/adc/ad7625.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-only)
 /*
- * Analog Devices Inc. AD7625 ADC driver
+ * Analog Devices Inc. high speed LVDS ADCs similar to the AD7625
  *
  * Copyright 2024 Analog Devices Inc.
  * Copyright 2024 BayLibre, SAS
@@ -17,10 +17,14 @@
 #include <linux/iio/backend.h>
 #include <linux/iio/iio.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/pwm.h>
 #include <linux/regulator/consumer.h>
+#include <linux/types.h>
 #include <linux/units.h>
 
 #define AD7625_INTERNAL_REF_MV 4096
@@ -33,6 +37,15 @@ struct ad7625_timing_spec {
 	unsigned int conv_msb_ns;
 };
 
+struct ad7625_ddr_timing {
+	/* Minimum conversion high time (t_{CNVH}). */
+	unsigned int cnv_high_min_ns;
+	/* Minimum CNV to first CLK edge of the same conversion (t_{FIRSTCLK}). */
+	unsigned int first_clk_min_ns;
+	/* Maximum next CNV to last CLK edge of the previous one (t_{LASTCLK}). */
+	unsigned int last_clk_max_ns;
+};
+
 struct ad7625_chip_info {
 	const char *name;
 	const unsigned int max_sample_freq_hz;
@@ -41,6 +54,18 @@ struct ad7625_chip_info {
 	const bool has_power_down_state;
 	const bool has_bandwidth_control;
 	const bool has_internal_vref;
+	/* Parts with DDR output on one or two lanes, timed by the PWMs. */
+	const struct ad7625_ddr_timing *ddr_timing;
+	const bool no_en_pins;
+	/* Name of the second PWM, "clk_gate" if NULL. */
+	const char *clk_pwm_name;
+	/* Supplies to enable, if the part isn't supplied by VIO, VDD1, VDD2. */
+	const char * const *supplies;
+	const unsigned int num_supplies;
+	/* Whether the scale is divided by a gain. */
+	const bool has_gain;
+	/* The gain * MILLI, 0 if it is pin strapped on the board and set in the DT. */
+	const u16 default_gain;
 };
 
 /* AD7625_CHAN_SPEC - Define a chan spec structure for a specific chip */
@@ -78,6 +103,12 @@ struct ad7625_state {
 	struct pwm_waveform cnv_wf;
 	unsigned int vref_mv;
 	u32 sampling_freq_hz;
+	/* Step of the PWMs, for the parts with DDR output */
+	struct pwm_waveform_step step;
+	/* Gain of the front end * MILLI */
+	u16 gain;
+	/* Whether the TWOLANES pin is high, for the parts with DDR output */
+	bool two_lanes;
 	/*
 	 * Optional GPIOs for controlling device state. EN0 and EN1
 	 * determine voltage reference configuration and on/off state.
@@ -164,6 +195,78 @@ static const struct ad7625_chip_info ad7961_chip_info = {
 	.has_internal_vref = false,
 };
 
+static const struct ad7625_ddr_timing ltc2387_ddr_timing = {
+	.cnv_high_min_ns = 5,
+	.first_clk_min_ns = 65,
+	.last_clk_max_ns = 49,
+};
+
+static const char * const ltc2387_supplies[] = { "vdd", "vddl", "ovdd" };
+static const char * const adaq2387x_supplies[] = { "vdd", "vio", "vs-p" };
+
+static const struct ad7625_chip_info ltc2387_16_chip_info = {
+	.name = "ltc2387-16",
+	.max_sample_freq_hz = 15 * HZ_PER_MHZ,
+	.chan_spec = AD7625_CHAN_SPEC(16),
+	.ddr_timing = &ltc2387_ddr_timing,
+	.no_en_pins = true,
+	.clk_pwm_name = "clk",
+	.has_gain = true,
+	.supplies = ltc2387_supplies,
+	.num_supplies = ARRAY_SIZE(ltc2387_supplies),
+	.default_gain = 1 * MILLI,
+};
+
+static const struct ad7625_chip_info ltc2387_18_chip_info = {
+	.name = "ltc2387-18",
+	.max_sample_freq_hz = 15 * HZ_PER_MHZ,
+	.chan_spec = AD7625_CHAN_SPEC(18),
+	.ddr_timing = &ltc2387_ddr_timing,
+	.no_en_pins = true,
+	.clk_pwm_name = "clk",
+	.has_gain = true,
+	.supplies = ltc2387_supplies,
+	.num_supplies = ARRAY_SIZE(ltc2387_supplies),
+	.default_gain = 1 * MILLI,
+};
+
+static const struct ad7625_chip_info adaq23875_chip_info = {
+	.name = "adaq23875",
+	.max_sample_freq_hz = 15 * HZ_PER_MHZ,
+	.chan_spec = AD7625_CHAN_SPEC(16),
+	.ddr_timing = &ltc2387_ddr_timing,
+	.no_en_pins = true,
+	.clk_pwm_name = "clk",
+	.has_gain = true,
+	.supplies = adaq2387x_supplies,
+	.num_supplies = ARRAY_SIZE(adaq2387x_supplies),
+	.default_gain = 2 * MILLI,
+};
+
+static const struct ad7625_chip_info adaq23876_chip_info = {
+	.name = "adaq23876",
+	.max_sample_freq_hz = 15 * HZ_PER_MHZ,
+	.chan_spec = AD7625_CHAN_SPEC(16),
+	.ddr_timing = &ltc2387_ddr_timing,
+	.no_en_pins = true,
+	.clk_pwm_name = "clk",
+	.has_gain = true,
+	.supplies = adaq2387x_supplies,
+	.num_supplies = ARRAY_SIZE(adaq2387x_supplies),
+};
+
+static const struct ad7625_chip_info adaq23878_chip_info = {
+	.name = "adaq23878",
+	.max_sample_freq_hz = 15 * HZ_PER_MHZ,
+	.chan_spec = AD7625_CHAN_SPEC(18),
+	.ddr_timing = &ltc2387_ddr_timing,
+	.no_en_pins = true,
+	.clk_pwm_name = "clk",
+	.has_gain = true,
+	.supplies = adaq2387x_supplies,
+	.num_supplies = ARRAY_SIZE(adaq2387x_supplies),
+};
+
 enum ad7960_mode {
 	AD7960_MODE_POWER_DOWN,
 	AD7960_MODE_SNOOZE,
@@ -172,12 +275,178 @@ enum ad7960_mode {
 	AD7960_MODE_TEST_PATTERN,
 };
 
+/* Cycles of the gated clock needed to cover @ns, rounded up. */
+static u32 ad7625_ddr_ns_to_cycles(struct ad7625_state *st, u32 ns)
+{
+	return mul_u64_u64_div_u64_roundup(ns, st->step.clk_rate_Hz,
+					   NSEC_PER_SEC);
+}
+
+/* PWM steps needed to cover @cycles clock cycles, rounded up. */
+static u32 ad7625_ddr_cycles_to_steps(struct ad7625_state *st, u32 cycles)
+{
+	return DIV_ROUND_UP(cycles, st->step.clk_cycles_per_step);
+}
+
+/*
+ * The PWMs round a requested length down to whole steps, so asking for
+ * round_up(n * step) ns results in exactly n steps.
+ */
+static u64 ad7625_ddr_steps_to_ns(struct ad7625_state *st, u32 steps)
+{
+	u64 cycles = mul_u32_u32(steps, st->step.clk_cycles_per_step);
+
+	return mul_u64_u64_div_u64_roundup(cycles, NSEC_PER_SEC,
+					   st->step.clk_rate_Hz);
+}
+
+/* CLK pulses per conversion. Each pulse carries 2 bits per lane (DDR). */
+static u32 ad7625_ddr_burst_pulses(struct ad7625_state *st)
+{
+	return DIV_ROUND_UP(st->info->chan_spec.scan_type.realbits,
+			    st->two_lanes ? 4 : 2);
+}
+
+/*
+ * Read the step of the PWMs. They have to agree, as CNV and CLK are one
+ * burst, and the burst has to be a whole number of steps long, so a PWM that
+ * takes several clock cycles per step can only make a matching number of
+ * pulses.
+ */
+static int ad7625_ddr_read_step(struct ad7625_state *st,
+				struct pwm_waveform_step *step)
+{
+	struct pwm_waveform_step cnv_step;
+	int ret;
+
+	ret = pwm_get_waveform_step_might_sleep(st->clk_gate_pwm, step);
+	if (ret)
+		return ret;
+
+	ret = pwm_get_waveform_step_might_sleep(st->cnv_pwm, &cnv_step);
+	if (ret)
+		return ret;
+
+	if (cnv_step.clk_rate_Hz != step->clk_rate_Hz ||
+	    cnv_step.clk_cycles_per_step != step->clk_cycles_per_step)
+		return -EINVAL;
+
+	if (ad7625_ddr_burst_pulses(st) % step->clk_cycles_per_step)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int ad7625_ddr_apply_freq(struct ad7625_state *st, u32 freq)
+{
+	u32 period, period_cycles, min_period, gate, burst_end, lastclk;
+	const struct ad7625_ddr_timing *t = st->info->ddr_timing;
+	u32 offset, offset_cycles, cnvh, cnvh_cycles;
+	struct pwm_waveform clk_gate_wf, cnv_wf;
+	struct pwm_waveform_step step;
+	u32 cycles_per_step;
+	int ret;
+
+	/* The step changes if the clock of the PWMs was reconfigured since probe. */
+	ret = ad7625_ddr_read_step(st, &step);
+	if (ret)
+		return ret;
+
+	st->step = step;
+
+	if (!freq || freq > st->info->max_sample_freq_hz ||
+	    freq > st->step.clk_rate_Hz)
+		return -EINVAL;
+
+	cycles_per_step = st->step.clk_cycles_per_step;
+
+	/*
+	 * Lengths are in steps of the PWMs, except lastclk, burst_end and the
+	 * ones named *_cycles, which are in clock cycles.
+	 */
+	gate = ad7625_ddr_burst_pulses(st) / cycles_per_step;
+	cnvh_cycles = ad7625_ddr_ns_to_cycles(st, t->cnv_high_min_ns);
+	cnvh = max(ad7625_ddr_cycles_to_steps(st, cnvh_cycles), 1U);
+	offset_cycles = ad7625_ddr_ns_to_cycles(st, t->first_clk_min_ns);
+	offset = ad7625_ddr_cycles_to_steps(st, offset_cycles);
+	lastclk = mul_u64_u64_div_u64(t->last_clk_max_ns, st->step.clk_rate_Hz,
+				      NSEC_PER_SEC);
+
+	/*
+	 * The gated clock burst for one conversion starts t_FIRSTCLK after its
+	 * CNV and may run into the next period, but has to end within
+	 * t_LASTCLK of the next CNV. It must also leave the gate low for at
+	 * least one step per period.
+	 */
+	burst_end = (offset + gate) * cycles_per_step;
+	min_period = burst_end > lastclk ?
+		     DIV_ROUND_UP(burst_end - lastclk, cycles_per_step) : 0;
+	period_cycles = DIV_ROUND_UP(st->step.clk_rate_Hz, freq);
+	period = max3(DIV_ROUND_UP(period_cycles, cycles_per_step), gate + 1,
+		      min_period);
+
+	cnv_wf = (struct pwm_waveform) {
+		.period_length_ns = ad7625_ddr_steps_to_ns(st, period),
+		.duty_length_ns = ad7625_ddr_steps_to_ns(st, cnvh),
+		.duty_offset_ns = 0,
+	};
+	clk_gate_wf = (struct pwm_waveform) {
+		.period_length_ns = cnv_wf.period_length_ns,
+		.duty_length_ns = ad7625_ddr_steps_to_ns(st, gate),
+		.duty_offset_ns = ad7625_ddr_steps_to_ns(st, offset % period),
+	};
+
+	/*
+	 * The waveforms are whole steps, so nothing should have to grow. If it
+	 * did, a minimum time of the part is no longer met.
+	 */
+	ret = pwm_round_waveform_might_sleep(st->cnv_pwm, &cnv_wf);
+	if (ret < 0)
+		return ret;
+	if (ret)
+		return -EINVAL;
+
+	ret = pwm_round_waveform_might_sleep(st->clk_gate_pwm, &clk_gate_wf);
+	if (ret < 0)
+		return ret;
+	if (ret)
+		return -EINVAL;
+
+	st->cnv_wf = cnv_wf;
+	st->clk_gate_wf = clk_gate_wf;
+	/*
+	 * The period was rounded up from the requested frequency, so round the
+	 * frequency up too, or writing the reported value back could add a step.
+	 */
+	st->sampling_freq_hz =
+		DIV64_U64_ROUND_UP(st->step.clk_rate_Hz,
+				   mul_u32_u32(period, cycles_per_step));
+
+	return 0;
+}
+
+static int ad7625_set_sampling_freq_ddr(struct ad7625_state *st, u32 freq)
+{
+	struct pwm_waveform_step old_step = st->step;
+	int ret;
+
+	ret = ad7625_ddr_apply_freq(st, freq);
+	/* Keep the step that the stored waveforms were computed with. */
+	if (ret)
+		st->step = old_step;
+
+	return ret;
+}
+
 static int ad7625_set_sampling_freq(struct ad7625_state *st, u32 freq)
 {
 	struct pwm_waveform clk_gate_wf = { }, cnv_wf = { };
 	unsigned long target;
 	int ret;
 
+	if (st->info->ddr_timing)
+		return ad7625_set_sampling_freq_ddr(st, freq);
+
 	if (!freq)
 		return -EINVAL;
 
@@ -239,6 +508,14 @@ static int ad7625_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
+		if (st->info->has_gain) {
+			/* Divided by the gain of the front end, 1 if the part has none. */
+			*val = st->vref_mv * MILLI;
+			*val2 = st->gain << (chan->scan_type.realbits - 1);
+
+			return IIO_VAL_FRACTIONAL;
+		}
+
 		*val = st->vref_mv;
 		*val2 = chan->scan_type.realbits - 1;
 
@@ -421,6 +698,37 @@ static int ad7960_set_mode(struct ad7625_state *st, enum ad7960_mode mode,
 	}
 }
 
+/* The gains the ADAQ23876 and ADAQ23878 can be strapped to, times MILLI. */
+static const u16 ad7625_gains[] = { 370, 730, 870, 1380, 2250 };
+
+static int ad7625_parse_ddr(struct device *dev, struct ad7625_state *st)
+{
+	int ret;
+
+	st->two_lanes = device_property_read_bool(dev, "adi,use-two-lanes");
+
+	/* A fixed gain part has no adi,gain-milli, the others are pin strapped. */
+	st->gain = st->info->default_gain;
+	if (st->gain)
+		return 0;
+
+	ret = device_property_read_u16(dev, "adi,gain-milli", &st->gain);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to read adi,gain-milli\n");
+
+	/*
+	 * The scale is gain << (realbits - 1), up to 17 bits for the 18-bit
+	 * parts, and has to fit in an int, so only these gains are accepted.
+	 */
+	for (unsigned int i = 0; i < ARRAY_SIZE(ad7625_gains); i++)
+		if (st->gain == ad7625_gains[i])
+			return 0;
+
+	return dev_err_probe(dev, -EINVAL, "unsupported adi,gain-milli %u\n",
+			     st->gain);
+}
+
 static int ad7625_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7625_state *st = iio_priv(indio_dev);
@@ -464,8 +772,10 @@ static const struct iio_buffer_setup_ops ad7625_buffer_setup_ops = {
 static int devm_ad7625_pwm_get(struct device *dev,
 			       struct ad7625_state *st)
 {
+	const char *clk_name;
 	struct clk *ref_clk;
 	u32 ref_clk_rate_hz;
+	int ret;
 
 	st->cnv_pwm = devm_pwm_get(dev, "cnv");
 	if (IS_ERR(st->cnv_pwm))
@@ -475,14 +785,28 @@ static int devm_ad7625_pwm_get(struct device *dev,
 	/* Preemptively disable the PWM in case it was enabled at boot */
 	pwm_disable(st->cnv_pwm);
 
-	st->clk_gate_pwm = devm_pwm_get(dev, "clk_gate");
+	clk_name = st->info->clk_pwm_name ?: "clk_gate";
+	st->clk_gate_pwm = devm_pwm_get(dev, clk_name);
 	if (IS_ERR(st->clk_gate_pwm))
 		return dev_err_probe(dev, PTR_ERR(st->clk_gate_pwm),
-				     "failed to get clk_gate pwm\n");
+				     "failed to get %s pwm\n", clk_name);
 
 	/* Preemptively disable the PWM in case it was enabled at boot */
 	pwm_disable(st->clk_gate_pwm);
 
+	/*
+	 * The PWMs tell the step of their waveforms, so the parts with DDR
+	 * output need no clock of their own to know the length of a CLK pulse.
+	 */
+	if (st->info->ddr_timing) {
+		ret = ad7625_ddr_read_step(st, &st->step);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to get usable steps of the pwms\n");
+
+		return 0;
+	}
+
 	ref_clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(ref_clk))
 		return dev_err_probe(dev, PTR_ERR(ref_clk),
@@ -498,8 +822,40 @@ static int devm_ad7625_pwm_get(struct device *dev,
 	return 0;
 }
 
+static int devm_ad7625_listed_regulator_setup(struct device *dev,
+					      struct ad7625_state *st)
+{
+	int ret;
+
+	ret = devm_regulator_bulk_get_enable(dev, st->info->num_supplies,
+					     st->info->supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable supplies\n");
+
+	/* VS- of the ADAQ modules is left out if it is tied to ground. */
+	ret = devm_regulator_get_enable_optional(dev, "vs-n");
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to enable VS-\n");
+
+	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
+	if (ret == -ENODEV) {
+		/* Without ref-supply the internal reference is used. */
+		st->vref_mv = AD7625_INTERNAL_REF_MV;
+		return 0;
+	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get REF voltage\n");
+
+	st->vref_mv = ret / (MICRO / MILLI);
+
+	return 0;
+}
+
 /*
- * There are three required input voltages for each device, plus two
+ * Parts with a supply list in their chip info (LTC2387, ADAQ2387x) get their
+ * supplies and the optional REF from devm_ad7625_listed_regulator_setup().
+ *
+ * The other parts have three required input voltages each, plus two
  * conditionally-optional (depending on part) REF and REFIN voltages
  * where their validity depends upon the EN pin configuration.
  *
@@ -519,6 +875,9 @@ static int devm_ad7625_regulator_setup(struct device *dev,
 	static const char * const regulator_names[] = { "vio", "vdd2", "vdd1" };
 	int ret, ref_mv;
 
+	if (st->info->supplies)
+		return devm_ad7625_listed_regulator_setup(dev, st);
+
 	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
 					     regulator_names);
 	if (ret)
@@ -566,6 +925,10 @@ static int ad7625_set_initial_mode(struct device *dev, struct ad7625_state *st)
 	enum ad7960_mode mode;
 	int ret;
 
+	/* The new parts have no EN pins. */
+	if (st->info->no_en_pins)
+		return 0;
+
 	/* Set the device mode based on detected EN configuration. */
 	if (!st->info->has_bandwidth_control) {
 		ad7625_set_en_gpios_for_vref(st, st->have_refin, st->vref_mv);
@@ -609,7 +972,9 @@ static int ad7625_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -EINVAL,
 				     "self-clocked mode not supported\n");
 
-	if (st->info->has_bandwidth_control)
+	if (st->info->ddr_timing)
+		ret = ad7625_parse_ddr(dev, st);
+	else if (st->info->has_bandwidth_control)
 		ret = ad7625_parse_mode(dev, st, 4);
 	else
 		ret = ad7625_parse_mode(dev, st, 2);
@@ -644,6 +1009,20 @@ static int ad7625_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (st->info->ddr_timing) {
+		if (st->two_lanes) {
+			ret = iio_backend_num_lanes_set(st->back, 2);
+		} else {
+			ret = iio_backend_num_lanes_set(st->back, 1);
+			/* Without the op, a backend can only be left on one lane. */
+			if (ret == -EOPNOTSUPP)
+				ret = 0;
+		}
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to set the number of lanes\n");
+	}
+
 	ret = devm_iio_backend_enable(dev, st->back);
 	if (ret)
 		return ret;
@@ -657,6 +1036,11 @@ static int ad7625_probe(struct platform_device *pdev)
 	if (st->info->has_bandwidth_control && !st->can_wide_bandwidth)
 		default_sample_freq = AD7960_MAX_NBW_FREQ;
 
+	/* The DDR parts reject rates above the clock of the PWMs. */
+	if (st->info->ddr_timing)
+		default_sample_freq = min(default_sample_freq,
+					  st->step.clk_rate_Hz);
+
 	ret = ad7625_set_sampling_freq(st, default_sample_freq);
 	if (ret)
 		return dev_err_probe(dev, ret,
@@ -670,6 +1054,11 @@ static const struct of_device_id ad7625_of_match[] = {
 	{ .compatible = "adi,ad7626", .data = &ad7626_chip_info },
 	{ .compatible = "adi,ad7960", .data = &ad7960_chip_info },
 	{ .compatible = "adi,ad7961", .data = &ad7961_chip_info },
+	{ .compatible = "adi,adaq23875", .data = &adaq23875_chip_info },
+	{ .compatible = "adi,adaq23876", .data = &adaq23876_chip_info },
+	{ .compatible = "adi,adaq23878", .data = &adaq23878_chip_info },
+	{ .compatible = "adi,ltc2387-16", .data = &ltc2387_16_chip_info },
+	{ .compatible = "adi,ltc2387-18", .data = &ltc2387_18_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad7625_of_match);
@@ -679,6 +1068,11 @@ static const struct platform_device_id ad7625_device_ids[] = {
 	{ .name = "ad7626", .driver_data = (kernel_ulong_t)&ad7626_chip_info },
 	{ .name = "ad7960", .driver_data = (kernel_ulong_t)&ad7960_chip_info },
 	{ .name = "ad7961", .driver_data = (kernel_ulong_t)&ad7961_chip_info },
+	{ .name = "adaq23875", .driver_data = (kernel_ulong_t)&adaq23875_chip_info },
+	{ .name = "adaq23876", .driver_data = (kernel_ulong_t)&adaq23876_chip_info },
+	{ .name = "adaq23878", .driver_data = (kernel_ulong_t)&adaq23878_chip_info },
+	{ .name = "ltc2387-16", .driver_data = (kernel_ulong_t)&ltc2387_16_chip_info },
+	{ .name = "ltc2387-18", .driver_data = (kernel_ulong_t)&ltc2387_18_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(platform, ad7625_device_ids);
@@ -694,6 +1088,6 @@ static struct platform_driver ad7625_driver = {
 module_platform_driver(ad7625_driver);
 
 MODULE_AUTHOR("Trevor Gamblin <tgamblin@baylibre.com>");
-MODULE_DESCRIPTION("Analog Devices AD7625 ADC");
+MODULE_DESCRIPTION("Analog Devices high speed LVDS ADCs similar to the AD7625");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("IIO_BACKEND");
-- 
2.56.0

