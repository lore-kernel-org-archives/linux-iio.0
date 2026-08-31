Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C403F7875;
	Mon, 31 Aug 2026 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178655; cv=none; b=o7Ps4lOgZoLdlb1LKUwokWoFZReFDO8UHVMKO9mdnTSeD6TKmqTICvLlukUsBoF5s4jy630mwwOGnNW2Cou1oYJ5V5ner+bETS5eum4bDn2gR4y5agvS1uQt1harnUV1svd1MF+BYzH4rZUrQNn6cOnuAHEHxU1kKVIH7hlMAho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178655; c=relaxed/simple;
	bh=CS53ZPElD2pCg3MB4FFjE1OQDuKtvLdjWU48Z8ZzjXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dInx/1SavK6lOAt7Q9H9ZdJP/JK0u/kI6dQRUFak9kxc2BmJsdkvNNjGsNBWexNbq9RA44H9+Bz1aVyKGthCUZy+cl50ALt9flahRDt201AFEgSr8VJjB7q1Ss5nytEnCxaiyuiCggwYqKsmVXPAy5zTta3DIQdIm3KyLMVb7mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=qVczcVvh; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="qVczcVvh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788178647; x=1788437847;
	bh=p9myFx9OVWkclsSuoFjNAFjmqmthOR41LTlOtA/N7Yc=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=qVczcVvhJpcV/AVO5xk9FqqnLsAvTb5m0PQMGlfd49k81XFqSXzBfix+Zq4b2U4CF
	 f6gZ4Flvn7NW8VPISpN3JTLbYZwHvnXMvor7/upO/NDYpTqiDYrmN/Winip3ndFfeH
	 utNmebgzbqLbt9WQGcAJw0RWwbSH6gUUID43aw7bXPBNB/4K0gl7QKhKgXX+subo7d
	 BcoDKsFFj+kzDI5f2WRRzdWJrhtt0LTLjH54YxbG6IyQMrvW2L9AqU0ifp0WimYtAk
	 CFDoeyNKI/n+hNCbAYqVBlF1ReMNLJ05HNwfkh+uPjkQUZGejzgOuAcBLBV3SZnqjp
	 O0I59/T2AnV3g==
X-Pm-Submission-Id: 4hYSfs6QCmz1DF6s
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 31 Aug 2026 14:17:10 +0200
Subject: [PATCH v7 7/8] iio: accel: mma8452: Fix use-after-free bug in
 error error path
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-mma8452-open-drain-v7-7-22946812c928@geanix.com>
References: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
In-Reply-To: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
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
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788178627; l=1149;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=CS53ZPElD2pCg3MB4FFjE1OQDuKtvLdjWU48Z8ZzjXU=;
 b=/b/04Cv24bEp1TyXOi6gF+r+ikAX4njrf37TsPrFcKerP4W8hKhbgwN1RCKYWXSL2ZFLwdkyD
 wG9QDTF8OvpDi6ugJykJjCSdQ97T0+E6UaHIoupzBbulY7LNVqOeuzp
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

If mma8452_probe() fails in iio_device_register() or later, we could end up
with runtime suspend callback being called with a now freed device pointer.

Fixes: 96c0cb2bbfe0 ("iio: mma8452: add support for runtime power management")
Cc: stable@vger.kernel.org
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index bf56ebd6e091..9619b200fa5a 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1745,7 +1745,7 @@ static int mma8452_probe(struct i2c_client *client)
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
-		goto free_irq;
+		goto runtime_suspend;
 
 	ret = mma8452_set_freefall_mode(data, false);
 	if (ret < 0)
@@ -1756,6 +1756,10 @@ static int mma8452_probe(struct i2c_client *client)
 unregister_device:
 	iio_device_unregister(indio_dev);
 
+runtime_suspend:
+	pm_runtime_disable(dev);
+	pm_runtime_set_suspended(dev);
+
 free_irq:
 	if (client->irq)
 		free_irq(client->irq, indio_dev);

-- 
2.55.0

