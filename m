Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198559;
	b=QUCUThnlgPJ+GQAkXL9W1Z7FLC0n1T+41lp2SY6x16e/ZCvuCwFGAmAQWXzfJ2TM6xC1
	 hZPjbRunLvaUQucVF6TEHKxRTeMkN17Mlb5ZGpudO4T7YQ+nk7NUotxj7rnsFduXp13WP
	 z6qILrn+5N9kjce9j0rUcB7RUBjDXez5Fz37Y9bEIlIKmGRqY86LidqtHHHyvRUg5dcO6
	 D61YgrhdE3JWfZCrQ0zTenAhIw8qX0+g+olp3DXNJcfK3duQwaPiKp/LzPRya6haZF/Kx
	 loDpTtEowD8fAI9TBpJlt903Q5gnXnhnBhMx5+TAThLwlofZ3VapOZky21BV7YUVdXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198559;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1JrXEd2NO/cJ+1CoKfKmdQuXHWCqxoOc8mX38KC+4vo=;
	b=RfNEK4JrBnI3L7OjPUgS42YZyP9EvQuAc71nmzu/FT64xKnkvwG4HNKsBHSNzR/vMyC8
	 JA90YMK2MwU5DhM/WkcarfpoQPywYGGF17oPGeHWPJyF5RNa+NikHmEgyM9K0yFt0nSnt
	 DKInV+KP32pB4wIx3pGKjL9DuURcITwMQ5a3z/tKl8uyQcnZpfNrjP75+duuktoi1kPvX
	 kRlCDrap8P3PN9qf4LjZtNHrlErhXK6FXCO3CNZWtH+Pdl/0anzE0drq7uePYdJtZy/Vt
	 jF67CXpGWoZR7LaRau0sSURTf7wwYujqh/nVbhdfneo3vE3IjeZ0Q47hoICWlDA8Zcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1IQboB3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198DA606A323;
	Mon,  9 Nov 2026 04:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1IQboB3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952031F00906;
	Mon,  9 Nov 2026 04:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794198558;
	bh=1JrXEd2NO/cJ+1CoKfKmdQuXHWCqxoOc8mX38KC+4vo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c1IQboB3Ziazu8d89pEJTcYjx/+p8MW4DFJs4P61Bm9z0vfQcFRcsESqwce4AvLre
	 GPjeZpvW+LmJUopV8HP9IMAHgzR9+onhx3VUGsjIGPVYjOnHvqwUxB+05XVc+wLh79
	 t9npLDpIwyn1pD6wuhltySUBHlj5iNgnG8imByx6XkWAuo/mcjgRmwvdkzEfPcccyk
	 HDUH3HoWFn4nJ1I9FaQ9wI+dticsSHTXt+IuPOXTEVaMhnlCUwrbyKUbhOAKIu/kRh
	 7RCOXirQLj8Qx+SqVyVgWdIQ3qTNzeDhgMIJlcrSRybGT/E8qYzFKZaeja1/p1MCpV
	 NWMoKaP73MTnA==
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
Subject: [RESEND PATCH 04/14] iio: adc: ti-ads1119: poll own trigger from interrupt handler
Date: Mon,  9 Nov 2026 04:28:41 +0000
Message-ID: <20261109042851.1326940-5-jic23@kernel.org>
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

Poll st->trig from ads1119_irq_handler() rather than indio_dev->trig.
The poll is only reached when iio_trigger_using_own() is true.

This removes a dependency on the trig field of struct iio_dev, which
is to become private to the IIO core.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/ti-ads1119.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index b0f04741ddc6..e815ba6d9d4f 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -497,7 +497,7 @@ static irqreturn_t ads1119_irq_handler(int irq, void *dev_id)
 	struct ads1119_state *st = iio_priv(indio_dev);
 
 	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev))
-		iio_trigger_poll(indio_dev->trig);
+		iio_trigger_poll(st->trig);
 	else
 		complete(&st->completion);
 
-- 
2.56.0

