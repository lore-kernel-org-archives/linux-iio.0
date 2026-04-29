Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453883FBEC2;
	Wed, 29 Apr 2026 13:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468058; cv=none; b=vE9bI3RxvSRmorXr+v9uJJs/Kf/ewffhDOp3xp739ZoV86ISDDRUuwqIk9YCpY8RfPnxdAKc3IckRMEn2QX+4SHdVHANF892+/GFm21EO7TBd5gVXTd8Rqpox4BwxndlZGk3ym1Xlf2jy5EQ7JRAHQFcS2ZGEX/dOZZ6eXR8ukE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468058; c=relaxed/simple;
	bh=cUU49IwGzqomXwO+cbWgn3tRrnMtke2zHDK1OHMoFXs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Lh18YgsVBxiclnpdZ5UjXo3mAjhIy6FispleMoNgfTMeUMol/0ShprEduSluiREipJ5npYvCNQoUdXDc19k/KOAdg4Zu8I/mM9Yh5JnWx4tFGwiAHA4CWtd/YQ+KToJEUEL/YA4UVU6G7h/nPskkRcjwh3fA20RQAqHCXJyKp54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twNAQ6ZX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twNAQ6ZX"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00E62C2BCF6;
	Wed, 29 Apr 2026 13:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777468058;
	bh=cUU49IwGzqomXwO+cbWgn3tRrnMtke2zHDK1OHMoFXs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=twNAQ6ZXPsLWL3y2/QHrNrPaeWASsZCfrh8Sa7ke59NY8qdl5V4oExBq7r39aLJcb
	 4VExkpmvPjPXX8u8ZBbeo+UQcr9Hi9ACOl+1sscr2XY2sttnYUHdf1cHuTcS/eV8Vy
	 GR06DitJ1lC5OlTaqaVXtqBz1ZHRK42SRf+UQpKdgh2pudlBJCrETTQo9rVszFN1+l
	 R12esaiF11487MrOybWVlPtLyl6XBeOfkTBm3yvC7YasjKh0oM3XQ7LQzw6oUTLN7R
	 W2zMEj3qbG7fxoTvNvoau0AwLDWTXRLze9euac/zOrZ/xpIk9ROYBOBGFmITeCpYrZ
	 tMHe5j0TjFrSQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD5ECCF9E3;
	Wed, 29 Apr 2026 13:07:37 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 29 Apr 2026 14:07:37 +0100
Subject: [PATCH v4 07/13] iio: dac: ad5686: remove redundant register
 definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-ad5686-fixes-v4-7-bb8f1cbd68e1@analog.com>
References: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
In-Reply-To: <20260429-ad5686-fixes-v4-0-bb8f1cbd68e1@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777468056; l=2960;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=pwWvV2HjzWSFMct9O8d223hNHPcXUCQE4vnfDjAN1E0=;
 b=CkzubH4KB8VSnQAdtJ0AbC6i7+Kq5M3Jzd0AC2d0shIhg4Mz5FyD2m4ay7KHFNOqwbNMQl2go
 e19shlKquVwCwHE9pM7T43dg2NvSb188WtMYUFC/LHA4AM9PrH+OzuE
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


