Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCCA346766
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 12:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734081; cv=none; b=fTFhr3yCp6XX2s6d+lp1U6nU01KPVFHs8F6Z1IdcGWBeHi+m59vYeC/wGEGyOprPcdYUbJ7bYz+gPsV0MROqnGoX898IcB3H5eS4DT7pStket2grO4bBxtScv3sPMV5EU/lCn6tinAssE45BlbZB/X6QSvSU9c3Miex3C7LsV98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734081; c=relaxed/simple;
	bh=ch9ve9LQc6Qi8boGhcrG9lniA/EangmgdJ2IcddcQ0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dSYZVVRV6ntuZGZ1NZCQb0zfOb4PdjwZHXAfZSRCpFQ+w8s7j/MDrtUJtRI4pbrrHuulpiVuZiohpxV4xKfyuDruvZanY7uQwbQKLqrONQrAbDl8lac+ppwbp2EvxvthbVjNOeRWTs7SgtkYzxLFJIIqgVr6JJP9nSDBS/n5GjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net; spf=pass smtp.mailfrom=arkamondal.net; dkim=pass (2048-bit key) header.d=arkamondal.net header.i=@arkamondal.net header.b=mbtnZaa8; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=N2RC5Tly; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arkamondal.net header.i=@arkamondal.net header.b="mbtnZaa8";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="N2RC5Tly"
DKIM-Signature: a=rsa-sha256; b=mbtnZaa8rOJRE6LUGuCasPAjdBOOXlgr0Eu1bBaxxeb3gXdzJmZdUuceuahICnfdtjYGJBzhknE8CEzBtGjP71gZxMGLgHQyrufMaVscip2vhiGuv1hnCUtDx6ZGtoDRnk7Erv2ndbJVbvGRyv8y+f8wizXQ7sP2q+OgOhoDnBJi4lGpOPJBRPCbbLol+uckOuNQAXt6bvm14wFwTFdHsXQzXYOjcE2eZw61I8pwmLwr0VtTzap5mALydGjqTu+GHNbCahWeAEA/YrEjKNJHG7FA2L0bgGivhLvBlDNap1BjcevZOPHAcGxTK8Y7JlWnCGKrQPVvMWF0yvZuZeePWQ==; s=purelymail2; d=arkamondal.net; v=1; bh=ch9ve9LQc6Qi8boGhcrG9lniA/EangmgdJ2IcddcQ0Q=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=N2RC5TlyEsV8HQbwsrVD0GRsp9fL1DtI6XJn64yybnuaQ3pRDwlq/TaXXxuhpi92C/H5RRoOBm4P18lp1uu70Nr2JaYq4IXjMhPNPICEvCs6/Q1RRpZWv573VtXLWOnjVKOlRClzwwrQEIkQN95Mfl/CoRJI6hqHC57crURYmjNiOwpGrcyxElb4kQ607NdCTD1mRbHxNzIjsnRHooolfD2K4L5b18STpIIwbev47T8HL39O/sysX7mgJhLTISo7tWfPAsfZS+b+Gro0cNChtmDeQ9R9ZX//gvvyqJO2TbUZNss/PPrIlObkLjtZN2WHHM9iJEduMW8D9d7QttfR7g==; s=purelymail2; d=purelymail.com; v=1; bh=ch9ve9LQc6Qi8boGhcrG9lniA/EangmgdJ2IcddcQ0Q=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1246644:48769:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -934585299;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 18 Sep 2026 12:20:56 +0000 (UTC)
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
Subject: [PATCH 3/5] iio: dac: ad5758: Fix the offset calculation
Date: Fri, 18 Sep 2026 21:20:30 +0900
Message-ID: <20260918122032.134947-4-arka@arkamondal.net>
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

The offset is a count of DAC codes, so the microamp or microvolt units
of min and max cancel out and the final division by 1000 is wrong. For
the +-20 mA range the driver reports -32 instead of -32768. For the
+-5 V and +-10 V ranges min * (1 << 16) also overflows int, and the
reported offset is 0.

Drop the division and do the multiplication in 64 bits.

Fixes: 28d1a7ac2a0d ("iio: dac: Add AD5758 support")
Signed-off-by: Arka Mondal <arka@arkamondal.net>
---

Notes:
    Compile tested only; no relevant hardware available.

 drivers/iio/dac/ad5758.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index 2a9e907b5eb8..1e21ad2a050d 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -9,6 +9,7 @@
 #include <linux/bsearch.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/spi/spi.h>
@@ -540,7 +541,7 @@ static int ad5758_read_raw(struct iio_dev *indio_dev,
 =09case IIO_CHAN_INFO_OFFSET:
 =09=09min =3D st->out_range.min;
 =09=09max =3D st->out_range.max;
-=09=09*val =3D ((min * (1 << 16)) / (max - min)) / 1000;
+=09=09*val =3D div_s64((s64)min * (1 << 16), max - min);
 =09=09return IIO_VAL_INT;
 =09default:
 =09=09return -EINVAL;
--=20
2.55.0

