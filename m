Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8290C47884F;
	Mon, 28 Sep 2026 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584016; cv=none; b=pP5/AfSh696hOir5XO8spa8GP1KhDvLwRw6CqSN4nZn8OJvMV5U1cI/i2kr/hyErkCDcbP904BEm1MniaKcJWwyUEzXP7O4EzeIZuBdSBHqaiRkNaZ4Q6s3vKithRhrVL7VQxYvg7tg96p8xAd+NZa158hP4NzS7fJQEAtLNIoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584016; c=relaxed/simple;
	bh=T7sr0TzMgmglAP2j9V16bPDOgCZYpUUMAGQh9Ee2guQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jgky6vRjZsERcYr13JzVopZ3iCF3AkGoTj0yYSgkKsoojcy9cbk2Gu/Z4CKSVYGBp3JCEWaec0qj6M1RYD1sVeGST54fCJO42rlW1rK/fNpseL1pl/m8kvYFxeohAaujWrGgqVb7LtTnN10WpOfPV3rA5Gb3t+ckgmIARzhKFnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=Rk98KsLk; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="Rk98KsLk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1790584004; x=1790843204;
	bh=b7mmMpqnnkKIyb7qAxiVt25p/f/J3CztQHK4bgN0iHo=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Rk98KsLk4JJLU3T35LqKnaJTFzmVl8uEzRz2eWuQrz7Z4R4Nz1tKwb438YrEGTQ6B
	 t7xbm5L2jK0tyipFO5/IwcpcSB6aBCtMpIk2fktBhfatNs7huLxPsizPQE9uYVV/mZ
	 iPMUNl7JlbwsETiKwEEF3miK1EWL4FyM+Vn5WrcG+hrxh5RmST4OrzPcflHKNceP4v
	 DKQljX6fj9WvjbZDsIVo11Ubnc79nT8mjFRbbr8VUOd7WMbYKnj/38W4FNE1K+7oo1
	 6/IpaH50NHfDlxjurxJW3JNPB+td/BrmULdjU9szhrMkRyp8D1HbY/XBBz/2bqUjot
	 gj5poYgWHlikA==
X-Pm-Submission-Id: 4htZCk3rscz1DF4X
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 28 Sep 2026 10:26:25 +0200
Subject: [PATCH v10 09/10] iio: accel: mma8452: Use proper error code when
 missing device model
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mma8452-open-drain-v10-9-b906fb408386@geanix.com>
References: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
In-Reply-To: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, 
 Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790583982; l=915;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=T7sr0TzMgmglAP2j9V16bPDOgCZYpUUMAGQh9Ee2guQ=;
 b=TKav7TFpZP0DQK6tKFhxPdwc3fuDzvnycoAjIcsEA2EEbD+BE/R6Puj1Paoffxr/jJY0PdEjc
 TsA417n/SLeBI/BdCIkI5SSALcz7EpoethuZlmC4zydoaT5U/zI03FZ
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Switch -ENODEV error on i2c_get_match_data() failure to -ENODATA to
satisfy the IIO coding style.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 0b48aded2230..dc8031e14c29 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1594,7 +1594,7 @@ static int mma8452_probe(struct i2c_client *client)
 
 	data->chip_info = i2c_get_match_data(client);
 	if (!data->chip_info)
-		return dev_err_probe(dev, -ENODEV, "unknown device model\n");
+		return dev_err_probe(dev, -ENODATA, "unknown device model\n");
 
 	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)

-- 
2.55.0

