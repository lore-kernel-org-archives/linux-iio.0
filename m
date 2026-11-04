Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793798558;
	b=q9mg1nUqpaH8uuGQ01oAfuhqoSm1nTcKss5DL5k/29WgI4/qN90rkUgY65L0AgHQYyts
	 sRYH0D05UcegltQj4t5iI5uYrVOemGRA8a7hw2fIzMSXjSIi4AvE7+lUoCGnlGFaStYRs
	 E/ocV7IVomKVngvZhUtOWsPoT530jyP3/+mXOTbCdT4y8JWR+ARh5cBarlxiU9suRIVsk
	 Q1Vsf2bJyrasFWDsbYT7rWhp49iholtNsFgbrzVi0B379ylRchrmoNxQTGy4Csm8hrV2T
	 PvKyzj4MgJ3kS6Zd8yw+W4ostWq5jcLhlsyuNkNGyUdhOf3qWw3Qs0rFynEjIY7gqJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798558;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=10qdUF9CvCO9SMXHWR1KkPNsdcZuS2DFuu4nkafin/U=;
	b=L9Rdyb6X6PzNOAtPkYpnwbH6lfJYTnZC1DsecIiB+4xjGgOjHoJ9eLf69qmcFOkpgXxQ
	 1O8R/GzUBNVEnlNB9mf+gj2ektgUX99R53hWNoyClbzTjWbV3bHPp3cQ+E0t1u3a592Oe
	 2MbypqFZL1hCpx+v2ncxxX6nMwW8dYoKIXXvxvgaFIoWqn552hCiDBwA7AkYzWraro3T8
	 3J7Y+PEgRdvn6pBURMmlmph+sjewqMN9rHqW9FUwKVN/iIqIaBZ10v9UmG0TgjrefBzvw
	 AQOFjpQtYBUNhWU1OqwnXtikob9NHQ8fkRVThZYoS9Xoyk3PuRLlgE4R0XjQZCsGsdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="Ns/arH3z";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=eaLSTbTT;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8845606A31B;
	Wed,  4 Nov 2026 13:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8845606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Ns/arH3z;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=eaLSTbTT
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A4Bd06o2876146;
	Wed, 4 Nov 2026 08:22:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=10qdUF9CvCO9SMXHWR1KkPNsdcZuS2DFuu4nkafin/U=; b=Ns/arH3
	zIQam8gP67wyGzxS5dxE89ZlwDWxtS/GTdZSkVjxqaZtNuhk7llJOqx5U2lxQOwg
	6XZ0aTOlQkSUiMDzP485gRhEfN9sZPhj40zmc0KI3FTO93w3fQPlZ7Y+fIMnx8RB
	beP37uc/+Q3TjthYlgZUcwPBiddpDU/UgFb/keZmxZ+WF9bPVM8q41qO25lDcOnr
	lVRZWNe4LT3samtSkURFb323jo3j/P66vnwgGf0qTln08QjhS1IF8+77GY14LiE+
	Au8C3Kjp3t0dyPlPoq9Y+mIxTDPbxlZd0PFCQjiMZUeoOnYed7cOutxq/hrW33Zy
	9nloBV1yAIDMcvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=10qdU
	F9CvCO9SMXHWR1KkPNsdcZuS2DFuu4nkafin/U=; b=eaLSTbTTmMr86GKtL0XWt
	bK1BqF4z5JxCWM98pU25btc02ozY4cp+LP1aq5QLrLP0JcbHycrlkKn9edm6wqfY
	wG80O4CJzP8TzxBErNwAYSB1hx/tEyEyCcIHRMXptxnJYC1uQXTsPwptPfahvKig
	DJYlRcGxQWRwrQqbjcpiqJ8BbgOUrkIPzPqjN3njr+MzlN5hZRNiduwWLeyLIWVp
	OthD2WYBx+fR9VuEyu5+1xN4Z4xtWiQwppLmbJixTGk0uKO3SYuVBYgyWKdAz/zE
	tKsA7Rw9uymxRCYqoRFIkwKVgND+xZc4R2ot6wuAfcp9LsVLdExmeI+GUiqKfeFz
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hqrk4v91k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 08:22:32 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A4DMVi0028035
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 4 Nov 2026 08:22:31 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 4 Nov
 2026 08:22:31 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 4 Nov 2026 08:22:31 -0500
Received: from HYB-aFjnqsVU6Ag.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A4DLnaq008011;
	Wed, 4 Nov 2026 08:22:22 -0500
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
Subject: [PATCH v2 5/5] iio: adc: ad7625: add LTC2387 and ADAQ2387x support
Date: Wed, 4 Nov 2026 15:21:43 +0200
Message-ID: <20261104132143.215581-6-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104132143.215581-1-Nicolae-daniel.Deaconescu@analog.com>
References: <20261104132143.215581-1-Nicolae-daniel.Deaconescu@analog.com>
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
X-Proofpoint-ORIG-GUID: XWRSltG76EYeb3HWmfVWlfZXyGYam8RN
X-Proofpoint-GUID: XWRSltG76EYeb3HWmfVWlfZXyGYam8RN
X-Authority-Analysis: v=2.4 cv=Y7RtIReN c=1 sm=1 tr=0 ts=6aeb3198 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=wI1k2SEZAAAA:8 a=IpJZQVW2AAAA:8 a=1iLRWRIp5nJdlh0i5JEA:9
 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6HWbV-4b7c7AdzY24d_u:22 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA1MyBTYWx0ZWRfX4TlJGWWkcu1D
 8YMLBIhlr9eyhql8TFLmIeBO6L0V9fIjRIEZeHC3tvuqYOzLwgF6YqH+GzksmPKIINObVOX8K5r
 ka+IUH8RruJ6rbF6Opa6xkylTHjSeKeombXwELpALRrLun0ZMM9u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA1MyBTYWx0ZWRfXzkjD9WQSA0AP
 0MGtxJ3dbXk5fyMCs5TQo/srCLrvA8NAluvttOymsUzkPn9hYJEUIzxqJTU7UTPjqlns4QJFsuC
 VH+lkFdSQFzp7l8vpYQDU1+hR/hunZZEF+IfCGuyCdCzTGp2E7QZqO6U7qgRJ+3B4StcB+uiNdT
 FBATACZlRItFPBztHS1U33YNEv++/oLhF1dXhCLPr4Efll9Cid7eyGKUlIEkveWRBDmV67RQy/5
 XfLzx9pYxCPVLMfo6Ry2VGxZYFvzoTDQ+ThxGP4JTJHkBQ7OSUBNaEO2eI3ZY/cEWxz5GxhX9cF
 3sP0bZYfIz7uBdAlEMjk4AeYZyQuxrszBt80h4MUmryHSUIwFm7k9a7+RS0QC8SgJ5nxQ/KJpcz
 1vdkezX06KAcj+DGWEhvkow3pI5fnQxC9dh1+zH/Ilqkds9Z09MjxIpwIKlEY1wjI7mYWfH/JE8
 HJKGi4/2mRYBi1nO3bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611040053

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

Add the LTC2387-16, LTC2387-18, ADAQ23875, ADAQ23876 and ADAQ23878 as
chip data of this driver. They are read through the same two PWMs and
IIO backend. They differ in a few ways that the chip data and a few
quirks cover, see the binding patch for the list:

- Data is output at double data rate on one or two lanes, so the CLK
  burst is the number of bits divided by 2 or by 4 pulses long.
- The burst of one conversion starts at least t_FIRSTCLK after its CNV
  and has to end at most t_LASTCLK after the next CNV, so at the maximum
  rate it runs into the next conversion period.
- They have no EN pins.
- The ADAQ parts divide the scale by the gain of their front end.

The changes are:

- Add chip info for the five parts, with a maximum sampling frequency of
  15 MSPS, and the OF and platform device ID entries for them.
- Add struct ad7625_ddr_timing with t_CNVH, t_FIRSTCLK and t_LASTCLK, and
  point the chip info of the new parts to it. A non-NULL pointer marks a
  part with DDR output.
- Add ad7625_set_sampling_freq_ddr(). Unlike for the AD762x and AD796x,
  the sampling period is raised until the CLK burst fits t_LASTCLK, so the
  maximum rate isn't limited to 10 MSPS by the period clamp.
- Build the waveforms in whole steps of the PWMs, which are read with
  pwm_get_waveform_step_might_sleep() when probing and each time the
  sampling frequency changes.
- Get the second PWM as "clk" for the new parts and "clk_gate" for the
  existing ones, and don't get a reference clock for the new parts, as the
  step already tells the clock rate of the PWM.
- Add ad7625_parse_ddr() to read adi,use-two-lanes and adi,gain-milli. The
  gain defaults to the fixed gain of the ADAQ23875 and to 1 for the
  LTC2387, and is required for the ADAQ23876 and ADAQ23878, whose gain is
  pin strapped and has to be one of the supported values.
- Divide the scale by the gain of the front end for the new parts.
- Enable the supplies of the new parts, and read their optional
  ref-supply, using the internal reference when it is absent.
- Set the number of lanes of the backend for the new parts. This can only
  be skipped if the backend can't set it and one lane is used.
- Limit the default sampling frequency of the new parts to the clock rate
  of the PWMs.
- Move the setup of the EN pin mode into ad7625_set_initial_mode(), which
  does nothing for the parts without EN pins. The code that sets the pins
  of the existing parts is unchanged.
- Include math64.h and minmax.h for the helpers that the new code uses.
- Add the new parts to the Kconfig help and Documentation/iio/ad7625.rst,
  and new maintainer entries.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Co-developed-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
---
 Documentation/iio/ad7625.rst |  34 ++-
 MAINTAINERS                  |   2 +
 drivers/iio/adc/Kconfig      |   7 +-
 drivers/iio/adc/ad7625.c     | 391 ++++++++++++++++++++++++++++++++---
 4 files changed, 404 insertions(+), 30 deletions(-)

diff --git a/Documentation/iio/ad7625.rst b/Documentation/iio/ad7625.rst
index 61761e3b75c3..5f7c481b13a5 100644
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
+* `LTC2387-16 <https://www.analog.com/LTC2387-16>`_
+* `LTC2387-18 <https://www.analog.com/LTC2387-18>`_
+* `ADAQ23875 <https://www.analog.com/ADAQ23875>`_
+* `ADAQ23876 <https://www.analog.com/ADAQ23876>`_
+* `ADAQ23878 <https://www.analog.com/ADAQ23878>`_
 
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
index 52024397dc78..39c50a0b72ee 100644
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
index 02de4809ae31..7fd54ad8889c 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -404,7 +404,7 @@ config AD7606_IFACE_SPI
 	  module will be called ad7606_spi.
 
 config AD7625
-	tristate "Analog Devices AD7625/AD7626 High Speed ADC driver"
+	tristate "Analog Devices AD762x, AD796x, LTC2387 and ADAQ2387x ADC driver"
 	depends on PWM
 	select IIO_BACKEND
 	help
@@ -413,6 +413,11 @@ config AD7625
 	  * AD7626 16-Bit, 10 MSPS PulSAR Analog-to-Digital Converter
 	  * AD7960 18-Bit, 5 MSPS PulSAR Analog-to-Digital Converter
 	  * AD7961 16-Bit, 5 MSPS PulSAR Analog-to-Digital Converter
+	  * LTC2387-16 16-Bit, 15 MSPS SAR Analog-to-Digital Converter
+	  * LTC2387-18 18-Bit, 15 MSPS SAR Analog-to-Digital Converter
+	  * ADAQ23875 and ADAQ23876 16-Bit, 15 MSPS uModule Data Acquisition
+	    Systems
+	  * ADAQ23878 18-Bit, 15 MSPS uModule Data Acquisition System
 
 	  The driver requires the assistance of the AXI ADC IP core to operate.
 
diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
index 0de7f29797ef..3489ff3349ae 100644
--- a/drivers/iio/adc/ad7625.c
+++ b/drivers/iio/adc/ad7625.c
@@ -17,6 +17,8 @@
 #include <linux/iio/backend.h>
 #include <linux/iio/iio.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pwm.h>
@@ -33,6 +35,15 @@ struct ad7625_timing_spec {
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
@@ -41,6 +52,16 @@ struct ad7625_chip_info {
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
+	/* Gain * 1000 of the ADAQ front end, 0 if the board has to provide it. */
+	const u16 default_gain_milli;
 };
 
 /* AD7625_CHAN_SPEC - Define a chan spec structure for a specific chip */
@@ -78,6 +99,10 @@ struct ad7625_state {
 	struct pwm_waveform cnv_wf;
 	unsigned int vref_mv;
 	u32 sampling_freq_hz;
+	/* Step of the PWMs and lane count, for the parts with DDR output */
+	struct pwm_waveform_step step;
+	u16 gain_milli;
+	bool two_lanes;
 	/*
 	 * Optional GPIOs for controlling device state. EN0 and EN1
 	 * determine voltage reference configuration and on/off state.
@@ -164,6 +189,70 @@ static const struct ad7625_chip_info ad7961_chip_info = {
 	.has_internal_vref = false,
 };
 
+static const struct ad7625_ddr_timing ltc2387_ddr_timing = {
+	.cnv_high_min_ns = 5,
+	.first_clk_min_ns = 65,
+	.last_clk_max_ns = 49,
+};
+
+static const char * const ltc2387_supplies[] = { "vdd", "vddl", "ovdd" };
+static const char * const adaq2387x_supplies[] = {
+	"vdd", "vio", "vs-p", "vs-n"
+};
+
+static const struct ad7625_chip_info ltc2387_16_chip_info = {
+	.name = "ltc2387-16",
+	.max_sample_freq_hz = 15 * MEGA,
+	.chan_spec = AD7625_CHAN_SPEC(16),
+	.has_internal_vref = true,
+	.ddr_timing = &ltc2387_ddr_timing,
+	.supplies = ltc2387_supplies,
+	.num_supplies = ARRAY_SIZE(ltc2387_supplies),
+	.default_gain_milli = 1000,
+};
+
+static const struct ad7625_chip_info ltc2387_18_chip_info = {
+	.name = "ltc2387-18",
+	.max_sample_freq_hz = 15 * MEGA,
+	.chan_spec = AD7625_CHAN_SPEC(18),
+	.has_internal_vref = true,
+	.ddr_timing = &ltc2387_ddr_timing,
+	.supplies = ltc2387_supplies,
+	.num_supplies = ARRAY_SIZE(ltc2387_supplies),
+	.default_gain_milli = 1000,
+};
+
+static const struct ad7625_chip_info adaq23875_chip_info = {
+	.name = "adaq23875",
+	.max_sample_freq_hz = 15 * MEGA,
+	.chan_spec = AD7625_CHAN_SPEC(16),
+	.has_internal_vref = true,
+	.ddr_timing = &ltc2387_ddr_timing,
+	.supplies = adaq2387x_supplies,
+	.num_supplies = ARRAY_SIZE(adaq2387x_supplies),
+	.default_gain_milli = 2000,
+};
+
+static const struct ad7625_chip_info adaq23876_chip_info = {
+	.name = "adaq23876",
+	.max_sample_freq_hz = 15 * MEGA,
+	.chan_spec = AD7625_CHAN_SPEC(16),
+	.has_internal_vref = true,
+	.ddr_timing = &ltc2387_ddr_timing,
+	.supplies = adaq2387x_supplies,
+	.num_supplies = ARRAY_SIZE(adaq2387x_supplies),
+};
+
+static const struct ad7625_chip_info adaq23878_chip_info = {
+	.name = "adaq23878",
+	.max_sample_freq_hz = 15 * MEGA,
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
@@ -172,12 +261,146 @@ enum ad7960_mode {
 	AD7960_MODE_TEST_PATTERN,
 };
 
+/* Cycles of the gated clock needed to cover @ns, rounded up. */
+static u32 ad7625_ddr_ns_to_cycles(struct ad7625_state *st, u32 ns)
+{
+	return DIV_ROUND_UP_ULL((u64)ns * st->step.clk_rate_hz, NSEC_PER_SEC);
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
+	u64 cycles = (u64)steps * st->step.clk_cycles_per_step;
+
+	return DIV64_U64_ROUND_UP(cycles * NSEC_PER_SEC, st->step.clk_rate_hz);
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
+	if (cnv_step.clk_rate_hz != step->clk_rate_hz ||
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
+	const struct ad7625_ddr_timing *t = st->info->ddr_timing;
+	struct pwm_waveform clk_gate_wf = { }, cnv_wf = { };
+	u32 period, min_period, gate, offset, lastclk, cnvh, burst_end;
+	struct pwm_waveform_step step;
+	u32 cycles_per_step;
+	u64 lastclk_cycles;
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
+	    freq > st->step.clk_rate_hz)
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
+	lastclk_cycles = (u64)t->last_clk_max_ns * st->step.clk_rate_hz;
+	lastclk = div_u64(lastclk_cycles, NSEC_PER_SEC);
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
+	period = DIV_ROUND_UP(st->step.clk_rate_hz, freq);
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
+	if (ret)
+		return ret < 0 ? ret : -EINVAL;
+
+	ret = pwm_round_waveform_might_sleep(st->clk_gate_pwm, &clk_gate_wf);
+	if (ret)
+		return ret < 0 ? ret : -EINVAL;
+
+	st->cnv_wf = cnv_wf;
+	st->clk_gate_wf = clk_gate_wf;
+	st->sampling_freq_hz = DIV64_U64_ROUND_CLOSEST(st->step.clk_rate_hz,
+						       (u64)period * cycles_per_step);
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
 
@@ -235,6 +458,14 @@ static int ad7625_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
+		if (st->info->ddr_timing) {
+			/* Referred to the input of the ADAQ front end, so divided by its gain. */
+			*val = st->vref_mv * MILLI;
+			*val2 = st->gain_milli << (chan->scan_type.realbits - 1);
+
+			return IIO_VAL_FRACTIONAL;
+		}
+
 		*val = st->vref_mv;
 		*val2 = chan->scan_type.realbits - 1;
 
@@ -417,6 +648,35 @@ static int ad7960_set_mode(struct ad7625_state *st, enum ad7960_mode mode,
 	}
 }
 
+static const u16 ad7625_gains_milli[] = { 370, 730, 870, 1380, 2250 };
+
+static int ad7625_parse_ddr(struct device *dev, struct ad7625_state *st)
+{
+	int ret, i;
+
+	st->two_lanes = device_property_read_bool(dev, "adi,use-two-lanes");
+
+	/* A fixed gain part has no adi,gain-milli, the others are pin strapped. */
+	st->gain_milli = st->info->default_gain_milli;
+	if (st->gain_milli)
+		return 0;
+
+	if (!device_property_present(dev, "adi,gain-milli"))
+		return dev_err_probe(dev, -EINVAL, "adi,gain-milli must be set\n");
+
+	ret = device_property_read_u16(dev, "adi,gain-milli", &st->gain_milli);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to read adi,gain-milli\n");
+
+	/* The scale shifts the gain by up to 17 bits, so it has to stay small. */
+	for (i = 0; i < ARRAY_SIZE(ad7625_gains_milli); i++)
+		if (st->gain_milli == ad7625_gains_milli[i])
+			return 0;
+
+	return dev_err_probe(dev, -EINVAL, "unsupported adi,gain-milli %u\n",
+			     st->gain_milli);
+}
+
 static int ad7625_buffer_preenable(struct iio_dev *indio_dev)
 {
 	struct ad7625_state *st = iio_priv(indio_dev);
@@ -462,6 +722,8 @@ static int devm_ad7625_pwm_get(struct device *dev,
 {
 	struct clk *ref_clk;
 	u32 ref_clk_rate_hz;
+	const char *clk_name;
+	int ret;
 
 	st->cnv_pwm = devm_pwm_get(dev, "cnv");
 	if (IS_ERR(st->cnv_pwm))
@@ -471,14 +733,28 @@ static int devm_ad7625_pwm_get(struct device *dev,
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
+					     "the steps of the pwms don't fit the CLK burst\n");
+
+		return 0;
+	}
+
 	ref_clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(ref_clk))
 		return dev_err_probe(dev, PTR_ERR(ref_clk),
@@ -494,6 +770,28 @@ static int devm_ad7625_pwm_get(struct device *dev,
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
+	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to get REF voltage\n");
+	if (!ret)
+		return dev_err_probe(dev, -EINVAL, "REF voltage must not be 0\n");
+
+	/* Without ref-supply the internal reference is used. */
+	st->vref_mv = ret == -ENODEV ? AD7625_INTERNAL_REF_MV : ret / (MICRO / MILLI);
+
+	return 0;
+}
+
 /*
  * There are three required input voltages for each device, plus two
  * conditionally-optional (depending on part) REF and REFIN voltages
@@ -515,6 +813,9 @@ static int devm_ad7625_regulator_setup(struct device *dev,
 	static const char * const regulator_names[] = { "vio", "vdd2", "vdd1" };
 	int ret, ref_mv;
 
+	if (st->info->ddr_timing)
+		return devm_ad7625_ddr_regulator_setup(dev, st);
+
 	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
 					     regulator_names);
 	if (ret)
@@ -557,6 +858,41 @@ static int devm_ad7625_regulator_setup(struct device *dev,
 	return 0;
 }
 
+static int ad7625_set_initial_mode(struct device *dev, struct ad7625_state *st)
+{
+	int ret;
+
+	/* The parts with DDR output have no EN pins. */
+	if (st->info->ddr_timing)
+		return 0;
+
+	/* Set the device mode based on detected EN configuration. */
+	if (!st->info->has_bandwidth_control) {
+		ad7625_set_en_gpios_for_vref(st, st->have_refin, st->vref_mv);
+		return 0;
+	}
+
+	/*
+	 * If neither sampling mode is available, then report an error,
+	 * since the other modes are not useful defaults.
+	 */
+	if (st->can_wide_bandwidth) {
+		ret = ad7960_set_mode(st, AD7960_MODE_WIDE_BANDWIDTH,
+				      st->have_refin, st->vref_mv);
+	} else if (st->can_narrow_bandwidth) {
+		ret = ad7960_set_mode(st, AD7960_MODE_NARROW_BANDWIDTH,
+				      st->have_refin, st->vref_mv);
+	} else {
+		return dev_err_probe(dev, -EINVAL,
+			"couldn't set device to wide or narrow bandwidth modes\n");
+	}
+
+	if (ret)
+		return dev_err_probe(dev, -EINVAL, "failed to set EN pins\n");
+
+	return 0;
+}
+
 static int ad7625_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -579,7 +915,9 @@ static int ad7625_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, -EINVAL,
 				     "self-clocked mode not supported\n");
 
-	if (st->info->has_bandwidth_control)
+	if (st->info->ddr_timing)
+		ret = ad7625_parse_ddr(dev, st);
+	else if (st->info->has_bandwidth_control)
 		ret = ad7625_parse_mode(dev, st, 4);
 	else
 		ret = ad7625_parse_mode(dev, st, 2);
@@ -591,29 +929,9 @@ static int ad7625_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	/* Set the device mode based on detected EN configuration. */
-	if (!st->info->has_bandwidth_control) {
-		ad7625_set_en_gpios_for_vref(st, st->have_refin, st->vref_mv);
-	} else {
-		/*
-		 * If neither sampling mode is available, then report an error,
-		 * since the other modes are not useful defaults.
-		 */
-		if (st->can_wide_bandwidth) {
-			ret = ad7960_set_mode(st, AD7960_MODE_WIDE_BANDWIDTH,
-					      st->have_refin, st->vref_mv);
-		} else if (st->can_narrow_bandwidth) {
-			ret = ad7960_set_mode(st, AD7960_MODE_NARROW_BANDWIDTH,
-					      st->have_refin, st->vref_mv);
-		} else {
-			return dev_err_probe(dev, -EINVAL,
-				"couldn't set device to wide or narrow bandwidth modes\n");
-		}
-
-		if (ret)
-			return dev_err_probe(dev, -EINVAL,
-					     "failed to set EN pins\n");
-	}
+	ret = ad7625_set_initial_mode(dev, st);
+	if (ret)
+		return ret;
 
 	ret = devm_ad7625_pwm_get(dev, st);
 	if (ret)
@@ -634,6 +952,13 @@ static int ad7625_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	if (st->info->ddr_timing) {
+		ret = iio_backend_num_lanes_set(st->back, st->two_lanes ? 2 : 1);
+		/* Without the op, a backend can only be left on one lane. */
+		if (ret && (ret != -EOPNOTSUPP || st->two_lanes))
+			return dev_err_probe(dev, ret, "failed to set the number of lanes\n");
+	}
+
 	ret = devm_iio_backend_enable(dev, st->back);
 	if (ret)
 		return ret;
@@ -647,6 +972,10 @@ static int ad7625_probe(struct platform_device *pdev)
 	if (st->info->has_bandwidth_control && !st->can_wide_bandwidth)
 		default_sample_freq = AD7960_MAX_NBW_FREQ;
 
+	/* The DDR parts reject rates above the clock of the PWMs. */
+	if (st->info->ddr_timing)
+		default_sample_freq = min_t(u32, default_sample_freq, st->step.clk_rate_hz);
+
 	ret = ad7625_set_sampling_freq(st, default_sample_freq);
 	if (ret)
 		return dev_err_probe(dev, ret,
@@ -660,6 +989,11 @@ static const struct of_device_id ad7625_of_match[] = {
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
@@ -669,6 +1003,11 @@ static const struct platform_device_id ad7625_device_ids[] = {
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
-- 
2.34.1

