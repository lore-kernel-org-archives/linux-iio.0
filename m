Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929853A3E87;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981562; cv=none; b=eO2hn6SP5+9DNOcJdg60rPBL+8Vxp11ghgjK7tqyUIedkFBIxBxlICU/5og50UVjZevaksmutHAg7TNShH+txBRYg/WqnGvJWCwEEBHHLQWA5Jb0X2VCUV1XgrJEYOips9SgT/xHD8a6U7wAaOMktf9Q0HLIryr4+T3EHrGK02o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981562; c=relaxed/simple;
	bh=MPXjkBJADgIt/wERiH+9oxvomnnB/9cU+fY4E1zlxkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iidYMgN0P1zzs3Y070mUbg+RiMmXOfHxBth8bW0nyur2aHFLjG7qVuYBFHxiO8ib1Gopz3UtzMfh+dhz6d47ghTXNvJqImUk8lcqDXa8f1VpH4ts/ifvo+/Cht6KTOTQU3FoNOZiUxNiZlcBSpiUSGA4FJfXT3RjGZYVVneslHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwIMK9A0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwIMK9A0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42729C2BCB4;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777981562;
	bh=MPXjkBJADgIt/wERiH+9oxvomnnB/9cU+fY4E1zlxkU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FwIMK9A0IZX4h3jKvx2QjDBoDCbJvQGBimI/aTPikClpie06qappMz35fkFf+3nJ6
	 6p8b3aZlii4F+Gn63px2zpp1+nvSv+Wp3Um4dl87arT2E/JqAp7FvqoY5CQv2eMiJI
	 dk5RPqfN4Vc0W+zAqM7JsZBmv+EgNpMNe3/KsJzH3eY9tEn3P7Ujo8kOzhoF56ZneH
	 8UbZKstm6olnfThzPkI08LW5GafXpZ8uTLcuMh5Wk9Xi5Ecn65SESjsJUPGbDn+gml
	 xPBvejAZ+OZ9ufCnr+a1yG/Y/BRFKZnwLlXe9LHhii87VYXDA26qix59WrqatktnZu
	 IxR0PE0D00rVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A22FFF885A;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 13:46:06 +0200
Subject: [PATCH v5 10/18] iio: magnetometer: ak8975: drop duplicate NULL
 check
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-magnetometer-fixes-v5-10-831b9b5550fc@gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
In-Reply-To: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777981558; l=997;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=XCs0GN+NbiGoXI2dfBbrODJcBvdjPZeVOf17jMKlR/o=;
 b=dHnX2TM5lF4yuVOe+fssLPd8Vy7wN2ARVf04Zv71ct3NnRWHaMx6oTNgTU5h10ownvM7cYjFV
 +xqmgtS7nGaAECPiU5bEmyk2CZzCIMAcuchUpRTMHzVQAKnbZry4SQL
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The gpiod_set_consumer_name() is NULL-aware, no need to perform the same
check in the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index c36d068081066ef6b42cc2f9c3c2e8978ec51623..7a971de2eebf127fc8ab68300fb82f38d9476c0c 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -918,8 +918,7 @@ static int ak8975_probe(struct i2c_client *client)
 	eoc_gpiod = devm_gpiod_get_optional(&client->dev, NULL, GPIOD_IN);
 	if (IS_ERR(eoc_gpiod))
 		return PTR_ERR(eoc_gpiod);
-	if (eoc_gpiod)
-		gpiod_set_consumer_name(eoc_gpiod, "ak_8975");
+	gpiod_set_consumer_name(eoc_gpiod, "ak_8975");
 
 	/*
 	 * According to AK09911 datasheet, if reset GPIO is provided then

-- 
2.47.3


