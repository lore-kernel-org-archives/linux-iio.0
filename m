Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC7B33BBD4;
	Mon, 26 Jan 2026 14:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769436113; cv=none; b=U7hccjcIMjOH0+pfEcseP9DPpPaM7GQh8YgPWARfZkNidvl06ZEi4zLPU7+eYxEbxsJbLxYYlpP4kYvH92BvB+Mv4jVenN/UOjc2OhZ7AV/wWHIfjjGp771UjXuF+g86tpnLuGpWSuFetX4z0HhjaPVngWEQLwOLayIvuu23lPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769436113; c=relaxed/simple;
	bh=6k8S+MVNujf8CVpBP7rvF3wH3BSWx2N/cmllMQPGJvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E2D8UKi9val93EceR5fZmkDNIsE5seAFrHy/5iFC63mJka25GhSyhAbQ77Wi7KIHG4NYDYqaHjkvG9OsiFDdg/yYkJZPZ+AzqDe6UzAyIeTf8nQACFYtsBdHjsVTGsEe8YZCOBo97oWl4h4wkESCi4Er7yY81Heo3Ce1xmQZ8TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWQ12rSP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWQ12rSP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B994BC2BCC6;
	Mon, 26 Jan 2026 14:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769436113;
	bh=6k8S+MVNujf8CVpBP7rvF3wH3BSWx2N/cmllMQPGJvM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lWQ12rSPOpzry418IlryCyJTXH/2BwDmZ0DADtsmYG3nc4l+rW5Mqbm6meTp8ZnLK
	 m44Q9z3CY7HA7fAVM5xu8NliBPZWO+sY4i+rEf+wCJD5uVVWZJD9bdmuEC+RjL3V54
	 xsUZNhzEU+GSihNVye+fvaJGXexjOYWBJHw6Pvddx/JkCrpV8UlNHsrEDVJKgwdcIh
	 wPpEjqSl+mJ40Mo9NO1+S1ou4A4MAg6DPSmEvJlPR+5vrERLb4t2wD3hG6xfUfwVpm
	 d9Iy+GD7gpgUryuSYmCQ+JF6EK1NxswSk33lm/DQQNA03Zu2ea7PoZL5cxQRfhx5R8
	 YD7wGz9TC0PIg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCABD13C1C;
	Mon, 26 Jan 2026 14:01:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 26 Jan 2026 13:51:07 +0000
Subject: [PATCH v2 6/6] iio: amplifiers: ad8366: Update device support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260126-iio-ad8366-update-v2-6-c9a4d31aeb01@analog.com>
References: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
In-Reply-To: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Alexandru Ardelean <alexandru.ardelean@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769436111; l=6385;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=cYZYdo1jsI63Nd/LYcxtiA2+53D0PuyoRYFvGABoZxk=;
 b=SG+43gvAVWKTS6faC3C6oXN1k3mQauE2++W11lrAB95N0ok4XS+bI1yg7gdSuedBdk0KwYt0Z
 Wym/czysWfcBZwnUpgqJSqgYCMXAkUvEKI5JhzKKzEZyjWM59ZYgNI1
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add support for the following digital step attenuators:
- HMC271A: 1dB LSB 5-Bit Digital Attenuator SMT, 0.7 - 3.7 GHz
- ADRF5720: 0.5 dB LSB, 6-Bit, Digital Attenuator, 9 kHz to 40 GHz
- ADRF5730: 0.5 dB LSB, 6-Bit, Digital Attenuator, 100 MHz to 40 GHz
- ADRF5731: 2 dB LSB, 4-Bit, Digital Attenuator, 100 MHz to 40 GHz
- HMC1018A: 1.0 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz
- HMC1019A: 0.5 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz

Additionally, copyright notice was updated with current year.

Co-developed-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Co-developed-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/Kconfig  |  6 ++++
 drivers/iio/amplifiers/ad8366.c | 72 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
index a8a604863eed..39d280d4d437 100644
--- a/drivers/iio/amplifiers/Kconfig
+++ b/drivers/iio/amplifiers/Kconfig
@@ -18,7 +18,13 @@ config AD8366
 	    AD8366 Dual-Digital Variable Gain Amplifier (VGA)
 	    ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
 	    ADL5240 Digitally controlled variable gain amplifier (VGA)
+	    ADRF5720: 0.5 dB LSB, 6-Bit, Silicon Digital Attenuator
+	    ADRF5730: 0.5 dB LSB, 6-Bit, Silicon Digital Attenuator
+	    ADRF5731: 2 dB LSB, 4-Bit, Silicon Digital Attenuator
+	    HMC271A: 1dB LSB 5-Bit Digital Attenuator SMT
 	    HMC792A 0.25 dB LSB GaAs MMIC 6-Bit Digital Attenuator
+	    HMC1018A: 1.0 dB LSB GaAs MMIC 5-BIT Digital Attenuator
+	    HMC1019A: 0.5 dB LSB GaAs MMIC 5-BIT Digital Attenuator
 	    HMC1119 0.25 dB LSB, 7-Bit, Silicon Digital Attenuator
 
 	  To compile this driver as a module, choose M here: the
diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 9ad6a628376c..14de0418a234 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -5,10 +5,16 @@
  *   AD8366 Dual-Digital Variable Gain Amplifier (VGA)
  *   ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
  *   ADL5240 Digitally controlled variable gain amplifier (VGA)
+ *   ADRF5720: 0.5 dB LSB, 6-Bit, Silicon Digital Attenuator, 9 kHz to 40 GHz
+ *   ADRF5730: 0.5 dB LSB, 6-Bit, Silicon Digital Attenuator, 100 MHz to 40 GHz
+ *   ADRF5731: 2 dB LSB, 4-Bit, Silicon Digital Attenuator, 100 MHz to 40 GHz
+ *   HMC271A: 1dB LSB 5-Bit Digital Attenuator SMT, 0.7 - 3.7 GHz
  *   HMC792A 0.25 dB LSB GaAs MMIC 6-Bit Digital Attenuator
+ *   HMC1018A: 1.0 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz
+ *   HMC1019A: 0.5 dB LSB GaAs MMIC 5-BIT DIGITAL ATTENUATOR, 0.1 - 30 GHz
  *   HMC1119 0.25 dB LSB, 7-Bit, Silicon Digital Attenuator
  *
- * Copyright 2012-2019 Analog Devices Inc.
+ * Copyright 2012-2026 Analog Devices Inc.
  */
 
 #include <linux/cleanup.h>
@@ -67,6 +73,18 @@ static size_t simple_pack_code(struct ad8366_state *st)
 	return 1;
 }
 
+static size_t adrf5731_pack_code(struct ad8366_state *st)
+{
+	st->data[0] = st->ch[0] << 2;
+	return 1;
+}
+
+static size_t hmc271_pack_code(struct ad8366_state *st)
+{
+	st->data[0] = bitrev8(st->ch[0] & 0x1F) >> 3;
+	return 1;
+}
+
 static const struct ad8366_info ad8366_chip_info = {
 	.gain_min = 4500,
 	.gain_max = 20500,
@@ -91,6 +109,30 @@ static const struct ad8366_info adl5240_chip_info = {
 	.pack_code = simple_pack_code,
 };
 
+static const struct ad8366_info adrf57x0_chip_info = {
+	.gain_min = -31500,
+	.gain_max = 0,
+	.gain_step = -500,
+	.num_channels = 1,
+	.pack_code = simple_pack_code,
+};
+
+static const struct ad8366_info adrf5731_chip_info = {
+	.gain_min = -30000,
+	.gain_max = 0,
+	.gain_step = -2000,
+	.num_channels = 1,
+	.pack_code = adrf5731_pack_code,
+};
+
+static const struct ad8366_info hmc271_chip_info = {
+	.gain_min = -31000,
+	.gain_max = 0,
+	.gain_step = 1000,
+	.num_channels = 1,
+	.pack_code = hmc271_pack_code,
+};
+
 static const struct ad8366_info hmc792_chip_info = {
 	.gain_min = -15750,
 	.gain_max = 0,
@@ -99,6 +141,22 @@ static const struct ad8366_info hmc792_chip_info = {
 	.pack_code = simple_pack_code,
 };
 
+static const struct ad8366_info hmc1018_chip_info = {
+	.gain_min = -31000,
+	.gain_max = 0,
+	.gain_step = 1000,
+	.num_channels = 1,
+	.pack_code = simple_pack_code,
+};
+
+static const struct ad8366_info hmc1019_chip_info = {
+	.gain_min = -15500,
+	.gain_max = 0,
+	.gain_step = 500,
+	.num_channels = 1,
+	.pack_code = simple_pack_code,
+};
+
 static const struct ad8366_info hmc1119_chip_info = {
 	.gain_min = -31750,
 	.gain_max = 0,
@@ -253,7 +311,13 @@ static const struct spi_device_id ad8366_id[] = {
 	{"ad8366", (kernel_ulong_t)&ad8366_chip_info},
 	{"ada4961", (kernel_ulong_t)&ada4961_chip_info},
 	{"adl5240", (kernel_ulong_t)&adl5240_chip_info},
+	{"adrf5720", (kernel_ulong_t)&adrf57x0_chip_info},
+	{"adrf5730", (kernel_ulong_t)&adrf57x0_chip_info},
+	{"adrf5731", (kernel_ulong_t)&adrf5731_chip_info},
+	{"hmc271a", (kernel_ulong_t)&hmc271_chip_info},
 	{"hmc792a", (kernel_ulong_t)&hmc792_chip_info},
+	{"hmc1018a", (kernel_ulong_t)&hmc1018_chip_info},
+	{"hmc1019a", (kernel_ulong_t)&hmc1019_chip_info},
 	{"hmc1119", (kernel_ulong_t)&hmc1119_chip_info},
 	{ }
 };
@@ -263,7 +327,13 @@ static const struct of_device_id ad8366_of_match[] = {
 	{ .compatible = "adi,ad8366", .data = &ad8366_chip_info },
 	{ .compatible = "adi,ada4961", .data = &ada4961_chip_info },
 	{ .compatible = "adi,adl5240", .data = &adl5240_chip_info },
+	{ .compatible = "adi,adrf5720", .data = &adrf57x0_chip_info },
+	{ .compatible = "adi,adrf5730", .data = &adrf57x0_chip_info },
+	{ .compatible = "adi,adrf5731", .data = &adrf5731_chip_info },
+	{ .compatible = "adi,hmc271a", .data = &hmc271_chip_info },
 	{ .compatible = "adi,hmc792a", .data = &hmc792_chip_info },
+	{ .compatible = "adi,hmc1018a", .data = &hmc1018_chip_info },
+	{ .compatible = "adi,hmc1019a", .data = &hmc1019_chip_info },
 	{ .compatible = "adi,hmc1119", .data = &hmc1119_chip_info },
 	{ }
 };

-- 
2.43.0


