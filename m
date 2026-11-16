Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793854;
	b=ImMCUf1Wl+vResUMk0wOlVwogqfVildzBWbZkts7PmeMFFgGKpOAB28rrM3/qXWm/ZP5
	 +kuXjPU7O4BmP7K79P4ZptUbyyBa5rJQpxQeLYQyH0cGhVliUavDpdTPjBCHfMbeuTF7X
	 5LtpZq9DcQjzvgxfD2MnUp6h8ZPoQTVWYVKCRhA66kUM2sYZn8SMnQ2GFP4Bu05OmBqPN
	 U/yvdB+Jj3cCdr/p7lkhp7XgUF6AFfPIHNtp7HbOqf5GPMx+OmoDPbpLazncrRIovMZNO
	 qIrjgqaWJTebUXSQQrgjtdRzCoJsfQi5ywyJBAUo347YkJq4PGteoeKQDvSYEu+7nOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793854;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QjjANKyH2B04aoOQLB9RFscAuqij9MjBaHoeAmqnqeY=;
	b=elA+V44iHdDtDKuYdgxs5vp1cMaZcOcnzhXWUjw7I96FbNHiO6Huthr937ZZ05sxCKea
	 3xFoSkWbDCVWk9BvnwGM6PiDWvN34kedpyFZEYTCh1PIrs5Nk2X+mkkxF0jI7qrlgmJfy
	 v7GI7mvhhD5rZHo6/z4VgsfrOoPuj41VtTKtnNNG8HhbXOXh9SkF2bBgaMHOQBlFXSEm/
	 obtJ5lzkl7Aij8IFKCMVS+v5ZZc9ptvlGajb3C1OIR6DJ0WcOchDwMAPAW4sqcZkNyQ5l
	 DgHM5f17ugRhbYpdOsnXeRImbKPbUwz7bSnRCq3I2wIeqZWYZ6zC0yu2mvq96f1aWbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Fx/Szn9K";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E68660A263C;
	Mon, 16 Nov 2026 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fx/Szn9K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 487F01F000C6;
	Mon, 16 Nov 2026 01:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793853;
	bh=QjjANKyH2B04aoOQLB9RFscAuqij9MjBaHoeAmqnqeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fx/Szn9K+O55WlhD4D7RUGINk+awqlzfAv1ueZy9nS6T2qxYuQ03EAaRQIqvp3Ymw
	 UP6VIUXxdHYx8WcAAehdilHupCo+UgPaIhlISPaEx4wGCniHg8lRPOi5OBqJuXki/S
	 effSUA2CFm73j9+VA7ICk4i0gMRYWYvQbb9m0aXhPvD4CHZby1lNyjfW1yC5NG+Zxy
	 e7cK8pyfXQI8yxYNFqkFZMTXjuny1wiDRDPyvLOXIDIpCaal6YZXTX0iDETq6FrP99
	 TqRMUVwSWyAjBoY3pBO2KZoxl6LcEPJCyxE5FEQrrrrs2c22Z5xfjo/qNQrVTXvIQu
	 qLBg3zesnZlrw==
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
Subject: [PATCH 29/35] iio: accel: adxl355: use default_trigger
Date: Mon, 16 Nov 2026 01:48:17 +0000
Message-ID: <20261116014823.3132576-30-jic23@kernel.org>
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
trigger directly in probe(). The IIO core now takes the reference during
iio_device_register(), so it is not leaked if probe() fails after the
trigger is set up. The ordering in this particular driver is such that
there is no leak, so this is just reducing fragility going forwards
and enabling addition refactors on top.

The copy of the trigger pointer in data->dready_trig is only used during
probe(), so replace it with a local variable.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/accel/adxl355_core.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 080c9f6f9a11..ff7e9fbdad77 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -227,7 +227,6 @@ struct adxl355_data {
 	enum adxl355_hpf_3db hpf_3db;
 	int calibbias[3];
 	int adxl355_hpf_3db_table[7][2];
-	struct iio_trigger *dready_trig;
 	union {
 		u8 transf_buf[3];
 		struct {
@@ -754,27 +753,27 @@ static const struct iio_chan_spec adxl355_channels[] = {
 static int adxl355_probe_trigger(struct iio_dev *indio_dev, int irq)
 {
 	struct adxl355_data *data = iio_priv(indio_dev);
+	struct iio_trigger *trig;
 	int ret;
 
-	data->dready_trig = devm_iio_trigger_alloc(data->dev, "%s-dev%d",
-						   indio_dev->name,
-						   iio_device_id(indio_dev));
-	if (!data->dready_trig)
+	trig = devm_iio_trigger_alloc(data->dev, "%s-dev%d", indio_dev->name,
+				      iio_device_id(indio_dev));
+	if (!trig)
 		return -ENOMEM;
 
-	data->dready_trig->ops = &adxl355_trigger_ops;
-	iio_trigger_set_drvdata(data->dready_trig, indio_dev);
+	trig->ops = &adxl355_trigger_ops;
+	iio_trigger_set_drvdata(trig, indio_dev);
 
 	ret = devm_request_irq(data->dev, irq, &iio_trigger_generic_data_rdy_poll,
-			       IRQF_NO_THREAD, "adxl355_irq", data->dready_trig);
+			       IRQF_NO_THREAD, "adxl355_irq", trig);
 	if (ret)
 		return ret;
 
-	ret = devm_iio_trigger_register(data->dev, data->dready_trig);
+	ret = devm_iio_trigger_register(data->dev, trig);
 	if (ret)
 		return dev_err_probe(data->dev, ret, "iio trigger register failed\n");
 
-	indio_dev->trig = iio_trigger_get(data->dready_trig);
+	indio_dev->default_trigger = trig;
 
 	return 0;
 }
-- 
2.56.1

