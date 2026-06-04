Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF3F42315B;
	Thu,  4 Jun 2026 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574630; cv=none; b=OjKRm2fIRJu7AVy/DoeYX4BhxVhFSiyHV2jP0YZAPTVoVlADPsmE0YaXXsB5Uz8Gn/2/odF3T1bH3s2jatoXmvIaAPZURGBnUWOEl04QPkbCQ7TJpUqMwV6L5TB1TIISaUY/6xZ/99ZRt2N13wPfiYJb02A2Bvp/syHdKw1TuP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574630; c=relaxed/simple;
	bh=RBovYy19EiZRsg07lrECIVRpp9OSIdemZtFEPxBHtyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FFADVDTnl7KnNvv4Eq9JNEIQ6HafX7sOR32FeDyFZXVI4+x329oZGsrCQnn0tUY5mcyvubgoUvRUth7T9Vh3SW8AxiQJqyAgzbG2NYA53F9MO9QAjYhgFiGEqs2hvN4qckrwYeSgEktW4VcbI3pPhch0XJ0V4CZK0AigQFHd6L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=hMMQbD8i; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="hMMQbD8i"
Received: from email.seznam.cz
	by smtpc-mxd-85fb448c55-l247v
	(smtpc-mxd-85fb448c55-l247v [2a02:598:96:8a00::1200:706])
	id 01e17ed8b98e5357031fe444;
	Thu, 04 Jun 2026 14:03:31 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780574611; bh=UnE6hazbC7NXuakkgz2RAPo+5oXRlfrayieK43sMpgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=hMMQbD8i5yhdpAC0MDr9+ukoLdfPKy9GsmrBbdr3ye5XXdIDP8vAdFgz+QhoPSV7r
	 lYbotoJPVNYjV7UNCHa75t5T/6x6A3oYAUZjypRoITrZqy3gzsQiadtv2ZolGp1G1B
	 o5fFbkeLx8SuM3rzFnQW87zL9HjE5NOe7Vqz75E8MLDDOuiZK3vdfnGa3VBcQGqK9n
	 LmJy+El+6C5NcDfmxNMLOGk5caay1CApalJyiB0u8lUcffCS+8bonXKWznMoixPJZS
	 B2O3Tn3aKbjyULB8ZJeh1SMlOhhBiQdG5ENegMZD+J0ePhZfXX/SdLdNzSaWCfZVVk
	 xXyM7JV2v2OsQ==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-k9lmt (szn-email-smtpd/2.0.73) with ESMTPA
	id fca65836-4b8d-4033-9fd2-c50de0c3c701;
	Thu, 04 Jun 2026 14:03:04 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>,
	Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/11] iio: proximity: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:59:30 +0200
Message-ID: <20260604120201.116925-11-vo.kratky@seznam.cz>
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
 drivers/iio/proximity/ping.c  |  4 ++--
 drivers/iio/proximity/srf04.c | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/proximity/ping.c b/drivers/iio/proximity/ping.c
index e3487094d7be..c54978c1a888 100644
--- a/drivers/iio/proximity/ping.c
+++ b/drivers/iio/proximity/ping.c
@@ -293,8 +293,8 @@ static int ping_probe(struct platform_device *pdev)
 
 	data->gpiod_ping = devm_gpiod_get(dev, "ping", GPIOD_OUT_LOW);
 	if (IS_ERR(data->gpiod_ping)) {
-		dev_err(dev, "failed to get ping-gpios: err=%ld\n",
-						PTR_ERR(data->gpiod_ping));
+		dev_err(dev, "failed to get ping-gpios: err=%pe\n",
+			data->gpiod_ping);
 		return PTR_ERR(data->gpiod_ping);
 	}
 
diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
index e97f9a20ac7a..06700a4cf275 100644
--- a/drivers/iio/proximity/srf04.c
+++ b/drivers/iio/proximity/srf04.c
@@ -264,23 +264,23 @@ static int srf04_probe(struct platform_device *pdev)
 
 	data->gpiod_trig = devm_gpiod_get(dev, "trig", GPIOD_OUT_LOW);
 	if (IS_ERR(data->gpiod_trig)) {
-		dev_err(dev, "failed to get trig-gpios: err=%ld\n",
-					PTR_ERR(data->gpiod_trig));
+		dev_err(dev, "failed to get trig-gpios: err=%pe\n",
+					data->gpiod_trig);
 		return PTR_ERR(data->gpiod_trig);
 	}
 
 	data->gpiod_echo = devm_gpiod_get(dev, "echo", GPIOD_IN);
 	if (IS_ERR(data->gpiod_echo)) {
-		dev_err(dev, "failed to get echo-gpios: err=%ld\n",
-					PTR_ERR(data->gpiod_echo));
+		dev_err(dev, "failed to get echo-gpios: err=%pe\n",
+					data->gpiod_echo);
 		return PTR_ERR(data->gpiod_echo);
 	}
 
 	data->gpiod_power = devm_gpiod_get_optional(dev, "power",
 								GPIOD_OUT_LOW);
 	if (IS_ERR(data->gpiod_power)) {
-		dev_err(dev, "failed to get power-gpios: err=%ld\n",
-						PTR_ERR(data->gpiod_power));
+		dev_err(dev, "failed to get power-gpios: err=%pe\n",
+						data->gpiod_power);
 		return PTR_ERR(data->gpiod_power);
 	}
 	if (data->gpiod_power) {
-- 
2.54.0

