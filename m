Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794089707;
	b=CjjrjNk6NZUQ7B8w1mIxiyDcNDhyM4Tf6qn5IRZoZZqgFmN8QmWUI6s8WtNrsXoKuK9X
	 XglZJvpCjQ1rmFp/RuBUTB1wZjv/v3RtRH+8N0gIPkK/lfwhh4+9pQUuz2508OHTv6xik
	 YAr+99U4DIVkf56far7DMpm+woLBxL3nlWGjlvZmGhazNJIIerQoJ7fLKenB+mlPKkaH0
	 5f6UEJD+Kzgh3miM1faTVuPCHXx7lNkz9CkmnTpRRZ8UDMaW2L/tcdJ0gbLzdz8nSPg9z
	 q9+W2YhfXJsqOJxFKAz/Oj2tIwQtpQhXtTf/VYdPTIibWK3uDt1fBeP8dj6z9THrusg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794089707;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VkJkvS4VjC+4o9+1aieAO9ThBp1oekCRHkCsmKp9hFc=;
	b=xlVOzLg6dxwCY86FrJToQgwpRNFPlo/Nosbt4H/BNTtpBRqk+J8vEj4g3Yg0lWXuqDdP
	 TBz9f8mhjUYu9v7HMoXfpRh2vIGs1tpiSew//Z1JY3f3IVgPoN1sAMFh90pSbwWIlh9Jf
	 OCY4yIHzcRSVRlFe7oCGajUrsK53w8ImkiEHEgT+qkNNME7iZa2764b82tzq2sWcnXEMW
	 WPAGYnMFDgaC6ur6mZUEAchfIMpxZRKZx3nFvcL7q1ByrMheKeijY2Hgik6Pae0m3La43
	 8qZRMiUhXuZCQ0FzhcxkXKS2heW7VWN3SgMw+DWTfN3XLzjZWHC694FwfyEIs7AJfGA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=msqdw++Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E2C606A32D;
	Sat,  7 Nov 2026 22:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=msqdw++Z
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794089706;
	b=3RorqCQYoX1Y6z+qu+MSunWk7EUdlFj9uA6XvrO1WYI/8WBdP4aADNa67q+Hyxa1136J
	 B8KEhsjd5lR2PCVcYSxTFLXq9GowuQk9Hb3ujJ+gH9p3x5Tzgvb6tYfVCfB+LCeJ0uRer
	 P/0ni10RiZO23kykWosmf+bLEkyffB388L6SJx8pkrE9OXidoUZjjyRp2zavScG5rwRpL
	 TEoMyzcmNTJowxLcxy4TwvRqCiLZlQ+Sk0syAzAsI88A9y5hlyxILeSVFhLV+BCgMLPQq
	 sOl9ndh91uzOaG77GLUDg33Jv81bEXm+1mSzQNnoh9S8tHvdND3Ap0yzBFBWmMYt5mw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794089706;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VkJkvS4VjC+4o9+1aieAO9ThBp1oekCRHkCsmKp9hFc=;
	b=XA1T09KBmDK/lBzvxXI/pqNgnVJF/5FbC0YHj+P/Yh1D5IiH9yxaKCv5K94huBTylS+u
	 MLofsSp3RsKnsJZ6M0weUa8m1obshA7PYU/tdns1YhyAV6fjyBbJkQU3XHYiM7IygxnGc
	 fZ3EfIY7xMjWBi9lF1hyEx8H4KjZ3Ltv75Bjs70UQBpAZyNlBZMdRQQ1lNksfV5WbroKV
	 8dDo+A8fDRkCBNaCGypws8gtLFm0IzPYGnSeh9EbV946HMCQUfyTOavTwEaClw8be6xfD
	 iARnqxmP3cQpTKUHjNqaHzNupH5Doh8DRREJUgpOxznCrzwZDREuULhoNPyTroq5KBg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 73C791F008A4;
	Sat,  7 Nov 2026 22:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794089706;
	bh=VkJkvS4VjC+4o9+1aieAO9ThBp1oekCRHkCsmKp9hFc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=msqdw++ZKs7WBQVeMmtiNvV4NVB/JHMyQRf6W6TXZ7LmM3tV+ZXR7+4ZoLYEtF+B2
	 yHnEQXVknMUABgU7n3smTWMe6UcHu5k3UjhsvYlXlwA0/KGuZKm93V+OzJrJnFf/XS
	 Ydnvi0rtLzHYLRH+PlxSaM1uWkREt8N2lEy2a1izJCsH6kmGWRVNeecjHSdQhXepPw
	 V/SAcxs3rHvtd+1Ztadjvoq4Bh7byNDtSUzn5aC9JJZEwdKUuIAsEs+RILb2yAqdZZ
	 ze/wSYs3ZsgWDkOrFBwol6J19unwmzgGTUBGJl5Dwksksay1u8LmHKyniZp8FpcxB6
	 jQWgpwMXTDPXw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EA11547D40;
	Sat,  7 Nov 2026 22:15:04 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Sun, 08 Nov 2026 00:15:06 +0200
Subject: [PATCH 4/4] iio: light: stk3310: add stk3337 support
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
Message-Id: <20261108-6768-stk3337-v1-4-0340c99b0e33@protonmail.com>
References: <20261108-6768-stk3337-v1-0-0340c99b0e33@protonmail.com>
In-Reply-To: <20261108-6768-stk3337-v1-0-0340c99b0e33@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794089703; l=2938;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=vkuVuX7Kh+a32Ce53rYW7Noy/cT8I5Rr0hB0sazZ9U0=;
 b=BVVWONPWgfwMZ3LX/Pkg9r9ApSLTqDIgFATDUY/d3/zVa6QHpFc1lf35aCxYoDsy3FYrzW0Jv
 dwJXBwCeAjRDH6boSBucONKlubNmh9r9Katq0ZCIacES9LY24Gt1fJV
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

In addition to the standard stk3310 ambient light and proximity
channels, the stk3337 provides a clear intensity channel, matching the
layout already used by the stk36c61.

Datasheet: https://www.bestmodulescorp.com/en/amfile/file/download/file/1699/product/1048/
Signed-off-by: Roman Vivchar <rva333@protonmail.com>
---
 drivers/iio/light/stk3310.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index 2f4747c06f43..6d629ce726fc 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -60,6 +60,7 @@
 #define STK3311S34_CHIP_ID_VAL			0x1E
 #define STK3311X_CHIP_ID_VAL			0x12
 #define STK3335_CHIP_ID_VAL			0x51
+#define STK3337_CHIP_ID_VAL			0x5F
 #define STK36C61_CHIP_ID_VAL			0x95
 #define STK3310_PSINT_EN			0x01
 #define STK3310_PS_MAX_VAL			0xFFFF
@@ -111,6 +112,7 @@ static const u8 stk3310_chip_ids[] = {
 	STK3311X_CHIP_ID_VAL,
 	STK3311_CHIP_ID_VAL,
 	STK3335_CHIP_ID_VAL,
+	STK3337_CHIP_ID_VAL,
 	STK36C61_CHIP_ID_VAL,
 };
 
@@ -233,6 +235,12 @@ static const struct iio_chan_spec stk3310_channels[] = {
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
@@ -260,6 +268,12 @@ static const struct stk3310_chip_info stk3310_chip_info = {
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
@@ -870,6 +884,7 @@ static const struct i2c_device_id stk3310_i2c_id[] = {
 	{ .name = "stk3310", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
 	{ .name = "stk3311", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
 	{ .name = "stk3335", .driver_data = (kernel_ulong_t)&stk3310_chip_info },
+	{ .name = "stk3337", .driver_data = (kernel_ulong_t)&stk3337_chip_info },
 	{ .name = "stk36c61", .driver_data = (kernel_ulong_t)&stk36c61_chip_info },
 	{ }
 };
@@ -888,6 +903,7 @@ static const struct of_device_id stk3310_of_match[] = {
 	{ .compatible = "sensortek,stk3310", .data = &stk3310_chip_info },
 	{ .compatible = "sensortek,stk3311", .data = &stk3310_chip_info },
 	{ .compatible = "sensortek,stk3335", .data = &stk3310_chip_info },
+	{ .compatible = "sensortek,stk3337", .data = &stk3337_chip_info },
 	{ .compatible = "sensortek,stk36c61", .data = &stk36c61_chip_info },
 	{ }
 };

-- 
2.56.0


