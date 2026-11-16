Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793798;
	b=HE6KDT+cgA0nt6Gd/RFx57yfcObmuZXHERyFAC3IQ+DNY9Q73dPWqfXHYPcqr2Mrt7dc
	 W3lW/8ZsLtCf0ceDyCRf03CT50Cn/eCHjfeAO0pjwkD4IT4tKtldvKTA3vKNKn8YOcKbK
	 ra+0GlcMEa8MibU7hMUTGqY6q2gpvV54SxzeyRBZGnMMAK936KaUDZzTjJyE7dBOd5eY1
	 ltIrC2oEhRFxzgA33F0vyoyazaVBBgV5U6cNlrS48hVmU4rHQ0SyMkVTVazrth0Lq709U
	 KZ7vj3/aCcVgvBT9/Grjrlmrtn2p+eL7QOvq70n3fkSyj1REhFh45cwhqnqBgUjCTfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793798;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8zx/VSsNnqy+Um+lGT28GPN1/fckFuWw5yHBN6QYvdQ=;
	b=lAzW930tt7Kads5/zEB0VmvjPRhcpIapEGxXoYdZZhhjTP1PmTKEZeQdMQ069jS29IPh
	 Gidqt4QMo3290YziNv/gb5vQuYC4RIlfWnwB5peSjXlqkqkYBYRnn7qJZYvyLpeaumMro
	 tO0lJ8QEEUwa9ALg/q0vvFzMQM5d17LleKGA7oA15LYNz0lIO5BgkqMU0vJh6JyqvsIoD
	 fVVBqC3TWtBMevBeNnLr6ItDpf2L8P+3CzzjT4BRqB9YNrQXZDdJjKpYkr9o9XmbetbJp
	 +LBOUB7NByQmcXsA6ZvSLoNEG1QncMUt7NZFBD2Bw8Ko0pPvZ/RobhCqV81M//NNrMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bz1NTFM5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911A606A31F;
	Mon, 16 Nov 2026 01:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bz1NTFM5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868DF1F000C5;
	Mon, 16 Nov 2026 01:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793798;
	bh=8zx/VSsNnqy+Um+lGT28GPN1/fckFuWw5yHBN6QYvdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bz1NTFM5MWThJYCwvljMzsVws0ueLG81a80cChtG+6wzBpEXe7V4k457UCU5SLzsP
	 +TiujbKaN3cYf3G4pB4kZM7jMM64DGyuEb/TgpjR6HES7M5evKOfOsnGTvmz/bwWwD
	 ZlVyyKe8lyF88rLgzmA911VBG67bej9JoVrxtlngJ8uRy1VkkyhOKHe1DCmP091hdZ
	 OdUn+83saX0xb0xGOwPR11KtYGh6A0FhglKbYFMO1VMLsNym29B8NAJKPrb6+0yj9C
	 WXVZmj9QGO8T2gESJrLJMPTulrVtkvup22MBI6kEkH/BmJ7gRQ+Z9+wEU2w7MCEMkj
	 1Q5rFyG9ik4fQ==
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
Subject: [PATCH 11/35] iio: temperature: tmp006: use default_trigger
Date: Mon, 16 Nov 2026 01:47:59 +0000
Message-ID: <20261116014823.3132576-12-jic23@kernel.org>
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
the trigger is set up. That leak can occur in this driver, but more
generally the intent is to avoid fragile ordering constraints.

The copy of the trigger pointer in data->drdy_trig is only used during
probe(), so replace it with a local variable.

Fixes: 91f75ccf9f03 ("iio: temperature: tmp006: add triggered buffer support")
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
This one is a fix, but I'm not planning to push for backport given
the impact is a reference and resulting leak of data in an unlikely
error path only.
---
 drivers/iio/temperature/tmp006.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/temperature/tmp006.c b/drivers/iio/temperature/tmp006.c
index d9f6449ec0d8..51196ea9211d 100644
--- a/drivers/iio/temperature/tmp006.c
+++ b/drivers/iio/temperature/tmp006.c
@@ -45,7 +45,6 @@
 struct tmp006_data {
 	struct i2c_client *client;
 	u16 config;
-	struct iio_trigger *drdy_trig;
 };
 
 static int tmp006_read_measurement(struct tmp006_data *data, u8 reg)
@@ -297,6 +296,7 @@ static int tmp006_probe(struct i2c_client *client)
 {
 	struct iio_dev *indio_dev;
 	struct tmp006_data *data;
+	struct iio_trigger *trig;
 	int ret;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))
@@ -340,25 +340,23 @@ static int tmp006_probe(struct i2c_client *client)
 		return ret;
 
 	if (client->irq > 0) {
-		data->drdy_trig = devm_iio_trigger_alloc(&client->dev,
-							 "%s-dev%d",
-							 indio_dev->name,
-							 iio_device_id(indio_dev));
-		if (!data->drdy_trig)
+		trig = devm_iio_trigger_alloc(&client->dev, "%s-dev%d",
+					      indio_dev->name,
+					      iio_device_id(indio_dev));
+		if (!trig)
 			return -ENOMEM;
 
-		data->drdy_trig->ops = &tmp006_trigger_ops;
-		iio_trigger_set_drvdata(data->drdy_trig, indio_dev);
-		ret = devm_iio_trigger_register(&client->dev, data->drdy_trig);
+		trig->ops = &tmp006_trigger_ops;
+		iio_trigger_set_drvdata(trig, indio_dev);
+		ret = devm_iio_trigger_register(&client->dev, trig);
 		if (ret)
 			return ret;
 
-		indio_dev->trig = iio_trigger_get(data->drdy_trig);
+		indio_dev->default_trigger = trig;
 
 		ret = devm_request_irq(&client->dev, client->irq,
 				       iio_trigger_generic_data_rdy_poll,
-				       IRQF_NO_THREAD, "tmp006_irq",
-				       data->drdy_trig);
+				       IRQF_NO_THREAD, "tmp006_irq", trig);
 		if (ret < 0)
 			return ret;
 	}
-- 
2.56.1

