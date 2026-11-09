Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198552;
	b=mPlL19HnSrVYUlqtfuUDHVSyFCA/T7BvPiFLI+XtTpzUvm3YNBq3ACRSUNfGnfEFK+6B
	 1fuFpSILcX53QEgKez6Dq/Jqk7ZEmzL7jGfkcwP8VAfxKQ60fWHPjFv5nEvvjU1LZlT99
	 kryS88FE6XqjrRL9yyHUR3Xs19Aeuewfek5/d8HCi5ut0dn1FqSP+4sqWXZ7Q1C1aZJ5O
	 bPnxewr3/0iWLH37x4A9rkzGmuoADFcd4IjnQ50DNL0sQnQovo0DRRljWGnYzBefu0Se5
	 hQ1GD9TtN8VXC/itvDnSfNxKYv3yNycJL2AoKdmX3pnnfWUOpocrB7vqUqhApwMwPVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198552;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2TNfnPdK8OCQ55KXkxrD8Ttgxo05/cSe/OzFy4EXz3Q=;
	b=BptHKrbZuZLn0RjQEbNCY2qhvV+/XGVq9J7Ks7D8Lk5r4fxY/Cx9b9sOlqZit6wJyw7y
	 gNz63VNYzlAEoy3vX3nfxrGMlsefEZ7jGY/CA2q9BCZl1+okkotgIGR8CSR163dFZofUg
	 YukRrRAZlNfRsQd9kgGojYX6nAY0i/q9y2H7Y1M2vawsyWqr4RT0HIa/5Uj4ODTMW1m89
	 kOldN5qKuTPtlJ8skRcNIvKxcyqFnkMH8Dx0/JE/be5tEa6uUBQ0X323VxtMmcKoqqiRC
	 MvRqS67XE9J2FaHSx+cBzkYAcqpIC17kqRSMpOIMucBjUV1XGfBu12I4zH1GVcZz9cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cy7Lzekx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10DD606A321;
	Mon,  9 Nov 2026 04:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cy7Lzekx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 563531F00906;
	Mon,  9 Nov 2026 04:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794198551;
	bh=2TNfnPdK8OCQ55KXkxrD8Ttgxo05/cSe/OzFy4EXz3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cy7LzekxVzAXjEoUYr8hNB61VteHdfo2xpTpaX16ipgWfJX607YFrt6QVuy8mwN3a
	 Qzlj61ESYglj5fbN+lFeRVMueGJNpVtOCVQXC5+c16tGuKhqpmYSQGbAc8jQ4G3R5V
	 CsgAWXRT1w15AqJi7+UbYxAhVskA83/rTs4YTCSkNh3TzldZXVStSwK6jynsM4jXau
	 25KgF3N9i5CqlX7GnpH037XoLFNzo+0iEC8S1DQ6EV4xJnJ5Q+ySztVPnRP14Fundr
	 4Z2UAEKk81d+VzIRm7C7E17kTtj4h/q5T62Zxj3j0WsZ4dm3lrrJ8h3Nz3iIXASFPD
	 +dX1zanQChR8g==
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
Subject: [RESEND PATCH 02/14] iio: accel: mma8452: poll own trigger from interrupt handler
Date: Mon,  9 Nov 2026 04:28:39 +0000
Message-ID: <20261109042851.1326940-3-jic23@kernel.org>
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

Poll data->trig from mma8452_interrupt() rather than indio_dev->trig.
The data ready interrupt is only enabled by the driver's own trigger's
set_trigger_state() callback, so that is the trigger in use whenever
this path is reached.

This removes a dependency on the trig field of struct iio_dev, which
is to become private to the IIO core.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/accel/mma8452.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index f9abff3842fc..44962ac7491f 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1099,7 +1099,7 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
 		return IRQ_NONE;
 
 	if (src & MMA8452_INT_DRDY) {
-		iio_trigger_poll_nested(indio_dev->trig);
+		iio_trigger_poll_nested(data->trig);
 		ret = IRQ_HANDLED;
 	}
 
-- 
2.56.0

