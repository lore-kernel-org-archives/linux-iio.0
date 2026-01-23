Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A57D35CB9C;
	Fri, 23 Jan 2026 11:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769168248; cv=none; b=L1RtIRjr6FzwlTLuwLxZdrLh8ztDYN9LZb20iEXlCBDSx0FrEsSU52WsR2Kij0hMPQo5F2NY8ZP6YzcXJmMvteGPWRQQEV9DbVGCsj0QdVlxJWv3VeuUwwsvnpUXtHnB7m2ORdq/p3GVxYpiDkR512GVBRCoNgkyvmGLr2a5Mlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769168248; c=relaxed/simple;
	bh=aiGlVd1BN8puUjJE6R0x7uIAwGUTd87MrPMBKwUJFWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGwkPTh879GRD6RuQcahQQIZqSAUnmjuRtKUc0z4XHk8qoFk1RU0cyzEb/tddv+FANrzTgBfjPxqBKOzEEGLxeDDlZpUkAVmNz4w+ZBX4evNpI6yXvwQVzEvE83nmkpIE8lsJTu+v3+Gdywdkbh2sFU0a2SZTK9tP0wnIG8vTd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MZJ8YFCK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ns2N6DET; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MZJ8YFCK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ns2N6DET"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769168240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpXBre8hOpdCJLr/q1ncOEZ+dMlHMQh3hprNMSGTivM=;
	b=MZJ8YFCKYKRuYMBkOMwk1ji4zbhy2xZw/yO7gMCTZ1m9rUvc9BFw/VxHOAGZ+hvKerSPnZ
	WnO9L6brsbRsFvNyKLL0SDcheWanKqbrC50sheXdTTtvXqzpvF1BAlABsY4qSlXL5ZPuH3
	fibX3fr4tt66KhL5TN09ryv/bQ8WcCfYqHLbLA/CP2NqL36W9bE3NuOYJWN6xGZO5VzdNe
	tlYABjRBhbyqaKvRwOftidCThKZKDLVFM++WGiEdVCsydInGE2yWIo/YVsCAqX+Xr5AOG3
	IvWJklgo4LgF8o98m9J1p97yHg0y3fINrBf9iF/P7HYMAV1XYAi3ZShITPMaKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769168240;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vpXBre8hOpdCJLr/q1ncOEZ+dMlHMQh3hprNMSGTivM=;
	b=Ns2N6DET06fM6N7BGIt/OWS3nTl68HOB4wqPKt/rAyDHSVBy4GvoHUuLBBAizGSeSyXGe8
	TaII2TOz775HpkAA==
To: linux-kernel@vger.kernel.org
Cc: linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH 19/21] iio: Use IRQF_NO_THREAD
Date: Fri, 23 Jan 2026 12:37:05 +0100
Message-ID: <20260123113708.416727-20-bigeasy@linutronix.de>
In-Reply-To: <20260123113708.416727-1-bigeasy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
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

Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/iio/accel/bma180.c        |  5 +++--
 drivers/iio/adc/ad7766.c          | 10 ++--------
 drivers/iio/gyro/itg3200_buffer.c |  2 +-
 drivers/iio/light/si1145.c        |  2 +-
 4 files changed, 7 insertions(+), 12 deletions(-)

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
index 4d570383ef025..9e4a66477d2d0 100644
--- a/drivers/iio/adc/ad7766.c
+++ b/drivers/iio/adc/ad7766.c
@@ -184,12 +184,6 @@ static const struct iio_info ad7766_info =3D {
 	.read_raw =3D &ad7766_read_raw,
 };
=20
-static irqreturn_t ad7766_irq(int irq, void *private)
-{
-	iio_trigger_poll(private);
-	return IRQ_HANDLED;
-}
-
 static int ad7766_set_trigger_state(struct iio_trigger *trig, bool enable)
 {
 	struct ad7766 *ad7766 =3D iio_trigger_get_drvdata(trig);
@@ -260,8 +254,8 @@ static int ad7766_probe(struct spi_device *spi)
 		 * Some platforms might not allow the option to power it down so
 		 * don't enable the interrupt to avoid extra load on the system
 		 */
-		ret =3D devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
-				       IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,
+		ret =3D devm_request_irq(&spi->dev, spi->irq, iio_trigger_generic_data_r=
dy_poll,
+				       IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN | IRQF_NO_THREAD,
 				       dev_name(&spi->dev),
 				       ad7766->trig);
 		if (ret < 0)
diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_b=
uffer.c
index a624400a239cb..767b87b7feea7 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -120,7 +120,7 @@ int itg3200_probe_trigger(struct iio_dev *indio_dev)
=20
 	ret =3D request_irq(st->i2c->irq,
 			  &iio_trigger_generic_data_rdy_poll,
-			  IRQF_TRIGGER_RISING,
+			  IRQF_NO_THREAD | IRQF_TRIGGER_RISING,
 			  "itg3200_data_rdy",
 			  st->trig);
 	if (ret)
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

