Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198584;
	b=k8+rdvu43SxeDflVZCx1qAo4qpBiq54SBX67hOTNbxx9ZnXTX8nSaQdJaFyFpexqAIIa
	 PW5xAR7+h/HmfvKihjkvjaVuR6fF+thlElW61XQlMbxjavKFj+RsD8awrOz+6Q5sRjNQq
	 s9t/roq3wuUnv2MiPt1S3BYBdtdKRm5b2qYzrFIX+ahbLr/LJLymihAU6ivV3G7sbAs1t
	 3SjPjM+3hurAKosyHTG7GnU00c0qI2Q3eU9TCfWybFp08wY9MO6NRkPTJZ9lBhBnOpmrG
	 Rx7J6jFUaqegn70mfvwgxf0fB2U9/ZBK8iQOsQw8T9n39XxynirZ2noepqfD7PGTeAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198584;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xbScOYTDgyrTUjPbnxCpt2oXpwahQgbrUgKAhY62GAM=;
	b=fl84XzbAts46wnUkJzn8+YgbflQVUu+3ydp/2EhbuxplMx2qbjZulDp0dqhNyUki/Lmt
	 0/O5lE2KJaLSC7wVJOS2m1WxgffELCEVaF/lc4e223uRgF8Plt5YGV5DUHG0BQ6iVgbQ6
	 Odww874e2eZcH5GjAGH3WLYovmzTEKmXqMj1u8WRMXSkJ56vehpWrVl3AKU3hdxFmFTqL
	 VeYSnw6ZThi1/3sS6H8AMI+blzIpt4vFh5qeBnvsz+JdOlLDEN3tamB+o4S29OmF03ndD
	 3wksnveK/vUdrnl9nlZBA2ny1UkrauCdjnRG/7EMEGsdUT56Zt3B4VeC1Zj4FcLeZTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDxlP33w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB206606A326;
	Mon,  9 Nov 2026 04:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDxlP33w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD661F008A5;
	Mon,  9 Nov 2026 04:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794198583;
	bh=xbScOYTDgyrTUjPbnxCpt2oXpwahQgbrUgKAhY62GAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kDxlP33wvnvJwg9gFlGYkaQ81DmvfkI0wn+hwMEUioFoGyrhL7vw4ip3KrconQQsb
	 YxsUDWY/xmlS8L2TubFR5ZFlas3T4ccW9CE06zB+C/1SBrkvBXYMKmuP7sSx4Js2FJ
	 QJMLV6M3yBRSK1thNxREdmT8pZGRNiz1HGmeHQtRX2DKM1kQ9P8XlDW/45OeRHewM3
	 JdtInJ/muzCRgBiknzKiZZXTGaTlZSwHzVahdvdFqKdDRc1yCqM52ZRnGdaocqDbSC
	 BJQbzCDTErYe/W4CeI3CaVCK/6RLTCkeMQOpY85kZNmIgyJxVkydFnZ0oaJyZDPQgL
	 yeyrj2oL1I+iw==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Song Qiang <songqiang1304521@gmail.com>,
	Radu Sabau <radu.sabau@analog.com>,
	Maxwell Doose <maxwell@maxwelld.cc>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Erikas Bitovtas <xerikasxx@gmail.com>,
	Waqar Hameed <waqar.hameed@axis.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [RESEND PATCH 12/14] iio: proximity: irsd200: poll own trigger from interrupt handler
Date: Mon,  9 Nov 2026 04:28:49 +0000
Message-ID: <20261109042851.1326940-13-jic23@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109042851.1326940-1-jic23@kernel.org>
References: <20261109042851.1326940-1-jic23@kernel.org>
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

Keep a pointer to the driver's trigger in struct irsd200_data and poll
that from irsd200_irq_thread() rather than indio_dev->trig. The data
interrupt source is only enabled by the trigger's set_trigger_state()
callback, so it is the driver's own trigger that is in use whenever this
path is reached.

This removes a dependency on the trig field of struct iio_dev, which
is to become private to the IIO core.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/proximity/irsd200.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
index b3db7f3a49f6..82edb135f4bf 100644
--- a/drivers/iio/proximity/irsd200.c
+++ b/drivers/iio/proximity/irsd200.c
@@ -122,6 +122,7 @@ struct irsd200_data {
 	struct regmap *regmap;
 	struct regmap_field *regfields[IRS_REGF_MAX];
 	struct device *dev;
+	struct iio_trigger *trig;
 };
 
 static int irsd200_setup(struct irsd200_data *data)
@@ -698,7 +699,7 @@ static irqreturn_t irsd200_irq_thread(int irq, void *dev_id)
 	}
 
 	if (status & BIT(IRS_INTR_DATA) && iio_buffer_enabled(indio_dev)) {
-		iio_trigger_poll_nested(indio_dev->trig);
+		iio_trigger_poll_nested(data->trig);
 		clear |= BIT(IRS_INTR_DATA);
 	}
 
@@ -917,6 +918,7 @@ static int irsd200_probe(struct i2c_client *client)
 	if (!trigger)
 		return -ENOMEM;
 
+	data->trig = trigger;
 	trigger->ops = &irsd200_trigger_ops;
 	iio_trigger_set_drvdata(trigger, data);
 
-- 
2.56.0

