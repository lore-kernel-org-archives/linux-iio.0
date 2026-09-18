Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1119B4E80B1
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734075; cv=none; b=F5Xml9cu9lRim1qt6Ch5hC1eKloqzK3HZ7e8hVcBZP7htb5nCfb4iUXC0C9mfh8c9CUj9rNcCisNa4Q6c4P/5cKIspMuTy7XGvFx1yJ2FxqYyxzGouxT98Ip5Hbk3fK3X74RuVr19IWLMlF0HDVE6ffe5JP1pWsFJVqWse8Dd5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734075; c=relaxed/simple;
	bh=a07U5kp7Ed56BcaidCAcdWRKpOlR81d1yd1MM3ojZNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QT+wvRZkwY0FtTgL2ECLp5t9GjyI22+rClffkBKLah7a5zgUbfboYKw0UbUNQG/pCIVY44mtHtv5+/47/BQ4GHYbVDuyJiKm+qXJkEfCBspRG6b+CwxG3gDJuT9G8Nzcr3OYLDsYTCdWXgY1Vw0K6c9Z1+O3BK27FvwKXXRaa2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net; spf=pass smtp.mailfrom=arkamondal.net; dkim=pass (2048-bit key) header.d=arkamondal.net header.i=@arkamondal.net header.b=e8NJ7vwn; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Wm13VU4N; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arkamondal.net header.i=@arkamondal.net header.b="e8NJ7vwn";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Wm13VU4N"
DKIM-Signature: a=rsa-sha256; b=e8NJ7vwnoCVNM0jWTGe1403nhCrKGqKxBeJC/WFSkJlTqdu4e/qDvD7hhLYJoO9m5lN6tF8lK+9Ubvrnm2FyjmtnXjFSV6nz1S+Q1vr6FwH9QzvaFuLg2RoImt0Pdw3kMPCE6BhgTcCHJ/CXVlVZkduX4gznAU80L1Miwk+t+bV3ilYe0ZCVhrFDYVkiMXYLopcrcMC9LTlaX4Z+Nz+FwjEm9IOEyM3PUVRkD98M7Q4l8jE19SPegh40fPy5AcCBHgm1HsupWdkCvk4wGpGv2G6kPyHal+drhRnAt44OW4SvOUAJf/HoH9pZCxY3QSks7Jpxzw7cumS4Ec2E46FIVQ==; s=purelymail2; d=arkamondal.net; v=1; bh=a07U5kp7Ed56BcaidCAcdWRKpOlR81d1yd1MM3ojZNg=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=Wm13VU4NDyaQOzeylNe+YJ+zKpOnVlNbpdrYc7GAa8uDpMRGjw2giL/FDO8d8/hlnC6lmEXVM+9LO5lu7VblGglvem+7hinaWVyUCbgt7ellwnu3E/P0agMJTMxT5kmxuCcPE2STWwXiYOokZlXwnh9SLmJVwLFGcrOeWBElPejdJ1+Lf6XJMpUKkd3Z/9dYK7n1lnRh5gWgMdQh9EyQgle6I/MHF+onqGfuCFb2HtM423DU2IA4xexxbaBCTiu2ITmuAyPeo9PsQIIQDBJ+ARLvJ+s9Twp8Cw7rZGTp/BEaJ2zIQ8jkhJqbtMzaX/GO3GSFX2pAbtH10FhP6ODPhQ==; s=purelymail2; d=purelymail.com; v=1; bh=a07U5kp7Ed56BcaidCAcdWRKpOlR81d1yd1MM3ojZNg=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1246644:48769:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -450814046;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 18 Sep 2026 12:20:51 +0000 (UTC)
From: Arka Mondal <arka@arkamondal.net>
To: Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arkamondalofficial@gmail.com,
	Arka Mondal <arka@arkamondal.net>
Subject: [PATCH 1/5] iio: dac: ad5758: Fix alignment for DMA safety
Date: Fri, 18 Sep 2026 21:20:28 +0900
Message-ID: <20260918122032.134947-2-arka@arkamondal.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918122032.134947-1-arka@arkamondal.net>
References: <20260918122032.134947-1-arka@arkamondal.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail
Content-Type: text/plain; charset=UTF-8

ad5758_spi_reg_read() reads into st->d32[2] with spi_sync_transfer(),
but d32 is not marked __aligned(IIO_DMA_MINALIGN), so it can share a
cacheline with the fields before it. When DMA is not cache coherent,
the cache invalidation after the read can discard CPU writes to those
fields.

Mark d32 __aligned(IIO_DMA_MINALIGN). It is the last member of the
struct, so nothing comes after it.

Fixes: 28d1a7ac2a0d ("iio: dac: Add AD5758 support")
Signed-off-by: Arka Mondal <arka@arkamondal.net>
---

Notes:
    Compile tested only; no relevant hardware available.

 drivers/iio/dac/ad5758.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index 44efa373cd80..ba381bd252d1 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -117,7 +117,7 @@ struct ad5758_state {
 =09unsigned int dc_dc_ilim;
 =09unsigned int slew_time;
 =09bool pwr_down;
-=09__be32 d32[3];
+=09__be32 d32[3] __aligned(IIO_DMA_MINALIGN);
 };
=20
 /*
--=20
2.55.0

