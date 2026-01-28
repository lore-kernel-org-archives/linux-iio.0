Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C01434DB4E;
	Wed, 28 Jan 2026 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594169; cv=none; b=K/gBD9iIYIepLvdUjOwYmYTF1Myn/QISSmtSAD9H7z0Bz0fTXfx9S0NkQAIKMkkDIIlsk8X5ARyamGZVCC3kOhyGKZDbcWB4Ldv1SUpJFmT8ZRQATEDDMQ+wEi/C0PF6nSlXaALAuUEX9S81i2oen7K0O+LiA+ZG1+x4feKUPcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594169; c=relaxed/simple;
	bh=tN18CMCmgx8USLEY2ZssO283/07WFCeGSige6eliaKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UTBSwn49NziOxgnZoCaEQ5apd4d9y3CjrGzpT0xkr6WynU3ykCzAzG7sTlD3vLcnAGAqwj7AKTsNGSuHcn3sugSbKlUOQ+8U3PpeSu7bIsGAvdqgA/y0idZLVrxwElmn9oEOzHXkeHn/PLUgeqZqAFYnRkMj52t/NBxmypEceoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=APGDBp0F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sIU6tFYV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="APGDBp0F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sIU6tFYV"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769594163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pi3WzHbsaRUWqkk7n9RAAPJIWl9CTCMgd8j56a+oU+4=;
	b=APGDBp0F3aZ5ff7ebF4jNL3+xZGQhisVYYAcrKi01IUrmc1z3Vk9FSBejVpWKFkLI54OF6
	LqanMRP5DrycWL8lGnJq3RQx03e507DuzfC4iNUEkTJ4m0Rg4aVGpJ3Kdlb9933U3flTeq
	/G3dcW4aj/Pm2jeQFsg9HqCG+ljbGSySCtvZJRFhCttfZfP55O51SiWH2HYrZSOj6fLdXg
	56HMkb+hrnYVRC8DEj7uGvDYoos9Pfx7RczzknZNHBJEW9/sNPZNZI6LNj0wW/YCyufQN3
	me4+xehl9H6+XvChVjSFKLBkgTCMHspeDQgk8ayJtPdL7BIeho50iS16xglRRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769594163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pi3WzHbsaRUWqkk7n9RAAPJIWl9CTCMgd8j56a+oU+4=;
	b=sIU6tFYVbDClMPK2Nm1RQrJKmBrDD6cSbiJIjkIgHBndEL3eNonq8tAJzS2ad+Z7dSENQy
	6LHy2EFtQgxx0sDw==
To: linux-kernel@vger.kernel.org
Cc: "Thomas Gleixner" <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Kent Gustavsson <kent@minoris.se>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 17/20] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Date: Wed, 28 Jan 2026 10:55:37 +0100
Message-ID: <20260128095540.863589-18-bigeasy@linutronix.de>
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

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.
The flag also disallows force-threading of the primary handler and the
irq-core will warn about this.

The intention here was probably not allowing forced-threading for
handlers such as iio_trigger_generic_data_rdy_poll() will intends to
invoke hard-interrupt handlers.

Replace IRQF_ONESHOT with IRQF_NO_THREAD.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Puranjay Mohan <puranjay@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Kent Gustavsson <kent@minoris.se>
Cc: Gustavo Silva <gustavograzs@gmail.com>
Cc: Nishant Malpani <nish.malpani25@gmail.com>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/accel/adxl355_core.c       |  5 ++---
 drivers/iio/accel/adxl372.c            |  9 ++++-----
 drivers/iio/accel/mxc4005.c            | 11 ++++-------
 drivers/iio/accel/stk8ba50.c           | 11 ++++-------
 drivers/iio/adc/ad4170-4.c             |  2 +-
 drivers/iio/adc/ad7768-1.c             |  5 ++---
 drivers/iio/adc/ad7779.c               |  2 +-
 drivers/iio/adc/mcp3911.c              |  2 +-
 drivers/iio/adc/ti-ads131e08.c         |  2 +-
 drivers/iio/chemical/ens160_core.c     |  9 +++------
 drivers/iio/gyro/adxrs290.c            |  2 +-
 drivers/iio/health/afe4403.c           |  9 ++++-----
 drivers/iio/health/afe4404.c           |  9 ++++-----
 drivers/iio/magnetometer/bmc150_magn.c |  9 +++------
 drivers/iio/pressure/dlhl60d.c         |  7 +++----
 drivers/iio/temperature/tmp006.c       | 10 ++++------
 16 files changed, 42 insertions(+), 62 deletions(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_c=
ore.c
index 5fc7f814b9077..1c1d64d5cbcb2 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -768,9 +768,8 @@ static int adxl355_probe_trigger(struct iio_dev *indio_=
dev, int irq)
 	data->dready_trig->ops =3D &adxl355_trigger_ops;
 	iio_trigger_set_drvdata(data->dready_trig, indio_dev);
=20
-	ret =3D devm_request_irq(data->dev, irq,
-			       &iio_trigger_generic_data_rdy_poll,
-			       IRQF_ONESHOT, "adxl355_irq", data->dready_trig);
+	ret =3D devm_request_irq(data->dev, irq, &iio_trigger_generic_data_rdy_po=
ll,
+			       IRQF_NO_THREAD, "adxl355_irq", data->dready_trig);
 	if (ret)
 		return dev_err_probe(data->dev, ret, "request irq %d failed\n",
 				     irq);
diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
index 46d518a2a0291..2f6aa52aeba51 100644
--- a/drivers/iio/accel/adxl372.c
+++ b/drivers/iio/accel/adxl372.c
@@ -1247,11 +1247,10 @@ int adxl372_probe(struct device *dev, struct regmap=
 *regmap,
=20
 		indio_dev->trig =3D iio_trigger_get(st->dready_trig);
=20
-		ret =3D devm_request_threaded_irq(dev, st->irq,
-					iio_trigger_generic_data_rdy_poll,
-					NULL,
-					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-					indio_dev->name, st->dready_trig);
+		ret =3D devm_request_irq(dev, st->irq,
+				       iio_trigger_generic_data_rdy_poll,
+				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
+				       indio_dev->name, st->dready_trig);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
index ac973d871c8bb..a2c3cf13d0981 100644
--- a/drivers/iio/accel/mxc4005.c
+++ b/drivers/iio/accel/mxc4005.c
@@ -486,13 +486,10 @@ static int mxc4005_probe(struct i2c_client *client)
 		if (!data->dready_trig)
 			return -ENOMEM;
=20
-		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
-						iio_trigger_generic_data_rdy_poll,
-						NULL,
-						IRQF_TRIGGER_FALLING |
-						IRQF_ONESHOT,
-						"mxc4005_event",
-						data->dready_trig);
+		ret =3D devm_request_irq(&client->dev, client->irq,
+				       iio_trigger_generic_data_rdy_poll,
+				       IRQF_TRIGGER_FALLING | IRQF_NO_THREAD,
+				       "mxc4005_event", data->dready_trig);
 		if (ret) {
 			dev_err(&client->dev,
 				"failed to init threaded irq\n");
diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
index 384f1fbcbcb37..a9ff2a273fe1c 100644
--- a/drivers/iio/accel/stk8ba50.c
+++ b/drivers/iio/accel/stk8ba50.c
@@ -428,13 +428,10 @@ static int stk8ba50_probe(struct i2c_client *client)
 	}
=20
 	if (client->irq > 0) {
-		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
-						stk8ba50_data_rdy_trig_poll,
-						NULL,
-						IRQF_TRIGGER_RISING |
-						IRQF_ONESHOT,
-						"stk8ba50_event",
-						indio_dev);
+		ret =3D devm_request_irq(&client->dev, client->irq,
+				       stk8ba50_data_rdy_trig_poll,
+				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
+				       "stk8ba50_event", indio_dev);
 		if (ret < 0) {
 			dev_err(&client->dev, "request irq %d failed\n",
 				client->irq);
diff --git a/drivers/iio/adc/ad4170-4.c b/drivers/iio/adc/ad4170-4.c
index efaed92191f1b..82205bfae531e 100644
--- a/drivers/iio/adc/ad4170-4.c
+++ b/drivers/iio/adc/ad4170-4.c
@@ -2973,7 +2973,7 @@ static int ad4170_probe(struct spi_device *spi)
=20
 	if (spi->irq) {
 		ret =3D devm_request_irq(dev, spi->irq, &ad4170_irq_handler,
-				       IRQF_ONESHOT, indio_dev->name, indio_dev);
+				       IRQF_NO_THREAD, indio_dev->name, indio_dev);
 		if (ret)
 			return ret;
=20
diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index d96802b7847a6..84ce23c8e5782 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -1394,9 +1394,8 @@ static int ad7768_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
=20
-	ret =3D devm_request_irq(&spi->dev, spi->irq,
-			       &ad7768_interrupt,
-			       IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+	ret =3D devm_request_irq(&spi->dev, spi->irq, &ad7768_interrupt,
+			       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
 			       indio_dev->name, indio_dev);
 	if (ret)
 		return ret;
diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index aac5049c9a07b..695cc79e78da5 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -840,7 +840,7 @@ static int ad7779_setup_without_backend(struct ad7779_s=
tate *st, struct iio_dev
 	iio_trigger_set_drvdata(st->trig, st);
=20
 	ret =3D devm_request_irq(dev, st->spi->irq, iio_trigger_generic_data_rdy_=
poll,
-			       IRQF_ONESHOT | IRQF_NO_AUTOEN, indio_dev->name,
+			       IRQF_NO_THREAD | IRQF_NO_AUTOEN, indio_dev->name,
 			       st->trig);
 	if (ret)
 		return dev_err_probe(dev, ret, "request IRQ %d failed\n",
diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
index a6f21791c6859..ddc3721f3f688 100644
--- a/drivers/iio/adc/mcp3911.c
+++ b/drivers/iio/adc/mcp3911.c
@@ -815,7 +815,7 @@ static int mcp3911_probe(struct spi_device *spi)
 		 * don't enable the interrupt to avoid extra load on the system.
 		 */
 		ret =3D devm_request_irq(dev, spi->irq, &iio_trigger_generic_data_rdy_po=
ll,
-				       IRQF_NO_AUTOEN | IRQF_ONESHOT,
+				       IRQF_NO_AUTOEN | IRQF_NO_THREAD,
 				       indio_dev->name, adc->trig);
 		if (ret)
 			return ret;
diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
index c9a20024d6b11..a585621b0bc30 100644
--- a/drivers/iio/adc/ti-ads131e08.c
+++ b/drivers/iio/adc/ti-ads131e08.c
@@ -827,7 +827,7 @@ static int ads131e08_probe(struct spi_device *spi)
 	if (spi->irq) {
 		ret =3D devm_request_irq(&spi->dev, spi->irq,
 			ads131e08_interrupt,
-			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
+			IRQF_TRIGGER_FALLING | IRQF_NO_THREAD,
 			spi->dev.driver->name, indio_dev);
 		if (ret)
 			return dev_err_probe(&spi->dev, ret,
diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens1=
60_core.c
index 86bde4a91bf7e..bbc96c4c62838 100644
--- a/drivers/iio/chemical/ens160_core.c
+++ b/drivers/iio/chemical/ens160_core.c
@@ -316,12 +316,9 @@ static int ens160_setup_trigger(struct iio_dev *indio_=
dev, int irq)
=20
 	indio_dev->trig =3D iio_trigger_get(trig);
=20
-	ret =3D devm_request_threaded_irq(dev, irq,
-					iio_trigger_generic_data_rdy_poll,
-					NULL,
-					IRQF_ONESHOT,
-					indio_dev->name,
-					indio_dev->trig);
+	ret =3D devm_request_irq(dev, irq, iio_trigger_generic_data_rdy_poll,
+			       IRQF_NO_THREAD, indio_dev->name,
+			       indio_dev->trig);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to request irq\n");
=20
diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index 8fcb41f45baac..3efe385ebedc4 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -597,7 +597,7 @@ static int adxrs290_probe_trigger(struct iio_dev *indio=
_dev)
=20
 	ret =3D devm_request_irq(&st->spi->dev, st->spi->irq,
 			       &iio_trigger_generic_data_rdy_poll,
-			       IRQF_ONESHOT, "adxrs290_irq", st->dready_trig);
+			       IRQF_NO_THREAD, "adxrs290_irq", st->dready_trig);
 	if (ret < 0)
 		return dev_err_probe(&st->spi->dev, ret,
 				     "request irq %d failed\n", st->spi->irq);
diff --git a/drivers/iio/health/afe4403.c b/drivers/iio/health/afe4403.c
index 0e5a512e3bb8f..d358f4d5e5da8 100644
--- a/drivers/iio/health/afe4403.c
+++ b/drivers/iio/health/afe4403.c
@@ -540,11 +540,10 @@ static int afe4403_probe(struct spi_device *spi)
 			return ret;
 		}
=20
-		ret =3D devm_request_threaded_irq(dev, afe->irq,
-						iio_trigger_generic_data_rdy_poll,
-						NULL, IRQF_ONESHOT,
-						AFE4403_DRIVER_NAME,
-						afe->trig);
+		ret =3D devm_request_irq(dev, afe->irq,
+				       iio_trigger_generic_data_rdy_poll,
+				       IRQF_NO_THREAD, AFE4403_DRIVER_NAME,
+				       afe->trig);
 		if (ret) {
 			dev_err(dev, "Unable to request IRQ\n");
 			return ret;
diff --git a/drivers/iio/health/afe4404.c b/drivers/iio/health/afe4404.c
index 768d794e574b9..032da52a96d0e 100644
--- a/drivers/iio/health/afe4404.c
+++ b/drivers/iio/health/afe4404.c
@@ -547,11 +547,10 @@ static int afe4404_probe(struct i2c_client *client)
 			return ret;
 		}
=20
-		ret =3D devm_request_threaded_irq(dev, afe->irq,
-						iio_trigger_generic_data_rdy_poll,
-						NULL, IRQF_ONESHOT,
-						AFE4404_DRIVER_NAME,
-						afe->trig);
+		ret =3D devm_request_irq(dev, afe->irq,
+				       iio_trigger_generic_data_rdy_poll,
+				       IRQF_NO_THREAD, AFE4404_DRIVER_NAME,
+				       afe->trig);
 		if (ret) {
 			dev_err(dev, "Unable to request IRQ\n");
 			return ret;
diff --git a/drivers/iio/magnetometer/bmc150_magn.c b/drivers/iio/magnetome=
ter/bmc150_magn.c
index 6a73f6e2f1f06..a022e1805dff7 100644
--- a/drivers/iio/magnetometer/bmc150_magn.c
+++ b/drivers/iio/magnetometer/bmc150_magn.c
@@ -906,12 +906,9 @@ int bmc150_magn_probe(struct device *dev, struct regma=
p *regmap,
 			goto err_poweroff;
 		}
=20
-		ret =3D request_threaded_irq(irq,
-					   iio_trigger_generic_data_rdy_poll,
-					   NULL,
-					   IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-					   "bmc150_magn_event",
-					   data->dready_trig);
+		ret =3D request_irq(irq, iio_trigger_generic_data_rdy_poll,
+				  IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
+				  "bmc150_magn_event", data->dready_trig);
 		if (ret < 0) {
 			dev_err(dev, "request irq %d failed\n", irq);
 			goto err_trigger_unregister;
diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
index 8bad7162fec64..46feb27fe632f 100644
--- a/drivers/iio/pressure/dlhl60d.c
+++ b/drivers/iio/pressure/dlhl60d.c
@@ -306,10 +306,9 @@ static int dlh_probe(struct i2c_client *client)
 	indio_dev->num_channels =3D ARRAY_SIZE(dlh_channels);
=20
 	if (client->irq > 0) {
-		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
-			dlh_interrupt, NULL,
-			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-			st->info->name, indio_dev);
+		ret =3D devm_request_irq(&client->dev, client->irq, dlh_interrupt,
+				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
+				       st->info->name, indio_dev);
 		if (ret) {
 			dev_err(&client->dev, "failed to allocate threaded irq");
 			return ret;
diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp=
006.c
index 10bd3f221929d..d8d8c8936d177 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -356,12 +356,10 @@ static int tmp006_probe(struct i2c_client *client)
=20
 		indio_dev->trig =3D iio_trigger_get(data->drdy_trig);
=20
-		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
-						iio_trigger_generic_data_rdy_poll,
-						NULL,
-						IRQF_ONESHOT,
-						"tmp006_irq",
-						data->drdy_trig);
+		ret =3D devm_request_irq(&client->dev, client->irq,
+				       iio_trigger_generic_data_rdy_poll,
+				       IRQF_NO_THREAD, "tmp006_irq",
+				       data->drdy_trig);
 		if (ret < 0)
 			return ret;
 	}
--=20
2.51.0

