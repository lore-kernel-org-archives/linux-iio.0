Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198568;
	b=k9/S90oPxp8W0qdc8hPRSWc6GfVThXk5XwFkHrKZlXzLB5KTtvIxdJioI8s7hNpISeq3
	 ssTa1l6B2pEULom4ITzo1ue6oVmTxNgvjCw5SIE7OedudAOqK2v2UryJYIZ1qmE5wes0J
	 xwZVp/uum0zL9D5Eq3XRszQF+i1KkD7wnHviMcFJtdZ1DI6F4A/sJMM0lSpbKmP9N8x2M
	 xYQ+fWwVccDgs6rGmucXB80B1aNyEDFsM0LTSLPhiov8A2POosD2gbdBa9mXdic45KK/x
	 D3330TCnncZo2x/6e3hEJZrrRUqN25dmVxi0MH5o1zxVRxW2CSz0ZASyAs0Xn5+RO5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198568;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+vNJkoFdRV0hile3s0HC3gFTuex7879BN3APjkn7jbs=;
	b=DdXiSI8xE5wJCe55k0X3+4xu8vYRD7X3j+YheB3h/vYf3J9LFVqMunS43wwI0a91EUKy
	 wEKI9m8Ynb7Ub1JYDyfChhXPg36Dty7I6Xt2oV6GiBmJnd064GtY/77KRE+IDs6NIyVZe
	 4lPDBT8SzLlDGRl8zhwLZGAJalwzYy5KJ4hYsa0VzZcfdYStQiHkGT2jWuFkEPd2lWQPv
	 nJ3tJ24mE29QpqcYWyMjHsXay/Y3d8BIKBA9PFWawTwfw0GWQIUPa7IJCBhKVJjpHejJw
	 xlavlP5huZsptBRSbfgJiP2ks7fucRAPBMvkp18SZW5D1sdMAT/wCK4PNxF2UXGOOsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jv1K5saN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22C606A338;
	Mon,  9 Nov 2026 04:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jv1K5saN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A4B1F008AB;
	Mon,  9 Nov 2026 04:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794198567;
	bh=+vNJkoFdRV0hile3s0HC3gFTuex7879BN3APjkn7jbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jv1K5saNkLZW16uHn+dTMyJM5qRf3XimTz3soJZCnus4lSjqOxAUkmwe+1J06v1cy
	 J3VsJ8EEmB61rvTPJ88cU3QTtmqR9ypNLMVafVMOFGsTg+8Fw1SUllRV+wqMSIMvGY
	 TUs9CjEJAGs6Kj6a9Q3r/+DmvBrU5L8xmYFnHkWaZ/sBCHHGd2FmP+bU0aO2EfRQKV
	 HvD47jvOvXYT8tHtL2+L+cNAdsygjZ0eFKVtW6Sv76yortyZm274iL9fZxaQC/1eo6
	 gYP1gsBUemzUQJaXexUYu0vnt6FTWEnyEAsDognGYFFvYSBO4jRVEsKo0j3ONVpPB/
	 tgE/vsooMLWbA==
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
Subject: [RESEND PATCH 07/14] iio: light: vl6180: poll own trigger from interrupt handler
Date: Mon,  9 Nov 2026 04:28:44 +0000
Message-ID: <20261109042851.1326940-8-jic23@kernel.org>
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

Poll data->trig from vl6180_threaded_irq() rather than indio_dev->trig.
The poll is only reached with the buffer enabled, which is only possible
with the driver's own trigger as iio_validate_own_trigger() rejects any
other.

This removes a dependency on the trig field of struct iio_dev, which
is to become private to the IIO core.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/vl6180.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
index aef8a5333442..44fd0446b583 100644
--- a/drivers/iio/light/vl6180.c
+++ b/drivers/iio/light/vl6180.c
@@ -525,7 +525,7 @@ static irqreturn_t vl6180_threaded_irq(int irq, void *priv)
 	struct vl6180_data *data = iio_priv(indio_dev);
 
 	if (iio_buffer_enabled(indio_dev))
-		iio_trigger_poll_nested(indio_dev->trig);
+		iio_trigger_poll_nested(data->trig);
 	else
 		complete(&data->completion);
 
-- 
2.56.0

