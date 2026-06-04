Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.78.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556622F8EB0;
	Thu,  4 Jun 2026 12:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.78.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574596; cv=none; b=RZdXe+GHTM+/N3v80NflKR8BPV3zA0heCHJ8+w3XpJ+CIy2O/qSH6SzBKsB2RMs8libbv8dBm0R+63/NzbU53fJ8Px6XjVe3qlcIGOzy2s9+ZYSjQ2wjfp7U1Sh+Z/fp3et90A0qKYHzOAmhSWvPRp0/Yug1VjeqgkfPGhS4Q1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574596; c=relaxed/simple;
	bh=Xwl8u/O1EsDI+QVIQ8LZl3VUbGMKutrSZrJXG97ZLnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nP3DirUWSsa1G7TTP7jde9zV+6dlDb2fqSKl59gGJ9/sozqLV1qSIRIvUrnbPrkDYj7Ta/0vMl0KQSE0uM+gKocjtFpVto1a9xgZtwWFyaMC5p+rbMle2iL9YMNTV1gUOj2RqLGoDlMT7FC7x5DT7SRg7IlBmQYjWmGqOYDi92U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=DJFy5n//; arc=none smtp.client-ip=77.75.78.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="DJFy5n//"
Received: from email.seznam.cz
	by smtpc-mxd-5757bcb9c-s9zn4
	(smtpc-mxd-5757bcb9c-s9zn4 [2a02:598:128:8a00::1000:a07])
	id 7eec93fec683be717c120962;
	Thu, 04 Jun 2026 14:03:07 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780574587; bh=pSHANDC3tUGhLA5FUAaQY3GukgCv0t9THUkW357545E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=DJFy5n//xjoPeeRettB8tD3X+ZVczDr2rOlvoHLZzbaukZtmPVUKlGhiU9xmv1eid
	 NPighjd51XcUwbNbdqdmUq/aLTOKetfqqRuzRia2AVQKP+wTm9+l3S66+yAE7WFRKN
	 2vTN1YXqvRvzGgw+I7hwoTGC9w5W7YHyKCQX2SvvNrF0J9/1zd1xHif2wifPcmlGaC
	 qYy3RkyP0oVgwojc1quurjXUrSj8EwAqScqW8/fqKCf+IBcGwf4CXCHlko2hlL8MXO
	 DTpx+wX5LUwBPbCE2QDevHnMvwJFO9gfvKdSLQir2vzk6L/0/FpGX686bF6jzMDQ4f
	 5QjBlHIJcpjGg==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-k9lmt (szn-email-smtpd/2.0.73) with ESMTPA
	id 03a8465b-41ff-415e-a196-081378abbfd9;
	Thu, 04 Jun 2026 14:02:59 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/11] iio: humidity: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:59:27 +0200
Message-ID: <20260604120201.116925-8-vo.kratky@seznam.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604120201.116925-1-vo.kratky@seznam.cz>
References: <20260604120201.116925-1-vo.kratky@seznam.cz>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace numeric PTR_ERR() logging with the %pe format specifier
so that error values are printed in a more readable form.

This change was identified using a Coccinelle semantic patch.

No functional change intended.

Signed-off-by: Vojtěch Krátký <vo.kratky@seznam.cz>
---
 drivers/iio/humidity/hts221_i2c.c | 4 ++--
 drivers/iio/humidity/hts221_spi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/humidity/hts221_i2c.c b/drivers/iio/humidity/hts221_i2c.c
index cbaa7d1af6c4..bf15f03cd3dd 100644
--- a/drivers/iio/humidity/hts221_i2c.c
+++ b/drivers/iio/humidity/hts221_i2c.c
@@ -31,8 +31,8 @@ static int hts221_i2c_probe(struct i2c_client *client)
 
 	regmap = devm_regmap_init_i2c(client, &hts221_i2c_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
-			PTR_ERR(regmap));
+		dev_err(&client->dev, "Failed to register i2c regmap %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
diff --git a/drivers/iio/humidity/hts221_spi.c b/drivers/iio/humidity/hts221_spi.c
index e6fef2acd523..15e46ad8707d 100644
--- a/drivers/iio/humidity/hts221_spi.c
+++ b/drivers/iio/humidity/hts221_spi.c
@@ -31,8 +31,8 @@ static int hts221_spi_probe(struct spi_device *spi)
 
 	regmap = devm_regmap_init_spi(spi, &hts221_spi_regmap_config);
 	if (IS_ERR(regmap)) {
-		dev_err(&spi->dev, "Failed to register spi regmap %ld\n",
-			PTR_ERR(regmap));
+		dev_err(&spi->dev, "Failed to register spi regmap %pe\n",
+			regmap);
 		return PTR_ERR(regmap);
 	}
 
-- 
2.54.0

