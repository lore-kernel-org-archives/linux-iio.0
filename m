Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427E342C98;
	Sun, 26 Apr 2026 08:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777192699; cv=none; b=utum5MdbYuS/vd6eGwxCz8DnKGtZsOFhbuaDA7cd5Gupdqs8ILnStP/kAqHRSzgcfiinqB4g9Qk+GkcCPehONaJrkd2yB7KQ4+daUkpM1yekc+C4sTk8fP+lUZF9QvvPzCKBhtp+sm0HqbvpcFz9BniaUJKlA6C+16tfALP6Psk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777192699; c=relaxed/simple;
	bh=cbuDm6FVS9j6IEsNVeVUYIKUme8sTUk+D87Au/xl8Rc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MyheFiujdG0v+jlVmxgG+SC2klj75NOKv4Gs1ns3onVLLYWYKbHYXJw0C0jybEkaMWjITpJgeQZzsWrEicRzBTGKYFDRZ0rz1YrCxiX7GlrvcdLHuv84h7zVTjk8K8g7GC8HFNVKhe60HD/xzk/idgNGI3C4zAodXPDT2LDjU5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqyrQICO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqyrQICO"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 79F77C2BCB7;
	Sun, 26 Apr 2026 08:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777192699;
	bh=cbuDm6FVS9j6IEsNVeVUYIKUme8sTUk+D87Au/xl8Rc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=rqyrQICOIdaVsYg7z6nQslqnU+Ln+Bis8dcebCRidtJ86qeWTUwVPEXRC2yh6IdI7
	 HEaR4mIkpRw2meQpx8QHX1X/+en0eb6/EsVnJU1Bx15UeYb/7VdWb4Fq2teCO8nzh9
	 6XqFGGHrMYjBaBSmA+JV2q7CbAhynVNX5jrr/8XPxOAUmt9XWPyC5e3wBL2L3Fzjos
	 kNSg+sDlMeVDIC3DGWYGc55yzpa6E1j34M8Qtu7Cdhc1dGtoQ7chCncvI+DEPxvrNk
	 1uax934WIc9veW2wnCt5OKL3a6zRj6GsVl75Y9CQuZmxRd+I/NvUh5EkuP0dNkQ4SO
	 GXjnM92K5dkvA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEC2FF8860;
	Sun, 26 Apr 2026 08:38:19 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 26 Apr 2026 09:38:03 +0100
Subject: [PATCH 02/10] iio: dac: ad5686: remove redundant register
 definition
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260426-ad5686-fixes-v1-2-7c946a77794e@analog.com>
References: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
In-Reply-To: <20260426-ad5686-fixes-v1-0-7c946a77794e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777192698; l=2906;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=QmKdjj798uhH4/it8tuOBgAkAWAuRLHliOPg7NhnXgA=;
 b=SyJia5ZWYXpGSbDtGx8UA+ZVcjL0prrrMJcGu3Fktt60dCqSNHfuj9XhaeC8Z66KKDgS8ZD5u
 +5bjusfsKVnDCLAibqCeTNYEwUVi6tuTksK9aqw7RXfL5ZK3OweSmms
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


