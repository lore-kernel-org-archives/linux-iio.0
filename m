Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793853;
	b=cVR1HevcmHTlmxLaI+zX/wgNWq8lQp8/voERtjLySjKnx6T2LClQbEtRB0BcRe2jvZDC
	 vY3EoC3lZkPOkNQzv0IIgVX4Imtwsfz4xzJvI6HdoMW3suoSwthY6VleW9QYJ/r/L5F+F
	 91gdsqgdBkfkRhUL5bYVeIwE12g/RILTU3Te0BsJxOG9Skf/yfB7ar05nDhYA1EVdVKRm
	 /jrayu+G666TOx7LS48c493NJjnYyVv8yQlTVfCjZ+5PmhK2iJrRHND7IX3qbIlxZB7Os
	 ieBENNQeTiBG/fpW9uiwLLclFnQnbXmMVs2hHk56+mmKh/qawsI0rW4XpqttbrzlWBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793853;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=B6KCe+IfaTxTcL1yex+HoKG7FtMVLlnwihy0XT1ygvU=;
	b=JuEchFhOlFEsjVLtzxGxZFybrTMBLFPuYIt59SjaroGSxZq6SO82K8rHndNE4tYULSJO
	 4rPfUO4DPjUCJPqjyWPJXAQUJQQxxzbLE18ZtKDyzp1I81GXz8U8BAIAiZWHeeo0ZEf9b
	 82UpN2XA3w0G+JbS1/tqWuIbGomnKA4XS2W6JFyjvCXjo1bw/mvsGROu5QVkYJeaZarQF
	 dVXO3r/hXab/PnEn7J+VWzVEXElb/6MEQaYuU51o5ka8CyF/QYyr3pRF0BUPwG1sRo3w1
	 f1Tv1yzNo03KkUEKhduJC2+lVdQqvISkgET/Hymm9VH3hZbwUKX+lWwMeD5eMvngxTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8bjF3S3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5D9606A896;
	Mon, 16 Nov 2026 01:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8bjF3S3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DFCC1F00939;
	Mon, 16 Nov 2026 01:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793853;
	bh=B6KCe+IfaTxTcL1yex+HoKG7FtMVLlnwihy0XT1ygvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P8bjF3S3QW8RpZWqSMNhw/BZ2R5Q1rcGfYO07mvtvqMLCNltd5j2d53kQJHzMs6xQ
	 ANOD6WaXabeJzwau5ufudSG/KLcdNp54V4uue+fUBQ5ap4N0U8D4dfxdFEusw5rLai
	 bsg1cI/12xgoKsBpiHPt1iAPIjpPIeSqbYkpxLpegKGmLRSNvg84mQa4oQiBZ6HeLU
	 p7NiE28QU4QoVedLwVMB+1NMqt79DxEqn38pbAUJ32CXfOf/p1WOiq0iW5alFE+kIo
	 X1hQYRVKAWAa2lLs3rxAwrNW7a2XxDO4KYxsQAX0EYt1epoTmwlxnVlNbPx+Yh8h7Q
	 KOklg/li9Cdzw==
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
Subject: [PATCH 28/35] iio: imu: bmi160: use default_trigger
Date: Mon, 16 Nov 2026 01:48:16 +0000
Message-ID: <20261116014823.3132576-29-jic23@kernel.org>
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
the trigger is set up. This particular driver doesn't have that leak
due to the specific ordering of calls. Hence this is just making
things less fragile and enabling further rework on top.

The copy of the trigger pointer in data->trig is only used during
probe(), so replace it with a local variable.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/imu/bmi160/bmi160.h      |  1 -
 drivers/iio/imu/bmi160/bmi160_core.c | 22 +++++++++++-----------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
index 629844c34f1a..1c4ce2e07b68 100644
--- a/drivers/iio/imu/bmi160/bmi160.h
+++ b/drivers/iio/imu/bmi160/bmi160.h
@@ -7,7 +7,6 @@
 
 struct bmi160_data {
 	struct regmap *regmap;
-	struct iio_trigger *trig;
 	struct regulator_bulk_data supplies[2];
 	struct iio_mount_matrix orientation;
 };
diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
index a27efa42e682..50007725f4cc 100644
--- a/drivers/iio/imu/bmi160/bmi160_core.c
+++ b/drivers/iio/imu/bmi160/bmi160_core.c
@@ -778,31 +778,31 @@ static const struct iio_trigger_ops bmi160_trigger_ops = {
 int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type)
 {
 	struct bmi160_data *data = iio_priv(indio_dev);
+	struct iio_trigger *trig;
 	int ret;
 
-	data->trig = devm_iio_trigger_alloc(&indio_dev->dev, "%s-dev%d",
-					    indio_dev->name,
-					    iio_device_id(indio_dev));
-
-	if (data->trig == NULL)
+	trig = devm_iio_trigger_alloc(&indio_dev->dev, "%s-dev%d",
+				      indio_dev->name,
+				      iio_device_id(indio_dev));
+	if (!trig)
 		return -ENOMEM;
 
 	ret = devm_request_irq(&indio_dev->dev, irq,
 			       &iio_trigger_generic_data_rdy_poll,
 			       irq_type | IRQF_NO_THREAD,
-			       "bmi160", data->trig);
+			       "bmi160", trig);
 	if (ret)
 		return ret;
 
-	data->trig->dev.parent = regmap_get_device(data->regmap);
-	data->trig->ops = &bmi160_trigger_ops;
-	iio_trigger_set_drvdata(data->trig, indio_dev);
+	trig->dev.parent = regmap_get_device(data->regmap);
+	trig->ops = &bmi160_trigger_ops;
+	iio_trigger_set_drvdata(trig, indio_dev);
 
-	ret = devm_iio_trigger_register(&indio_dev->dev, data->trig);
+	ret = devm_iio_trigger_register(&indio_dev->dev, trig);
 	if (ret)
 		return ret;
 
-	indio_dev->trig = iio_trigger_get(data->trig);
+	indio_dev->default_trigger = trig;
 
 	return 0;
 }
-- 
2.56.1

