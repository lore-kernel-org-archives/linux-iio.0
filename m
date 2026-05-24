Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E41A391507;
	Sun, 24 May 2026 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779617842; cv=none; b=FSwHW/+aab8K4U54MuJ4sfb/qDKSj8Ti1OQ9pEWWVRx+Y7UgMu6UDZ+Gn5PHst2ba2vHeJpHNgu32kNQAxHZuKSV9UHWAoqOlHTJG7MBfteGGBWZsWD+th+bvQmfpq84xWXWOqMNqdT9G5jvzcz49GsF0bkYomfyIdmE1fluStQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779617842; c=relaxed/simple;
	bh=bb/UWgCIu6K/3vdlLrr7kCALX/SM0rT2dT20k/YzzAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ur1gAmVmxkIN9F1LwEpXfh/7Q0km0LHMlHghw0Eb7RbrlTasKlwDRehjkJefDEXxcDvR/IswK5TQDoGjEO06ZohTHLohq8MS/pOq5AxcPIi++3cw+BDPbNcsfXY2S1vylBAAEVmjjn4Bf4Sg7w5mkR5y0Cpub6eJZwyw7uWsKHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ou1+1JEt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ou1+1JEt"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67F2DC2BD04;
	Sun, 24 May 2026 10:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779617842;
	bh=bb/UWgCIu6K/3vdlLrr7kCALX/SM0rT2dT20k/YzzAc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Ou1+1JEtophLNFukjGESXuaO89oOT/jejMI1Kr0fw6bnS4AZeS69GPEY404uDChwd
	 YDRTS9DZnL6K3WIoC56bDxy+PGYwxrxk3pPB//kw1lwWyASVr7MflGRuyY5l8ZzSZ3
	 ZBKY0zGs+7zmd10QqPfi2jQLi+yinag7+loFI8LydQXpBFaYEG8KX9+vRI1D/BK8qF
	 DB1uCKnMcUj31jNsihRN1wYR6ySzhsw1zP4b6mNw/6pgOOnVgrVbHxG2+SqZgpYz2u
	 PqthkR81hQV26tnYoTuG7L2gKF7XtbDU1Zzj+pySptMTjmS5yB8w4KMC/u1HeWK2Hj
	 0YBEmEueKls1w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611E8CD5BAB;
	Sun, 24 May 2026 10:17:22 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 24 May 2026 11:17:07 +0100
Subject: [PATCH v7 7/8] iio: dac: ad5686: cleanup doc header of local
 structs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260524-ad5686-fixes-v7-7-b6bf395d08bd@analog.com>
References: <20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com>
In-Reply-To: <20260524-ad5686-fixes-v7-0-b6bf395d08bd@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779617840; l=1894;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=9M9FWK1fBxPndrzRZIkO8E7OkPdoP0n0+s7M4QAkbIw=;
 b=yCmhXMZo8mBz11L9Psc3URynDqCrZQUsnl2DQyTcgx1vYMU7gawVdXzv6cWEVagkK2tcvbKSn
 X1HEVFalWDnAmAGQgXvyLU7p+OEuVcM0l5Afb8qp3pWlgblXrSqf87K
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


