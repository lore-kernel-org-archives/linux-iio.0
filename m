Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFF03806CA;
	Fri,  1 May 2026 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777626922; cv=none; b=dDmC7M3rTUDIoMRkhoVPJ0vPfKGh1CuMgDmOSFhQXrwxNCdGTQfcM7KFX56Zq9vNAqB1g7IThci6pxXhRbgiCuwDTVFaKCTpOTu0/80X1iC/LxLS4TSoWdoZohUpL9rYSVL0UrO/FbWAIzpw71EpN1BpO7weMHdy/3d3pBIQxq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777626922; c=relaxed/simple;
	bh=cUU49IwGzqomXwO+cbWgn3tRrnMtke2zHDK1OHMoFXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YUoWWzxy9QyM0Xi2X3uArAsPmWjAD8q9UoFMNfnpUCpWA9/uEeFu33wvd16+zInSU98/PlB11KKKOUym6jM6qOQ3KMkXiSqn1X/Ik9c8qqQJB+HnnTRCV3f+8nbwxyIccY8mlHHCttRVELhEaPP53VxtoFHqjeJp+7A5zItDyoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4YRMg5+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4YRMg5+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8246C2BCF7;
	Fri,  1 May 2026 09:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777626921;
	bh=cUU49IwGzqomXwO+cbWgn3tRrnMtke2zHDK1OHMoFXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Z4YRMg5+f7gkAPMmsen3SNFWKFYvCYpywQCfKd7eCkHC89cCVOivCSqSfVJ+KhPXt
	 a6CDhDTm4sy4me8xweOmxGiehH6b5yCkV5vUAFogRNkITFT6yepYlLKoTXeL0QrNb2
	 t7EQCsU+4oIyxZhsxKHkggbA0NH0nEZr/9JOh3tNpaZ8ZHfwLWMvZ3h/K4GBeVu+BP
	 u47C2+oiAYRlYV9TGa+WEFh5jxMBeevFETo2EptWr+9rU/Cp9fOYSZWo7a2jwSuL2Q
	 la92uyH4UHcuEfno8vPIFAXQ0feFpYMFKnZG2+hmg/qtmHN4NSP1nY51x2MAseIlv4
	 A87QxdzyaPn8g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF43DCD3427;
	Fri,  1 May 2026 09:15:21 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 01 May 2026 10:14:59 +0100
Subject: [PATCH v5 06/12] iio: dac: ad5686: remove redundant register
 definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-ad5686-fixes-v5-6-0b2f45488418@analog.com>
References: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
In-Reply-To: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stefan Popa <stefan.popa@analog.com>, Jonathan Cameron <jic23@cam.ac.uk>, 
 Greg Kroah-Hartman <gregkh@suse.de>, 
 Michael Auchter <michael.auchter@ni.com>, 
 Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777626920; l=2960;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=pwWvV2HjzWSFMct9O8d223hNHPcXUCQE4vnfDjAN1E0=;
 b=+LXCEt41Ma5NmA7SWmewLgCuweMyMqgBUAi+WsqzN6bCSEQ25KPku+lky7HaZrXN9NJS3e80u
 LTioCDlF4FnCaLkvmbtfpiQZganOkX5IWLCuUWeo4iDtu27vNoVUpc+
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

AD5683_REGMAP and AD5693_REGMAP behave the same way in the common code,
and that is because they target single channel devices from the same
sub-family. There is no reason to separate them and it will make things
simpler when refactoring the chip info table.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 19 +++++--------------
 drivers/iio/dac/ad5686.h |  2 --
 2 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 572dcc918ef2..d9bab8d7bcb0 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -112,10 +112,6 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 		if (chan->channel > 0x7)
 			address = 0x8;
 		break;
-	case AD5693_REGMAP:
-		shift = 13;
-		ref_bit_msk = AD5693_REF_BIT_MSK;
-		break;
 	default:
 		return -EINVAL;
 	}
@@ -296,7 +292,7 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 		.channels = ad5311r_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 1,
-		.regmap_type = AD5693_REGMAP,
+		.regmap_type = AD5683_REGMAP,
 	},
 	[ID_AD5337R] = {
 		.channels = ad5337r_channels,
@@ -418,24 +414,24 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 		.channels = ad5691r_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 1,
-		.regmap_type = AD5693_REGMAP,
+		.regmap_type = AD5683_REGMAP,
 	},
 	[ID_AD5692R] = {
 		.channels = ad5692r_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 1,
-		.regmap_type = AD5693_REGMAP,
+		.regmap_type = AD5683_REGMAP,
 	},
 	[ID_AD5693] = {
 		.channels = ad5693_channels,
 		.num_channels = 1,
-		.regmap_type = AD5693_REGMAP,
+		.regmap_type = AD5683_REGMAP,
 	},
 	[ID_AD5693R] = {
 		.channels = ad5693_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 1,
-		.regmap_type = AD5693_REGMAP,
+		.regmap_type = AD5683_REGMAP,
 	},
 	[ID_AD5694] = {
 		.channels = ad5684_channels,
@@ -536,11 +532,6 @@ int ad5686_probe(struct device *dev,
 		cmd = AD5686_CMD_INTERNAL_REFER_SETUP;
 		ref_bit_msk = AD5686_REF_BIT_MSK;
 		break;
-	case AD5693_REGMAP:
-		cmd = AD5686_CMD_CONTROL_REG;
-		ref_bit_msk = AD5693_REF_BIT_MSK;
-		st->use_internal_vref = !has_external_vref;
-		break;
 	default:
 		return -EINVAL;
 	}
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index d08160e7fad9..af15994c01ad 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -46,7 +46,6 @@
 #define AD5310_REF_BIT_MSK			BIT(8)
 #define AD5683_REF_BIT_MSK			BIT(12)
 #define AD5686_REF_BIT_MSK			BIT(0)
-#define AD5693_REF_BIT_MSK			BIT(12)
 
 /**
  * ad5686_supported_device_ids:
@@ -89,7 +88,6 @@ enum ad5686_regmap_type {
 	AD5310_REGMAP,
 	AD5683_REGMAP,
 	AD5686_REGMAP,
-	AD5693_REGMAP
 };
 
 struct ad5686_state;

-- 
2.43.0


