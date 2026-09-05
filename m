Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1548A36728B;
	Sat,  5 Sep 2026 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788615605; cv=none; b=lD5AD/okUsPEzW7/oIYBlJs0F0nq16xsL89FVfpPmT0hvqUYR7bDUItI74TGCWaHwFpk71yML3vv5GTEUVm/f5uQ252DZIuAJ0ngQ0qtDhiT7WkXzgVs4h9p/5D/T4XuDaSg3Nc5bonGWskWsZpyeUvX8xUgCod+wbOuLfoUvBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788615605; c=relaxed/simple;
	bh=6CC5ySQF3fs8cgknQ8tNJnwua2n/QL4nwl82goBaMws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/LOlCIIesOmodK1fCQRc10n6EIGT6ec77SJcYIaIuP7HLbCdOczFzkMec8Wr51vfMbH5e3QlAiR5rl90xpaYIzMi4GXEcFZSzQp1x+ikEsnpyZ8uHC/f8ZVR7/tN1eg2/3Kd0iB6ELLcW172Ov7opUl3fdCKoRSPzD6B00TYfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=KBdpJCZC; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="KBdpJCZC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Tz
	TBptFZYg9+VFT1PVPN+bck6iwxRVwubrXxsauM0q8=; b=KBdpJCZCxyCJUJEzOZ
	sMpWxAUwFuZmzFGs8br3APN8zVn9yLAfb6e8f8KoMgAD5ywpgUcbkJdM2GmxYUVY
	YBx4ToUecfwdguc1xeqI5w85YwPUjF3jc+AUQEi0djI1W8TV5RirMdmhvLTCTu5r
	2SKiNAORW9wlLqPJFs++lq8aI=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wB38SadG5xqgvBWAw--.7336S2;
	Sat, 05 Sep 2026 21:39:42 +0800 (CST)
From: "hpp.iscas" <hppiscas@163.com>
To: Nuno =?utf-8?q?S=C3=A1?= <nuno.sa@analog.com>
Cc: "hpp.iscas" <hppiscas@163.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: cdc: ad7150: fix OF matching and publish module aliases
Date: Sat,  5 Sep 2026 21:39:39 +0800
Message-ID: <20260905133939.66210-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:_____wB38SadG5xqgvBWAw--.7336S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr1DJr13ZF4Uur17WFW8Xrb_yoW8JFWUpF
	4DZFyFkr15KFWa9a4jvF18uF98G3Z3A3s0kr4UGw4fuws8GFyUZFWvkaySkr98XFWrGan3
	Xr4jyr47uan7AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UqYL9UUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxh6veGqcG54jzgAA3R

The positional initializers in ad7150_of_match populate the name member=0D
of struct of_device_id, not compatible. Consequently the table does not=0D
match the compatible properties documented for AD7150, AD7151 and AD7156.=0D
The table is also absent from the module alias metadata.=0D
=0D
Use designated compatible initializers and publish the corrected table.=0D
Keep the existing I2C ID fallback and per-device driver data unchanged.=0D
=0D
Fixes: 89f2d5b080bc ("staging:iio:cdc:ad7150: Add of_match_table")=0D
Signed-off-by: hpp.iscas <hppiscas@163.com>=0D
---=0D
 drivers/iio/cdc/ad7150.c | 8 +++++---=0D
 1 file changed, 5 insertions(+), 3 deletions(-)=0D
=0D
diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c=0D
index 2f35c6d..b36ac4e 100644=0D
--- a/drivers/iio/cdc/ad7150.c=0D
+++ b/drivers/iio/cdc/ad7150.c=0D
@@ -636,11 +636,13 @@ static const struct i2c_device_id ad7150_id[] =3D {=0D
 MODULE_DEVICE_TABLE(i2c, ad7150_id);=0D
 =0D
 static const struct of_device_id ad7150_of_match[] =3D {=0D
-	{ "adi,ad7150" },=0D
-	{ "adi,ad7151" },=0D
-	{ "adi,ad7156" },=0D
+	{ .compatible =3D "adi,ad7150" },=0D
+	{ .compatible =3D "adi,ad7151" },=0D
+	{ .compatible =3D "adi,ad7156" },=0D
 	{ }=0D
 };=0D
+MODULE_DEVICE_TABLE(of, ad7150_of_match);=0D
+=0D
 static struct i2c_driver ad7150_driver =3D {=0D
 	.driver =3D {=0D
 		.name =3D "ad7150",=0D

