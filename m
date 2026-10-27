Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108689;
	b=g+iQ71D0Xmv7mBcQZS6dq8u1AA39cAd0T1d6gisCobTqXO5bCQyeDa+fH+q9VKIRAFlR
	 GSnjX57o7a0ysFZjpY5wC63auyHCxzUO1If+0cZB3fiWkG9q2t//ZHsgaHY1ohpES+D7a
	 Iy7ZOieTpaZriXbxYqEduGRgijd1qOPc7nwbOmT8stJiAOYi5EDFN/qmc5p58ifUru4Yp
	 obGoxr+GSgVF39XysXIFd/ikgLc7ioj4wAWXO6IAWt1y4nJ54wAt+qIH+88V6FHCLhYAu
	 67xdprDP4/AzcfVAhM5JfcqHVfrDzSYttYrdVP4G9f9P+KMeR7ivsef350iQrIlqicA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108689;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-ADIRuleOP-NewSCL:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=sNCSGbUiOxlLV57ia7fTmNtmohJYtJVaMetRZT5myzs=;
	b=0XLl5JEUEHa4YlEeWFdy4Pn157+H7pG1+MJRmQOd4qMDyArUakBH3ua1sYOu2VeeBd5F
	 xIO1d1eopk074VqGzDgiSRxqU/2DnBcRopyJPH0bacsM9EZJA7CFeE2k5bTLB8YCnp2FW
	 6s79bzslt5qZR/01xkUxLInpokCG+5LPStEnRRDH0wi/Bilaq3LnxmGqWnY8cl4lPBh7s
	 3T8r8QS9son4rkz1TGBTwpNG/Z+TVqtvC44V4fY9v1KmJYo+KxiPWGi899vFy1S2Nbyfp
	 ICcLCb3JyklLVg3MvMIYRu4svB3s3k0TnFeGQkUiW6VUT/0INE9imXJKiddqC0TX5wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="oT/Iot7b";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=0uSMlui5;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D098606A31A;
	Tue, 27 Oct 2026 13:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D098606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=oT/Iot7b;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=0uSMlui5
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RDgPNF3119804;
	Tue, 27 Oct 2026 09:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=sNCSGbUiOxlLV57ia7fTmNtmohJYtJVaMetRZT5myzs=; b=oT/Iot7
	bruRzyzA37vCDo9ERkJ2X/VOh6Jv6MFzg6lTzwydv3o4WBlOxl35ydthD3pKwk9Z
	wPbRZ72jZmSlWms3Vsd35RDjzVl/+eqQvfjhaINRxlspvDiD2k2C1zeMeb7r9Iw3
	3TR7SJb3WfCG8xO+RhQktAAni/HMTTzuwW4Kk6a4vESX1N4K66sPsGcbwu+Tm7JV
	GEjvPvMzpWi0e9WBCtR3LfW9bxCAoJLc30ou1gNNkHnGzkd8c6NkiC8RtBiyRzWD
	9zSk61iUktjSyv9+cZY+PgZqCYf8FZaw1bbZ7/8bLYtmyPzOOM8J4FOHBO4Bg0VE
	v9wTjaZzuaVsodQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sNCSG
	bUiOxlLV57ia7fTmNtmohJYtJVaMetRZT5myzs=; b=0uSMlui5fhVvcp0TZdFRt
	TcvL1TRz05G0LNgXsBArT0VG7HT+CCPPy570P2YV5FlFpmaWVl2oo/+L+2fuAV4S
	fsFBXe9K81AzG7Y1qXqEL9fKdW8nIjO65SjW2Tavl0jQ9fxJUbf/MO1Na9NL2d+P
	Qv+xuQR28sL/VeY5LwbczJMgO9wYNJX7y1tWgmg7V5L5ck2eDUEb8ogfLQ13NsCQ
	ZMpLzzH1PjcT1UfggeUx4+50KrgKiGjhIhCVl8AaWL8l8Mt/iYw/jWLaNyJl7Xvi
	EoQOjuh/QMoB2Biu5wfhPx6HCcKs+S5FP5BAbpaUJ10Wyiz2e6n7wrzTYYi4s9p4
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hjjct3m1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Oct 2026 09:44:44 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69RDihBx039583
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Oct 2026 09:44:43 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 27 Oct
 2026 09:44:43 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 27 Oct 2026 09:44:43 -0400
Received: from HYB-aFjnqsVU6Ag.ad.analog.com ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69RDiPUQ014649;
	Tue, 27 Oct 2026 09:44:35 -0400
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>,
        Sergiu
 Cuciurean <sergiu.cuciurean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH 2/2] iio: adc: add ltc2387 driver
Date: Tue, 27 Oct 2026 15:44:09 +0200
Message-ID: <20261027134409.76824-3-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261027134409.76824-1-Nicolae-daniel.Deaconescu@analog.com>
References: <20261027134409.76824-1-Nicolae-daniel.Deaconescu@analog.com>
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
X-Proofpoint-ORIG-GUID: WgWcejW6j2z-iJFAkjjDOW4RwLv0sdg5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX/M32RsMj6lC4
 F6q81wYjgWfdJw0NkKpnlXnDG8VYtRInimeap7VqEaiLX1RWt/+Y9BREQiIH6gF9GXPg639Bn7A
 Gpy60KGXBajhdPcceDHpHeG/yB5wINJ5wl40yEMFnflnypyMvV7hJiMAjzLheNLsNJKvM+VdVMa
 aBVQQ2k82grnVvrRY3nqq//SNm3qCRLb23PpRm5E36jss3+jmaqCcY1w+c48++dsGH3S9cKxZbi
 KeMHRPIQKvXndsKw+tQxlagsY790ucVa9KDJeEsxjbhW6RUQQiwbbP+i3DtbTtzFV/l26wID157
 zvOIjh36KUbQfwNVup8oLkfI4V3SbJixJPCwPjbW25dE6JSZbfb2h4X4KVUEA3jCRi09wUXNala
 UdzuYBi7ccfkUfbUwknv4Q/Ded9cg9sK4LwmWmDbstUcupSKDRXdOqsi1K5g/HIAfjpHOfm2T7Y
 4NQhpA28QI0e2t4apKg==
X-Proofpoint-GUID: WgWcejW6j2z-iJFAkjjDOW4RwLv0sdg5
X-Authority-Analysis: v=2.4 cv=HtPjiETS c=1 sm=1 tr=0 ts=6ae0aacc cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=9pL5GlJ4ATL8W5xn2UUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1NCBTYWx0ZWRfX20wpy/psIYCD
 A57X2jJ+y+qUcXge9QZgQOKuaKUKS8dbHO8nZZnsfCf5KP3z0T5O/ij98yoWP0VcUShLpOhLPrA
 GPr4ktM5p4/WiSmHmHtFYCiD0vIL/tBhff6sd/KM157ziAMUf1we
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270054

From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>

Add a driver for the LTC2387-16/18 and the ADAQ23875/23876/23878.

The driver generates CNV and the gated data clock with two PWM
channels, timed against the reference clock to meet t_FIRSTCLK, and
gets sample data through the IIO backend framework from the AXI ADC
core. It supports one-lane and two-lane output and reports the
sampling frequency the PWMs produce after rounding to whole reference
clock cycles. in_voltage_scale is referred to the analog input, so on
the ADAQ parts it is divided by the front-end gain.

Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
Co-developed-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Assisted-by: Claude:claude-opus-5-5
---
 MAINTAINERS               |   1 +
 drivers/iio/adc/Kconfig   |  11 +
 drivers/iio/adc/Makefile  |   1 +
 drivers/iio/adc/ltc2387.c | 482 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 495 insertions(+)
 create mode 100644 drivers/iio/adc/ltc2387.c

diff --git a/MAINTAINERS b/MAINTAINERS
index b871d7f25d76..6e242a955e09 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15536,6 +15536,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/lltc,ltc2387.yaml
+F:	drivers/iio/adc/ltc2387.c
 
 LTC2664 IIO DAC DRIVER
 M:	Michael Hennerich <michael.hennerich@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 02de4809ae31..c543f066dbee 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -994,6 +994,17 @@ config LTC2378
 	  This driver can also be built as a module. If so, the module will
 	  be called ltc2378.
 
+config LTC2387
+	tristate "Linear Technology LTC2387 ADC driver"
+	depends on PWM
+	select IIO_BACKEND
+	help
+	  Say yes here to build support for Linear Technology LTC2387 18/16
+	  bit 15Msps SAR ADC.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called ltc2387.
+
 config LTC2471
 	tristate "Linear Technology LTC2471 and LTC2473 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 9e82c21dbd37..4032276f55f1 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_LPC18XX_ADC) += lpc18xx_adc.o
 obj-$(CONFIG_LPC32XX_ADC) += lpc32xx_adc.o
 obj-$(CONFIG_LTC2309) += ltc2309.o
 obj-$(CONFIG_LTC2378) += ltc2378.o
+obj-$(CONFIG_LTC2387) += ltc2387.o
 obj-$(CONFIG_LTC2471) += ltc2471.o
 obj-$(CONFIG_LTC2485) += ltc2485.o
 obj-$(CONFIG_LTC2496) += ltc2496.o ltc2497-core.o
diff --git a/drivers/iio/adc/ltc2387.c b/drivers/iio/adc/ltc2387.c
new file mode 100644
index 000000000000..c236b99baa4a
--- /dev/null
+++ b/drivers/iio/adc/ltc2387.c
@@ -0,0 +1,482 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Linear Technology LTC2387 ADC driver
+ *
+ * Copyright 2022 - 2026 Analog Devices Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/iio/backend.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/kernel.h>
+#include <linux/math64.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/pwm.h>
+#include <linux/regulator/consumer.h>
+#include <linux/mod_devicetable.h>
+
+#define LTC2387_VREF		4096
+#define LTC2387_T_CNVH		8
+
+/*
+ * Minimal value for t_{FIRSTCLK} according to
+ * https://www.analog.com/media/en/technical-documentation/data-sheets/238718fa.pdf
+ * is 65 ns. Add some slack because there is some rounding involved in the PWM
+ * driver. With the PWM driver rounding to the nearest possible value, targeting
+ * 70 ns works for input clk rates >= 100 MHz.
+ */
+#define LTC2387_T_FIRSTCLK_NS	70
+
+#define KHz 1000
+#define MHz (1000 * KHz)
+
+#define LTC2378_MULTIPLE_CHAN(_idx, _storagebits, _realbits, _shift)	\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
+		.indexed = 1,						\
+		.channel = _idx,					\
+		.scan_index = _idx,					\
+		.scan_type = {						\
+			.sign = 's',					\
+			.storagebits = _storagebits,			\
+			.realbits = _realbits,				\
+			.shift = _shift,				\
+		},							\
+	}
+
+#define LTC2378_CHAN(_realbits, _storagebits)				\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),\
+		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),\
+		.scan_type = {						\
+			.sign = 's',					\
+			.storagebits = _storagebits,			\
+			.realbits = _realbits,				\
+		},							\
+	}
+
+enum ltc2387_lane_modes {
+	ONE_LANE = 0,
+	TWO_LANES = 1
+};
+
+enum ltc2387_id {
+	ID_LTC2387_16,
+	ID_LTC2387_16_X4,
+	ID_LTC2387_18,
+	ID_LTC2387_18_X4,
+	ID_ADAQ23875,
+	ID_ADAQ23876,
+	ID_ADAQ23878,
+};
+
+struct ltc2387_info {
+	const char *name;
+	struct iio_chan_spec channels[4];
+	unsigned int test_pattern[2];
+	int num_channels;
+	int resolution;
+	/* Gain * 1000 when adi,gain-milli is absent; unity for the bare parts. */
+	u32 default_gain_milli;
+};
+
+#define LTC2387_TEST_PATTERN_16 {					\
+	[ONE_LANE]  = 0b1010000001111111,				\
+	[TWO_LANES] = 0b1100110000111111,				\
+}
+
+#define LTC2387_TEST_PATTERN_18 {					\
+	[ONE_LANE]  = 0b101000000111111100,				\
+	[TWO_LANES] = 0b110011000011111100,				\
+}
+
+static const struct ltc2387_info ltc2387_infos[] = {
+	[ID_LTC2387_16] = {
+		.name = "ltc2387-16",
+		.default_gain_milli = 1000,
+		.resolution = 16,
+		.test_pattern = LTC2387_TEST_PATTERN_16,
+		.channels = { LTC2378_CHAN(16, 16) },
+		.num_channels = 1,
+	},
+	[ID_LTC2387_16_X4] = {
+		.name = "ltc2387-16-x4",
+		.default_gain_milli = 1000,
+		.resolution = 16,
+		.test_pattern = LTC2387_TEST_PATTERN_16,
+		.channels = {
+			LTC2378_MULTIPLE_CHAN(0, 64, 16, 0),
+			LTC2378_MULTIPLE_CHAN(1, 64, 16, 16),
+			LTC2378_MULTIPLE_CHAN(2, 64, 16, 32),
+			LTC2378_MULTIPLE_CHAN(3, 64, 16, 48),
+		},
+		.num_channels = 4,
+	},
+	[ID_LTC2387_18] = {
+		.name = "ltc2387-18",
+		.default_gain_milli = 1000,
+		.resolution = 18,
+		.test_pattern = LTC2387_TEST_PATTERN_18,
+		.channels = { LTC2378_CHAN(18, 32) },
+		.num_channels = 1,
+	},
+	[ID_LTC2387_18_X4] = {
+		.name = "ltc2387-18-x4",
+		.default_gain_milli = 1000,
+		.resolution = 18,
+		.test_pattern = LTC2387_TEST_PATTERN_18,
+		.channels = {
+			LTC2378_MULTIPLE_CHAN(0, 128, 18, 0),
+			LTC2378_MULTIPLE_CHAN(1, 128, 18, 32),
+			LTC2378_MULTIPLE_CHAN(2, 128, 18, 64),
+			LTC2378_MULTIPLE_CHAN(3, 128, 18, 96),
+		},
+		.num_channels = 4,
+	},
+	[ID_ADAQ23875] = {
+		.name = "adaq23875",
+		.default_gain_milli = 2000,
+		.resolution = 16,
+		.test_pattern = LTC2387_TEST_PATTERN_16,
+		.channels = { LTC2378_CHAN(16, 16) },
+		.num_channels = 1,
+	},
+	[ID_ADAQ23876] = {
+		.name = "adaq23876",
+		.default_gain_milli = 0,
+		.resolution = 16,
+		.test_pattern = LTC2387_TEST_PATTERN_16,
+		.channels = { LTC2378_CHAN(16, 16) },
+		.num_channels = 1,
+	},
+	[ID_ADAQ23878] = {
+		.name = "adaq23878",
+		.default_gain_milli = 0,
+		.resolution = 18,
+		.test_pattern = LTC2387_TEST_PATTERN_18,
+		.channels = { LTC2378_CHAN(18, 32) },
+		.num_channels = 1,
+	},
+};
+
+struct ltc2387_dev {
+	const struct ltc2387_info *device_info;
+	enum ltc2387_lane_modes lane_mode;
+	unsigned long ref_clk_rate;
+	struct iio_backend *back;
+	struct pwm_device *clk_gate;
+	struct regulator *vref;
+	struct pwm_device *cnv;
+	struct clk *ref_clk;
+
+	unsigned int vref_mv;
+	u32 sampling_freq;
+	u32 gain_milli;
+};
+
+static int ltc2387_set_sampling_freq(struct ltc2387_dev *ltc, int freq)
+{
+	unsigned long long ref_clk_period_ns;
+	struct pwm_waveform clk_gate_wf = { }, cnv_wf = { };
+	unsigned long long period_cycles;
+	int ret, clk_en_time;
+	u32 rem;
+
+	if (freq <= 0 || freq > ltc->ref_clk_rate)
+		return -EINVAL;
+
+	ref_clk_period_ns = DIV_ROUND_UP(NSEC_PER_SEC, ltc->ref_clk_rate);
+
+	cnv_wf.duty_length_ns = ref_clk_period_ns;
+
+	/*
+	 * The goal here is that the PWM is configured with a minimal period not
+	 * less than 1 / freq (with freq measured in Hz).
+	 *
+	 * When a period P (measured in ns) is passed to pwm_apply_state(), the
+	 * actually implemented period is:
+	 *
+	 *      round_down(P * R / NSEC_PER_SEC) / R
+	 *
+	 * (measured in s) with R = ltc->ref_clk_rate. So we have:
+	 *
+	 *        round_down(P * R / NSEC_PER_SEC) / R ≥ 1 / freq
+	 *      ⟺ round_down(P * R / NSEC_PER_SEC) ≥ R / freq
+	 *
+	 * With the LHS being integer this is equivalent to:
+	 *
+	 *        round_down(P * R / NSEC_PER_SEC) ≥ round_up(R / freq)
+	 *      ⟺ P * R / NSEC_PER_SEC ≥ round_up(R / freq)
+	 *      ⟺ P ≥ round_up(R / freq) * NSEC_PER_SEC / R
+	 */
+
+	cnv_wf.period_length_ns =
+		div_u64_rem((u64)DIV_ROUND_UP(ltc->ref_clk_rate, freq) * NSEC_PER_SEC,
+			    ltc->ref_clk_rate, &rem);
+	if (rem)
+		cnv_wf.period_length_ns += 1;
+
+	/* Gate the active period of the clock (see page 10-13 for both LTC's) */
+	if (ltc->lane_mode == TWO_LANES)
+		clk_en_time = DIV_ROUND_UP_ULL(ltc->device_info->resolution, 4);
+	else
+		clk_en_time = DIV_ROUND_UP_ULL(ltc->device_info->resolution, 2);
+
+	clk_gate_wf.duty_length_ns = ref_clk_period_ns * clk_en_time;
+	clk_gate_wf.duty_offset_ns = LTC2387_T_FIRSTCLK_NS;
+
+	if (cnv_wf.period_length_ns < clk_gate_wf.duty_length_ns)
+		cnv_wf.period_length_ns = clk_gate_wf.duty_length_ns + ref_clk_period_ns;
+
+	clk_gate_wf.period_length_ns = cnv_wf.period_length_ns;
+
+	if (clk_gate_wf.duty_offset_ns >= clk_gate_wf.period_length_ns)
+		div64_u64_rem(clk_gate_wf.duty_offset_ns,
+			      clk_gate_wf.period_length_ns,
+			      &clk_gate_wf.duty_offset_ns);
+
+	ret = pwm_set_waveform_might_sleep(ltc->cnv, &cnv_wf, false);
+	if (ret < 0)
+		return ret;
+
+	ret = pwm_set_waveform_might_sleep(ltc->clk_gate, &clk_gate_wf, false);
+	if (ret < 0)
+		return ret;
+
+	period_cycles = mul_u64_u32_div(cnv_wf.period_length_ns,
+					ltc->ref_clk_rate, NSEC_PER_SEC);
+	if (!period_cycles)
+		return -EINVAL;
+
+	ltc->sampling_freq = DIV_ROUND_CLOSEST_ULL(ltc->ref_clk_rate,
+						   period_cycles);
+
+	return 0;
+}
+
+static int ltc2387_setup(struct iio_dev *indio_dev)
+{
+	struct ltc2387_dev *ltc = iio_priv(indio_dev);
+	struct device *dev = indio_dev->dev.parent;
+
+	if (device_property_present(dev, "adi,use-two-lanes"))
+		ltc->lane_mode = TWO_LANES;
+
+	return ltc2387_set_sampling_freq(ltc, 15 * MHz);
+}
+
+static int ltc2387_read_raw(struct iio_dev *indio_dev,
+			    const struct iio_chan_spec *chan,
+			    int *val, int *val2, long info)
+{
+	struct ltc2387_dev *ltc = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = ltc->sampling_freq;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		/* Referred to the SMA input, so divided by the front-end gain. */
+		*val = ltc->vref_mv * 2 * 1000;
+		*val2 = ltc->gain_milli << chan->scan_type.realbits;
+		return IIO_VAL_FRACTIONAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ltc2387_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int val, int val2, long info)
+{
+	struct ltc2387_dev *ltc = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ltc2387_set_sampling_freq(ltc, val);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static void ltc2387_pwm_disable(void *data)
+{
+	pwm_disable(data);
+}
+
+static void ltc2387_regulator_disable(void *data)
+{
+	regulator_disable(data);
+}
+
+static void ltc2387_clk_disable(void *data)
+{
+	clk_disable_unprepare(data);
+}
+
+static const struct iio_info ltc2387_info = {
+	.read_raw = ltc2387_read_raw,
+	.write_raw = ltc2387_write_raw,
+};
+
+static const struct of_device_id ltc2387_of_match[] = {
+	{
+		.compatible = "lltc,ltc2387-16",
+		.data = &ltc2387_infos[ID_LTC2387_16]
+	}, {
+		.compatible = "lltc,ltc2387-16-x4",
+		.data = &ltc2387_infos[ID_LTC2387_16_X4]
+	}, {
+		.compatible = "lltc,ltc2387-18",
+		.data = &ltc2387_infos[ID_LTC2387_18]
+	}, {
+		.compatible = "lltc,ltc2387-18-x4",
+		.data = &ltc2387_infos[ID_LTC2387_18_X4]
+	}, {
+		.compatible = "adi,adaq23875",
+		.data = &ltc2387_infos[ID_ADAQ23875]
+	}, {
+		.compatible = "adi,adaq23876",
+		.data = &ltc2387_infos[ID_ADAQ23876]
+	}, {
+		.compatible = "adi,adaq23878",
+		.data = &ltc2387_infos[ID_ADAQ23878]
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, ltc2387_of_match);
+
+static int ltc2387_probe(struct platform_device *pdev)
+{
+	struct iio_dev			*indio_dev;
+	struct ltc2387_dev		*ltc;
+	int				ret;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*ltc));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	ltc = iio_priv(indio_dev);
+
+	ltc->vref = devm_regulator_get_optional(&pdev->dev, "vref");
+	if (!IS_ERR(ltc->vref)) {
+		ret = regulator_enable(ltc->vref);
+		if (ret) {
+			dev_err(&pdev->dev, "Can't enable vref regulator\n");
+			return ret;
+		}
+		ret = regulator_get_voltage(ltc->vref);
+		if (ret < 0)
+			return ret;
+
+		ltc->vref_mv = ret / 1000;
+		ret = devm_add_action_or_reset(&pdev->dev,
+					       ltc2387_regulator_disable,
+					       ltc->vref);
+		if (ret)
+			return ret;
+	} else {
+		if (PTR_ERR(ltc->vref) != -ENODEV)
+			return PTR_ERR(ltc->vref);
+
+		ltc->vref_mv = LTC2387_VREF; /* Internal vref is used */
+	}
+
+	ltc->ref_clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(ltc->ref_clk))
+		return PTR_ERR(ltc->ref_clk);
+
+	ret = clk_prepare_enable(ltc->ref_clk);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(&pdev->dev, ltc2387_clk_disable,
+				       ltc->ref_clk);
+	if (ret)
+		return ret;
+	ltc->ref_clk_rate = clk_get_rate(ltc->ref_clk);
+
+	ltc->clk_gate = devm_pwm_get(&pdev->dev, "clk_gate");
+	if (IS_ERR(ltc->clk_gate))
+		return PTR_ERR(ltc->clk_gate);
+
+	ret = devm_add_action_or_reset(&pdev->dev, ltc2387_pwm_disable,
+				       ltc->clk_gate);
+	if (ret)
+		return ret;
+
+	ltc->cnv = devm_pwm_get(&pdev->dev, "cnv");
+	if (IS_ERR(ltc->cnv))
+		return PTR_ERR(ltc->cnv);
+
+	ret = devm_add_action_or_reset(&pdev->dev, ltc2387_pwm_disable,
+				       ltc->cnv);
+
+	if (ret)
+		return ret;
+
+	ltc->device_info = device_get_match_data(&pdev->dev);
+	if (!ltc->device_info)
+		return -EINVAL;
+
+	ltc->gain_milli = ltc->device_info->default_gain_milli;
+	device_property_read_u32(&pdev->dev, "adi,gain-milli", &ltc->gain_milli);
+	if (!ltc->gain_milli)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "adi,gain-milli must be nonzero\n");
+
+	indio_dev->channels = ltc->device_info->channels;
+	indio_dev->num_channels = ltc->device_info->num_channels;
+	indio_dev->dev.parent = &pdev->dev;
+	indio_dev->name = ltc->device_info->name;
+	indio_dev->info = &ltc2387_info;
+
+	ltc->back = devm_iio_backend_get(&pdev->dev, NULL);
+	if (IS_ERR(ltc->back))
+		return dev_err_probe(&pdev->dev, PTR_ERR(ltc->back),
+				     "failed to get IIO backend\n");
+
+	ret = devm_iio_backend_request_buffer(&pdev->dev, ltc->back, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_backend_enable(&pdev->dev, ltc->back);
+	if (ret)
+		return ret;
+
+	/* axi_ltc2387 has a single capture channel carrying every scan element. */
+	ret = iio_backend_chan_enable(ltc->back, 0);
+	if (ret)
+		return ret;
+
+	ret = ltc2387_setup(indio_dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "\nltc2387 setup failed\n");
+		return ret;
+	}
+
+	return devm_iio_device_register(&pdev->dev, indio_dev);
+}
+
+static struct platform_driver ltc2387_driver = {
+	.probe          = ltc2387_probe,
+	.driver         = {
+		.name   = "ltc2387",
+		.of_match_table = ltc2387_of_match,
+	},
+};
+module_platform_driver(ltc2387_driver);
+
+MODULE_AUTHOR("Sergiu Cuciurean <sergiu.cuciurean@analog.com>");
+MODULE_DESCRIPTION("Linear Technology LTC2387 ADC");
+MODULE_LICENSE("Dual BSD/GPL");
+MODULE_IMPORT_NS("IIO_BACKEND");
-- 
2.34.1

