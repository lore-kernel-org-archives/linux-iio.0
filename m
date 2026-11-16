Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793854;
	b=VjjiQ5T9DrsdguinQlJNilocinijc1alqq9t5pcU8DMatdjaW+WrRv+qLX7rXVesnX5k
	 yO40Vir0VXzFOLwJSujbnf+x2AEb28PVbosVjlmw4WUZFGF0NdbhhPEEHDvQ1GPrc+Bsd
	 z++op03B1md/bB+nDmGN35a7MC8gATF9uJeP42Ges1Cuo3lt7x/fvNyqWBVPFADOr9Qaf
	 hmZ2xVuxOvmN3FV4x/oOdqyqMhOFp6Y7KjyDhOgVwTRPaj5sswU43DaKKusnomVm9TQs3
	 VWQSWuVD98CNrvD9Q/VF2r0VUGcqO3ifgbbd4h/q2p9yhFJRVx604z1exY9vFjYIZPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793854;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OkLUpvqoChdOLzjAlYGgEYQWNeVERS3W3LYApB+dQRw=;
	b=eJe7D81TJZ1Wzz5/JcHeoWfYjFRk8KPWXkwZVaal6hbO8C1Db7TIedIHa9hUpntpsKj6
	 XjIs6dc7itDK1eFrDIeDvlSkua4hFTWx1Uv4ZsIhnQY2jvzhhdLtNhbpA1slSD4NX/K31
	 gxlC68+UxZUDc6KILiyoPIbEmPOBXs0RlpXBPIdO50OkiaCtk6ALGXsCM7Afmnajy0C+t
	 wdN9gmuftg8ZdSiK2qLJFsiwQ/iH0zH9QlZMphBA+lxUWIvwfM43SmU+5UFD5L3/uXEJv
	 ZZxT29Fp/iVJtw9McleJGQ9UdZOfWxioRQk/EKQk1e7Zqhi2sonMJiHfhE0QUSCElzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T7iPvsS3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39E5606A332;
	Mon, 16 Nov 2026 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T7iPvsS3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC3F1F01819;
	Mon, 16 Nov 2026 01:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793854;
	bh=OkLUpvqoChdOLzjAlYGgEYQWNeVERS3W3LYApB+dQRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T7iPvsS3Yi/ngGWmUHh+ZUJqaRfL3MU0iqnU+DQRFWVJl6v8Y/vMZ3jjmxXcXutDj
	 fyu6ytMtQlM9HwykQ/GUah98IZqjLygSY9ThhMyG99C9CjAXaxwezW8M66QhzSa+nW
	 +eyRXYRbvIoToORsrUzTrHi1eCxxlT37zQyiFc4SP1cVsVaG0/9JS5vJicXWFHDQyZ
	 Hdua4PveiSmF0CbRoGquS43x78hj2kEBJxf86fmc530yWS+pR85d50/fgtKwLs+NKh
	 o2yK3dMeXe7SWh3XChdJgODHiOuDx7rgQHPD4SH1n7I82I2EVT1vlm044qJLp3Cnr1
	 ArTxD+viMSyag==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	Gustavo Silva <gustavograzs@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Jorge Marques <jorge.marques@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Dan Robertson <dan@dlrobertson.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Maxwell Doose <maxwell@maxwelld.cc>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Esben Haabendal <esben@geanix.com>,
	Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 30/35] iio: gyro: adxrs290: use default_trigger
Date: Mon, 16 Nov 2026 01:48:18 +0000
Message-ID: <20261116014823.3132576-31-jic23@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261116014823.3132576-1-jic23@kernel.org>
References: <20261116014823.3132576-1-jic23@kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Set indio_dev->default_trigger rather than taking a reference to the
trigger in probe(). The IIO core now takes the reference during
iio_device_register(), relaxing ordering constraint between setting
this and registration of buffers. The ordering in this driver was such
that there is not a leak, so this is more about avoiding fragility and
enabling further refactors on top.

The copy of the trigger pointer in st->dready_trig is only used during
probe(), so replace it with a local variable.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/gyro/adxrs290.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/gyro/adxrs290.c b/drivers/iio/gyro/adxrs290.c
index b61cc81122a6..8b1807124795 100644
--- a/drivers/iio/gyro/adxrs290.c
+++ b/drivers/iio/gyro/adxrs290.c
@@ -72,7 +72,6 @@ struct adxrs290_state {
 	enum adxrs290_mode	mode;
 	unsigned int		lpf_3db_freq_idx;
 	unsigned int		hpf_3db_freq_idx;
-	struct iio_trigger      *dready_trig;
 	/* Ensure correct alignment of timestamp when present */
 	struct {
 		s16 channels[3];
@@ -566,6 +565,7 @@ static const struct iio_info adxrs290_info = {
 static int adxrs290_probe_trigger(struct iio_dev *indio_dev)
 {
 	struct adxrs290_state *st = iio_priv(indio_dev);
+	struct iio_trigger *trig;
 	int ret;
 
 	if (!st->spi->irq) {
@@ -573,28 +573,27 @@ static int adxrs290_probe_trigger(struct iio_dev *indio_dev)
 		return 0;
 	}
 
-	st->dready_trig = devm_iio_trigger_alloc(&st->spi->dev, "%s-dev%d",
-						 indio_dev->name,
-						 iio_device_id(indio_dev));
-	if (!st->dready_trig)
+	trig = devm_iio_trigger_alloc(&st->spi->dev, "%s-dev%d", indio_dev->name,
+				      iio_device_id(indio_dev));
+	if (!trig)
 		return -ENOMEM;
 
-	st->dready_trig->ops = &adxrs290_trigger_ops;
-	iio_trigger_set_drvdata(st->dready_trig, indio_dev);
+	trig->ops = &adxrs290_trigger_ops;
+	iio_trigger_set_drvdata(trig, indio_dev);
 
 	ret = devm_request_irq(&st->spi->dev, st->spi->irq,
 			       &iio_trigger_generic_data_rdy_poll,
-			       IRQF_NO_THREAD, "adxrs290_irq", st->dready_trig);
+			       IRQF_NO_THREAD, "adxrs290_irq", trig);
 	if (ret)
 		return ret;
 
-	ret = devm_iio_trigger_register(&st->spi->dev, st->dready_trig);
+	ret = devm_iio_trigger_register(&st->spi->dev, trig);
 	if (ret) {
 		dev_err(&st->spi->dev, "iio trigger register failed\n");
 		return ret;
 	}
 
-	indio_dev->trig = iio_trigger_get(st->dready_trig);
+	indio_dev->default_trigger = trig;
 
 	return 0;
 }
-- 
2.56.1

