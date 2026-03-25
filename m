Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A5016A956;
	Wed, 25 Mar 2026 11:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774437145; cv=none; b=PVOqAndpC7yISTObDt5ddIAGcMzWybNx5ULUj7r6PaqG08rsNuoNXaMMkODB3dHHoxlL5hrnRbzf9ipHCD4Ic9srpisr0a5pTOBwilHn+1WR64xkmJQoj9M85m4baJnzSzENmCDMK01M94cTm3M8vjh7y66etmI1TRkAC+FJKjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774437145; c=relaxed/simple;
	bh=v1y5m4SGLtIgpA6R72CXUvsNNMHPFRUQdZtH3CuzF60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pL9bYhyY/0Y3mcukyArgvS5E6L56LGElhsNffTXL251CM+YdyCRD6zKGm5cvdshrpzg6eSM8f4KXt1hPhloT9Y5MbD9sYMKO4Atv4TptXh3jdPd+cuC+/9zZ2r2KkIbP0qalgm3A+aV2bGg63PvYanlKrw+zT5nIK417eF264nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0ob1MNs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0ob1MNs"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F288CC2BCB0;
	Wed, 25 Mar 2026 11:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774437145;
	bh=v1y5m4SGLtIgpA6R72CXUvsNNMHPFRUQdZtH3CuzF60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=p0ob1MNshvCefh2W0rwRDSn4lcR26R7SXo1G+mgHHMBCMDqWjbtQt1AIWh6S3Hyfp
	 o0++lLG3s4u7PMUilLnVp2zplbqQZH+tppgf1Ocp9nwK8DZLofGQXfyyYZ3V0oa0yr
	 qiTZqVMdqO4jzNVG+QP/OQ7XMdiCpga9L+lSduKS14Gd4T2bBUwQ+eH8i4Xo8J5gae
	 q4gLVGsYgmyJbV6mllxo4RZ+eBzSFnAKiZ8OWIkw0qAeawiGzwxuV+qYpaw8HGlZlc
	 n0/XhQ8T5tRaUOaYeJUs76uYlnje1d1gG8U8eEyu7fXT+X4pXihEMe2MtnFOkzJJKs
	 GNWqvL1gbBZ+Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2EC7103A9AB;
	Wed, 25 Mar 2026 11:12:24 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 25 Mar 2026 11:12:03 +0000
Subject: [PATCH 2/2] iio: amplifiers: ad8366: add support for adrf5702/3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-adrf570x-iio-support-v1-2-9a2685eb2e55@analog.com>
References: <20260325-adrf570x-iio-support-v1-0-9a2685eb2e55@analog.com>
In-Reply-To: <20260325-adrf570x-iio-support-v1-0-9a2685eb2e55@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774437143; l=3508;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=AsNs5tyHtb0PShFN/SAT4QMGDo6HOT+KvogC5g2UCX8=;
 b=2+oY5DPNo4WEC+olLvftCchq99Nj6592+xVQpUbXn3yDSbD5KE4kh7b45GuQaUI6OWfOrcHzl
 yY9QCHxPnZ4BNXXGS9xpE4YBGEynpu22KBe9wVgDCN1gs0cKd3Wohum
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add chip info structs and device table entries for ADRF5702 and ADRF5703
Digital Step Attenuators.

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


