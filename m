Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794938919;
	b=ZCyKYEy+au0b50RtwdQkYVl7ZrMSP6S4gNgEwHSpC6TxX8qBWPfKnhnCkBoa8TLMvuuo
	 Ks8cCIkBtYz/PCrZ7qriZryCqOyuaoiKBB/fUPbZMRfV/6FRYTQPaHnkk8V7eBKFi85Fg
	 0AfGr8Lba11fG6mFNN0ZpcY8hMpSG7UL+GWPxiFDgcEuM637LwuhlIml4f/SCGde1Dx1Y
	 2n5Lsi+2GQIWKLudzm9MJJxqT6njIvtzTBa0r5pG7KyOIeznBYuWQvfWD3TTYj4OmzHdS
	 uVo/pFq8tLrgNnkqLBUvjX1FPbkVCTQ7z4J+FVCc2okRQEZCuncr9R0jl+0zQDHBl+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938919;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lBv1QkcVqrzBLtWl+RFcQicSUN3lSbOKmyFzCff4/lA=;
	b=t9tUsnM6+1FOMNnK/ksf3JU0E3niA/d8v0VFWzYZHXXIwyCKGuExO8NhfYxIr44cSVVG
	 a6bPSlB74t3pNtx9cK2dktwSJPY1uGqhFn+qMxwVINcMGOEy9P+7Zm+QwjNbs/G5uC6DU
	 1uz9Q2c3NFKtU3b30ozdVwZhoWSNtzqpbyafppXZQNuVSsz0faPbNANQLd7EsUv6HBFul
	 syfmkK4iKecWV1q3qNH/h6myGOdxptofaP+biE/SSnGs5Tr42qOVPJt/rCN8r4QeQJwDz
	 d0mn/PM4lFvS7XAPTnL7sFTAs2z0QUhjDxg2sujqNooC0YP+J7umfS/uKHBYJ6xHh9w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9HP4AP7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0207606A33E;
	Tue, 17 Nov 2026 18:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W9HP4AP7
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794938918;
	b=glJo2YQQNEQ62lBtS97zox5niGC2Bl+xeSLwNstc9Gpz4yTdJBDOthoIcgEOSLzRYFtt
	 bUP39yXWoTINpnWwaYm2vtzr/U+YetTWjxxIBOLdKUXqTs+N20Htqirpt7gjijqbvcQNo
	 xfMjJXSayny6k2kMC+2b6m0FWodoMp0/BxSuM8LZPMXcK/FA9qjuFbv7eEQ60OyHMdqX4
	 kou2aJquZyIEQ2hCvk6gq75B+m7hm5i5hIv8t0vicwXbnBN5v6J8NO9kdGghKl1pcTB4y
	 NKeJVKhF1xN2303yOdZHgquEy9STl0+uLqgdoKvesSSsYhiOB+VuvxsEtzM3FGSC+wA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794938918;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=lBv1QkcVqrzBLtWl+RFcQicSUN3lSbOKmyFzCff4/lA=;
	b=hJdbRLP1HhqrlbI/e/M8BIsy1JlmVrkwvP4qSajBOgXYs+eyNJjkJ1JxW/r5n4trUr8s
	 PDZE0Fo0ouFE6fgaqADKNWhZVU6kgiZcoi55V+9ImPu2zBfFV+4PUlvmGuk6o/JA9Ryvc
	 CNqLbRep4DFhme5KV6jYe3KGGPd9dJqnWE0dfuIo8cDUphkhI3SDQUDYb6LrilbqJDYnr
	 UGDMC1EnpRGBe158ft/CMhqiELr0OpyZQDkPBIka8X/g1aDf/37zMyAIFYlUAmqT6ppDo
	 2cwFHghqFUf/ulkLVAnmVFVYVAjHxEE8IGcQCj4zk3jkO1E+PxJyFaZFQiSUkYi+EWg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id CF0081F000C8;
	Tue, 17 Nov 2026 18:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794938918;
	bh=lBv1QkcVqrzBLtWl+RFcQicSUN3lSbOKmyFzCff4/lA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=W9HP4AP7ptMsX5lgcqzCIzMpSYU0g9bWIAUK8P5SReEShldbdwawCvLKBX1dJVKwo
	 07igsEWoZFwnJp1QwMbsx3oQUwUoRLOIaVcUdJpXtBszqb3/MTqatxXpuV11MUIy5+
	 1gHOjcjtnaAx1GRpershyFMfsKW4lDeYlbi4JluSxiJiVrs7LVJiPpfg4k7dhToBUv
	 OWyXFtjcyc3EClTYm6sowH0Opm3Ql8ufuy9k1YbSbiPD0Cd7BTmtJJgHxH4iXMD0mv
	 wE/xBKfTfEjZrt6G3SmvaP5xdEXuPe7DW0U6bu7aAt6BuN3WIPnh1naK7oMvZR45vZ
	 ZIxBE/JZnmBTw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5AAEB4AA4B;
	Tue, 17 Nov 2026 18:08:37 +0000 (UTC)
From: Roman Vivchar via B4 Relay <devnull+rva333.protonmail.com@kernel.org>
Date: Tue, 17 Nov 2026 20:08:38 +0200
Subject: [PATCH v2 4/4] iio: light: stk3310: add stk3337 support
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
Message-Id: <20261117-6768-stk3337-v2-4-92f4c7be3bc6@protonmail.com>
References: <20261117-6768-stk3337-v2-0-92f4c7be3bc6@protonmail.com>
In-Reply-To: <20261117-6768-stk3337-v2-0-92f4c7be3bc6@protonmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Roman Vivchar <rva333@protonmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794938915; l=2981;
 i=rva333@protonmail.com; s=20260510; h=from:subject:message-id;
 bh=0naml7KDqN1k4Vap19ZZGhPsCJbbjNxXLLCyW649Tuk=;
 b=oYJbxsyyVSMS8osBi0A+6cy+4bBTd8cyqd+MHSBSO+Z6rFmp1z+K8sudxSgpbgK3ayFqYzcYE
 dyezSv4zgQ+B+YU1ybVAoXAfae0wGZbNuRJmSBnl02pNfJATDyRdB60
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
2.56.1


