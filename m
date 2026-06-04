Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5421C43C05C;
	Thu,  4 Jun 2026 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574620; cv=none; b=jc9/3unLI8OG0XqK9fwUt8fMU8eIfA5twzuUHxWjxxE9PaNmJoaVBCn+oWSZFlpX39e3usyt4WDQHcWdIeGYB5J16WelpRcHsC3aIpkyc9Y20g35rUhEfFFAT3V1QNj2Id2CPflXxaofBW7L81haC6mp0wVQ9tvPcPMxAPlMOlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574620; c=relaxed/simple;
	bh=rhBwatMxaiktdPM988FxOj1jz/MYZ9U8lx9ehwXrVk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tCQH6wlkv+3tO6g9KpoatH8/RTZQq2IaNDr5E5SirdWuK7bNHpIydCIbRTPO9J2rikfJrOIW0xijIXAgtC7PvmHtfR0GyfAHY5RH9giFs/Loq9bOb+qnpgKXUs/p6jULnBQr4MWt+wgEwAw5+A0vlczvHhfEHmRfkXRBKyHJm3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=sTaX9rrU; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="sTaX9rrU"
Received: from email.seznam.cz
	by smtpc-mxd-5757bcb9c-s9zn4
	(smtpc-mxd-5757bcb9c-s9zn4 [2a02:598:128:8a00::1000:a07])
	id 6611856bde7ea8e464ef1ff7;
	Thu, 04 Jun 2026 14:03:21 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780574601; bh=heIHXKVFiyCfTS7M+QMeSe19bjhM4xEIp4r0NC8voRY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=sTaX9rrUIoVqlu3qc15g3XtvMi7xxkjlFisZWTgGWEbg6aXJospEQ//DXHz3oMtmw
	 y7VdEa12vZm2d7uZF/VM1IlsskOEnDG9ABCkumgfAIm57HRiaX9j7e/WiPLyFQh7mU
	 X2VTsEJ74xLzvhRzx/0uic3sWi8R6YbHV+w/j1veZ9/ApWvKmp0M9fpPXhLCdZpxWS
	 27cTRPdSZYkXALeX3DDujZ/uc6+qhxFyUv8TSzeEtxQ+DR22ykXp6BZnK6FXRGPESF
	 l1yHr5DdumTNtncWndNa7vCKuqUVp9URArkZ75aLpJsXzv8qTaRx0iK5qaInXgLTap
	 TJxqHwLcWIZNA==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-k9lmt (szn-email-smtpd/2.0.73) with ESMTPA
	id 58e34a39-31c4-4da9-a846-b434222e180c;
	Thu, 04 Jun 2026 14:03:04 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/11] iio: resolver: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:59:31 +0200
Message-ID: <20260604120201.116925-12-vo.kratky@seznam.cz>
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
 drivers/iio/resolver/ad2s1200.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/resolver/ad2s1200.c b/drivers/iio/resolver/ad2s1200.c
index c00a60cb31a5..3a6a66553839 100644
--- a/drivers/iio/resolver/ad2s1200.c
+++ b/drivers/iio/resolver/ad2s1200.c
@@ -145,15 +145,15 @@ static int ad2s1200_probe(struct spi_device *spi)
 
 	st->sample = devm_gpiod_get(&spi->dev, "adi,sample", GPIOD_OUT_LOW);
 	if (IS_ERR(st->sample)) {
-		dev_err(&spi->dev, "Failed to claim SAMPLE gpio: err=%ld\n",
-			PTR_ERR(st->sample));
+		dev_err(&spi->dev, "Failed to claim SAMPLE gpio: err=%pe\n",
+			st->sample);
 		return PTR_ERR(st->sample);
 	}
 
 	st->rdvel = devm_gpiod_get(&spi->dev, "adi,rdvel", GPIOD_OUT_LOW);
 	if (IS_ERR(st->rdvel)) {
-		dev_err(&spi->dev, "Failed to claim RDVEL gpio: err=%ld\n",
-			PTR_ERR(st->rdvel));
+		dev_err(&spi->dev, "Failed to claim RDVEL gpio: err=%pe\n",
+			st->rdvel);
 		return PTR_ERR(st->rdvel);
 	}
 
-- 
2.54.0

