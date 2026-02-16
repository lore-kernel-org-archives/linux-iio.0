Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FEB2D77E3;
	Mon, 16 Feb 2026 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771261853; cv=none; b=fzta646viVeFNSbLaX2F+MKvEzhPLAn2uENpGcqT/8PfjLe3JK5Gg9pwvG0x1IQ6E8+ppHe5Y3EFuj/e8mGt6zgNrV3zdwCPMKPXZBNmnDmYEegwGK6dOtvn5q260CsSr/FZYMiAeevxSG/KDoxQW2Cc0A06SzH2TRgcwxdWrvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771261853; c=relaxed/simple;
	bh=kK87cTU4G81SqasFsmZlFGyid0u7KnD0LcPWzRhX0d8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oNy93o0kWI0wlDmMmQXaBCqF6kyUHHOvVyj3MdPsT6ggNzPrtY4966g292X98fv4pnlLXN1DFhGAE9b1VAQgT4fJ+1qNAz3Wf3Suy30upNUhztDzf4cLT34znk4GaHkSmShjIOpRkMxJzP+bEWB7x7QU7DGbch4YlWoqUtnK3oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUVxP8dE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUVxP8dE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 984E3C2BCB2;
	Mon, 16 Feb 2026 17:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771261853;
	bh=kK87cTU4G81SqasFsmZlFGyid0u7KnD0LcPWzRhX0d8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=YUVxP8dE79tlqa8FVf9SdV/GMcH4M+Z0CoIFqNIuSOc0aj+NkvbYDxe5vkOSa9989
	 JmQpsim4y6bEOHnFIbGu/zbTbK3m1kGB+YftmsTuvWzUOYng0GtPEaN+T6RkjCNYYs
	 I8YSNpsLNyJUaiggkeukYaXF5aAeulDGLcC2EOc0DUOV3NsrWImD5/FcsDpmxvl3oC
	 SYEVMiF2Nzoa+ywiLA8wP2u9ZiaNreWET/rWC0C1SXWm1hlD0pwUlVPbZAGRjd85OJ
	 VYnd10ohMIXkNM1o3e8hfSwDLth/l2/pSYXoA5oUROSjwJRSU2suKQdyuN9tDAAXaa
	 5q76i6g3QGHtA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0D9E81A32;
	Mon, 16 Feb 2026 17:10:53 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 16 Feb 2026 17:10:48 +0000
Subject: [PATCH v5 04/11] iio: amplifiers: ad8366: add local dev pointer to
 the probe function
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260216-iio-ad8366-update-v5-4-7e6091357d02@analog.com>
References: <20260216-iio-ad8366-update-v5-0-7e6091357d02@analog.com>
In-Reply-To: <20260216-iio-ad8366-update-v5-0-7e6091357d02@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771261851; l=1006;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Ou/8WMhF7+AKa6GUeABGRew50pWjtWQbhob86fa1e1g=;
 b=AYfam7BpNMyle/XdIo6jM8ZbQWBDr5tpXDxBDpVQNhMfc7ARSj710xAKrc3GSbB+sNNt2uad7
 CjnRLEkcfZTB5oncvmpESApnjBCunwsKlBe7xoyEFG6YGyCZa6dXNyf
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Create local device pointer in the probe function to shorten lines, making
the code easier to read. The local device pointer replaces &spi->dev and
will be reused across other probe function places in later patches.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 8dc639d30dbb..677d02f4f075 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -248,11 +248,12 @@ static const struct iio_chan_spec ada4961_channels[] = {
 
 static int ad8366_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct iio_dev *indio_dev;
 	struct ad8366_state *st;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (indio_dev == NULL)
 		return -ENOMEM;
 

-- 
2.43.0


