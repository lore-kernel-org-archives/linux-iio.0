Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=91.99.108.219
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794904900;
	b=hS7ZM7I/vPtN+93FN6msCLrsyY8tRapoVhhSh659JBNjOWBw1eVwr+qEeA7dul/BsLXa
	 Uy7TRgpR8SsunCWKf/iglBcpSX0xs4D5Y1kRaPfmkS6XJUZ5EGUZLwtMx3m6ESH0ackT9
	 5vLUAQ9c+dREsGR5KQBYTnOwK3/u9UmRm93pKWrRVR5eF6Q2TxpIzcQJGBSvYpNZZdlJK
	 1dPfkp5VK8HKx9PZdWonbb8hSGu++1pVRKPTVPM8vsf2w19mTkBuhtaVW8ruKRBTWfUil
	 LLosip9Me9sBoD+QUH00uTjkZJ9HdJFIwvwkTbu4mKN11ACoIbNec7MVofDqdE4ch5w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794904900;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=H9je0lU4+ntBTXv39mm93LUN3Jyv/9j/FoEJztnH290=;
	b=nhxfn/N5t4B/L624vEzdcrUCt1o7yxPq7cMsuB9O3l9VgBKR522vVId7XJi4nWykPxRU
	 lI4Y+rP6JrS4BhYFBfct4oN3GtWqqIvdLS18vh3hHYuMGWCi4nSSnZBl0ewb61yzi8rmY
	 wOEJ+T2LsxYN+smDU0kGAJd6tXclrNMiA2B+g0C9/llBZsYc6ycBQhYYgD9TY22oSrh6A
	 g4/YLA4VDtA3y8Bi7YOF4Mhvfs+scDMBcQE8ldoHzYSiVZaQuTURQxpgVH6kT1KOC68Pf
	 9zhXRBfdqDFTQ58cWAew98bAO64rRmhcN/8I80s65xrd5XwC9i7YBTVgzjZA1yZJN1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=catcrafts.net;
	spf=pass smtp.mailfrom=catcrafts.net;
	dkim=pass header.d=catcrafts.net header.i=@catcrafts.net header.a=rsa-sha256 header.s=mail2026 header.b=aQofHHF3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=91.99.108.219
Received: from mail.catcrafts.net (mail.catcrafts.net [91.99.108.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9CC606A894;
	Tue, 17 Nov 2026 08:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF9CC606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=catcrafts.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=catcrafts.net header.i=@catcrafts.net header.a=rsa-sha256 header.s=mail2026 header.b=aQofHHF3
Received: from jorijnpc (unknown [87.215.145.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail.catcrafts.net (Postfix) with ESMTPSA id 18246FA9F6;
	Tue, 17 Nov 2026 08:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=catcrafts.net;
	s=mail2026; t=1794904890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9je0lU4+ntBTXv39mm93LUN3Jyv/9j/FoEJztnH290=;
	b=aQofHHF3y4gXLjus16EXmEcn0OEDrRg4km5CkqxMb9jhrEZ1YxW7r1TNKdFJrt/g21KioN
	78ALX782bZZeZ42DUGA0O3hV56PFr48JnTQJupbgla/hkyUdqeWM1MfojTCt44ATbvJPIG
	rjBfURZ04nDXJZg5RKhOKCxe0DGtLrJ2yxKwEfiV8BTwMH6t5uRRnoSW/xSYc9GixoFSgX
	00iVEhi6dka4ZW5EoaAICDePwpGQPBryjzIsmvE3KRdwJFYycDpijtOmJqWdXGaK3Zn0za
	TFlT7OD96R7g1SruV3P4Xs3VG/Miag+IRwq8J3x6j6LB/kr6t8kRdGUt473lNw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=jorijnvdgraaf@catcrafts.net smtp.mailfrom=jorijnvdgraaf@catcrafts.net
ARC-Seal: i=1; s=mail2026; d=catcrafts.net; t=1794904890; a=rsa-sha256;
	cv=none;
	b=bytWCVzhFKQnz5RHVTt9mKSqVM9aGV2VttS4UOKM9S0PhVOF/HrmE5bCPm/EFMSzgEBks6
	2L0oK1z02P7fQ0W085XbZFyG9/Ua9qLytXh8Yp26BeluJetVF352Ujk1LVaIU/3mD0Ji/7
	z7fO3lwTXV4+O3gjpEQR+CVCIAjYvgpbgvDeBCv+jwLpJl3BQgFuV5nuux1KcpKrZLQLPZ
	uVgeq946PaxrYk3TLWnKz5AJ/u2eS/bVttcNaamH7VuDLcZv8hfgPCHfSSiL4JJ9I731DK
	TmAkXCL41t0zXWap4vC9QnKEZ1OTtyNAXqsZIRxnC2lEHwHwIWDPfTmoFdc4bQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=jorijnvdgraaf@catcrafts.net smtp.mailfrom=jorijnvdgraaf@catcrafts.net
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=catcrafts.net;
	s=mail2026; t=1794904890;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9je0lU4+ntBTXv39mm93LUN3Jyv/9j/FoEJztnH290=;
	b=cq57s59gujIH8NeBwNruqlzF4nhsLT9BEBClF/dTyKyGrjP7tors+6+orkKeEi8Dzr7BC7
	jW0AWgBI8eGBZTYr03gmuUnxhPHbdj/ORfU01tTrM49KNvYpkOp2S23OaGLL6Y7Ruo8Su8
	tnVn9uzBbnXt9Lu7JkDKyiYV33qJLqM+imR2ykH9FjgOSgCLfcEOeqBjzc7jQmosdwIS9G
	QUep5/D9XlxdRHKrMTC5RNMwHSMjTNc9T/5SekOQIG8H/3Hf85raJnMKQEtKkn37xWrMAi
	i2i7xb9wXKruBWWYfSoUpz6zBvlfEQyJePicmJnqqiOq1dm9Bxlk8CYW7ZSvPA==
From: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Eddie James <eajames@linux.ibm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Joshua Crofts <crofts@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>,
	Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Subject: [PATCH 3/3] iio: pressure: dps310: add Goermicro SPL07-003 support
Date: Tue, 17 Nov 2026 09:39:54 +0100
Message-ID: <20261117083954.335814-4-jorijnvdgraaf@catcrafts.net>
In-Reply-To: <20261117083954.335814-1-jorijnvdgraaf@catcrafts.net>
References: <20261117083954.335814-1-jorijnvdgraaf@catcrafts.net>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The Goermicro SPL07-003 needs what the ZTS8032 chip data already
describes: c31 and c40 in the pressure polynomial, and TMP_CFG bit 7, a
rate bit on this chip too, left clear. Its TMP_EXT is MEAS_CFG bit 3 and
stays at the reset value, the internal sensor the datasheet recommends.

Its c31 and c40 are 12 bit values packed into 0x22-0x24, where the
ZTS8032 has 16 bit values in 0x22-0x25, so the coefficient block is 21
bytes. Add a chip flag for that layout, the chip data and the I2C and OF
IDs.

Tested on a Fairphone (Gen. 6). The DPS310 temperature workaround skips
this unit: bit 1 of register 0x32 is set.

Datasheet: https://media.digikey.com/pdf/Data%20Sheets/Goertek%20Microelectronics%20PDFs/SPL07-003.pdf
Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
---
 drivers/iio/pressure/Kconfig  |  1 +
 drivers/iio/pressure/dps310.c | 32 ++++++++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
index ffd072e4bb8f..26bbfe944980 100644
--- a/drivers/iio/pressure/Kconfig
+++ b/drivers/iio/pressure/Kconfig
@@ -116,6 +116,7 @@ config DPS310
 	select IIO_TRIGGERED_BUFFER
 	help
 	  Support for the following digital barometric pressure sensors:
+	  - Goermicro SPL07-003
 	  - Infineon DPS310
 	  - Zilltek ZTS8032
 	  They can be accessed over I2C bus.
diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 5cee23986f30..22ed88d17926 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -9,6 +9,11 @@
  * calibration coefficients (c31, c40) and temperature calibrated against
  * the internal sensor.
  *
+ * The Goermicro SPL07-003 has c31 and c40 too, as 12 bit values, and its
+ * datasheet recommends the internal temperature sensor.
+ *
+ * https://media.digikey.com/pdf/Data%20Sheets/Goertek%20Microelectronics%20PDFs/SPL07-003.pdf
+ *
  * Temperature calculation:
  *   c0 * 0.5 + c1 * T_raw / kT °C
  */
@@ -71,6 +76,7 @@
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
 #define DPS310_COEF_LEN		18
+#define SPL07_COEF_LEN		21
 #define ZTS8032_COEF_LEN	22
 
 #define MAX_COEF_LEN		22
@@ -115,6 +121,7 @@ struct dps310_chip_info {
 	bool coef_for_ext_sensor;
 	u8 coef_len;
 	bool has_c31_c40;
+	bool c31_c40_12bit;
 };
 
 static const struct dps310_chip_info dps310_chip_info = {
@@ -123,6 +130,14 @@ static const struct dps310_chip_info dps310_chip_info = {
 	.coef_len = DPS310_COEF_LEN,
 };
 
+static const struct dps310_chip_info spl07_chip_info = {
+	.name = "spl07-003",
+	.coef_for_ext_sensor = false,
+	.coef_len = SPL07_COEF_LEN,
+	.has_c31_c40 = true,
+	.c31_c40_12bit = true,
+};
+
 static const struct dps310_chip_info zts8032_chip_info = {
 	.name = "zts8032",
 	.coef_for_ext_sensor = false,
@@ -234,8 +249,8 @@ static int dps310_get_coefs(struct dps310_data *data)
 
 	/*
 	 * Calculate pressure calibration coefficients. c00 and c10 are 20 bit
-	 * 2's complement numbers, while the rest are 16 bit 2's complement
-	 * numbers.
+	 * 2's complement numbers, while c01, c11, c20, c21 and c30 are 16 bit
+	 * 2's complement numbers.
 	 */
 	c00 = (coef[3] << 12) | (coef[4] << 4) | (coef[5] >> 4);
 	data->c00 = sign_extend32(c00, 19);
@@ -258,7 +273,14 @@ static int dps310_get_coefs(struct dps310_data *data)
 	c30 = (coef[16] << 8) | coef[17];
 	data->c30 = sign_extend32(c30, 15);
 
-	if (data->info->has_c31_c40) {
+	if (!data->info->has_c31_c40)
+		return 0;
+
+	if (data->info->c31_c40_12bit) {
+		/* Two 12 bit values in three bytes, like c0 and c1 */
+		data->c31 = sign_extend32(get_unaligned_be16(&coef[18]) >> 4, 11);
+		data->c40 = sign_extend32(get_unaligned_be16(&coef[19]), 11);
+	} else {
 		data->c31 = sign_extend32(get_unaligned_be16(&coef[18]), 15);
 		data->c40 = sign_extend32(get_unaligned_be16(&coef[20]), 15);
 	}
@@ -810,7 +832,7 @@ static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 
 	/*
 	 * Section 4.9.1 of the DPS310 spec, Horner form to avoid overflow.
-	 * c40 and c31 are ZTS8032 only and zero on the DPS310.
+	 * c40 and c31 are zero on the DPS310.
 	 */
 	if (!dps310_horner_step(&prs, data->c40, p, kp) ||
 	    !dps310_horner_step(&prs, data->c30, p, kp) ||
@@ -1495,12 +1517,14 @@ static int dps310_probe(struct i2c_client *client)
 
 static const struct i2c_device_id dps310_id[] = {
 	{ .name = "dps310", .driver_data = (kernel_ulong_t)&dps310_chip_info },
+	{ .name = "spl07-003", .driver_data = (kernel_ulong_t)&spl07_chip_info },
 	{ .name = "zts8032", .driver_data = (kernel_ulong_t)&zts8032_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, dps310_id);
 
 static const struct of_device_id dps310_of_match[] = {
+	{ .compatible = "goermicro,spl07-003", .data = &spl07_chip_info },
 	{ .compatible = "infineon,dps310", .data = &dps310_chip_info },
 	{ .compatible = "zilltek,zts8032", .data = &zts8032_chip_info },
 	{ }
-- 
2.56.0

