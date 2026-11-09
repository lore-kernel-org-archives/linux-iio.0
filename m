Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198590;
	b=zUeIhzx1E0adE+jBiWoHSRtfTTr0izXc+29uqBfemXx9ivS72bl5c4+rlYBwueZZEsvJ
	 0Z7A5AWjCPwPyYo/G+C8q9ohhlzrFxFHI80/t3bl3yNYyakbGo/oP1dmSFT2UCTQ085y8
	 h3UYka2nbHUhXgte67kGpT6rbFvjcJ1Nub9cg/kPRafyRQdAU3wS2LAiFeBHqIfppo8zu
	 SOAz7CfVPeaKqIoQqoswbowU5Y0m1oY+Ghxe1uJUNm0ltcrzCvFcCi3IX3D1KYJRVDsJL
	 m6UnFcKxCA/e220zQnOuru7/mR5B93x3J0h5Lx+q7EmFcCdNFLOZuKuicCcaiWo3QCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198590;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VJyuxI9FB+vQTbzBQeNpV3K1r7mKGAWrwyncU59TBXg=;
	b=koMvVJU9Eyok986gTaqUeWPJ9GEqkeNQRsJmbRCw2N3VAartRlKecBgyEO3dQQ2AgqzC
	 B45lQjcyAopsKxZ6dBrQt7iLqNcnraW/M5BW58El9xnkYbfRMGCFc9mSJ74NKkCUFi6py
	 zKVkZgpsRV/qZG6HzfFFIHutKdpqfRsq9evmN+YzlqeF00fLzM2SJZXtK4AaXH0TqsFdc
	 dwOQeMIvaScBcax8I3WjEPqGKrlOWYQc38mqVhLUIt6aPoy/24JVpYMZoIhcK0UJR1Gjh
	 xAIuTkCe2gEBnvavMlgwTVhTPuWW9tbwMPqNR6chmqajOKCEza5anR+NpymwYKrPAqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+XUXOMK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A68606A321;
	Mon,  9 Nov 2026 04:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B+XUXOMK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829A31F0089F;
	Mon,  9 Nov 2026 04:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794198590;
	bh=VJyuxI9FB+vQTbzBQeNpV3K1r7mKGAWrwyncU59TBXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B+XUXOMKbPdhD1BGXkC/E2/xwYEy2NAetDtDS/+xsM86lYqLNZeXzIE6fKBqVVDEh
	 36eLwjDSPtvnkru2ZUQwlAItk0oNWmn7LhQcpb7fgNZhDPA9imCmeRF+aoEtBrr1vc
	 w7S7vrWhdcC6CahlvwhJZUp6t/FKws8KvfVoeRgl55JInraUbK7hATJJsnr5LwoRrL
	 ILzDjXBhYC/oqAdKyEGB36ciCzsPF/vYxeKml1XuinbOVijmUcW8ul60uGR19+bl0V
	 xRujoRckKBdPCUQmc/DyngtTp82e0i5b344je7L4I3V3e9FzBKtYK4I8J5TUjjDOqg
	 +Iyr3jzlf8J2Q==
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
Subject: [RESEND PATCH 14/14] iio: adc: at91_adc: poll the enabled trigger from interrupt handler
Date: Mon,  9 Nov 2026 04:28:51 +0000
Message-ID: <20261109042851.1326940-15-jic23@kernel.org>
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

The driver registers several hardware triggers, any of which may be
selected. The end of conversion interrupt is only enabled for buffered
capture by the set_trigger_state() callback of the trigger being
enabled, and handle_adc_eoc_trigger() then polls indio_dev->trig.

Record the trigger in at91_adc_configure_trigger() before enabling the
interrupt and poll that instead. It is not cleared on disable so that
an interrupt still in flight polls the same trigger as before rather
than dereferencing NULL.

Also use the trigger passed to at91_adc_configure_trigger() to look up
its configuration rather than indio_dev->trig, which is the same
trigger.

This removes the driver's dependencies on the trig field of struct
iio_dev, which is to become private to the IIO core.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/at91_adc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 0ac74ad92fca..49e7fb2d39f2 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -229,6 +229,7 @@ struct at91_adc_state {
 	u8			sample_hold_time;
 	bool			sleep_mode;
 	struct iio_trigger	**trig;
+	struct iio_trigger	*cur_trig;	/* last enabled of trig[] */
 	bool			use_external;
 	u32			vref_mv;
 	u32			res;		/* resolution used for conversions */
@@ -294,7 +295,7 @@ static void handle_adc_eoc_trigger(int irq, struct iio_dev *idev)
 
 	if (iio_buffer_enabled(idev)) {
 		disable_irq_nosync(irq);
-		iio_trigger_poll(idev->trig);
+		iio_trigger_poll(st->cur_trig);
 	} else {
 		st->last_value = at91_adc_readl(st, AT91_ADC_CHAN(st, st->chnb));
 		/* Needed to ACK the DRDY interruption */
@@ -562,7 +563,7 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 
 	value = at91_adc_get_trigger_value_by_name(idev,
 						   st->caps->triggers,
-						   idev->trig->name);
+						   trig->name);
 	if (value < 0)
 		return value;
 
@@ -581,6 +582,7 @@ static int at91_adc_configure_trigger(struct iio_trigger *trig, bool state)
 					AT91_ADC_CH(chan->channel));
 		}
 
+		st->cur_trig = trig;
 		at91_adc_writel(st, AT91_ADC_IER, reg->drdy_mask);
 
 	} else {
-- 
2.56.0

