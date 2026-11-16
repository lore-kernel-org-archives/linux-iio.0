Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793768;
	b=ku6E/0teI3C9hF47/6/IFVEIDrjFnWnDMcYxoE1Zm5baxPOJ+LhM+r4Y2SfevNgiu/SF
	 1t5MHvjHC5ZMaWNAdy+DHw0YwF0iHgMMDma1jB8huSlQaYtT8hN3rxVQE84Nqty3fnoXH
	 V0xz3oTEKU7IuIsRnF30eV7dXFd05pVYHCzkhio8+ek3ddHufZHXr/yskZylxwyHXHTLW
	 qhK8e9+rQlYDJwsinS/C+Y0/1LjJGZBE72ar1pbK8KewzeOWMDeaIdxofWhF7IJDvv4cA
	 w2MnM9nSeXhXzAmFEvxZ/IdNNjRNXY0nrXvbrbliyF0vqX84/uWU2YijOeVezgkrIvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793768;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CUBj8Vhzs8kcADKbQ10wA3ATw5zPg022rW7eodf7LYo=;
	b=elvrDaAUsXHATFfimI9kHTSn2qtQHjN7ueGFZ3zSsGr+QJVK3PWmOIsya2urZdkeZXOL
	 ninid/6e+qkAWKtsgVyHEaqLu3dOlogs7WHOfzbGMRA3d5FqtqUy/s+6apA1crIoH4oaw
	 tia6JHWtVcJG8/U6AVVboaTLArYg1AOVo8HgQ+gZuJ5RUYPk3W2NHiXm+n38PBDaE1SLE
	 6tUPUx2d4G+aojW0/KnAivcyXFY/s4EzYSfrhOVi+txrtx9MmKJ9hARqnGJe0kfnci8hU
	 br0PgDfalneZi5WJmYqPm4Nz1F7UcMHB4QgUiftWU7x5T6v7FUXV+XEF1wAqMFzOq1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omt36tXQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9806A606A881;
	Mon, 16 Nov 2026 01:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omt36tXQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935231F000CD;
	Mon, 16 Nov 2026 01:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793768;
	bh=CUBj8Vhzs8kcADKbQ10wA3ATw5zPg022rW7eodf7LYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=omt36tXQtw+dfxAXudpVM+iJhkLlU4HfpI5aZgsFYuBJYgHcW//y6Cgo4m0jFaZVQ
	 DyIdB1Jc0hO4TIPETkB9ticDZPIIommo50gHZVlQfgcntXbICUho+wBCQTX8ET0UW3
	 pXmE2/LiggYecxHfXZGKQOffOaJjlq/ADy4LHvnzAVa0+cg/jKeh5Xf9jQOc22v35M
	 a9Jnz++pZkAQ0fTaYyK4ieGBKDq/s0fXkVhwumOR3KiqrVfrLB+PXe5vCSSjE5H1jo
	 MoAqoRiyKO7qM1wo6oSB4TOwLAf4yVbey/ga4z1fbsVq4faO5qhjGJJRtGbm8zsWaI
	 YbtOmBaBGf7dA==
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
Subject: [PATCH 07/35] iio: adc: ad7779: use default_trigger
Date: Mon, 16 Nov 2026 01:47:55 +0000
Message-ID: <20261116014823.3132576-8-jic23@kernel.org>
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
iio_device_register(), so it is not leaked if probe() fails after
the trigger is set up. This avoid fragile ordering constraints.

The copy of the trigger pointer in st->trig is only used during
probe(), so replace it with a local variable.

Fixes: c9a3f8c7bfcb ("drivers: iio: adc: add support for ad777x family")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/ad7779.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
index 79fb38d0f400..53e4a9a19b60 100644
--- a/drivers/iio/adc/ad7779.c
+++ b/drivers/iio/adc/ad7779.c
@@ -141,7 +141,6 @@ struct ad7779_state {
 	struct spi_device *spi;
 	const struct ad7779_chip_info *chip_info;
 	struct clk *mclk;
-	struct iio_trigger *trig;
 	unsigned int sampling_freq;
 	enum ad7779_filter filter_enabled;
 	struct iio_backend *back;
@@ -821,33 +820,34 @@ static int ad7779_setup_channels(struct iio_dev *indio_dev, const struct ad7779_
 
 static int ad7779_setup_without_backend(struct ad7779_state *st, struct iio_dev *indio_dev)
 {
-	int ret;
 	struct device *dev = &st->spi->dev;
+	struct iio_trigger *trig;
+	int ret;
 
 	indio_dev->info = &ad7779_info;
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
 
-	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
-					  iio_device_id(indio_dev));
-	if (!st->trig)
+	trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
+				      iio_device_id(indio_dev));
+	if (!trig)
 		return -ENOMEM;
 
-	st->trig->ops = &ad7779_trigger_ops;
+	trig->ops = &ad7779_trigger_ops;
 
-	iio_trigger_set_drvdata(st->trig, st);
+	iio_trigger_set_drvdata(trig, st);
 
 	ret = devm_request_irq(dev, st->spi->irq, iio_trigger_generic_data_rdy_poll,
 			       IRQF_NO_THREAD | IRQF_NO_AUTOEN, indio_dev->name,
-			       st->trig);
+			       trig);
 	if (ret)
 		return ret;
 
-	ret = devm_iio_trigger_register(dev, st->trig);
+	ret = devm_iio_trigger_register(dev, trig);
 	if (ret)
 		return ret;
 
-	indio_dev->trig = iio_trigger_get(st->trig);
+	indio_dev->default_trigger = trig;
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
 					      &iio_pollfunc_store_time,
-- 
2.56.1

