Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198556;
	b=C1AiWzonEfw25wxIf0cF+uJNDOvc71hIw6//3a9eEvyp88LQZFs8+lovjXLL+xocFXK3
	 lL88OhukcbYYlKWLyhF6px8T915HDJbuHRWYbcIoyI1T39Q7JVlKc33raBDbg9/8RDhSb
	 FHGsHyPuRbZ73qBqRcucY96PkyZKt+r/2AjzqwAFwoehJFXyJ3n/mHkPCqjw3qJtbe9Pc
	 paORVLcrYRaZxv2zpdcM25VTLqZmt8PaW1uFoca6SUZdOVN0Mu9Pe4hv+0PnAoStDdkhy
	 cG4Tq+ohQUQ/6q/Pmo8wWRuh2CiMAH/CmOf6FuO/vaKfRjeDBWH4+X79ac4vNoQ57vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198556;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=I7LWda9VcDO/rMIUhcFJBfu3q+cLbfZB0A4Yi23fMc4=;
	b=VsYNIjUYa1uv+4kyISJBmV3NS5lo4ISWMMvVkY6yDbYD1f984RHH96g/scEQgwKhXdLM
	 HQXXPsUVlyYT4CsKUu1IIxxEzu6UexCmxRM9baAWNrr11FCvPzSj5l8RrNbrRras9nTFn
	 eVFm6naa2a1/LF7FRV+FuBkPKd8FjqlHSYxVXh7gR4pYKoA8Kr2bWgKS5YfEEomJnZ1z3
	 QLyIfXqG4XemkA//o+BtwJjtb24KnDQMjIbr+GADeb6h52yt5oXgor/S5Ptp99T2NDCNV
	 hPHsBRG/aGh3Om0Vl9mQTFwusTRIyf+161sV6pwM7xXbYL62t1gmtlw3AhrK0p5lV5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtdWscg8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1799B606D801;
	Mon,  9 Nov 2026 04:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GtdWscg8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FA9F1F008A7;
	Mon,  9 Nov 2026 04:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794198555;
	bh=I7LWda9VcDO/rMIUhcFJBfu3q+cLbfZB0A4Yi23fMc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GtdWscg8eg1YDIHa6Rim+cbadHt5rYIJ9dAYofGbKwz7PyP+K0fvHDqokWO4C81Az
	 QOmky9qQy2TD7YUxv8C/Zb2sgeRHx0v687dTbnWdxs/R3Q5GZymEM9LchGqj8X1Vy/
	 HrnZmgVJ1aKdgYcux3xGN4RqW+1tVTCr89QRiw+rVkgwpEhgjQ8TnU8BZZX5vYAtcE
	 +Zr/pd+A49fZavVboVKF3c+gWaU2WtmFpAqykUubLELYDJ5gneCDWUQQ9M3FPW/U3y
	 +A30gXXfRxx9YSz/mvXT9gG7OfLPrhCVQfE3IQwpJ/HS9fZuNIU21iY2Evq5e12dJ8
	 dz2l9Z9RwTxdw==
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
Subject: [RESEND PATCH 03/14] iio: adc: max1027: poll own trigger from interrupt handler
Date: Mon,  9 Nov 2026 04:28:40 +0000
Message-ID: <20261109042851.1326940-4-jic23@kernel.org>
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

Poll st->trig from max1027_handler() rather than indio_dev->trig. The
poll is only reached when the buffer is enabled and the device's own
trigger is in use.

This removes a dependency on the trig field of struct iio_dev, which
is to become private to the IIO core.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/max1027.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
index 8d282feea8b5..65a0e85faca9 100644
--- a/drivers/iio/adc/max1027.c
+++ b/drivers/iio/adc/max1027.c
@@ -481,7 +481,7 @@ static irqreturn_t max1027_handler(int irq, void *private)
 	if (!iio_buffer_enabled(indio_dev) || !iio_trigger_using_own(indio_dev))
 		complete(&st->complete);
 	else
-		iio_trigger_poll(indio_dev->trig);
+		iio_trigger_poll(st->trig);
 
 	return IRQ_HANDLED;
 }
-- 
2.56.0

