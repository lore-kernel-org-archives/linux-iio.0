Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D5C19D065;
	Sun, 20 Sep 2026 03:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789875214; cv=none; b=VXjiNFj9S6p5KhusdKhuyng7svpGz5x2KKpiTqt0q+a/QQ4oVuBDkzGVBhUGd9GpaBRtYk2I4L7JcKhKTPUxw8OrH83e5CSB87BdMaDpx4ZmXUPsYtkBo5WkqeKyzFj3H70sKrcbdQv61GeGas1cEi3Y3pINAR+zaWyQZvMFFDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789875214; c=relaxed/simple;
	bh=yTcOxy54RfrT5BmhhvJpQ+22VWA7MNMCgrbs6wMFRZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aMUAjZYC+dmzfU7EkuDY1n34AriQWb+Ih1XyGh265Jo+T6YYpmZknoYnvSC86r+ckX0pYDgmZ43Am6M3tkehV7Xiyv/toSnTUpa/dKlt8apNJxotK9E1R5sTdz0iWEe18zX5R88EkV/rU2kTcMruqXatI/tzFoez+RW+m3H3C0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=LLcdnBdF; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="LLcdnBdF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Gy
	KQdaB9T27anvxUSlIVIK7edWszZ6M3M7OiCI+M7go=; b=LLcdnBdFKS6ywCIPio
	zuqH8Te+qLt97gYy7mQxPMV75WwePaEes4MlhAo5u8zkqiMAXptM5+t+qwGfxG7k
	LWAclePVvrGTVmiFzMk/aS9wiv0qzMSVXctCaQonplYu7wVtwplHjIXDsHmtUEgK
	ahgy9IJPG0QUyx5+htiU4uKAs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCXxwXwU69qNLgNBw--.53728S2;
	Sun, 20 Sep 2026 11:33:05 +0800 (CST)
From: Pengpeng Hou <hppiscas@163.com>
To: nuno.sa@analog.com
Cc: michael.hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hppiscas@163.com
Subject: [PATCH v2] iio: cdc: ad7150: fix OF matching and publish module aliases
Date: Sun, 20 Sep 2026 11:33:03 +0800
Message-ID: <20260920033303.11879-1-hppiscas@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCXxwXwU69qNLgNBw--.53728S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFWkWrWxXFWUuw4rGF4fGrg_yoW8WFW7pF
	srZFyrKry3KayakFWjv3WfuF98Wwn3A34DKFW5Kw43u390gFyUuFWvka1ftr98XF4xGana
	qw4jyw4Uuw4kZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U8l19UUUUU=
X-CM-SenderInfo: 5kssx2xfdvqiywtou0bp/xtbCxhSYYWqvU-Rq+AAA3b

The OF match entries use positional initializers, which initialize the
name field rather than compatible. Consequently the advertised AD7150,
AD7151 and AD7156 compatible strings do not describe OF compatible
matches. The table is also not exported for module alias generation.

Use designated compatible initializers and publish the OF table. Keep
the existing I2C ID table and its device-variant selection unchanged.

The issue was found by our static-analysis tool.

Fixes: 89f2d5b080bc ("staging:iio:cdc:ad7150: Add of_match_table")
Assisted-by: gpt 5
Signed-off-by: Pengpeng Hou <hppiscas@163.com>
---
Changes since v1:
https://lore.kernel.org/all/20260905133939.66210-1-hppiscas@163.com/
Use the submitter's full name and rebase on current mainline; retain the
reviewed code change.

 drivers/iio/cdc/ad7150.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/cdc/ad7150.c b/drivers/iio/cdc/ad7150.c
index 2f35c6d2f9ce..b36ac4e2dae8 100644
--- a/drivers/iio/cdc/ad7150.c
+++ b/drivers/iio/cdc/ad7150.c
@@ -636,11 +636,13 @@ static const struct i2c_device_id ad7150_id[] = {
 MODULE_DEVICE_TABLE(i2c, ad7150_id);
 
 static const struct of_device_id ad7150_of_match[] = {
-	{ "adi,ad7150" },
-	{ "adi,ad7151" },
-	{ "adi,ad7156" },
+	{ .compatible = "adi,ad7150" },
+	{ .compatible = "adi,ad7151" },
+	{ .compatible = "adi,ad7156" },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, ad7150_of_match);
+
 static struct i2c_driver ad7150_driver = {
 	.driver = {
 		.name = "ad7150",

base-commit: 518e5b794c06c0f0eb40df3e202274a66202c137
-- 
2.50.1 (Apple Git-155)

