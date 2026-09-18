Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E194E781B
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734093; cv=none; b=EiLwac6WnYZg0ig3u9i/+Lsg6Rq/QZXBcJA6pDGZuvXKzo8KNMUvj/lrQ9DrQaVDLhDM9mNyX/MXMRrYunFVRujTSwii8Rrrui4eIbVEDWJK9/nYYK0tQ38VTm2rp97vFZX5/8dsPUShJaMmUowCyZzXLxpqCVUySYkQ5kqEfaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734093; c=relaxed/simple;
	bh=3W5C2796scL1/2OyZXCyBa69zoV5O+l8I3JiNOsPG1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tk6ysmGIsCXTAR5Pvw1jgjGeRP0pdp6nPBEZHDXitGvRipkD31dp0RfydXvNP/0wrB68yyfaFgwqnyQXsYu0rtd0ivyhWw5/MJrWjiZit1tipKJT6t8KKvh193hWeZUdYeYNfayKVjAAFY9VPDEVMapV6zprVwCDJ+/ap5PYcVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net; spf=pass smtp.mailfrom=arkamondal.net; dkim=pass (2048-bit key) header.d=arkamondal.net header.i=@arkamondal.net header.b=iKKniw34; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Mw9NieBh; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arkamondal.net header.i=@arkamondal.net header.b="iKKniw34";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Mw9NieBh"
DKIM-Signature: a=rsa-sha256; b=iKKniw34QGt1RnfPqgD7aWTuV+gA/dsto3IpW5q2/6XClb4WP1H/re0GZj0aY/HbPicotMh66E5St+hmJ+3v8KCU2b92z7odfXjKjKwcccoxcAn8zUnTl2JL0Vljffk/qroaL2luIV6md9XaDOytJ93q7zekb8V6Jkawt1eJs/O5G5aLoeiUmHs0Di/JWUzX9CS9BRRKvRckQ9qRpDUVETPVucPl2rweU1GjgGDhBJnLzUamfDiXDgPwT9zdCdCetGxEuTvum2nUvv0EzDwl1Fu2aWMQFN/RaXNlEfcylXMf3Emt3MklO+K5tF6ruCfLPBnWcuV6bNJS5jqWRFpbZw==; s=purelymail2; d=arkamondal.net; v=1; bh=3W5C2796scL1/2OyZXCyBa69zoV5O+l8I3JiNOsPG1s=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=Mw9NieBh0cu5hEJVKYVdRoMkeslcT7GQSsFtqB2fZkRI+tyg728cdWkoJRa4VHU1su4r0beyyQYiA9bWXppH7rhOHXgCF+tcehI2gb4lbkpc7RzHirER3KjLppBI60tRYnw7Q4P6DjGMU72DxmTvYkYU3pgPdCNBeu9w5OyJlDsclQx7YhbScC5g/Hv3qd+HoQR7nco/oOdKhsgWKM923clh6AojupRVF9xcY6VJ5CXTLLe3foxTGnaWvSOpoiV1qvLTyEajaY0OiI5NVOaP34aQ8qZ/M0CTFnVkQf0k25U1s85spO018bCMtsZ56TfNCR9eR73wdEPrxUaNBqt/dw==; s=purelymail2; d=purelymail.com; v=1; bh=3W5C2796scL1/2OyZXCyBa69zoV5O+l8I3JiNOsPG1s=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1246644:48769:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -646422619;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Fri, 18 Sep 2026 12:21:02 +0000 (UTC)
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
Subject: [PATCH 5/5] iio: dac: ad5758: Fix the 4 mA to 20 mA current range
Date: Fri, 18 Sep 2026 21:20:32 +0900
Message-ID: <20260918122032.134947-6-arka@arkamondal.net>
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

Range code 1010 selects 4 mA to 20 mA (data sheet Rev. B, Table 32),
but the driver describes it as 4 uA to 24 mA. With the reported scale
and offset, userspace converts raw code 0 to about 0 mA instead of
4 mA, and full scale to about 23 mA instead of 20 mA.

Describe the range as 4000 to 20000 uA and rename the enum entry to
match. Map the deprecated <4 24000> device tree value to the corrected
range, so existing device trees keep working.

Fixes: 28d1a7ac2a0d ("iio: dac: Add AD5758 support")
Signed-off-by: Arka Mondal <arka@arkamondal.net>
---

Notes:
    Compile tested only; no relevant hardware available.

 drivers/iio/dac/ad5758.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index 1e21ad2a050d..b152001f38d4 100644
--- a/drivers/iio/dac/ad5758.c
+++ b/drivers/iio/dac/ad5758.c
@@ -141,7 +141,7 @@ enum ad5758_output_range {
 =09AD5758_RANGE_PLUSMINUS_10V,
 =09AD5758_RANGE_0mA_20mA =3D 8,
 =09AD5758_RANGE_0mA_24mA,
-=09AD5758_RANGE_4mA_24mA,
+=09AD5758_RANGE_4mA_20mA,
 =09AD5758_RANGE_PLUSMINUS_20mA,
 =09AD5758_RANGE_PLUSMINUS_24mA,
 =09AD5758_RANGE_MINUS_1mA_PLUS_22mA,
@@ -164,7 +164,7 @@ static const struct ad5758_range ad5758_voltage_range[]=
 =3D {
 static const struct ad5758_range ad5758_current_range[] =3D {
 =09{ AD5758_RANGE_0mA_20mA, 0, 20000},
 =09{ AD5758_RANGE_0mA_24mA, 0, 24000 },
-=09{ AD5758_RANGE_4mA_24mA, 4, 24000 },
+=09{ AD5758_RANGE_4mA_20mA, 4000, 20000 },
 =09{ AD5758_RANGE_PLUSMINUS_20mA, -20000, 20000 },
 =09{ AD5758_RANGE_PLUSMINUS_24mA, -24000, 24000 },
 =09{ AD5758_RANGE_MINUS_1mA_PLUS_22mA, -1000, 22000 },
@@ -747,6 +747,12 @@ static int ad5758_parse_dt(struct ad5758_state *st)
 =09=09=09=09"Missing \"range-microamp\" property\n");
 =09=09=09return ret;
 =09=09}
+
+=09=09if (tmparray[0] =3D=3D 4 && tmparray[1] =3D=3D 24000) {
+=09=09=09tmparray[0] =3D 4000;
+=09=09=09tmparray[1] =3D 20000;
+=09=09}
+
 =09=09range =3D ad5758_current_range;
 =09=09size =3D ARRAY_SIZE(ad5758_current_range);
 =09}
--=20
2.55.0

