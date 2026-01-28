Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF22E34F250;
	Wed, 28 Jan 2026 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594167; cv=none; b=pEatAAUQipwRrLc1oUa0O16W9BtbNO3VJfRqkkBtwJNyeK7cQmgoLYuF+BaYi3+akHSfWmU91+mVXuyVIEBMFQNlLQU7uT5LmlozFpIEcWrav8McmFpIv+1CIkmPSCEDxh2IZZqifJRV0pT9Vc3Q6DNHEWkamzrK7eoqixtZnGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594167; c=relaxed/simple;
	bh=phux7thwKtdZtkvXcZ2DoPmH1TZxv8ZEzey1TPcAu3c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kb0HX0MIhQmhSSB9ACzCKnpGk/LBiupJziTeIDVTzG9ZHMIq3/Nzz4mv4Y54lu+IzibNDn72uFFya2766oeLpksT1wubx5aiR2j8ZiqCDzoTLdk0ghIyfwX0qSTmvzsU1pDffNvSMez/u9vqzQSqYsgkKAo1ZrNPSx8oYQPmj7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zNayfIEJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ekQ8KL/s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zNayfIEJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ekQ8KL/s"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769594163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ja9nqRg1OSWpmOUqkXhxSrU++h130vgylolwaiBkV1M=;
	b=zNayfIEJ6xW2SFTVIOCfMFJWX57nz4zk3722jRTmpuQhmOYoxgTurKqgo4c0H/ypopXHPO
	x8C71WHlxVig0KCBX/+ffmDRZrR06RFTRPjpNW/ZksOwexLSaPF7P3qkpewFfdxnIXXHku
	TZU5lxm6za9JH7BibnCfuIpJ5YdT20G02Wl1tfYCd2F/doEv3DFNbXv5iHVlbkAzyaMlSD
	AqO+zA9jef/AeXyr+brrl8c7f6iy1oQLLu3hU5iyKjEs1ntMhtBQdz4L5rGI3qHPvpFMp0
	68klIkohsxgSErtb9cccTNzRlBgzQlc+1vud6NHXWlITuvvO1uxegoXkTlsJJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769594163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ja9nqRg1OSWpmOUqkXhxSrU++h130vgylolwaiBkV1M=;
	b=ekQ8KL/sHRC/JmBS5p4dfPTJSrJFG9walTf76o7ldEwTSw+Hr0xFZiqHQhQzg8DTSf68Id
	p2Fx7IyCnqTkpuAg==
To: linux-kernel@vger.kernel.org
Cc: "Thomas Gleixner" <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 16/20] iio: Use IRQF_NO_THREAD
Date: Wed, 28 Jan 2026 10:55:36 +0100
Message-ID: <20260128095540.863589-17-bigeasy@linutronix.de>
In-Reply-To: <20260128095540.863589-1-bigeasy@linutronix.de>
References: <20260128095540.863589-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The interrupt handler iio_trigger_generic_data_rdy_poll() will invoke
other interrupt handler and this supposed to happen from within the
hardirq.

Use IRQF_NO_THREAD to forbid forced-threading.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/accel/bma180.c        | 5 +++--
 drivers/iio/adc/ad7766.c          | 2 +-
 drivers/iio/gyro/itg3200_buffer.c | 8 +++-----
 drivers/iio/light/si1145.c        | 2 +-
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 8925f5279e627..7bc6761f51354 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -986,8 +986,9 @@ static int bma180_probe(struct i2c_client *client)
 		}
=20
 		ret =3D devm_request_irq(dev, client->irq,
-			iio_trigger_generic_data_rdy_poll, IRQF_TRIGGER_RISING,
-			"bma180_event", data->trig);
+				       iio_trigger_generic_data_rdy_poll,
+				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
+				       "bma180_event", data->trig);
 		if (ret) {
 			dev_err(dev, "unable to request IRQ\n");
 			goto err_trigger_free;
diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index 4d570383ef025..1e6bfe8765ab3 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -261,7 +261,7 @@ static int ad7766_probe(struct spi_device *spi)
 		 * don't enable the interrupt to avoid extra load on the system
 		 */
 		ret =3D devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
-				       IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,
+				       IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN | IRQF_NO_THREAD,
 				       dev_name(&spi->dev),
 				       ad7766->trig);
 		if (ret < 0)
diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_b=
uffer.c
index a624400a239cb..cf97adfa97274 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -118,11 +118,9 @@ int itg3200_probe_trigger(struct iio_dev *indio_dev)
 	if (!st->trig)
 		return -ENOMEM;
=20
-	ret =3D request_irq(st->i2c->irq,
-			  &iio_trigger_generic_data_rdy_poll,
-			  IRQF_TRIGGER_RISING,
-			  "itg3200_data_rdy",
-			  st->trig);
+	ret =3D request_irq(st->i2c->irq, &iio_trigger_generic_data_rdy_poll,
+			  IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
+			  "itg3200_data_rdy", st->trig);
 	if (ret)
 		goto error_free_trig;
=20
diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
index f8eb251eca8dc..ef0abc4499b74 100644
--- a/drivers/iio/light/si1145.c
+++ b/drivers/iio/light/si1145.c
@@ -1248,7 +1248,7 @@ static int si1145_probe_trigger(struct iio_dev *indio=
_dev)
=20
 	ret =3D devm_request_irq(&client->dev, client->irq,
 			  iio_trigger_generic_data_rdy_poll,
-			  IRQF_TRIGGER_FALLING,
+			  IRQF_TRIGGER_FALLING | IRQF_NO_THREAD,
 			  "si1145_irq",
 			  trig);
 	if (ret < 0) {
--=20
2.51.0

