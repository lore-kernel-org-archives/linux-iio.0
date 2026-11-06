Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981169;
	b=t8khNNuRlC8K2dDz0DIxMq+fAcCu2cPVcf8NST6ePnHueM1t8TCxVez0+oKSmeCfrD9s
	 t0AO2tfU/3w3EBVggcXTRZNhquNwF39+8iRFnhkR7MjTp+uOAVqK2UYCCz32K91GcnuF4
	 8xyrE+Jiol2nyISe9LFjGMZUqsmzdMmH4rtidn9aacLVm3B318+ESkVB1sLghwczlaEB0
	 nPoh+j5ujPm1RLYTZnhwDt9rg44tXaS7ld6mKY+4W1QFlOkHiUjf6kv7wOBWE4++oxCZ9
	 WycuPb8B2Nsm6wFNaPSy/ZaiM8paXx4TAlEyi5D4c5X6oMPUdHU9iSptjUU0qO9dHYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981169;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Kv+Bztim2NyAISrPzwESVlTMjjdKnoWq6Ufh6LEtGJE=;
	b=lPBecnSQX1luf+AOjWayU/tKqrSgYR2H1Q0m1M9p21LIkKyX8fWv0N+FHBfXfn2s3Nnh
	 wIX5IO4mYiGQTTlo8BN016jx+UxdMvt6cVfOpFzvYhvLHH7X9dK3+pNOZBcV7ozYfQZre
	 ryYo+ILxADJnMtjq1444oVROXI50LQwB0Usm2PaMzacDk8+kGOC90DcUj/kWn6S1xFAdf
	 yvsR6QdD4cgpnqL9W0RNKNmRX4Yk1gqpdHIej9Qqsi7DUuNzggkQtIwtaYg4m25pcxRw2
	 K2/bW9geIvkNMH263yYTjx6h3Qg7tZ5n7TKH6TKgga1VKSaHVzr8Bj5bibTpMJp1Kag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=T2M0WaLv;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=jddCloer;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1225F606D811;
	Fri,  6 Nov 2026 16:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1225F606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=T2M0WaLv;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=jddCloer
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F49tf833049;
	Fri, 6 Nov 2026 11:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=Kv+Bztim2NyAISrPzwESVlTMjjdKnoWq6Ufh6LEtGJE=; b=T2M0WaL
	v85uZJUlMuhvvZxOeWMl+n5mMc9xNu/liqvdlGlx03E+HW8UhT3o60eSjy2Ld0Pk
	mHqGR4pmb2XTVeD3dTVgZln3amcSq48yUscOzul/XrnVwYeYY/a5PGGEe7ylumcK
	dHIffbGWuQ16ZEwAUyZMTFCE2JGsjp1Uew2AaGJAXM2b03tbrNw0y10mr3A7nqMu
	4cQJfzjTOSdoSo6HQHoeFFaZvmjsLzH/rfy0N0EIZWalWjVz4bIXay69YjO1V1Vz
	fup0j/UMVKPrNcMG/fLDOR99bFLLTuig8cuYqW5PYbKOsWH17XGjk7za4XxeE55b
	hzcX9t7RW22cjvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Kv+Bz
	tim2NyAISrPzwESVlTMjjdKnoWq6Ufh6LEtGJE=; b=jddCloer067+ZJiaD54JZ
	yHKcN+RtSH8udFbZKJ8xZzNHxYeRq/mcOGQnMjJs3UgwlA5dlGPv/FDl82DwkF1q
	MGmqL9gctgYakQBqTMHIWGVSByfOmhWUaGfpVZGyEl99kJr5WsWXsat95h/q+v4t
	Ke3EY1fsVJN4ZtS4dSEJL0Mx8smBlttJX7N8y6pQmZRYchQh7jMt0ifBiNcBTAgI
	2BlaOxBovwKZNcrHO9tppcySs1fgwMgDnK50VJCRbYG2n5D8arlN4T91IyE5/Y67
	ETku8KPsAaUanH/Il4TQYASWXQlU7iGVHjs9oTTZjFphoMDh4z52futwys3S/Gi1
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3q052cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 11:06:03 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 6A6G62uD036395
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Nov 2026 11:06:02 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 6 Nov
 2026 11:06:02 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Nov 2026 11:06:02 -0500
Received: from arch ([10.135.2.92])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A6G5TDO016340;
	Fri, 6 Nov 2026 11:05:54 -0500
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
        Trevor
 Gamblin <tgamblin@baylibre.com>,
        Joshua Crofts <crofts@kernel.org>,
        Sergiu
 Cuciurean <sergiu.cuciurean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Nicolae-Daniel
 Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Subject: [PATCH v3 7/7] iio: adc: ad7625: add LTC2387 and ADAQ2387x support
Date: Fri, 6 Nov 2026 18:05:19 +0200
Message-ID: <20261106160529.876251-8-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com>
References: <20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com>
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
X-Proofpoint-ORIG-GUID: 5rSdtmkncrSDwFnP_m9z3UKpQsifq6O6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfX6jPpjHDaC0U+
 qdUukYPzdHYCzwuPC8gOtfiDUizBjc1+9u5rFS+jpaWCmWt1CnWKCAdmE1SyI8nFyfU8XenZZUs
 TrpTqKRoXX/FsS/Z9vM7SAGzHJzeie+B0QhXBla/M1hNWSrRdB6r
X-Authority-Analysis: v=2.4 cv=Lt8HWXdc c=1 sm=1 tr=0 ts=6aedfaeb cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=wI1k2SEZAAAA:8 a=IpJZQVW2AAAA:8 a=T56gM9Jo7u0a-kw7O4IA:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6HWbV-4b7c7AdzY24d_u:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: 5rSdtmkncrSDwFnP_m9z3UKpQsifq6O6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NCBTYWx0ZWRfX+Nkfptj0P1UZ
 3pIjit85CGcocZBhEbIcHaPHedtOuejHffKUb5kx5qFLcHhj42d+fzbbUKPkf74NZHbpn2UmiZI
 Ax6MYzOeHLeLAD8klKGQWaUfBNNWH8IXh47ACYIs7kxMPl+BrYFG0pDWLIh6DqSJBXYbfkHIWi+
 gSxiXZK4I/EarfvtVvDmbsW8MpL8WTHO0eVi4qslwOXvYDQU35KGpyw8maDqWX18kv8JvJ9zUPc
 qmxwl+Ny79c+WowLg6gm/0dxPLI9ut8R1ed5em2yWunX07mgdrqOpuW9OzYI0D4nYCEoqPREOl3
 QT5fpO50MpJziiHCca7IrPqs2eWMcGwcoeMgabnnlX1sSC200/UZgsyNGSsoUAr4uItir+jF6hb
 ifvia9mrgqt3bxA1nWiqRRc0oy05Dhn+c/vp1YdC5yF2rjkBChiC5aK2Whmbx96+9HeAgRGv34M
 SeVJXWtJ1lnd4yGpM4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060064

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

Add the LTC2387-16, LTC2387-18, ADAQ23875, ADAQ23876 and ADAQ23878 as chip
data of this driver. The same two PWMs and IIO backend read them. Chip data
and a few quirks cover the differences, see the binding patch for the list:

- Data is output at double data rate on one or two lanes, so the CLK burst
  is the number of bits divided by 2 or 4 pulses long.
- The burst of one conversion starts at least t_FIRSTCLK after its CNV and
  ends at most t_LASTCLK after the next CNV, so at the maximum rate it runs
  into the next conversion period.
- No EN pins.
- The ADAQ parts divide the scale by the gain of their front end.

Changes:

- Add chip info for the five parts, maximum sampling frequency 15 MSPS,
  plus OF and platform device ID entries.
- Add struct ad7625_ddr_timing with t_CNVH, t_FIRSTCLK and t_LASTCLK. The
  chip info of the new parts points to it, and a non-NULL pointer marks a
  part with DDR output.
- Add ad7625_set_sampling_freq_ddr(). Unlike the AD762x and AD796x, the
  sampling period rises until the CLK burst fits t_LASTCLK, so the period
  clamp doesn't limit the maximum rate to 10 MSPS.
- Build waveforms in whole PWM steps, read with
  pwm_get_waveform_step_might_sleep() at probe and on each sampling
  frequency change.
- Get the second PWM as "clk" for the new parts and "clk_gate" for the
  existing ones. No reference clock for the new parts, as the step gives
  the PWM clock rate.
- Add ad7625_parse_ddr() reading adi,use-two-lanes and adi,gain-milli. Gain
  defaults to the fixed ADAQ23875 gain and to 1 for the LTC2387. It is
  required for the ADAQ23876 and ADAQ23878, whose gain is pin strapped, and
  must be a supported value.
- Divide the scale by the front end gain for the new parts.
- Enable the supplies of the new parts, with VS- of the ADAQ modules
  optional as it can be tied to ground. Read the optional ref-supply and
  use the internal reference when it is absent.
- Set the backend number of lanes for the new parts. Skipping is allowed
  only if the backend can't set it and one lane is used.
- Limit the default sampling frequency of the new parts to the PWM clock
  rate.
- Skip the EN pin mode setup for the new parts, as they have no EN pins.
- Include math64.h, minmax.h, property.h and types.h for the new code.
- Add the new parts, sorted by part number, to the Kconfig help and
  Documentation/iio/ad7625.rst.
- Make the Kconfig prompt, the top comment of the driver and
  MODULE_DESCRIPTION() generic, as the driver supports more than the
  AD7625.
- Add new maintainer entries.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Co-developed-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
---
 Documentation/iio/ad7625.rst |  34 +++-
 MAINTAINERS                  |   2 +
 drivers/iio/adc/Kconfig      |   7 +-
 drivers/iio/adc/ad7625.c     | 358 ++++++++++++++++++++++++++++++++++-
 4 files changed, 392 insertions(+), 9 deletions(-)

diff --git a/Documentation/iio/ad7625.rst b/Documentation/iio/ad7625.rst
index 61761e3b75c3..d37420b76d4b 100644
--- a/Documentation/iio/ad7625.rst
+++ b/Documentation/iio/ad7625.rst
@@ -4,8 +4,9 @@
 AD7625 driver
 ====================
 
-ADC driver for Analog Devices Inc. AD7625, AD7626, AD7960, and AD7961
-devices. The module name is ``ad7625``.
+ADC driver for Analog Devices Inc. AD7625, AD7626, AD7960, AD7961, LTC2387-16,
+LTC2387-18, ADAQ23875, ADAQ23876 and ADAQ23878 devices. The module name is
+``ad7625``.
 
 Supported devices
 =================
@@ -16,8 +17,14 @@ The following chips are supported by this driver:
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
 
@@ -65,6 +72,27 @@ The source is determined by the device tree. If ``ref-supply`` is present, then
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
+gain of their front end, given by ``adi,gain-milli``.
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
index 02de4809ae31..eb217d7dbba1 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -404,7 +404,7 @@ config AD7606_IFACE_SPI
 	  module will be called ad7606_spi.
 
 config AD7625
-	tristate "Analog Devices AD7625/AD7626 High Speed ADC driver"
+	tristate "Analog Devices high speed LVDS ADC driver"
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
index 133c83df8a52..0e7a059df8a6 100644
--- a/drivers/iio/adc/ad7625.c
+++ b/drivers/iio/adc/ad7625.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: (GPL-2.0-only)
 /*
- * Analog Devices Inc. AD7625 ADC driver
+ * Analog Devices Inc. high speed LVDS ADC driver
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
@@ -41,6 +54,16 @@ struct ad7625_chip_info {
 	const bool has_power_down_state;
 	const bool has_bandwidth_control;
 	const bool has_internal_vref;
+	/*
+	 * The LTC2387 and ADAQ2387x output data on one or two lanes at double
+	 * data rate, have no EN pins and learn their timing from the PWMs.
+	 * They are the parts with @ddr_timing set.
+	 */
+	const struct ad7625_ddr_timing *ddr_timing;
+	const char * const *supplies;
+	int num_supplies;
+	/* Gain of the ADAQ front end * MILLI, 0 if the board has to provide it. */
+	u16 default_gain;
 };
 
 /* AD7625_CHAN_SPEC - Define a chan spec structure for a specific chip */
@@ -78,6 +101,11 @@ struct ad7625_state {
 	struct pwm_waveform cnv_wf;
 	unsigned int vref_mV;
 	u32 sampling_freq_hz;
+	/* Step of the PWMs and lane count, for the parts with DDR output */
+	struct pwm_waveform_step step;
+	/* Gain of the front end * MILLI */
+	u16 gain;
+	bool two_lanes;
 	/*
 	 * Optional GPIOs for controlling device state. EN0 and EN1
 	 * determine voltage reference configuration and on/off state.
@@ -164,6 +192,68 @@ static const struct ad7625_chip_info ad7961_chip_info = {
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
+	.has_internal_vref = true,
+	.ddr_timing = &ltc2387_ddr_timing,
+	.supplies = ltc2387_supplies,
+	.num_supplies = ARRAY_SIZE(ltc2387_supplies),
+	.default_gain = 1 * MILLI,
+};
+
+static const struct ad7625_chip_info ltc2387_18_chip_info = {
+	.name = "ltc2387-18",
+	.max_sample_freq_hz = 15 * HZ_PER_MHZ,
+	.chan_spec = AD7625_CHAN_SPEC(18),
+	.has_internal_vref = true,
+	.ddr_timing = &ltc2387_ddr_timing,
+	.supplies = ltc2387_supplies,
+	.num_supplies = ARRAY_SIZE(ltc2387_supplies),
+	.default_gain = 1 * MILLI,
+};
+
+static const struct ad7625_chip_info adaq23875_chip_info = {
+	.name = "adaq23875",
+	.max_sample_freq_hz = 15 * HZ_PER_MHZ,
+	.chan_spec = AD7625_CHAN_SPEC(16),
+	.has_internal_vref = true,
+	.ddr_timing = &ltc2387_ddr_timing,
+	.supplies = adaq2387x_supplies,
+	.num_supplies = ARRAY_SIZE(adaq2387x_supplies),
+	.default_gain = 2 * MILLI,
+};
+
+static const struct ad7625_chip_info adaq23876_chip_info = {
+	.name = "adaq23876",
+	.max_sample_freq_hz = 15 * HZ_PER_MHZ,
+	.chan_spec = AD7625_CHAN_SPEC(16),
+	.has_internal_vref = true,
+	.ddr_timing = &ltc2387_ddr_timing,
+	.supplies = adaq2387x_supplies,
+	.num_supplies = ARRAY_SIZE(adaq2387x_supplies),
+};
+
+static const struct ad7625_chip_info adaq23878_chip_info = {
+	.name = "adaq23878",
+	.max_sample_freq_hz = 15 * HZ_PER_MHZ,
+	.chan_spec = AD7625_CHAN_SPEC(18),
+	.has_internal_vref = true,
+	.ddr_timing = &ltc2387_ddr_timing,
+	.supplies = adaq2387x_supplies,
+	.num_supplies = ARRAY_SIZE(adaq2387x_supplies),
+};
+
 enum ad7960_mode {
 	AD7960_MODE_POWER_DOWN,
 	AD7960_MODE_SNOOZE,
@@ -172,12 +262,152 @@ enum ad7960_mode {
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
+static int ad7625_set_sampling_freq_ddr(struct ad7625_state *st, u32 freq)
+{
+	u32 period, min_period, gate, offset, lastclk, cnvh, burst_end;
+	const struct ad7625_ddr_timing *t = st->info->ddr_timing;
+	struct pwm_waveform clk_gate_wf = { }, cnv_wf = { };
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
+	/* Everything but lastclk and burst_end is in steps of the PWMs. */
+	gate = ad7625_ddr_burst_pulses(st) / cycles_per_step;
+	cnvh = ad7625_ddr_ns_to_cycles(st, t->cnv_high_min_ns);
+	cnvh = max(ad7625_ddr_cycles_to_steps(st, cnvh), 1U);
+	offset = ad7625_ddr_ns_to_cycles(st, t->first_clk_min_ns);
+	offset = ad7625_ddr_cycles_to_steps(st, offset);
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
+	period = DIV_ROUND_UP(st->step.clk_rate_Hz, freq);
+	period = max3(DIV_ROUND_UP(period, cycles_per_step), gate + 1, min_period);
+
+	cnv_wf.period_length_ns = ad7625_ddr_steps_to_ns(st, period);
+	cnv_wf.duty_length_ns = ad7625_ddr_steps_to_ns(st, cnvh);
+
+	clk_gate_wf.period_length_ns = cnv_wf.period_length_ns;
+	clk_gate_wf.duty_length_ns = ad7625_ddr_steps_to_ns(st, gate);
+	clk_gate_wf.duty_offset_ns = ad7625_ddr_steps_to_ns(st, offset % period);
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
+	st->sampling_freq_hz =
+		DIV64_U64_ROUND_CLOSEST(st->step.clk_rate_Hz,
+					mul_u32_u32(period, cycles_per_step));
+
+	return 0;
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
 
@@ -239,6 +469,14 @@ static int ad7625_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
+		if (st->info->ddr_timing) {
+			/* Referred to the input of the ADAQ front end, so divided by its gain. */
+			*val = st->vref_mV * MILLI;
+			*val2 = st->gain << (chan->scan_type.realbits - 1);
+
+			return IIO_VAL_FRACTIONAL;
+		}
+
 		*val = st->vref_mV;
 		*val2 = chan->scan_type.realbits - 1;
 
@@ -421,6 +659,33 @@ static int ad7960_set_mode(struct ad7625_state *st, enum ad7960_mode mode,
 	}
 }
 
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
+	/* The scale shifts the gain by up to 17 bits, so it has to stay small. */
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
@@ -464,8 +729,10 @@ static const struct iio_buffer_setup_ops ad7625_buffer_setup_ops = {
 static int devm_ad7625_pwm_get(struct device *dev,
 			       struct ad7625_state *st)
 {
+	const char *clk_name;
 	struct clk *ref_clk;
 	u32 ref_clk_rate_hz;
+	int ret;
 
 	st->cnv_pwm = devm_pwm_get(dev, "cnv");
 	if (IS_ERR(st->cnv_pwm))
@@ -475,14 +742,28 @@ static int devm_ad7625_pwm_get(struct device *dev,
 	/* Preemptively disable the PWM in case it was enabled at boot */
 	pwm_disable(st->cnv_pwm);
 
-	st->clk_gate_pwm = devm_pwm_get(dev, "clk_gate");
+	clk_name = st->info->ddr_timing ? "clk" : "clk_gate";
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
@@ -498,6 +779,37 @@ static int devm_ad7625_pwm_get(struct device *dev,
 	return 0;
 }
 
+static int devm_ad7625_ddr_regulator_setup(struct device *dev,
+					   struct ad7625_state *st)
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
+		st->vref_mV = AD7625_INTERNAL_REF_MV;
+		return 0;
+	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to get REF voltage\n");
+	if (ret == 0)
+		return dev_err_probe(dev, -EINVAL, "REF voltage must not be 0\n");
+
+	st->vref_mV = ret / (MICRO / MILLI);
+
+	return 0;
+}
+
 /*
  * There are three required input voltages for each device, plus two
  * conditionally-optional (depending on part) REF and REFIN voltages
@@ -519,6 +831,9 @@ static int devm_ad7625_regulator_setup(struct device *dev,
 	static const char * const regulator_names[] = { "vio", "vdd2", "vdd1" };
 	int ret, ref_mV;
 
+	if (st->info->ddr_timing)
+		return devm_ad7625_ddr_regulator_setup(dev, st);
+
 	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
 					     regulator_names);
 	if (ret)
@@ -565,6 +880,10 @@ static int ad7625_set_initial_mode(struct device *dev, struct ad7625_state *st)
 {
 	int ret;
 
+	/* The parts with DDR output have no EN pins. */
+	if (st->info->ddr_timing)
+		return 0;
+
 	/* Set the device mode based on detected EN configuration. */
 	if (!st->info->has_bandwidth_control) {
 		ad7625_set_en_gpios_for_vref(st, st->have_refin, st->vref_mV);
@@ -614,7 +933,9 @@ static int ad7625_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -EINVAL,
 				     "self-clocked mode not supported\n");
 
-	if (st->info->has_bandwidth_control)
+	if (st->info->ddr_timing)
+		ret = ad7625_parse_ddr(dev, st);
+	else if (st->info->has_bandwidth_control)
 		ret = ad7625_parse_mode(dev, st, 4);
 	else
 		ret = ad7625_parse_mode(dev, st, 2);
@@ -649,6 +970,19 @@ static int ad7625_probe(struct platform_device *pdev)
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
+			return dev_err_probe(dev, ret, "failed to set the number of lanes\n");
+	}
+
 	ret = devm_iio_backend_enable(dev, st->back);
 	if (ret)
 		return ret;
@@ -662,6 +996,10 @@ static int ad7625_probe(struct platform_device *pdev)
 	if (st->info->has_bandwidth_control && !st->can_wide_bandwidth)
 		default_sample_freq = AD7960_MAX_NBW_FREQ;
 
+	/* The DDR parts reject rates above the clock of the PWMs. */
+	if (st->info->ddr_timing)
+		default_sample_freq = min(default_sample_freq, st->step.clk_rate_Hz);
+
 	ret = ad7625_set_sampling_freq(st, default_sample_freq);
 	if (ret)
 		return dev_err_probe(dev, ret,
@@ -675,6 +1013,11 @@ static const struct of_device_id ad7625_of_match[] = {
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
@@ -684,6 +1027,11 @@ static const struct platform_device_id ad7625_device_ids[] = {
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
@@ -699,6 +1047,6 @@ static struct platform_driver ad7625_driver = {
 module_platform_driver(ad7625_driver);
 
 MODULE_AUTHOR("Trevor Gamblin <tgamblin@baylibre.com>");
-MODULE_DESCRIPTION("Analog Devices AD7625 ADC");
+MODULE_DESCRIPTION("Analog Devices high speed LVDS ADC");
 MODULE_LICENSE("GPL");
 MODULE_IMPORT_NS("IIO_BACKEND");
-- 
2.56.0

