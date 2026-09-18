Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83EA42902E
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 12:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734078; cv=none; b=mm0YCvbtuN4QIqmsfdnpBWm0wc64hzC0VRRhvW0axOWxzkY7TXBoMUNph5x6i/V8iiZm6RT9Vra5yWvbjzrHoSBGzgqhmJBmbbUXa8R8tLx5S324eYZ32LipV6jJDDT5TgcwwKn9LllJRj02UYp/TuG9XjnPRGkIMvsrOPkfvDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734078; c=relaxed/simple;
	bh=ib4SDiCj1gxthZP03lLIECcZx7+5SyPWlQBW0JrWDow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EnmQjWPUdAkJXR6rULoFCntvsjUylioiwY09r55sae20rmwQL4opf+kyMPBULDDmCdBOpIZkPL6pOEu2cvliK9NP6UdbU6/cwk52dmQF2Aoa/R+PF5DujwTMgylMC7Fbh2d4BOLjDuNc6y22OCJ2NpH6uruE99Sr+P1Azp+cvCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net; spf=pass smtp.mailfrom=arkamondal.net; dkim=pass (2048-bit key) header.d=arkamondal.net header.i=@arkamondal.net header.b=dudFhndH; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=WZJkOXZx; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arkamondal.net header.i=@arkamondal.net header.b="dudFhndH";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="WZJkOXZx"
DKIM-Signature: a=rsa-sha256; b=dudFhndHLz3pF2gVpwCdmN7F6QkBFZ9gADI7hjXL3PNC/wQSFYFeIsx40op+MLEOKXO6rYck/Xb4ZBwQiodTL9GrFF6WcCkFZLy5hRSdL/BEZdSApdXyP8wNWvLMGqqA/booMM5pWExVMZXxTY5usDVM6QPrHeOOSKLiedDlIhJIjjjyJCL6vT46iR2xb7CWJxbq/i8V1mZKjiZmZ8J7CLjhv6V67R9vBZe4D1lxP7bmZVZZK5T2Hw//NujPOXRVa8UhD3TxSRKg0RdzRnxQA/u5HPUa3tKq3oxwpTURVmgMjUKLivycr0cd1ptwWLPQgl20U5WlqhvfHAbVl2hExA==; s=purelymail2; d=arkamondal.net; v=1; bh=ib4SDiCj1gxthZP03lLIECcZx7+5SyPWlQBW0JrWDow=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=WZJkOXZx63nbDfbFVYfZf+F4GC0l/BETUBMnrb+yxgdRQjiVBjS/ZXKG3HhbicxKR/5IJIS0NW7azerC0uLCkZvoSJVRcBXTgoDSd2zqtRPJil9iFriuOWxL+Sn25aO8+S1JBT1+ffrd1B5kHY4C8QteDVBLgwHCpWb+YLub8Ge4cAF6BI+UfjZYwOKNmG4KlZRB+X/4nh+r9To+mW6Pr++Gl3c+Ys1qx+cMrZuULP/t9OeuKeZh1xK7jIeekB25g1u8owFj0VC+78gZgW3lacA0Lje7Bb8jsI1X92FslylJ/2Ra/g1WcLCrP0vsYHavGStiriKz9FAtKIzC5vGfNA==; s=purelymail2; d=purelymail.com; v=1; bh=ib4SDiCj1gxthZP03lLIECcZx7+5SyPWlQBW0JrWDow=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1246644:48769:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1394276197;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 18 Sep 2026 12:20:54 +0000 (UTC)
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
Subject: [PATCH 2/5] iio: dac: ad5758: Reject out-of-range raw values
Date: Fri, 18 Sep 2026 21:20:29 +0900
Message-ID: <20260918122032.134947-3-arka@arkamondal.net>
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

ad5758_write_raw() passes the value from userspace straight to
ad5758_spi_reg_write(), which keeps only the low 16 bits. Writing -1
to the raw attribute gives full-scale output, and 65536 gives code 0.

Return -EINVAL for values outside 0 to U16_MAX, as ad5755 does.

Fixes: 28d1a7ac2a0d ("iio: dac: Add AD5758 support")
Signed-off-by: Arka Mondal <arka@arkamondal.net>
---

Notes:
    Compile tested only; no relevant hardware available.

 drivers/iio/dac/ad5758.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index ba381bd252d1..2a9e907b5eb8 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -556,6 +556,9 @@ static int ad5758_write_raw(struct iio_dev *indio_dev,
=20
 =09switch (info) {
 =09case IIO_CHAN_INFO_RAW:
+=09=09if (val < 0 || val > U16_MAX)
+=09=09=09return -EINVAL;
+
 =09=09mutex_lock(&st->lock);
 =09=09ret =3D ad5758_spi_reg_write(st, AD5758_DAC_INPUT, val);
 =09=09mutex_unlock(&st->lock);
--=20
2.55.0

