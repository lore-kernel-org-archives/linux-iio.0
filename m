Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198575;
	b=f7I26a0P/dqeMmSZkhtfDh85nVg1HVGVzFxZ07pT+sfYKq2WvoQNdG6Y4xVWl5sBZt4+
	 wSZTxLFz4FAwPhh4vA6cR/KZ9/Bg+l1pchFSKe5veG1NGcaGSAAgGAtM3xFIi2S404srm
	 rly1BzFt6eoxGLw4feTU1IxlzqGv/q6Ij4UesDVJ+75w2OpsYN+PhmJYaXUWCtIoovG7y
	 P/VX9duEgqiTL4nTjyfjVkTz0fORBde9qQgJzHYtBJFZAh1XTnU6/Tu6Uq6ZzU5Gnn/jJ
	 HUyTVhF+WmUo9YuHiJtPesUT6lnFRGkHF1NDxcaSiDvYFrjwqp87P43shFQNtfSUuyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198575;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EtQrRKvpWtz+E3mm+kaVFsLMC7JdRWPcalkYQmYAWUQ=;
	b=GcZllgTVJAdJoYejV1mL0PY1tWfM4jdBsmR4Zrk8dsUv4xMX2+OS92TGqugJp2DMUEwi
	 Ef1CXjopiNfmkFj3S7yVqOu5PikrAIwc9TcwV2qV/GSm2ewT5y96zOn0qPmqESU1M+1ed
	 tU7DBZPjCJLMjPzAXsGX4qXjYsW9/ggwymKlzOGfu055fza766QEHTTSewdsaqbdFfU0A
	 HciWz529/3iiUDt0y/l2dMOwzkjBkS150QpIVPPLDefLA0AXpqeYRm/Hj8Z9b5azpgX3P
	 8F5Lh1dkZ8/FXSfJC8un6Ux4KFOzKE0bRZ446liBlMph9QUGuW+OCnN/33YxeeYBJ2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHaOj6Yt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464E7606A322;
	Mon,  9 Nov 2026 04:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mHaOj6Yt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9441F0089F;
	Mon,  9 Nov 2026 04:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794198575;
	bh=EtQrRKvpWtz+E3mm+kaVFsLMC7JdRWPcalkYQmYAWUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mHaOj6Yt9loVuJqPUJ0leTjU9s1jn+U7f6ppOin5cwHfwIaK7jFoS8DTGkgS5nulu
	 +E6H3Z0nLvd8T5X9l0P/FcSqLHF7xA3S1BKYTgCwX0RYuG0j2IQDCANH9pE9tlxvHs
	 760kckEwWgbrlRqStQIT6sLSt2JnzKzOp3s33HDCsiAzMETKagwpPiK+xSZ8DuojfR
	 vLvZaRutRHYNVsNv8Bwv8Bkaxm4bIpy6AyKWtP4VAMKz7nWF/lMRbok0t7XUcHnHoe
	 nYYDyyYiLXfWSOydmK96kk2CtXCLFqsw9re/9gZlg45/Wmoocr4uKtZTNBcxM3Fv+G
	 mmFmknLdDbCbA==
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
Subject: [RESEND PATCH 09/14] iio: adc: ad4691: poll own trigger from interrupt handler
Date: Mon,  9 Nov 2026 04:28:46 +0000
Message-ID: <20261109042851.1326940-10-jic23@kernel.org>
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

Keep a pointer to the CNV burst trigger in struct ad4691_state and poll
that from ad4691_irq() rather than indio_dev->trig. The interrupt is
only enabled for CNV burst mode with the buffer enabled, and the iio_info
used in that mode only accepts the driver's own trigger via
iio_validate_own_trigger(), so this is the same trigger.

This removes a dependency on the trig field of struct iio_dev, which
is to become private to the IIO core.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/ad4691.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
index f2f7c4c6424a..f63a68a009f8 100644
--- a/drivers/iio/adc/ad4691.c
+++ b/drivers/iio/adc/ad4691.c
@@ -441,6 +441,7 @@ struct ad4691_state {
 	struct spi_device *spi;
 
 	struct pwm_device *conv_trigger;
+	struct iio_trigger *trig;
 	int irq;
 	int vref_uV;
 	u32 cnv_period_ns;
@@ -1563,7 +1564,7 @@ static irqreturn_t ad4691_irq(int irq, void *private)
 	 * the IRQ.
 	 */
 	disable_irq_nosync(st->irq);
-	iio_trigger_poll(indio_dev->trig);
+	iio_trigger_poll(st->trig);
 
 	return IRQ_HANDLED;
 }
@@ -1861,6 +1862,7 @@ static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
 	if (!trig)
 		return -ENOMEM;
 
+	st->trig = trig;
 	trig->ops = &ad4691_trigger_ops;
 	iio_trigger_set_drvdata(trig, st);
 
-- 
2.56.0

