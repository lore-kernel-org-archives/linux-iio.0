Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD4D30BB8D;
	Mon, 27 Apr 2026 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289411; cv=none; b=bzjYg+fBG9RWo17zjdi3RvJ2YMAs3DTiH2N2yCMQ3JkBR5ruExdXYrQB17/wAnOCjSpqecCPn4LsS5qJ1IkQCJYaBUpYpjBoBW0M9if6j9konMcowwqhqseJpnkFQQ3SBPoINPjcmf80hevqf0z2bCfbZf9DfNARviZfR3A8TYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289411; c=relaxed/simple;
	bh=ljmE1rWpKZCn3pxvkkd3tXDkCzv8bTgE+KAX4BqGjzA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HtxYRckcdC9o69vmkWZdSzJvvSQ77QldIUR5fPaASCCDxOdd1hfD3EG74HJ4EHuahWBlsrBY2I4Tdm+yZuiNy0f7CisBrVvQ9FRERAMTO/t6q9ul56hb3Y70S9lDnp5tuVae30hHad3uU6ZVPZZuN4zxC3VJymIu3bzqNUD/cvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7330ZBn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7330ZBn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FDC8C2BCF5;
	Mon, 27 Apr 2026 11:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777289411;
	bh=ljmE1rWpKZCn3pxvkkd3tXDkCzv8bTgE+KAX4BqGjzA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=G7330ZBnGLRGThB227HGDYPkybgLcIaovi2tcyr3zjvI6jZ0Je3ocaYZZ086F8+sc
	 RI+SzOoKU/X3hkq8tap0X2zibY1uVN+xJ2RNPJfGPNXtdkEYQqT4BFy0pjDCd4+lJy
	 QjxUnIr1p4hXFWgfslzVx5KvTWVDEFvlPetQV5xbY8ioFf5XkgSYWAlAE81kIgRnKS
	 /bx4kerd+IgtknZDtxDMLsbcxIaIEYh5JzOK+rwpU+pGvk6MRytYSNgXcurvTZRcyd
	 nXJmGNaLqZf/rVugzPWQMRXGvVXBgedK/lu2WldatFBLoLZgfk8V+2+4Ll6WXthokN
	 UKK7ctOzpdwQQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AF1FF8861;
	Mon, 27 Apr 2026 11:30:11 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 27 Apr 2026 12:30:13 +0100
Subject: [PATCH v2 06/11] iio: dac: ad5686: remove redundant register
 definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-ad5686-fixes-v2-6-188e05199368@analog.com>
References: <20260427-ad5686-fixes-v2-0-188e05199368@analog.com>
In-Reply-To: <20260427-ad5686-fixes-v2-0-188e05199368@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777289409; l=2960;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=5pwGj1cw0fpuxn2ieaGg3QNQN8ARYGCB2EEt3sxkuHg=;
 b=LJH3ER6HfxTaBmUvcbQCgjhk4w4r3VsEN/i858nGAZBlaX/FLSpjUbof5FTR2BltshWmjXaUC
 weAsagyTrZUAMPdtZSdYB5o4Gw5jusjxg0a/xskHnfs6ZeHQyTbbnXI
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
index 2c1692097c0c..53d58f0af16e 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -110,10 +110,6 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
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
@@ -294,7 +290,7 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 		.channels = ad5311r_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 1,
-		.regmap_type = AD5693_REGMAP,
+		.regmap_type = AD5683_REGMAP,
 	},
 	[ID_AD5337R] = {
 		.channels = ad5337r_channels,
@@ -416,24 +412,24 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
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
@@ -531,11 +527,6 @@ int ad5686_probe(struct device *dev,
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


