Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8093D32F764;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869184; cv=none; b=POsDXNchSG8LTv51YSmwf34IIUlwRHcaXX5/nmoarL38TYCDnhppWSJ/7wrULT6cofBC6OM+R340I82tViYatYuXAACI4I44nzliSGPVWsWOaXDDenra3h0y+S6KNriOTd1TaeiUSo8PfkxFfxZn+B2rRRJmtBvJ0gWPrAMozoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869184; c=relaxed/simple;
	bh=F9Nr0dL97FhuwgP6JQ6EOPNw/sgLvryAOIT0llXjf58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UFWqXwmrl/8+V5e1i0ARZibmEFrOQVdprJwpBRR+Byppl8yxDpbdMfVKThxnA6fDHdcM6yEsXlPovc36Y5ff8Cry+xJoNpAQtJ534efovMeoQ40f/On7CY0kDQSao3Ns5KASd859l+PgeByxYnwW7Y6LExYcUfXAFv9yIGk2h38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dM+Lo0kC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dM+Lo0kC"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4F381C4AF15;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776869184;
	bh=F9Nr0dL97FhuwgP6JQ6EOPNw/sgLvryAOIT0llXjf58=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dM+Lo0kCsHbMM0ajj1yIvZuM1pWf2bv2iPI09Y2Yb0XwlVfw5bHcZtWQTAfh4MimO
	 pjkc/gji4Bmo1e7bL9Rbsr8ZawULAILJkEZs7oMU/gb05m8YBvzPph1zXBaDlaj/ww
	 zPOcYpC12V5wd076aLM618VoGHSwi191zmTe/cX+l78u3P3RLH6MgajjAhe1c9i3ro
	 DVcXPCWsWXcBrfIJ2Tsu7H1bZdZ+E0fvXxblrD2RhiSKRQbOQbO1ObMzgTFDNpVGAC
	 eD0G9gaBONWwHAN9OHLbQ5X6ND2Ng6oZDyFXlgVO67GSvOpCR75aY0UgbpaUf8/QMC
	 awv6X6pJqyHKw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46136F9EDC9;
	Wed, 22 Apr 2026 14:46:24 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Apr 2026 15:45:42 +0100
Subject: [PATCH 08/22] iio: dac: ad5686: remove redundant register
 definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-ad5313r-iio-support-v1-8-ed7dca001d1b@analog.com>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
In-Reply-To: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Auchter <michael.auchter@ni.com>, linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776869181; l=2846;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=ohjQW1AWDwRd84EWTvh6fCxsW2xwkyxLY5jzdH+7/fM=;
 b=qxDCy61RCTrZvVxcG8tC7f+4uoyo/zcsS/ec1eJJ3Wa2EkE8J9O1RVCm/uwwJGf8S9kyw9ZZP
 T/TaWDBqmogAa7fr38zUKzWEft2UIXBAMh459R2VgNLjOvH8CMuzdGV
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

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 19 +++++--------------
 drivers/iio/dac/ad5686.h |  2 --
 2 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 1a6eb3832f22..0bc925bd827e 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -93,10 +93,6 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
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
@@ -277,7 +273,7 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
 		.channels = ad5311r_channels,
 		.int_vref_mv = 2500,
 		.num_channels = 1,
-		.regmap_type = AD5693_REGMAP,
+		.regmap_type = AD5683_REGMAP,
 	},
 	[ID_AD5337R] = {
 		.channels = ad5337r_channels,
@@ -399,24 +395,24 @@ static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
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
@@ -508,11 +504,6 @@ int ad5686_probe(struct device *dev,
 		cmd = AD5686_CMD_INTERNAL_REFER_SETUP;
 		ref_bit_msk = 0;
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
index 3fcc792ea656..fe6482e84178 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -45,7 +45,6 @@
 
 #define AD5310_REF_BIT_MSK			BIT(8)
 #define AD5683_REF_BIT_MSK			BIT(12)
-#define AD5693_REF_BIT_MSK			BIT(12)
 
 /**
  * ad5686_supported_device_ids:
@@ -88,7 +87,6 @@ enum ad5686_regmap_type {
 	AD5310_REGMAP,
 	AD5683_REGMAP,
 	AD5686_REGMAP,
-	AD5693_REGMAP
 };
 
 struct ad5686_state;

-- 
2.43.0


