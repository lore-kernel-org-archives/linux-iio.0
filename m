Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69ECD3793AC;
	Sun,  5 Jul 2026 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783251562; cv=none; b=iS05kWU0VhWt61T/nF8NpcpHDsLutrGibnN2Z3xJ0Smft+EvTIPzjrLGP1ecpz5/uC365wDvNbYnbxUmIP7jjG0isu1dJy6QYcZqi5H4scxAbl3pLKHQ8BvCDd8BOpnSPUez2pWUXdEloLYaB9i7385UVbXPwueuNBrgHHLNX/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783251562; c=relaxed/simple;
	bh=N//W61n3xcaHZVwzLBleSs5AIOXEvBnvue6KXId5i2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XeYE686GpZOqhXMZhvFMfX0QpD/dsglxNthgfRmofxGG4deDvBw2NRDntjDoELa7VK0j31PzQYhJLVvEr7z2JJSzqyhI/GwE3uNTjDR/Q26vy9RFo6m5/ZAjhR+ghLH5cQhYb2KPHjDVZzGdlV/KdTC4J2ZjklxBobAM0hBL+0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Maq3cFHe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Maq3cFHe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 16BB8C2BCC7;
	Sun,  5 Jul 2026 11:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783251562;
	bh=N//W61n3xcaHZVwzLBleSs5AIOXEvBnvue6KXId5i2s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Maq3cFHe/Ad4Ka5Cp7kCjOVMX58XD58KGKCgsDuC75EDOkDFZ7psBjikkiRmKSmqS
	 PZq3sq1+cF4t5Yge9cxje7WwoU8iufjuv0glkMKTRWUH7pxRDYLOe49WDHjprYu6O4
	 bQxzVzgKfFyNDqRYolqJc08VjOg90JthO7gufmp4MIgNgqZxRnkGd33iGpHQIMS3X6
	 8yPi6fkzGiFM4ZmYEJ80WUeSlSXobqEirvfawLI6PCtF5iSNmQo2C96GWiGq+J9kCs
	 Ql6DZdrOX3/B7fx2DgJDi/LCeq5faCfgr5+XMCIbgrVGyIG/5Jck1Lojg1L8LWikso
	 BU5UUlsFV0nOg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFDBC43602;
	Sun,  5 Jul 2026 11:39:21 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 05 Jul 2026 12:38:56 +0100
Subject: [PATCH v6 1/6] iio: dac: ad5686: refactor command/data macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-ad5686-new-features-v6-1-269594c7aae5@analog.com>
References: <20260705-ad5686-new-features-v6-0-269594c7aae5@analog.com>
In-Reply-To: <20260705-ad5686-new-features-v6-0-269594c7aae5@analog.com>
To: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783251560; l=4663;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Pwyu0rw5uPjvDrSRUQEZTTxAb8eLnctJHJjfb2rrhcg=;
 b=RZgycBLsVH3HOunBnqAw/m0/XfQsEug+9tr4knbYhEozt4MWzwGib4enl/BVIFjOxtc7A+qq+
 Ty2ff2JSJprBp0YaCg9Fap9wEqocGIh0ruO3EbmBjoMZVa4PxshZxvp
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Replace usage of bit shifting macros for FIELD_PREP(), which would not
ignore bit masking when preparing SPI/I2C commands.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686-spi.c | 21 +++++++++++----------
 drivers/iio/dac/ad5686.h     | 13 ++++++-------
 drivers/iio/dac/ad5696-i2c.c | 11 ++++++-----
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
index 6b6ef1d7071f..d3b64b4361d5 100644
--- a/drivers/iio/dac/ad5686-spi.c
+++ b/drivers/iio/dac/ad5686-spi.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/bitfield.h>
 #include <linux/errno.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -26,21 +27,21 @@ static int ad5686_spi_write(struct ad5686_state *st,
 
 	switch (st->chip_info->regmap_type) {
 	case AD5310_REGMAP:
-		st->data[0].d16 = cpu_to_be16(AD5310_CMD(cmd) |
-					      val);
+		st->data[0].d16 = cpu_to_be16(FIELD_PREP(AD5310_CMD_MSK, cmd) |
+					      FIELD_PREP(AD5310_DATA_MSK, val));
 		buf = &st->data[0].d8[0];
 		tx_len = 2;
 		break;
 	case AD5683_REGMAP:
-		st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
-					      AD5683_DATA(val));
+		st->data[0].d32 = cpu_to_be32(FIELD_PREP(AD5686_CMD_MSK, cmd) |
+					      FIELD_PREP(AD5683_DATA_MSK, val));
 		buf = &st->data[0].d8[1];
 		tx_len = 3;
 		break;
 	case AD5686_REGMAP:
-		st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
-					      AD5686_ADDR(addr) |
-					      val);
+		st->data[0].d32 = cpu_to_be32(FIELD_PREP(AD5686_CMD_MSK, cmd) |
+					      FIELD_PREP(AD5686_ADDR_MSK, addr) |
+					      FIELD_PREP(AD5686_DATA_MSK, val));
 		buf = &st->data[0].d8[1];
 		tx_len = 3;
 		break;
@@ -81,9 +82,9 @@ static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
 		return -EINVAL;
 	}
 
-	st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
-				      AD5686_ADDR(addr));
-	st->data[1].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP));
+	st->data[0].d32 = cpu_to_be32(FIELD_PREP(AD5686_CMD_MSK, cmd) |
+				      FIELD_PREP(AD5686_ADDR_MSK, addr));
+	st->data[1].d32 = cpu_to_be32(FIELD_PREP(AD5686_CMD_MSK, AD5686_CMD_NOOP));
 
 	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
 	if (ret < 0)
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index c424720f8f72..0d1bbf110926 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -14,13 +14,6 @@
 
 #include <linux/iio/iio.h>
 
-#define AD5310_CMD(x)				((x) << 12)
-
-#define AD5683_DATA(x)				((x) << 4)
-
-#define AD5686_ADDR(x)				((x) << 16)
-#define AD5686_CMD(x)				((x) << 20)
-
 #define AD5686_ADDR_DAC(chan)			(0x1 << (chan))
 #define AD5686_ADDR_ALL_DAC			0xF
 
@@ -38,12 +31,18 @@
 #define AD5686_CMD_CONTROL_REG			0x4
 #define AD5686_CMD_READBACK_ENABLE_V2		0x5
 
+#define AD5310_CMD_MSK				GENMASK(15, 12)
+#define AD5310_DATA_MSK				GENMASK(11, 0)
 #define AD5310_REF_BIT_MSK			BIT(8)
 #define AD5310_PD_MSK				GENMASK(10, 9)
 
+#define AD5683_DATA_MSK				GENMASK(19, 4)
 #define AD5683_REF_BIT_MSK			BIT(12)
 #define AD5683_PD_MSK				GENMASK(14, 13)
 
+#define AD5686_CMD_MSK				GENMASK(23, 20)
+#define AD5686_ADDR_MSK				GENMASK(19, 16)
+#define AD5686_DATA_MSK				GENMASK(15, 0)
 #define AD5686_REF_BIT_MSK			BIT(0)
 #define AD5686_PD_MSK				GENMASK(1, 0)
 
diff --git a/drivers/iio/dac/ad5696-i2c.c b/drivers/iio/dac/ad5696-i2c.c
index 279309329b64..bd8666a02b47 100644
--- a/drivers/iio/dac/ad5696-i2c.c
+++ b/drivers/iio/dac/ad5696-i2c.c
@@ -7,6 +7,7 @@
  * Copyright 2018 Analog Devices Inc.
  */
 
+#include <linux/bitfield.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
@@ -35,9 +36,8 @@ static int ad5686_i2c_read(struct ad5686_state *st, u8 addr)
 	};
 	int ret;
 
-	st->data[0].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP) |
-				      AD5686_ADDR(addr) |
-				      0x00);
+	st->data[0].d32 = cpu_to_be32(FIELD_PREP(AD5686_CMD_MSK, AD5686_CMD_NOOP) |
+				      FIELD_PREP(AD5686_ADDR_MSK, addr));
 
 	ret = i2c_transfer(i2c->adapter, msg, 2);
 	if (ret < 0)
@@ -52,8 +52,9 @@ static int ad5686_i2c_write(struct ad5686_state *st,
 	struct i2c_client *i2c = to_i2c_client(st->dev);
 	int ret;
 
-	st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) | AD5686_ADDR(addr)
-				      | val);
+	st->data[0].d32 = cpu_to_be32(FIELD_PREP(AD5686_CMD_MSK, cmd) |
+				      FIELD_PREP(AD5686_ADDR_MSK, addr) |
+				      FIELD_PREP(AD5686_DATA_MSK, val));
 
 	ret = i2c_master_send(i2c, &st->data[0].d8[1], 3);
 	if (ret < 0)

-- 
2.43.0


