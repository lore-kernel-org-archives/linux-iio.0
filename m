Received: from mail.imp.bg.ac.rs (mail.imp.bg.ac.rs [147.91.50.100])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2AF3D9DDB;
	Wed, 18 Mar 2026 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.91.50.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773842750; cv=none; b=e2Gpy+eIPAHLc1HLcZq3LZNVG1+jUWVo0QRcxfKoGeVuC6xhUglbprlmHIQ5qkYA/DZher4JB3ri2RpXu8rY1GLb5gUG9oV2VVKbI21mWnl2eDcpabPzhkn7zcUdZDiCjGQ+Iul9gNEQLTT534SNmX/16qLkBlekQ2AfGJVAv78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773842750; c=relaxed/simple;
	bh=loLZF4fYQRx0NkUM71EwF8pagBw4U43XimK/P5ZgcyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKsI8aZpj/b0keNBiCpJbWGU4gsQmDb6f3CMVBmCRH50XNAVE/F40162+W8uwVG/Tt8TwT0uFtUVu1IxA0jjP6JEhF9TIQ5e4zoZbE7o2UAcTqiCz7Xgy68mmGkL/8Pv3GBhuIgZHcyLv09N3h4wh0QKvBCpVRQ3kqKHMp0ki/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pupin.rs; spf=pass smtp.mailfrom=pupin.rs; dkim=pass (1024-bit key) header.d=pupin.rs header.i=@pupin.rs header.b=GS3Hlr39; arc=none smtp.client-ip=147.91.50.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pupin.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pupin.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pupin.rs header.i=@pupin.rs header.b="GS3Hlr39"
Received: from localhost (localhost [127.0.0.1])
	by mail.imp.bg.ac.rs (Postfix) with ESMTP id 201B6140C271C;
	Wed, 18 Mar 2026 14:57:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pupin.rs; h=
	content-transfer-encoding:mime-version:references:in-reply-to
	:x-mailer:message-id:date:date:subject:subject:from:from
	:received:received; s=dkim20260301; t=1773842268; bh=loLZF4fYQRx
	0NkUM71EwF8pagBw4U43XimK/P5ZgcyQ=; b=GS3Hlr39gG8A9u2+QbxB0ZGmStg
	oOFX13x/+52DQe42OtSoI9O6rTBxfgrombqT0TOhQSVEK93gokmMDGPWfcMFWeKQ
	lxWlOf+GjEmWQaO20GLeUTxc6q2+v+bFciJZiKCEhO+ne8GeXjYXlvWt6MvvB/pr
	lmIDLgSIH+c4x3FI=
X-Virus-Scanned: amavis at imp.bg.ac.rs
Received: from mail.imp.bg.ac.rs ([127.0.0.1])
 by localhost (mail.imp.bg.ac.rs [127.0.0.1]) (amavis, port 10024) with LMTP
 id 6DueaU1mUuWE; Wed, 18 Mar 2026 14:57:48 +0100 (CET)
X-Comment: SPF check N/A for local connections - client-ip=147.91.52.78; helo=phyvm-virtualbox; envelope-from=david.marinovic@pupin.rs; receiver=jic23@kernel.org 
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.imp.bg.ac.rs E3006140C272A
Received: from phyvm-VirtualBox (unknown [147.91.52.78])
	by mail.imp.bg.ac.rs (Postfix) with ESMTPS id E3006140C272A;
	Wed, 18 Mar 2026 14:57:47 +0100 (CET)
From: =?UTF-8?q?David=20Marinovi=C4=87?= <david.marinovic@pupin.rs>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Marinovic <david.marinovic@pupin.rs>
Subject: [PATCH 3/3] iio: dac: ltc2632: add support for LTC2654 DAC family
Date: Wed, 18 Mar 2026 14:57:32 +0100
Message-ID: <20260318135736.91564-4-david.marinovic@pupin.rs>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260318135736.91564-1-david.marinovic@pupin.rs>
References: <5d4fb8998d9634c3e5a8ed17b80dae07@pupin.rs>
 <20260318135736.91564-1-david.marinovic@pupin.rs>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Marinovic <david.marinovic@pupin.rs>

Add support for the Linear Technology LTC2654 quad DAC family.
The LTC2654 is a 4-channel, 16-/12-bit DAC with SPI interface,
sharing the same 24-bit SPI protocol as the existing LTC2632/
LTC2634/LTC2636 devices supported by this driver.

The LTC2654L-16 variant has been tested on a Phytec phyCORE-STM32MP1
board with the DAC connected via SPI1. The driver probes successfully
and all 4 channels are accessible via the IIO sysfs interface.

Add support for the following variants:
- LTC2654L-16: 16-bit, 2.5V internal reference
- LTC2654L-12: 12-bit, 2.5V internal reference
- LTC2654H-16: 16-bit, 4.096V internal reference
- LTC2654H-12: 12-bit, 4.096V internal reference

Signed-off-by: David Marinovic <david.marinovic@pupin.rs>
---
 drivers/iio/dac/ltc2632.c | 40 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index ca0b88285ce5..c84a7e314f08 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -58,8 +58,9 @@ static int ltc2632_spi_write(struct spi_device *spi,
 	 * The input shift register is 24 bits wide.
 	 * The next four are the command bits, C3 to C0,
 	 * followed by the 4-bit DAC address, A3 to A0, and then the
-	 * 12-, 10-, 8-bit data-word. The data-word comprises the 12-,
-	 * 10-, 8-bit input code followed by 4, 6, or 8 don't care bits.
+	 * 16-, 12-, 10-, 8-bit data-word. The data-word comprises the
+	 * 16-, 12-, 10-, 8-bit input code followed by 0, 4, 6, or 8
+	 * don't care bits.
 	 */
 	data = (cmd << 20) | (addr << 16) | (val << shift);
 	put_unaligned_be24(data, &msg[0]);
@@ -185,6 +186,7 @@ static const struct iio_chan_spec_ext_info ltc2632_ext_info[] = {
 		LTC2632_CHANNEL(7, _bits), \
 	}
 
+static DECLARE_LTC2632_CHANNELS(ltc2632x16, 16);
 static DECLARE_LTC2632_CHANNELS(ltc2632x12, 12);
 static DECLARE_LTC2632_CHANNELS(ltc2632x10, 10);
 static DECLARE_LTC2632_CHANNELS(ltc2632x8, 8);
@@ -297,6 +299,30 @@ static const struct ltc2632_chip_info ltc2636h8_chip_info = {
 	.vref_mv	= 4096,
 };
 
+static const struct ltc2632_chip_info ltc2654l16_chip_info = {
+	.channels	= ltc2632x16_channels,
+	.num_channels	= 4,
+	.vref_mv	= 2500,
+};
+
+static const struct ltc2632_chip_info ltc2654l12_chip_info = {
+	.channels	= ltc2632x12_channels,
+	.num_channels	= 4,
+	.vref_mv	= 2500,
+};
+
+static const struct ltc2632_chip_info ltc2654h16_chip_info = {
+	.channels	= ltc2632x16_channels,
+	.num_channels	= 4,
+	.vref_mv	= 4096,
+};
+
+static const struct ltc2632_chip_info ltc2654h12_chip_info = {
+	.channels	= ltc2632x12_channels,
+	.num_channels	= 4,
+	.vref_mv	= 4096,
+};
+
 static int ltc2632_probe(struct spi_device *spi)
 {
 	struct ltc2632_state *st;
@@ -366,6 +392,10 @@ static const struct spi_device_id ltc2632_id[] = {
 	{ "ltc2636-h12", (kernel_ulong_t)&ltc2636h12_chip_info },
 	{ "ltc2636-h10", (kernel_ulong_t)&ltc2636h10_chip_info },
 	{ "ltc2636-h8",  (kernel_ulong_t)&ltc2636h8_chip_info  },
+	{ "ltc2654-l16", (kernel_ulong_t)&ltc2654l16_chip_info },
+	{ "ltc2654-l12", (kernel_ulong_t)&ltc2654l12_chip_info },
+	{ "ltc2654-h16", (kernel_ulong_t)&ltc2654h16_chip_info },
+	{ "ltc2654-h12", (kernel_ulong_t)&ltc2654h12_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ltc2632_id);
@@ -389,6 +419,10 @@ static const struct of_device_id ltc2632_of_match[] = {
 	{ .compatible = "lltc,ltc2636-h12", .data = &ltc2636h12_chip_info },
 	{ .compatible = "lltc,ltc2636-h10", .data = &ltc2636h10_chip_info },
 	{ .compatible = "lltc,ltc2636-h8",  .data = &ltc2636h8_chip_info  },
+	{ .compatible = "lltc,ltc2654-l16", .data = &ltc2654l16_chip_info },
+	{ .compatible = "lltc,ltc2654-l12", .data = &ltc2654l12_chip_info },
+	{ .compatible = "lltc,ltc2654-h16", .data = &ltc2654h16_chip_info },
+	{ .compatible = "lltc,ltc2654-h12", .data = &ltc2654h12_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ltc2632_of_match);
@@ -404,5 +438,5 @@ static struct spi_driver ltc2632_driver = {
 module_spi_driver(ltc2632_driver);
 
 MODULE_AUTHOR("Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>");
-MODULE_DESCRIPTION("LTC2632 DAC SPI driver");
+MODULE_DESCRIPTION("LTC2632/LTC2654 DAC SPI driver");
 MODULE_LICENSE("GPL v2");
-- 
2.50.1

