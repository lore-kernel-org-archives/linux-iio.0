Received: from mail.imp.bg.ac.rs (mail.imp.bg.ac.rs [147.91.50.100])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE5140DFBF;
	Tue, 10 Mar 2026 15:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=147.91.50.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773156593; cv=none; b=MeZ69SsE7VuGN6TeUgtE1w3lxM1SEZNECH/9CKS2H43jmahG6DE/yrb8JVRGbR03zcebSmXTRVAefDzH+4xz1PeBHB4iJ30vmKd1czU2zN01SiR9cPFaoNrmEQTLEKT2XtiNh9yYn58dYWL0vC4uYHje3C0qJAm0kYgAs1whYIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773156593; c=relaxed/simple;
	bh=CsrGp59lJi1S7TXNeA7D4Mwfq7dbJtBYPzpTxQ+wkFs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=OUQoczQVNK8olBehbCNg0miA10g9hctEAnYe/6oCCPDb7FFiJgp350ubzQkmOhBnA1R1/hyGrlDh8FmB/+E84I+3wWpVtgMXy4OY7JRo8Trq5+4oxwVqwHxjQlkWLCVwFFU20tzCQuwdQYIXLY848nny7R9vaxrowK3UwnUs/x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pupin.rs; spf=pass smtp.mailfrom=pupin.rs; dkim=pass (1024-bit key) header.d=pupin.rs header.i=@pupin.rs header.b=daYYB8/2; arc=none smtp.client-ip=147.91.50.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pupin.rs
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pupin.rs
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pupin.rs header.i=@pupin.rs header.b="daYYB8/2"
Received: from localhost (localhost [127.0.0.1])
	by mail.imp.bg.ac.rs (Postfix) with ESMTP id 4D753140C6790;
	Tue, 10 Mar 2026 16:29:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pupin.rs; h=
	content-transfer-encoding:content-type:content-type:organization
	:message-id:references:in-reply-to:subject:subject:from:from
	:date:date:mime-version:received:received:received; s=
	dkim20260301; t=1773156588; bh=CsrGp59lJi1S7TXNeA7D4Mwfq7dbJtBYP
	zpTxQ+wkFs=; b=daYYB8/2OqAR4snMS8jz2szRMj0EKVANuBNyx0c6+LdR0oIzu
	b3vBp0g9+4GGRt0Zd3HLw9ceSvvpOhOmXhIAmMuEjfcye/2+znAFxN8tfUeVTDpM
	eJcEj3aMSh4VxCYlZgGD+m4ygVrnKu/LqfP27G80Zz0i1BGrtGRoznI9F0=
X-Virus-Scanned: amavis at imp.bg.ac.rs
Received: from mail.imp.bg.ac.rs ([127.0.0.1])
 by localhost (mail.imp.bg.ac.rs [127.0.0.1]) (amavis, port 10024) with LMTP
 id heLFrbcVhbNf; Tue, 10 Mar 2026 16:29:48 +0100 (CET)
X-Comment: SPF check N/A for local connections - client-ip=147.91.50.99; helo=webmail.imp.bg.ac.rs; envelope-from=david.marinovic@pupin.rs; receiver=jic23@kernel.org 
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.imp.bg.ac.rs 2FBB3140C678E
Received: from webmail.imp.bg.ac.rs (webmail.imp.bg.ac.rs [147.91.50.99])
	by mail.imp.bg.ac.rs (Postfix) with ESMTP id 2FBB3140C678E;
	Tue, 10 Mar 2026 16:29:48 +0100 (CET)
Received: from unknown (unknown [147.91.52.213]) by webmail.imp.bg.ac.rs
 (Roundcube webmail) with HTTP; Tue, 10 Mar 2026 16:29:48 +0100 CET
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Mar 2026 16:29:48 +0100
From: =?UTF-8?Q?David_Marinovi=C4=87?= <david.marinovic@pupin.rs>
To: jic23@kernel.org
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iio: dac: ltc2632: add support for LTC2654 DAC family
In-Reply-To: <5d4fb8998d9634c3e5a8ed17b80dae07@pupin.rs>
References: <5d4fb8998d9634c3e5a8ed17b80dae07@pupin.rs>
Message-ID: <82ba84f98db9c32d3fc4efd7ef6697a2@pupin.rs>
X-Sender: david.marinovic@pupin.rs
Organization: IMPT
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit


Add support for the Linear Technology LTC2654 quad DAC family.
The LTC2654 is a 4-channel, 16-/12-bit DAC with SPI interface,
sharing the same 24-bit SPI protocol as the existing LTC2632/
LTC2634/LTC2636 devices supported by this driver.

Add support for the following variants:
- LTC2654L-16: 16-bit, 2.5V internal reference
- LTC2654L-12: 12-bit, 2.5V internal reference
- LTC2654H-16: 16-bit, 4.096V internal reference
- LTC2654H-12: 12-bit, 4.096V internal reference

Signed-off-by: David Marinovic <david.marinovic@pupin.rs>
---
  drivers/iio/dac/ltc2632.c | 47 ++++++++++++++++++++++++++++++++++++---
  1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ltc2632.c b/drivers/iio/dac/ltc2632.c
index 105f939f7e54..05d3bf65399f 100644
--- a/drivers/iio/dac/ltc2632.c
+++ b/drivers/iio/dac/ltc2632.c
@@ -67,6 +67,10 @@ enum ltc2632_supported_device_ids {
         ID_LTC2636H12,
         ID_LTC2636H10,
         ID_LTC2636H8,
+       ID_LTC2654L16,
+       ID_LTC2654L12,
+       ID_LTC2654H16,
+       ID_LTC2654H12
  };

  static int ltc2632_spi_write(struct spi_device *spi,
@@ -79,8 +83,8 @@ static int ltc2632_spi_write(struct spi_device *spi,
          * The input shift register is 24 bits wide.
          * The next four are the command bits, C3 to C0,
          * followed by the 4-bit DAC address, A3 to A0, and then the
-        * 12-, 10-, 8-bit data-word. The data-word comprises the 12-,
-        * 10-, 8-bit input code followed by 4, 6, or 8 don't care bits.
+        * 16-, 12-, 10-, 8-bit data-word. The data-word comprises the
+        * 16-, 12-, 10-, 8-bit input code followed by 0, 4, 6, or 8 
don't care bits.
          */
         data = (cmd << 20) | (addr << 16) | (val << shift);
         put_unaligned_be24(data, &msg[0]);
@@ -206,6 +210,7 @@ static const struct iio_chan_spec_ext_info 
ltc2632_ext_info[] = {
                 LTC2632_CHANNEL(7, _bits), \
         }

+static DECLARE_LTC2632_CHANNELS(ltc2632x16, 16);
  static DECLARE_LTC2632_CHANNELS(ltc2632x12, 12);
  static DECLARE_LTC2632_CHANNELS(ltc2632x10, 10);
  static DECLARE_LTC2632_CHANNELS(ltc2632x8, 8);
@@ -301,6 +306,26 @@ static const struct ltc2632_chip_info 
ltc2632_chip_info_tbl[] = {
                 .num_channels   = 8,
                 .vref_mv        = 4096,
         },
+       [ID_LTC2654L16] =  {
+               .channels       = ltc2632x16_channels,
+               .num_channels   = 4,
+               .vref_mv        = 2500,
+       },
+       [ID_LTC2654L12] = {
+               .channels       = ltc2632x12_channels,
+               .num_channels   = 4,
+               .vref_mv        = 2500,
+       },
+       [ID_LTC2654H16] = {
+               .channels       = ltc2632x16_channels,
+               .num_channels   = 4,
+               .vref_mv        = 4096,
+       },
+       [ID_LTC2654H12] =  {
+               .channels       = ltc2632x12_channels,
+               .num_channels   = 4,
+               .vref_mv        = 4096,
+       },
  };

  static int ltc2632_probe(struct spi_device *spi)
@@ -372,6 +397,10 @@ static const struct spi_device_id ltc2632_id[] = {
         { "ltc2636-h12", 
(kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636H12] },
         { "ltc2636-h10", 
(kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636H10] },
         { "ltc2636-h8", 
(kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636H8] },
+       { "ltc2654-l16", 
(kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2654L16] },
+       { "ltc2654-l12", 
(kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2654L12] },
+       { "ltc2654-h16", 
(kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2654H16] },
+       { "ltc2654-h12", 
(kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2654H12] },
         { }
  };
  MODULE_DEVICE_TABLE(spi, ltc2632_id);
@@ -431,6 +460,18 @@ static const struct of_device_id ltc2632_of_match[] 
= {
         }, {
                 .compatible = "lltc,ltc2636-h8",
                 .data = &ltc2632_chip_info_tbl[ID_LTC2636H8]
+       }, {
+               .compatible = "lltc,ltc2654-l16",
+               .data = &ltc2632_chip_info_tbl[ID_LTC2654L16]
+       }, {
+               .compatible = "lltc,ltc2654-l12",
+               .data = &ltc2632_chip_info_tbl[ID_LTC2654L12]
+       }, {
+               .compatible = "lltc,ltc2654-h16",
+               .data = &ltc2632_chip_info_tbl[ID_LTC2654H16]
+       }, {
+               .compatible = "lltc,ltc2654-h12",
+               .data = &ltc2632_chip_info_tbl[ID_LTC2654H12]
         },
         { }
  };
@@ -447,5 +488,5 @@ static struct spi_driver ltc2632_driver = {
  module_spi_driver(ltc2632_driver);

  MODULE_AUTHOR("Maxime Roussin-Belanger 
<maxime.roussinbelanger@gmail.com>");
-MODULE_DESCRIPTION("LTC2632 DAC SPI driver");
+MODULE_DESCRIPTION("LTC2632/LTC2654 DAC SPI driver");
  MODULE_LICENSE("GPL v2");
--
2.50.1




-------- Original Message --------
Subject: [PATCH 0/2] iio: dac: ltc2632: add support for LTC2654 DAC 
family
Date: 10.03.2026 16:27
 From: David Marinović <david.marinovic@pupin.rs>
To: jic23@kernel.org

This patch series adds support for the Linear Technology LTC2654
quad DAC family to the existing ltc2632 driver.

The LTC2654 shares the same 24-bit SPI protocol as the existing
LTC2632/2634/2636 devices, requiring minimal additions to the
driver.

The LTC2654L-16 variant has been tested on a Phytec phyCORE-STM32MP1
board with the DAC connected via SPI1. The driver probes successfully
and all 4 channels are accessible via the IIO sysfs interface.

Patch 1 adds the driver support.
Patch 2 updates the DT bindings documentation.

David Marinovic (2):
   iio: dac: ltc2632: add support for LTC2654 DAC family
   dt-bindings: iio: dac: ltc2632: add LTC2654 compatible strings

Signed-off-by: David Marinovic <david.marinovic@pupin.rs>
