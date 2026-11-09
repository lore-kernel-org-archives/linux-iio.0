Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198587;
	b=xgVtJ+I3YA5jViUH3ttwh5GhUZOy/4thw23/Dvb63Ontr5g/0tYIvP3f0oGVkHxHdzgA
	 9L288fYWJILNxfHoii8B/ujTN2MUnsS0c/yErEhVJE4J37PffUA7eSP19af+RrDoVq7vg
	 etaNtW78KaI+oEaLnxV+JkcRFi8JfyNia+1otAk2zTwdO8IxPjj/7Gw0Un79y+rgpY5Av
	 MNdThFGnRMeDLefJgBW/zPrhkMr6gAunI7JmzkZoMOp6aeWBAyclK0E39nSFQ27vAHsjA
	 RoFebLDgcqjPi1BmMN+FN0XUaX/TilZgtbJfPXITSVzGhr/0SSoMBstCu04OCjfS8wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198587;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EfFmOf0f+fNfNklcyJtZOIJbh/mFnJlDVoVYHmduvz4=;
	b=CJtCCIZcurZEY9RjRLvkTmhJPlUGCRzEsouaHcdwUSlZPyh3jZ2wJkmR+P2VzTlgg3zN
	 1QKQoPHaJUvv4uc5GQyNfdrtDk98rfEQEEWere6nvEPLChcx5/tn8JErPXJJQiW9Q4HI6
	 2u2AbtJTyBbbXluJCw8jb06zGKJ89XB9IN8XUOBIbmhDwsSXyDsveMDXLapp3Wm9GhiK6
	 G9LSmtDhsXoEVnUwRaz6KIj8AV01QXwoZByF6/1bXx21gF/1/vxHoQ0NzrFmd3rk4SZ/F
	 a53lweCNQe7tvVNzC681lxmxusiHOHlsU+JDEdBGhsZ5uvINTOgU1pTYr5faoBCj9qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BmxF9gW9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29004606A33C;
	Mon,  9 Nov 2026 04:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BmxF9gW9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1523A1F008A1;
	Mon,  9 Nov 2026 04:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794198586;
	bh=EfFmOf0f+fNfNklcyJtZOIJbh/mFnJlDVoVYHmduvz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BmxF9gW9s8/BktGdZpiRcAZ6Jp/ob9zYf1tzd4EZKRE/BuE+aBsxU8xSRwfWt8Onm
	 3A57CNPd6knLhFtWvuUfxXPqsdYWVdrVmniS2RaucRHGXcqjJW6DSP5joZpujBWL3s
	 mQdpzBfUAbHAzK0mgbGMof3y9JPf+kz1vCMOAzF4gGzC/Q9s15s2RwKuGh5q3kDG7p
	 kAp+DFi5/XsT6G/8uDuOMXRck3Ye6GpAISX6vqpPtqHQeFyofUBmnYepJjoOnf4yW6
	 536Uv+Fd7mLQ6EGuWxgxKVBw4ZHZvtn7xINoYeKPyE2S9ZUUcHusIf2ToJdeStNsgA
	 PtaRpk0iZe3Cw==
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
Subject: [RESEND PATCH 13/14] iio: light: vcnl4000: poll own trigger from interrupt handler
Date: Mon,  9 Nov 2026 04:28:50 +0000
Message-ID: <20261109042851.1326940-14-jic23@kernel.org>
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

Keep a pointer to the driver's trigger in struct vcnl4000_data and poll
that from vcnl4010_irq_thread() on a data ready interrupt rather than
indio_dev->trig.

With the driver's own trigger in use this is the same trigger. The
driver does not restrict which trigger may be used and the data ready
interrupt is enabled whenever the buffer is enabled, so with another
trigger in use the data ready interrupt previously also polled that
trigger, running its consumers in addition to when it fired itself.
Now samples are only captured when the selected trigger fires, with the
trigger handler clearing the data ready status as before.

This removes a dependency on the trig field of struct iio_dev, which
is to become private to the IIO core.

Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/vcnl4000.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 911f8d1c74d4..cab6e0af8c7e 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -206,6 +206,7 @@ struct vcnl4000_data {
 	struct vcnl4200_channel vcnl4200_al;
 	struct vcnl4200_channel vcnl4200_ps;
 	uint32_t near_level;
+	struct iio_trigger *trig;
 };
 
 struct vcnl4000_chip_spec {
@@ -1547,7 +1548,7 @@ static irqreturn_t vcnl4010_irq_thread(int irq, void *p)
 	}
 
 	if (isr & VCNL4010_INT_DRDY && iio_buffer_enabled(indio_dev))
-		iio_trigger_poll_nested(indio_dev->trig);
+		iio_trigger_poll_nested(data->trig);
 
 end:
 	return IRQ_HANDLED;
@@ -1893,6 +1894,7 @@ static int vcnl4010_probe_trigger(struct iio_dev *indio_dev)
 	if (!trigger)
 		return -ENOMEM;
 
+	data->trig = trigger;
 	trigger->ops = &vcnl4010_trigger_ops;
 	iio_trigger_set_drvdata(trigger, indio_dev);
 
-- 
2.56.0

