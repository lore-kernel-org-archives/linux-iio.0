Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B53949C4A1
	for <linux-iio@vger.kernel.org>; Tue,  6 Oct 2026 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791300783; cv=none; b=k79ExCRpereEx6MoOmGRwRF25CXuhaa8b62YfP7U2MQWAbbI6NcifXBoeaDOhxJjlvdgVHCBCGZK9Pj+2qSvkrwxQuOgoy7axn6D27sXP51yVbpfmKAnVYwAUbu1Ka3djcH9zBd6kVRjiVjy0Sp2GJlkVo/iqXL7r30kDX9kQcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791300783; c=relaxed/simple;
	bh=ZyFQoNDJRwJ1ZwkpG81Du1OLpMt6qaBe+3QwMXgsGyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OS5/QQFsVX8AhqT7J+NN4NH/jeRWNGpUc/avQbWWTyHtS5u39v6eCNy7429nNDw7xiMdfaWut5uhtkuDRPXQ1CEyDUwxLQHJu8h3WIe61SKPSGRbtZtX04OUND9W+dY/pj6ZJfwV/yG38dL5lTdI36UdCBEyNdmIT/07wZfEudA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net; spf=pass smtp.mailfrom=arkamondal.net; dkim=pass (2048-bit key) header.d=arkamondal.net header.i=@arkamondal.net header.b=GqDN4YQX; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=GIEWWUjF; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arkamondal.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arkamondal.net header.i=@arkamondal.net header.b="GqDN4YQX";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="GIEWWUjF"
DKIM-Signature: a=rsa-sha256; b=GqDN4YQXjr1R0pU6OuGEH2FaXDuTAFCuhokl3TZ2xNhiAzD50lunXud4Fw7gs35TSzRB9uAuaahv/ORXkk9wPAlnDN4l1CSVa4y+MwMbrB0EMuUaTN/eOFKJ5dfIv7mnya5uCBs/SsSFuXOjmZa3qKs7nKnADoFmE+DLnloSeZ5JjvIQBAa8DLrxeUTRwx/hX77LmzreKMDNwHM0Nh6nQGU6uYf8NgSSvY2tDXuUtevL377LTr50hVBxaVeVJPA1Z3F14Be+e5e+hrbS3ihup7fQcOm5PzaswBcX+oEhVnG3XA+m1DtCh1EEGUgoDrQUFE1Dhkqm7l2eeZrvF4Hi4g==; s=purelymail1; d=arkamondal.net; v=1; bh=ZyFQoNDJRwJ1ZwkpG81Du1OLpMt6qaBe+3QwMXgsGyc=; h=Received:From:To:Subject:Date;
DKIM-Signature: a=rsa-sha256; b=GIEWWUjFdzd7WVj5VLV8vqfJZJWMAReNwWIZLa8v1/y+TmLO80QrRLi4d6pWS9nAwkQ37/iqDrjS+pvyZ49wqPYIh9lYOlJO+5hg+K7Kn9XGSkatjw3A9yXJLF8qw+GvpbUd8lo3ijw2lXoV1Grl85ppJJRe7k1IG9ZjWXN7g+XWJ315VX2PaBh0/NBK+3MoWRnBQhYs4ko1Yy/UT/EmlnSC3GgRwggVSuvoj4YXfJ6TMvQPyuRUC+j+e21lDmVDX1z+sZjiFnz6fgJVtGbIomDft3ZHAkqlqw69ERgBs/5QJb9ihOWwfcWoCR3ktG3soJwzSmj/oDBzve6RFYvHEg==; s=purelymail1; d=purelymail.com; v=1; bh=ZyFQoNDJRwJ1ZwkpG81Du1OLpMt6qaBe+3QwMXgsGyc=; h=Feedback-ID:Received:From:To:Subject:Date;
Feedback-ID: 1246644:48769:null:purelymail
X-Pm-Original-To: linux-iio@vger.kernel.org
Authentication-Results: purelymail.com; auth=pass
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -1990973388;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Tue, 06 Oct 2026 15:32:34 +0000 (UTC)
From: Arka Mondal <arka@arkamondal.net>
To: Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stefan Popa <stefan.popa@analog.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@analog.com,
	arkamondalofficial@gmail.com,
	Arka Mondal <arka@arkamondal.net>
Subject: [PATCH v2 5/5] iio: dac: ad5758: Fix the 4 mA to 20 mA current range
Date: Wed,  7 Oct 2026 00:32:10 +0900
Message-ID: <20261006153210.364862-3-arka@arkamondal.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006153210.364862-1-arka@arkamondal.net>
References: <20261006153210.364862-1-arka@arkamondal.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by Purelymail

Range code 1010 selects 4 mA to 20 mA (data sheet Rev. B, Table 32),
but the driver describes it as 4 uA to 24 mA. With the reported scale
and offset, userspace converts raw code 0 to about 0 mA instead of
4 mA, and full scale to about 23 mA instead of 20 mA.

Describe the range as 4000 to 20000 uA and rename the enum entry to
match. A device tree that still has <4 24000> no longer matches any
entry in the table, so probe fails with "range invalid".

Fixes: 28d1a7ac2a0d ("iio: dac: Add AD5758 support")
Signed-off-by: Arka Mondal <arka@arkamondal.net>
Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
---

Notes:
    Compile tested only; no relevant hardware available.

 drivers/iio/dac/ad5758.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
index 1e21ad2a050d..4c15447ccb6b 100644
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
--=20
2.55.0

