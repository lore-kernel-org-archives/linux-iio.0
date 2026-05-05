Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC66441044;
	Tue,  5 May 2026 12:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984510; cv=none; b=atAdeWY1xSoBsC3HLF6Q9G0wAhqywMe3c2un78eWeLgsmjMM9HEzBda9kRw4IdUA4meOkKzTdj/MOeaml2wprcaKaDKFtijiu5Iq5kxRnm9iIZfPC1/LzvVQO0VM9k4ytVSsJ64bnhp1370GDn537UEOKpBNJY5k0Me2wYFWTHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984510; c=relaxed/simple;
	bh=bb/UWgCIu6K/3vdlLrr7kCALX/SM0rT2dT20k/YzzAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ePAIPk2HG69zlGVGu7UuzjcoLNCCQQNrogjSgK8sDptgV6YXUMLbbWPdnMQ7IzsyGM522aALzdqEEOxzfeU0pc3MW8/E9UpFUOk2u0vSqZzyQiEuY1s4sLz1kcwemOItqPbeYT519lOydtBk7YH55/oeeRK3HZ49hIq1uReldxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3W2G1x/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3W2G1x/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B9A9C2BCF7;
	Tue,  5 May 2026 12:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777984510;
	bh=bb/UWgCIu6K/3vdlLrr7kCALX/SM0rT2dT20k/YzzAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=l3W2G1x/SaitbdnQr5VW8gDWdKM0wJ7l6CYkjk6maDayFPuS6k8HleXOE3Iz6ypW/
	 WeYYyLgUM3cPmmVkbdX1tMmj5Gcthpqn717Vat8MXuV7GpXDp2KrFBDJoMG+P+LcNv
	 bzagf+dv6yWJ72dbLF8fylwQ4P9tuFsNiulPasHJfnGHwF/lUlmN/UI2SqcIZXI8X2
	 LSD8I8kKAxnxFuvJ+FsaiyQjXIg0L2c6fWfcYyN4Cb7RCCyILrbPquKSlqOZRtjd3/
	 irU5cLdVjV69r4M7GT7yCI+beXkiSA3Al6OfRcG/MjBFUogK7Uk5/S+T7Ediq2lwRP
	 N7xvncCCYw3Vw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A00FF885A;
	Tue,  5 May 2026 12:35:10 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 05 May 2026 13:35:12 +0100
Subject: [PATCH v6 11/12] iio: dac: ad5686: cleanup doc header of local
 structs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-ad5686-fixes-v6-11-c2d5f7be32be@analog.com>
References: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
In-Reply-To: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777984508; l=1894;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=9M9FWK1fBxPndrzRZIkO8E7OkPdoP0n0+s7M4QAkbIw=;
 b=vHsb9LC5podKC63Z3q3ixSPwG7t29SNWHag83P++WUQsROJu9kvfz2uDKbcIvhtZE3CxjOTlQ
 QEeChenhSVeAYT7vcgmGLy8qxr4VnYUlQD/xdWVkN9R86Fe2wU3wncA
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Review documentation comment header for ad5686_chip_info and ad5686_state.
Update variable names and description and remove unnecessary blank line
between comment and struct declaration.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 17980c54839c..3945f5fb6b7e 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -69,12 +69,11 @@ typedef int (*ad5686_read_func)(struct ad5686_state *st, u8 addr);
 
 /**
  * struct ad5686_chip_info - chip specific information
- * @int_vref_mv:	AD5620/40/60: the internal reference voltage
+ * @int_vref_mv:	the internal reference voltage
  * @num_channels:	number of channels
  * @channel:		channel specification
  * @regmap_type:	register map layout variant
  */
-
 struct ad5686_chip_info {
 	u16				int_vref_mv;
 	unsigned int			num_channels;
@@ -112,16 +111,16 @@ extern const struct ad5686_chip_info ad5679r_chip_info;
 
 /**
  * struct ad5686_state - driver instance specific data
- * @spi:		spi_device
+ * @dev:		device instance
  * @chip_info:		chip model specific constants, available modes etc
  * @vref_mv:		actual reference voltage used
  * @pwr_down_mask:	power down mask
  * @pwr_down_mode:	current power down mode
  * @use_internal_vref:	set to true if the internal reference voltage is used
- * @lock		lock to protect the data buffer during regmap ops
- * @data:		spi transfer buffers
+ * @lock:		lock to protect access to state fields, which includes
+ *			the data buffer during regmap ops
+ * @data:		transfer buffers
  */
-
 struct ad5686_state {
 	struct device			*dev;
 	const struct ad5686_chip_info	*chip_info;

-- 
2.43.0


