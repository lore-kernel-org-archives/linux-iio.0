Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795367807;
	b=eWmj6LNOiOF/z8z0yDrolsVB07fhzl5QFVt5+Hl7qE5dw1WBILWZOvApM2pA717btt7F
	 rZ8aPbD8o7ogSMfaZhjZB4OoWPPpILUP7yWrUUsN/XSxWcjnjmDbYl1fmjge2Nc+joLSG
	 vKFgv0M4TPsqUsI/CGJrmsjlQjcUbKtDOSibZZp+N02DSfsXX+1OmHusA9OM+lErITSOT
	 z6tvfKz1H6qm2Ng3nue8rdKfbmS/uswQLo20jGI1eZj0iSa5emt8wkGz4tkU7wHHp3vhU
	 QvTMWLIwkfTjEtmWOW49i2esLeJQ9VKSE3ACgn9Z5wgM3cLw/M/b4n7LdEySpB2oyiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795367807;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vhgz+iXG+urC0DlryxtVmZDNjZwOyHtUcSI6Pec5kmA=;
	b=bKLa4cu2bKXgv79wjxeFMN0gkZU2YupGHUcE8EGMlW0+DAwZS7o8aMcxobn9YuKz5wJo
	 QeNJS5GitRo3ZLma0kEVXMnYB3c4QOttzfnetv8Cb057Dh6uvo1i1lCB0qUCvpxWWuvtt
	 /CenD18fY4r5Dg3cv2/x8pmKgXtY1X/Ird1VgCQKHBA4WuNEvo8QMkc3PqtdKPhAFizZE
	 VyYjh2U++kwq2Q8fBfeW7WHEXrlOoPyorYusmSiat06TvvNLt74AfKB73NADWKm3EBNAb
	 b3i3Y1NS0opXM6VETEFpmeN7VMIvIe2IDUAU0I11T23kPchb+a03BHuqZ94LfeaJ3aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6H4qbSH;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC37F606A33C;
	Sun, 22 Nov 2026 17:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W6H4qbSH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795367807;
	b=bMmWEDqOs2sUOZkeVBcA7VGecI9nhfRcNufbSvDxWGvBobbeq6xrDqtZOfbz9vl2mCuC
	 gw2SFpqLLAxtPl4cfCJhsLqRMUL2gzbiqNds2p3W3FLAI5OFcc7znX6JbQ4KmZokGReP3
	 8dilYODIhVA2AmFfzktXhxcIFoxukvC8uIoHXJ586Ikx9Eub46M58HiTVJ2a05aWLEXoe
	 mX9CPqKP1qwJBWbU763gD+xWI6xX/FnTQGFs9ZRsJTV9gbPggBoX3p+laE771OjQuUxmr
	 wFeUGbuFdVLOvOffOjPNOLfPN460qbtEw261A8OwZH8jI7sbQPoF+DwIiJv8tHgaaeg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795367807;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vhgz+iXG+urC0DlryxtVmZDNjZwOyHtUcSI6Pec5kmA=;
	b=AaEHcGgvhthFjeToW3zSLj61CKIbXyVTjwfCo8JeR4xW0i0LSrT7uDx/4GomNLjMdv5P
	 recmLM1MUkdaHX4Ri0fwVw1Emv9AH5+5+K7Pw+PtB72lKmlyFTocV9EclcMHqwTwZ0Msh
	 cS8VQlTeQC+K5jL5LkPnPtbAoeJqcnha+w8idM9DJ81lMviCI4eUeyL9qjyU76hej63/g
	 buQ6SXPuF4QUG481xBpuOPLOaG9RehGN3X8s5tT/A1al4p/YdwsUcLiajP/8zbZ4mcOnM
	 8SbdfPKaPFt/TErRalP4DV92zEdcLlUIWUcdUw6XThJ2oLApTD4eiKFqEurxVjRCuEQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B43C21F000E6;
	Sun, 22 Nov 2026 17:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795367807;
	bh=vhgz+iXG+urC0DlryxtVmZDNjZwOyHtUcSI6Pec5kmA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=W6H4qbSHVDI5o5PXYV/5e/jaUPrqfGInnYUhwPPV0MYgHjSoB7JxCWrQjpGmsR5N2
	 jtxnPmuX2mFmQU2YWFnVYHRSZH+aokXrMlZ892jk1E030Tai9W6Cgtk3MpbSHl6wQ8
	 99ipu8U3r6muG1iPwhEou2bwiByPH3HoxYk7WL63xGY7dZCw+bg56JTM94raMDwjkO
	 2YONPnPuRzfwB8VXUX8M1sA6Lo3rLQvAjkaTXxm0lt+9PvA22b+oQaesG9RPUK/p3C
	 UpY3OYu65HgahUxjnpX6k58f4fZ0he+bVAiio0JyfmKK1sMtSSZVkkttTp2tCWF2HV
	 5f91Lby+WvaVg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BF2274C151;
	Sun, 22 Nov 2026 17:16:36 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Sun, 22 Nov 2026 19:15:46 +0200
Subject: [PATCH v3 5/7] iio: light: stk3310: add stk3337 support
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-6768-stk3337-v3-5-b0d0a924e843@protonmail.com>
References: <20261122-6768-stk3337-v3-0-b0d0a924e843@protonmail.com>
In-Reply-To: <20261122-6768-stk3337-v3-0-b0d0a924e843@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Joshua Crofts <crofts@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795367795; l=3029;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=QUiW+L2tM0373vjEf++AB6l0cThgF9C/jzPhxhIiPQE=;
 b=+q97PVWCB3zoSXuGW9bwT5cJT3dDeEZVrrOKqSipIu/q0EVeJnGSNeTg4ZHarRTg3tlrId1ev
 lOOjolsem2TCo5WH3IHmsh+Z4KSTdZQBj40tc4yKdS/l9XA/Y8OHyrx
X-Developer-Key: i=rva333@protonmail.com; a=ed25519;
 pk=zww/nWjBGoQ4POXCG0BV6fx2iuXK6jx77rsKPA5YK5Y=
X-Endpoint-Received: by B4 Relay for rva333@protonmail.com/20260510 with
 auth_id=777
X-Original-From: Roman Vivchar <rva333@protonmail.com>
Reply-To: rva333@protonmail.com
Content-Transfer-Encoding: 7bit

From: Roman Vivchar <rva333@protonmail.com>

Add support for the stk3337 sensor, found in the Xiaomi Redmi Note 9
phone.

The stk3337 is a subset of the stk36c61. It provides the stk3310 ambient
light and proximity channels along with the clear intensity channel from
the stk36c61, but lacks the red, green, and blue intensity channels.

Datasheet: https://www.bestmodulescorp.com/en/amfile/file/download/file/1699/product/1048/
Reviewed-by: Joshua Crofts <crofts@kernel.org>
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 drivers/iio/light/stk3310.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 828c3404215e..83f40714b972 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -61,6 +61,7 @@
 #define STK3311S34_CHIP_ID_VAL			0x1E
 #define STK3311X_CHIP_ID_VAL			0x12
 #define STK3335_CHIP_ID_VAL			0x51
+#define STK3337_CHIP_ID_VAL			0x5F
 #define STK36C61_CHIP_ID_VAL			0x95
 #define STK3310_PSINT_EN			0x01
 #define STK3310_PS_MAX_VAL			0xFFFF
@@ -112,6 +113,7 @@ static const u8 stk3310_chip_ids[] = {
 	STK3311X_CHIP_ID_VAL,
 	STK3311_CHIP_ID_VAL,
 	STK3335_CHIP_ID_VAL,
+	STK3337_CHIP_ID_VAL,
 	STK36C61_CHIP_ID_VAL,
 };
 
@@ -234,6 +236,12 @@ static const struct iio_chan_spec stk3310_channels[] = {
 	STK3310_PROXIMITY_CHANNEL,
 };
 
+static const struct iio_chan_spec stk3337_channels[] = {
+	STK3310_LIGHT_CHANNEL,
+	STK3310_PROXIMITY_CHANNEL,
+	STK36C61_INTENSITY_CHANNEL(CLEAR, STK36C61_REG_CLEAR_DATA_MSB),
+};
+
 static const struct iio_chan_spec stk36c61_channels[] = {
 	STK3310_LIGHT_CHANNEL,
 	STK3310_PROXIMITY_CHANNEL,
@@ -261,6 +269,12 @@ static const struct stk3310_chip_info stk3310_chip_info = {
 	.num_channels = ARRAY_SIZE(stk3310_channels),
 };
 
+static const struct stk3310_chip_info stk3337_chip_info = {
+	.name = "stk3337",
+	.channels = stk3337_channels,
+	.num_channels = ARRAY_SIZE(stk3337_channels),
+};
+
 static const struct stk3310_chip_info stk36c61_chip_info = {
 	.name = "stk36c61",
 	.channels = stk36c61_channels,
@@ -868,6 +882,7 @@ static const struct i2c_device_id stk3310_i2c_id[] = {
 	{ .name = "stk3310", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
 	{ .name = "stk3311", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
 	{ .name = "stk3335", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
+	{ .name = "stk3337", .driver_data = (kernel_ulong_t)&stk3337_chip_info },
 	{ .name = "stk36c61", .driver_data = (kernel_ulong_t)&stk36c61_chip_info },
 	{ }
 };
@@ -886,6 +901,7 @@ static const struct of_device_id stk3310_of_match[] = {
 	{ .compatible = "sensortek,stk3310", .data = &stk3310_chip_info },
 	{ .compatible = "sensortek,stk3311", .data = &stk3310_chip_info },
 	{ .compatible = "sensortek,stk3335", .data = &stk3310_chip_info },
+	{ .compatible = "sensortek,stk3337", .data = &stk3337_chip_info },
 	{ .compatible = "sensortek,stk36c61", .data = &stk36c61_chip_info },
 	{ }
 };

-- 
2.56.1


