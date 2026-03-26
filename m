Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B6539FCAD;
	Thu, 26 Mar 2026 18:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774549943; cv=none; b=XweSbSd8E54bkzwDvKQYkFtBtJlACwC0tbgvFA42Nzq/7J7PING6gtgzI9JWu8ktK+ifNRlV+uYbOcTcxFzbABHIUSt777Y6aNDCWx2YRSmSGBiVmEU2nqSD3aOkQv7P6EBeHh1+Ps3Rv/aYqIFxku1v+p3Z3ioIXlsnJ7SW1mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774549943; c=relaxed/simple;
	bh=Hom04uPizYqHH9Z7CUP6T+8bG4T7pz30VDETLsxikXo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nXhzMb4DEIm0Rc/NMHcJB1xB4sdUErIXcxNjwa5qkanZkioFY6tQN5UO/q5qmZCIt+DyLzbBrWuBf03W0cHxLFdAWyUO94MdjHxdWnK3Ij20PTCdHhe5iRNRaJsjYvHx8ivB2kzzJWcQrELDUWy6O9laVbsl5bjSrME+XRZCzTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LRYQeNqe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LRYQeNqe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 466C1C2BCB2;
	Thu, 26 Mar 2026 18:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774549943;
	bh=Hom04uPizYqHH9Z7CUP6T+8bG4T7pz30VDETLsxikXo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LRYQeNqeMxxZLZq+s/Xhf5Xwa2D9/q/z0dKdznRLzFbr75wFclTZMl77FKX8J3CeZ
	 Lmysg/U7zRRGZ9drdG/wq7SRCOM3d0R/00HPXdpF1VD8lQSA+3+K3HOZDUfVvyTisN
	 8bvG1GfcRW4+753rWzJqftTkMz6KCbjpRPUvAuPXccXSrw0AVcEsoZtrTWc6T/+G8G
	 DrznNSf16NC1QUUnOzawI+nmgRoGtjUR68KO4DWfuf5uQyRt30ZA5+c/lM+JlGcJmP
	 sld40QeyWNWvm8dTexCWPInKorDtDBXXHO26QA8hkHjAzqWtNGShpiqg7Vp3MN4946
	 cvz1808fYUsqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CDC10A1E63;
	Thu, 26 Mar 2026 18:32:23 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 26 Mar 2026 18:32:17 +0000
Subject: [PATCH v2 2/2] iio: amplifiers: ad8366: add support for adrf5702/3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260326-adrf570x-iio-support-v2-2-b622a17335d0@analog.com>
References: <20260326-adrf570x-iio-support-v2-0-b622a17335d0@analog.com>
In-Reply-To: <20260326-adrf570x-iio-support-v2-0-b622a17335d0@analog.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774549942; l=3552;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=C6P6Zr+ZHRuErV9w+QMBv1TsPXudqbrh6GcR2maa73k=;
 b=ixIs+B5ItIa27KzDB0Q8Ui8rF3K+OdrI65dGqEd+ydTV2axa3QYIbvhwJmGgHcsSuwyQ3i4XR
 QVDGvhI7hOXDU2s5wJGBHUn9jdR7JbUyYnKLQvgYJP1vRS1JXbwwPFu
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add chip info structs and device table entries for ADRF5702 and ADRF5703
Digital Step Attenuators.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/Kconfig  |  2 ++
 drivers/iio/amplifiers/ad8366.c | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/iio/amplifiers/Kconfig b/drivers/iio/amplifiers/Kconfig
index 39d280d4d437..9e24421b5e97 100644
--- a/drivers/iio/amplifiers/Kconfig
+++ b/drivers/iio/amplifiers/Kconfig
@@ -18,6 +18,8 @@ config AD8366
 	    AD8366 Dual-Digital Variable Gain Amplifier (VGA)
 	    ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
 	    ADL5240 Digitally controlled variable gain amplifier (VGA)
+	    ADRF5702: 0.125 dB LSB, 8-Bit, Silicon Digital Attenuator
+	    ADRF5703: 0.25 dB LSB, 7-Bit, Silicon Digital Attenuator
 	    ADRF5720: 0.5 dB LSB, 6-Bit, Silicon Digital Attenuator
 	    ADRF5730: 0.5 dB LSB, 6-Bit, Silicon Digital Attenuator
 	    ADRF5731: 2 dB LSB, 4-Bit, Silicon Digital Attenuator
diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 334ca91c0f59..bbf41a1fb3a1 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -5,6 +5,8 @@
  *   AD8366 Dual-Digital Variable Gain Amplifier (VGA)
  *   ADA4961 BiCMOS RF Digital Gain Amplifier (DGA)
  *   ADL5240 Digitally controlled variable gain amplifier (VGA)
+ *   ADRF5702: 0.125 dB LSB, 8-Bit, Silicon Digital Attenuator, 50 MHz to 20 GHz
+ *   ADRF5703: 0.25 dB LSB, 7-Bit, Silicon Digital Attenuator, 9 kHz to 20 GHz
  *   ADRF5720: 0.5 dB LSB, 6-Bit, Silicon Digital Attenuator, 9 kHz to 40 GHz
  *   ADRF5730: 0.5 dB LSB, 6-Bit, Silicon Digital Attenuator, 100 MHz to 40 GHz
  *   ADRF5731: 2 dB LSB, 4-Bit, Silicon Digital Attenuator, 100 MHz to 40 GHz
@@ -106,6 +108,22 @@ static const struct ad8366_info adl5240_chip_info = {
 	.num_channels = 1,
 };
 
+static const struct ad8366_info adrf5702_chip_info = {
+	.name = "adrf5702",
+	.gain_min = -31875,
+	.gain_max = 0,
+	.gain_step = -125,
+	.num_channels = 1,
+};
+
+static const struct ad8366_info adrf5703_chip_info = {
+	.name = "adrf5703",
+	.gain_min = -31750,
+	.gain_max = 0,
+	.gain_step = -250,
+	.num_channels = 1,
+};
+
 static const struct ad8366_info adrf5720_chip_info = {
 	.name = "adrf5720",
 	.gain_min = -31500,
@@ -337,6 +355,8 @@ static const struct spi_device_id ad8366_id[] = {
 	{ "ad8366", (kernel_ulong_t)&ad8366_chip_info },
 	{ "ada4961", (kernel_ulong_t)&ada4961_chip_info },
 	{ "adl5240", (kernel_ulong_t)&adl5240_chip_info },
+	{ "adrf5702", (kernel_ulong_t)&adrf5702_chip_info },
+	{ "adrf5703", (kernel_ulong_t)&adrf5703_chip_info },
 	{ "adrf5720", (kernel_ulong_t)&adrf5720_chip_info },
 	{ "adrf5730", (kernel_ulong_t)&adrf5730_chip_info },
 	{ "adrf5731", (kernel_ulong_t)&adrf5731_chip_info },
@@ -353,6 +373,8 @@ static const struct of_device_id ad8366_of_match[] = {
 	{ .compatible = "adi,ad8366", .data = &ad8366_chip_info },
 	{ .compatible = "adi,ada4961", .data = &ada4961_chip_info },
 	{ .compatible = "adi,adl5240", .data = &adl5240_chip_info },
+	{ .compatible = "adi,adrf5702", .data = &adrf5702_chip_info },
+	{ .compatible = "adi,adrf5703", .data = &adrf5703_chip_info },
 	{ .compatible = "adi,adrf5720", .data = &adrf5720_chip_info },
 	{ .compatible = "adi,adrf5730", .data = &adrf5730_chip_info },
 	{ .compatible = "adi,adrf5731", .data = &adrf5731_chip_info },

-- 
2.43.0


