Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEFF345CCD;
	Sun, 26 Apr 2026 08:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777192700; cv=none; b=iHoGqApH5SPczqslSEAUJWiPkvt0IWKfOx0I8aVlZSqxWvLHZYDsWxE4C6NiTWNsY0ExvUNNgqE1Oum68cCu4mmL9gZuQjObECPrIJXJ0FVAtIWTrRA0cUhZrzsov/s4jzEYRjLCduSTWEooaVfFVjr96a2avOAqR0HZNzw5NcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777192700; c=relaxed/simple;
	bh=Cbm0UPTOuxFCb3mealagbDc9JbENivgWyAX23J8Thuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PCH8YZp2TlSJumK/dcDSapNRsxj22Zsx5hYYlxhNlBf9r+xcvXCY5/C7EogmCE0iME3qaGpBEKgXv2IgrVrMQ270l/dQXK/22se3jV96Q1S3WhP733QNtXvE2Rdl0hdVl1IQ2aVYJZ5wJ3hy7EqVlUaovdI/BhFl4GQzMGrQxC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXzvuXaQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXzvuXaQ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E8AA0C2BCC4;
	Sun, 26 Apr 2026 08:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777192699;
	bh=Cbm0UPTOuxFCb3mealagbDc9JbENivgWyAX23J8Thuc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qXzvuXaQJMUJ7aHAuomYxtm06Zx1ceVVxyrOTVwdbeeOYFc/LlyAnrXHgM+mD6yR4
	 cNlT+Se8Y2BhJVoqC2IKqz440HG6pxPJjWdkryP0+9mabNOGJ+Nk04+5V4qKE55xGH
	 enjusVzvol5u9oI02QmZ1HLTkMh8l/un4zfkhi1Yl/Tw/vMLHgdBnv+pWc6U0u89+3
	 puejRhLDTmJLOOOOOXNYLJg4CxbBSqAcbxxlC9OUYUck6KMMI5ogp8RXFLkaeRyL/T
	 CuOGk8f4CbaeduWESfer25U0Qhqwr78QYvr+rX6P2taK1NNVDeBJ0xLMAhjavCUjWC
	 tKPdg6u6Gg9bQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10F3FF8860;
	Sun, 26 Apr 2026 08:38:19 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Sun, 26 Apr 2026 09:38:10 +0100
Subject: [PATCH 09/10] iio: dac: ad5686: cleanup doc header of local
 structs
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260426-ad5686-fixes-v1-9-7c946a77794e@analog.com>
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
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777192698; l=1834;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=c0BEZ1A0gywVZfdklIC/KEzn/5Gdqo24dUnmHYw5Cxg=;
 b=NF9zuAarSReVuhrh5bh3ca6e5Kf+m8duh0w3KuYSZyn/jvnDWaMEqhP1BdtVQT4xph/Y5+mx5
 hrp3V7hSCSSDLoB6UxhlfCP+FjfexNL2+3MwpCPqHn9J9xUHyVyHN47
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

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/dac/ad5686.h | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index 7004d0d1d97a..8043cb4ab3cf 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -63,12 +63,11 @@ typedef int (*ad5686_read_func)(struct ad5686_state *st, u8 addr);
 
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
@@ -106,16 +105,16 @@ extern const struct ad5686_chip_info ad5679r_chip_info;
 
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


