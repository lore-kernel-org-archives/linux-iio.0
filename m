Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198563;
	b=ZU1IUYbdGQckP0Tgs+V/hlt1Gu8g9UF51zT6vZqQBcK0g1/Ws20Fk5ezMyW7DsZ0mrlZ
	 JfEZGdWVebFRt7UCpzEjZYSkQR31tcIwS43eEG8dAy1RcSYL1vDdgvJsE8rQq0QYxZK+V
	 1vV0WFnJ8ullRsNwZHeOeUVxep+iBV1ikbK5blz/diY+THwhqXMaX1vtX1w988j6M1HjR
	 XfRLGmKF6OKr8NBo5n6gG7LWdj9v3cWcDTtUrYTcozRNDJfANIOs4qwWHVpHNbvjR9KpN
	 3JSzWO9x4mhFHgio7aIosvZrIYFiFUEFGpOFdwRmS5ofKXxljZslXcHJTLnwwoUP1xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198563;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nAzU2aEwFGvXBq3kemA/V5Nf6mODtkvSfg96CQhWfEw=;
	b=31fgYTheSwurFWSPkSSlv7vbm6rDA+5s4L90alKLOgA3CGhRzMZNJDE+nEmJHaHSuRzX
	 4NUE433CPvvdbL2Vf7BhRDeqdK2eLAglgI1LfrG3ITElepoUz1jdI7Dq5ZNtp5+Aq4OaC
	 7xvnmQmyuU3zfV9usCDQ09+uekaNCd+u7elvD9dbOkBNf2Zmoh20JmF/l+8mVyxZ1hX+Y
	 SEczlzPW/0IdOxIvjE0QJF2w3iQHDrStYKjkZjgBDpZg6/VkLbgigX3nVL634NxbrYcCE
	 PfgXm1k/LuDtuelkb4OJWsFzw8MORkHMRdXs+uGzOBLajDvZ/t5DiMOnSGCUfDnjUOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4wi0LUN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24ABD606A332;
	Mon,  9 Nov 2026 04:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m4wi0LUN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3891F008A6;
	Mon,  9 Nov 2026 04:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794198562;
	bh=nAzU2aEwFGvXBq3kemA/V5Nf6mODtkvSfg96CQhWfEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m4wi0LUN2k/pYap5MyaRQ1cxirhJL4fguB/SPVUdWDRnJOX39Ik9UvMQKufA5DvwB
	 qJSO1BC2ZCKFhgqXFRKQ/Y4aOXCjOSCNSjBlIQ9hoT2tvFfI1RdBs6UWpqhIJ3QZh+
	 iFfdN7UmJ6+jC0tLPxgIBr8xeUzEQj6hfy2Ug9TugjdXJKj0mgK7gf7vh+fPSx8Gzu
	 ys87tRmV2GZruXmLdMlnvAswP8BU3zjLj/XCsj+epjbmL5cEX/mRl5qGeDqLdJU29O
	 5VqjvAHMC/PNlaxhIzGH9cX7lu0c1hccGqex/G2A9TaQVWH2eQDx17UnEbUpbi8LLt
	 MRGGrUVgkIVcw==
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
Subject: [RESEND PATCH 05/14] iio: adc: mxs-lradc-adc: poll own trigger from interrupt handler
Date: Mon,  9 Nov 2026 04:28:42 +0000
Message-ID: <20261109042851.1326940-6-jic23@kernel.org>
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

Poll adc->trig from the interrupt handler rather than iio->trig.
Conversions that raise this interrupt are only started when the
driver's own trigger is enabled, via its set_trigger_state() callback.

This removes a dependency on the trig field of struct iio_dev, which
is to become private to the IIO core.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/mxs-lradc-adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/mxs-lradc-adc.c b/drivers/iio/adc/mxs-lradc-adc.c
index dda5182a5076..0174c7bb8d58 100644
--- a/drivers/iio/adc/mxs-lradc-adc.c
+++ b/drivers/iio/adc/mxs-lradc-adc.c
@@ -393,7 +393,7 @@ static irqreturn_t mxs_lradc_adc_handle_irq(int irq, void *data)
 	if (iio_buffer_enabled(iio)) {
 		if (reg & lradc->buffer_vchans) {
 			spin_lock_irqsave(&adc->lock, flags);
-			iio_trigger_poll(iio->trig);
+			iio_trigger_poll(adc->trig);
 			spin_unlock_irqrestore(&adc->lock, flags);
 		}
 	} else if (reg & LRADC_CTRL1_LRADC_IRQ(0)) {
-- 
2.56.0

