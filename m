Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA2334E75A;
	Wed, 28 Jan 2026 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594170; cv=none; b=l5aWyFssWQV5njkLvaoL0oSdaTvdFiPbyVXDogDJ2E8jSL4mt/KFj6ph8gGBH2w9WS/CDi2IpnIvcLNa7yM7PoILcx4Th67V+iZb/Yy65/RMj5XijYbg7Fb0smg5paPjSFGOxqvQ0zYlEx/3hLW0xjBC+SbWNn2p7r9WXwYAXP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594170; c=relaxed/simple;
	bh=fjwDBjXn9ktigdyc5frdA4SAb1wMfTbk3w5QpgfJe+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRCwblrc4Sx7whJZn05bhx9CTfkFg+B3cH2x6z6Q3eLWpxb3uZocjh1h2j9dffKMYM3WDTarar/nrrbpfMklshfaNsjmPeJ3K/RlQl271grlnsyeBGU4b2YP/6ziuJroMXYEMQj6qyJF+Fc1BiYG1qOUipQJxFcukfrvi9cv6nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h9NSiq1Y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fYk6bI/s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h9NSiq1Y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fYk6bI/s"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769594164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zn/om1QLQ5QnjRFzFZkdVQxs6a/meF8KP+yq1DIgPkw=;
	b=h9NSiq1Y+TSLOZo8Kw5QJYAa4R7gT6BLlKpqFORRnpt08QxUOfx+t8gX0zRvRaJUXnK4uC
	crPWoMuCwCfHyTrb25LNweOULye2JVcScChwAAqWheXtCurdsjVZJBnuIBlGvyot+sOfiM
	xqnFSmnNOehrz/T/8uviv2lnVK2XFxXb18LCv+5XNE/AXck8ur3cJu9xnj+b1I93hxow3y
	dCg+6t1ypKZFQp+unNSQZBicGwpJ3wviKoBTLRHGnjCsMULGTC34Q3YbJRm8D74MK3J+oV
	j0aKD01sC4tsKRZ8wMmOoB4EdX/ri6ImZzkkn8UOvOr2WYYgMOBPbWUB6DVy0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769594164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zn/om1QLQ5QnjRFzFZkdVQxs6a/meF8KP+yq1DIgPkw=;
	b=fYk6bI/sKvIwK+k3GOz8E3NNRe7Xi7ejF5r5OwuVeJ3XJV4pqgC2kjfOQl13YzYY9Lj/96
	kv15zD8VILQmPDCw==
To: linux-kernel@vger.kernel.org
Cc: "Thomas Gleixner" <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2 19/20] iio: adc: ad7766: Use iio_trigger_generic_data_rdy_poll()
Date: Wed, 28 Jan 2026 10:55:39 +0100
Message-ID: <20260128095540.863589-20-bigeasy@linutronix.de>
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

ad7766_irq() is identical to iio_trigger_generic_data_rdy_poll().

Use iio_trigger_generic_data_rdy_poll() instead of ad7766_irq().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org
---
 drivers/iio/adc/ad7766.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7766.c b/drivers/iio/adc/ad7766.c
index 1e6bfe8765ab3..9e4a66477d2d0 100644
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
@@ -260,7 +254,7 @@ static int ad7766_probe(struct spi_device *spi)
 		 * Some platforms might not allow the option to power it down so
 		 * don't enable the interrupt to avoid extra load on the system
 		 */
-		ret =3D devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
+		ret =3D devm_request_irq(&spi->dev, spi->irq, iio_trigger_generic_data_r=
dy_poll,
 				       IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN | IRQF_NO_THREAD,
 				       dev_name(&spi->dev),
 				       ad7766->trig);
--=20
2.51.0

