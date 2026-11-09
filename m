Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198566;
	b=Pbn6Od0+SMluEMqmgf9VCSysuh7RDxktH30HBNI+vcm3KaJu2hfp5mM+PtTDzqdHx3tI
	 i11ZHfsFbrrnxoF9dxUwhIUs9UjCmrXQdkuTGUXXTZNv0fUOXFlAWsn1sbfUUIotR7Gvu
	 uCxrDVLHwrJPnHUiTE9KkqFSokJ3TqlToP6vj8WWEYHbmWhLwao27lgJDUYdxgNbLFRzW
	 bWFSYLpg5cuZqUlnaxuGuq3R2wlhEPEqBzPtAv+4OnBPZAlP1jhna4NPbKs8BuxKuVrkg
	 Ha8o26C+DfD64gZesFxhq29mHFzBePjAXoST/hs3l0IG8PMwXTZ+3EdenvIFHXAkJdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198566;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=P7U6eYOXzQk6WjNmpy/+3nVmJAdQE4etbQZ1/KFKhmo=;
	b=h9NK+zC4B7EwqyyJW9nafSFNYmrbS3Xn9ZLlp+3J1985IR35V+rL1pVr7veZ5KjLEpxI
	 kRHiTVOqm3iNk8W7faGKzU/NoqgqSYDIKMGljuT1W/zc+H02y/aLhUzKxVRnGTZ62k9fL
	 JDjb3FxeYPgD8ACFREy4a/oZLgTjBgIUYCb6SR0fRg+p0xWc6DsPc6JsKnXtBDuh/1AuN
	 Y68UvtF7GRqv15W3pDmy8UudaagSgDnOzLZEcsEBHuH5NKhBJ0/6YEIQnEsX2Pb+xg4t0
	 ctLZvcYbkOyO+4nP6on3RsAl/9ls56UqbAQ0wh7hzWtCqE5ncQULMrgaiUVNXlB9lng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZH9HoMq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05CF606A333;
	Mon,  9 Nov 2026 04:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gZH9HoMq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D801F008A4;
	Mon,  9 Nov 2026 04:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794198565;
	bh=P7U6eYOXzQk6WjNmpy/+3nVmJAdQE4etbQZ1/KFKhmo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gZH9HoMqscK53VEh7Rc1ywdaMSsuTXE9iSadt3noKThY3jKPyxfEaw9KOTKFqLCD3
	 FcmtZTYVq+aizuk4fjxkfssUF3c40MGxsVCaFumjbxAYGAMeNqwNbyp2k1BG9u2wXo
	 gGZDAj80OTZcb7ZQqWpNtdcI49J5BoZgTseZeVpbJaJeaPHbckXudo2Sx8HC9URD/I
	 GnHTqGHKWnW25t4enMxuhV9McLK60Ckqb8bTiMZQPPxxToj6ubQmqhIFYVkFKSqtUq
	 5LjHllo99Gv5CWiNhUS3vh9G1Kp1ON+SATZoEPNukkMunnTpTTNtykxf8U4t0WXOGQ
	 f4BrW5AwHcF5Q==
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
Subject: [RESEND PATCH 06/14] iio: adc: at91-sama5d2: poll own trigger on data ready interrupt
Date: Mon,  9 Nov 2026 04:28:43 +0000
Message-ID: <20261109042851.1326940-7-jic23@kernel.org>
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

Poll st->trig from the data ready interrupt path rather than
indio->trig. The data ready interrupt is only enabled for the triggered
buffer when DMA is not in use and the device's own trigger is in use,
see at91_adc_buffer_check_use_irq().

The DMA completion callback still polls indio_dev->trig as it must run
the pollfunc on whichever trigger the device is using.

This removes one dependency on the trig field of struct iio_dev, which
is to become private to the IIO core.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/at91-sama5d2_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index dba4e7b2e77b..e4db74fa1360 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1711,7 +1711,7 @@ static irqreturn_t at91_adc_interrupt(int irq, void *private)
 		   (status & AT91_SAMA5D2_IER_DRDY)) {
 		/* triggered buffer without DMA */
 		disable_irq_nosync(irq);
-		iio_trigger_poll(indio->trig);
+		iio_trigger_poll(st->trig);
 	} else if (iio_buffer_enabled(indio) && st->dma_st.dma_chan) {
 		/* triggered buffer with DMA - should not happen */
 		disable_irq_nosync(irq);
-- 
2.56.0

