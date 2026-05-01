Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEC837FF67;
	Fri,  1 May 2026 09:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777626921; cv=none; b=Hns7PYb2IW+Rm52v+XejdsVP2WkfPCCqbur1RstZkBNSOOan4z44hPxaNuzSXzlMilvvuSbZuiru4jXs0N7XbO7QLzmUo3/XNXb7TBuqaxmMIzWkJVFW2m/OJnFZJuhx3kxUkYBEo4zVmK/MsAx3kxCAlcR88KwlXd+/2NYWKc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777626921; c=relaxed/simple;
	bh=NV+pb6nkEs/Kb/1eTRMnTHalM7wi/b80qqdCmx/U20E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Iq6JNxL2xksrQDBl8H6qZRhHxQYRKFyLV0WunQynA1GPSIiZvHsXWTj/645zkZWKlE3TdTsG+08GlUbxa+Fg0Lsxv6HU+chVmFUyCk8EcSb+c8+OOO+Mv9EsI34cV+qLcG6z9VeK77UlmC2C2HyeMVwquLQD4WKmjk3z5q3xgck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L4J1Hyr0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L4J1Hyr0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92492C2BCC4;
	Fri,  1 May 2026 09:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777626921;
	bh=NV+pb6nkEs/Kb/1eTRMnTHalM7wi/b80qqdCmx/U20E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=L4J1Hyr08mvHpESb8fiv0lyEeWCsDoNbUuwZehu5NPKW5MM0Sl2vjQcBvBP4T1Tfk
	 J+Zkc1mCag7UC8Ig7VTc4B2neIvEUSzTfq5GO5weL3qlCPDMX3t8C1NorsgVSBBFEO
	 XFKpAVuGS0AONRodMrBqq8MJ2+6sijjTEiwIQyfD28ECvfNJw30hvQJivjh101r0oG
	 WYQsB/dYgF1w84RnnVJsrky7OI3k8YYTVTEatpr3tY+gEarFhxG31GKUokYIoRwj2S
	 DvYl4G9g5xAsFvSl6mCM8E0ifQagUeOsjFQQyeenDBHF5NbHfrv4vruT3kfAUwNo+n
	 +f5H5ppJPDljA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F3EFF885A;
	Fri,  1 May 2026 09:15:21 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Fri, 01 May 2026 10:14:54 +0100
Subject: [PATCH v5 01/12] iio: dac: ad5686: fix ref bit initialization for
 single-channel parts
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-ad5686-fixes-v5-1-0b2f45488418@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777626920; l=1845;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=ACFFNXIkeDLRrCLvd6fNW7RHjZhA5Kd+3kUIKJGbV70=;
 b=Lpp7uuafosV47S63MBj747UaEkDxUqPV5uLczxRsfRHLS/eqHigbOCHGVeDdlM4EgKmfTOAqC
 lYA+lOZxciuCAn3JPy6+iTiRcr973Ye3ftMDo1L66cdEEH7+R6PPYJm
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

The reference bit position was ignored when writing the register at the
probe() function (!!val was used). When such bit is 1, internal voltage
reference is disabled so that an external one can be used. For
multi-channel devices, bit 0 of the Internal Reference Setup command
behaves the same way, so AD5686_REF_BIT_MSK is created. The issue exists
since support for single-channel devices were first introduced.

Fixes: be1b24d24541 ("iio:dac:ad5686: Add AD5691R/AD5692R/AD5693/AD5693R support")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 6 +++---
 drivers/iio/dac/ad5686.h | 1 +
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 9a384c50929b..1fc54c38b629 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -511,7 +511,7 @@ int ad5686_probe(struct device *dev,
 		break;
 	case AD5686_REGMAP:
 		cmd = AD5686_CMD_INTERNAL_REFER_SETUP;
-		ref_bit_msk = 0;
+		ref_bit_msk = AD5686_REF_BIT_MSK;
 		break;
 	case AD5693_REGMAP:
 		cmd = AD5686_CMD_CONTROL_REG;
@@ -522,9 +522,9 @@ int ad5686_probe(struct device *dev,
 		return -EINVAL;
 	}
 
-	val = (has_external_vref | ref_bit_msk);
+	val = has_external_vref ? ref_bit_msk : 0;
 
-	ret = st->write(st, cmd, 0, !!val);
+	ret = st->write(st, cmd, 0, val);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index e7d36bae3e59..36e16c5c4581 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -46,6 +46,7 @@
 
 #define AD5310_REF_BIT_MSK			BIT(8)
 #define AD5683_REF_BIT_MSK			BIT(12)
+#define AD5686_REF_BIT_MSK			BIT(0)
 #define AD5693_REF_BIT_MSK			BIT(12)
 
 /**

-- 
2.43.0


