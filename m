Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3C135DA77;
	Wed, 22 Apr 2026 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869185; cv=none; b=bc5IbFIk+R0pH+Jf9HOnEzgczVV7MVyeTKM6EsJ75KaOoihN1ZGmZx3FjHjtLxdOk/b/qxqeS4HTFrsn/uviz3Ko9QlmeO/jKgjskzUHiVnEe/nGvJt/Uem+3vws3yE/Ycpkkr479O09Yt/Rc55omx4DwtOpduSimG5DMROab80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869185; c=relaxed/simple;
	bh=3kb2rSZ83unoM8iTQf9eNEvk87lDtXl/5M1lwDciVh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y0dSZiDSLTUYZUwTE3K8btEsiinynOY5B0vDjEKB3HwDv1Pjto+rl+newC6I7oYHzMwZTYhKHjMpKLCI+k0DYIfVVt4CPpo5t1tZiOVjE/h+6YTSPFd6HfTBDbYIVeQ22ufqmy8i/Lv/QteeYQEJgNdTOz2g7EOel9/y88yiG6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJdM1q+A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJdM1q+A"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DBF7C2BCB2;
	Wed, 22 Apr 2026 14:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776869185;
	bh=3kb2rSZ83unoM8iTQf9eNEvk87lDtXl/5M1lwDciVh4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UJdM1q+AX5BvquMTtsBnq23ksbbqqUGaYrL+GAQHi6HjNalOduINcLI9884ptc+KL
	 yJcmbwxisO3IqsIAm+mtWlPSkjwnV1F1ZUfTnGpafQWekdei8JNFP/XawgxAAI2B+3
	 mzJRCHgiePpLH5CFD0ELCHHmqAx3vgzArOJXPvWO05MwhcoDixactYtVbTZKkr/GIP
	 epBupXQBmFDvsiJVTVOc0xdtwWfHeAromTF3yeZo41zqyjNBrUoCHDuMALWPq5NDTL
	 X9yI3sroAl7ibghGrGCDV5DasWKjcctqwCd7IlLog4xRFUwvQpV6VnFxFJuN3nj6ma
	 7B5xfMZBnfaAQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16420F9EDF3;
	Wed, 22 Apr 2026 14:46:25 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Wed, 22 Apr 2026 15:45:53 +0100
Subject: [PATCH 19/22] iio: dac: ad5686: add ldac gpio
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260422-ad5313r-iio-support-v1-19-ed7dca001d1b@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776869181; l=2053;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=378jN4/xaZA344iqhUUHGi9nfoBwWVzEp0C0waS1ZBY=;
 b=v96yvtPdGymCJ/tIcXH8we6BOqphHO7HhCQzxs7gkP2o/us62Q007vZYxb1jpbsl9PIw04U+N
 GjA4UCaS4OMANNvWUvOMYWk4NXFK6ysv/0pzyTJziY9Yb3zEs01mkv1
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

If wired LADC, should be held low when unused (pin is active-low), which
allows for synchronous DAC updates. This will be used to update all the
channels at the same time when adding buffer support.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.c | 5 +++++
 drivers/iio/dac/ad5686.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index f239880d1cc7..d37b4902766f 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -551,6 +551,11 @@ int ad5686_probe(struct device *dev,
 		return dev_err_probe(dev, PTR_ERR(rstc),
 				     "Failed to get reset controller\n");
 
+	st->ldac_gpio = devm_gpiod_get_optional(dev, "ldac", GPIOD_OUT_HIGH);
+	if (IS_ERR(st->ldac_gpio))
+		return dev_err_probe(dev, PTR_ERR(st->ldac_gpio),
+				     "Failed to get LDAC GPIO\n");
+
 	/* Set all the power down mode for all channels to 1K pulldown */
 	st->pwr_down_mode = ~0U;
 	st->pwr_down_mask = ~0U;
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index e2ed0a2a8ac9..3b7460178632 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -9,6 +9,7 @@
 #define __DRIVERS_IIO_DAC_AD5686_H__
 
 #include <linux/bits.h>
+#include <linux/gpio/consumer.h>
 #include <linux/mutex.h>
 #include <linux/types.h>
 
@@ -123,6 +124,7 @@ extern const struct ad5686_chip_info ad5679r_chip_info;
  * @dev:		device instance
  * @chip_info:		chip model specific constants, available modes etc
  * @ops:		bus specific operations
+ * @ldac_gpio:		LDAC pin GPIO descriptor
  * @vref_mv:		actual reference voltage used
  * @pwr_down_mask:	power down mask
  * @pwr_down_mode:	current power down mode
@@ -134,6 +136,7 @@ struct ad5686_state {
 	struct device			*dev;
 	const struct ad5686_chip_info	*chip_info;
 	const struct ad5686_bus_ops	*ops;
+	struct gpio_desc		*ldac_gpio;
 	unsigned short			vref_mv;
 	unsigned int			pwr_down_mask;
 	unsigned int			pwr_down_mode;

-- 
2.43.0


