Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198580;
	b=BcZr3VHie45KXo7ZbDEcL8vNLuI3mKUAp9SLV+5qK40MiPBh1HC4Xb7lixF5Xhh/z8iS
	 vM8EZZ78bYqSSa1+V5/e/UfFXRDnHjyGr8zmDi+R7wij7nFUtS4TlJgO0x4P/dCkuoikG
	 bbNc7YtKzwPEnIYHtm3oHphuYEfSxnGN9njMl7yHKY5gN1juNjhgKyyfSQsolWkVZDQ0L
	 BcRFffJU78Mxr0kH3OeToBT7K+PVipiCTNy+MCQ4c5ZFj3Q3t8dU8xy7zxgJ++sP3KZd/
	 tDF2gt3R3mho1dghahAnP6AXUBG2IQmpGH0ApreLz0KbuCLgooMA6uf2RVPiolIHcBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198580;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8Uj4IOUei/xFM9ENtdppOiYtatJz1cAwsG8KzHWm0/Q=;
	b=126qbtI1aqxjZXtULx5TSOurgKKXgW7InnlFqID00QWligUx2oLlp1K06PZfXhy92nFu
	 zcdf+LOrlHObOdBwyyhMSJq7+06KkSQ9RomvdkjoP+1Mt3zEbP+jLPd4s2FcWNHdw/l9v
	 JX6SNjzeGQknrbszqbhYo3P2QxJ80KZ7fwHwIo982WSn0LSvzyt726FBtGZYXJCHtuouE
	 CVrr+DZ6CJT+FdcXkzp7VLhPtGgVBA0pImO9O+GIPNHYEVPwqpOs7sG9sCQII/Wf9YoRv
	 NDctOvpLM8zABs/pOFtT84icN2rhL/bToTIqpxryLe8Pg09cvUe4QgmK8WKA5KVMBaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esH6v05E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DAF606A33A;
	Mon,  9 Nov 2026 04:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=esH6v05E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76ED41F0089F;
	Mon,  9 Nov 2026 04:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794198580;
	bh=8Uj4IOUei/xFM9ENtdppOiYtatJz1cAwsG8KzHWm0/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=esH6v05EZV0nApoELcYM1z84zOs/5RLje5rnURuufcaDrHhdrdxIwevpHYiuerzfI
	 rKhEaesek/0KWD9BZEJZKRB1jbSuIyvQNoaFn+rvwQOQ6Wcyx8pYFPUj+FDC8B6GHs
	 ITCFkppwZ8BYqcXQgAxc7tBqcTGyvVYAexAdEnuAprdA1OVR2xZlD6Tf/9pZGWu7et
	 UZW2YHA9S2lahDdtvfrfbGUkJSiXDKGo6RAqF5N8Z6peTHWhaFs7DI/bG8g3Rd/aFZ
	 VzOm0hMkK+hpJyXDM4c9I19R8yNdu99DpOidA+e6TxBmk3SVnu2OHZwUr9TomuNV+z
	 dbBzov4bz9nGg==
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
Subject: [RESEND PATCH 11/14] iio: proximity: vl53l1x-i2c: poll own trigger from interrupt handler
Date: Mon,  9 Nov 2026 04:28:48 +0000
Message-ID: <20261109042851.1326940-12-jic23@kernel.org>
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

Keep a pointer to the driver's trigger in struct vl53l1x_data and poll
that from vl53l1x_irq_handler() rather than indio_dev->trig. Only the
driver's own trigger is accepted, via iio_validate_own_trigger(), so
with the buffer enabled that is the trigger in use.

This removes a dependency on the trig field of struct iio_dev, which
is to become private to the IIO core.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/proximity/vl53l1x-i2c.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/vl53l1x-i2c.c b/drivers/iio/proximity/vl53l1x-i2c.c
index bce238d1b6de..ffc6fe45b165 100644
--- a/drivers/iio/proximity/vl53l1x-i2c.c
+++ b/drivers/iio/proximity/vl53l1x-i2c.c
@@ -102,6 +102,7 @@ struct vl53l1x_data {
 	enum vl53l1x_distance_mode distance_mode;
 	u8 gpio_polarity;
 	int irq;
+	struct iio_trigger *trig;
 };
 
 static const struct regmap_range vl53l1x_volatile_ranges[] = {
@@ -587,7 +588,7 @@ static irqreturn_t vl53l1x_irq_handler(int irq, void *priv)
 	struct vl53l1x_data *data = iio_priv(indio_dev);
 
 	if (iio_buffer_enabled(indio_dev))
-		iio_trigger_poll(indio_dev->trig);
+		iio_trigger_poll(data->trig);
 	else
 		complete(&data->completion);
 
@@ -707,6 +708,7 @@ static int vl53l1x_probe(struct i2c_client *client)
 		if (!trig)
 			return -ENOMEM;
 
+		data->trig = trig;
 		trig->ops = &vl53l1x_trigger_ops;
 		iio_trigger_set_drvdata(trig, indio_dev);
 		ret = devm_iio_trigger_register(dev, trig);
-- 
2.56.0

