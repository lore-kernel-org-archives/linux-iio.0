Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795440344;
	b=4hjESBOot8J3gNE380fTFpdTkPrarBxdKpneFpEZljdcyRlGE6P/FfD5RlUUnxLKtU6l
	 1ump1fX/JECoTr7nb6XkWD+zuH7RNZHaKGiB5KeV0/YCd1qBSMnX9eEmNhp2e/rU2uOZO
	 2rGn8dKnVbn+Bw6As9gc+SObzN/AKpO8MOi22r/mCnZ3aIHwun2jJvoLO/IiG/S+2mAmM
	 BqqUKdTE9d3coOCAb72VWUE4BjL8yS0uvfc9BpphFF6vw+ScSXs9bzrUKs/6sroJsOLXn
	 ndecNWQikD60af5wNffJ6nEbg26dQfkD4uz97k/CSZKDjkK4xfy/ISRWOI1mJmGe3ZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795440344;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ghLbjIWrwX99A63ayhLT6wXwasSJ5NHBxrxpfq9NcCM=;
	b=GulGz3iP4RVQqCMMpBK1FlHSdATbdjM6f0ldwmV4ujiadQIUit9Hu77FOYxOjhpqCRFT
	 zcckK9plSyl60VfZYQ49nlp5lX1zMDM+0UtHl5BFwoNpSG7/MdNNQzJgXXukqJWVBpFtg
	 vRSE3jJBiJDDqYDgbU6Xs51Y/ZAhClY5WUZKi0vwXIpngke8wMmt09Q9iQPa0ZW6s2xmN
	 BwNSrzNC62WHnRLvv7HNKSP4T+q1Ug6SgGooq5QPh+w2z5GITyvokQvr+6TiLyg24dobi
	 rYDcewZKo6bbXQ6k9OGFPfwe4805oo+Pxl23FGn85jI41qyM/Pb8se8etQW3vBmTT7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMWObjSj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9290C60A2601;
	Mon, 23 Nov 2026 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fMWObjSj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795440344;
	b=nW6uRY8C1D3N22ngiuBpoM4pecAPcJtFwh3FrU+BxZQFgXNnokN6J5jVIZuW5iHBXSaP
	 yWvuLbMIyawRJ6i121591xl7o1qf9jzmFXRmZSW2JZzBkPtUsJA6hJgi6cpSSgzw5xMhb
	 Ep/5El954aykvEpM+K9d3W5x8Rx1B+oM7VIzm006gO7EAF+DuxLncRlkR0hj3bTF8Ui8r
	 pM6CC5v8HiP9UvLMoWhoX8W0ZuVhNIWEIJnNpYrd95raquCbV3wGKpHnm8FErp1W950S3
	 iOXY9nOa57mbopHZq4nXUK+vlV59m5+cdBB2wFXgxdVGSIJ6oUiatK/wLQZnlWB+ddg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795440344;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ghLbjIWrwX99A63ayhLT6wXwasSJ5NHBxrxpfq9NcCM=;
	b=NtCgoMCSvRO8Jgguxkt9YeTUy5R1luNuAD2wvjwtY2dd/OC7dOgHPxN+yRflfn2rcSgU
	 RfRqDw4LFzrNI/WiQqk6XVgffiUdLfi2/YAyopOUGqgg9hsrLSPeA29NT8DvyFLJeYj8B
	 m98ilhqoxHu59YlX53ilQRiPCcwUAz/eyXkXsdu8FShjUVY31J/pEjMqSQN/i7WjZT7BS
	 zdZLikCA+8SsWrx2sowR69c9L84iIozSKr4ieFX0O9aDgNgNNdgJVV9DUyeudenms7wWk
	 WBWEhZOLcul7oHvttiRo+T9BcabBSouGl2tB/14ok06SY93DCQJsDERRJ9xSHOMbYjg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 41BD21F000ED;
	Mon, 23 Nov 2026 13:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795440344;
	bh=ghLbjIWrwX99A63ayhLT6wXwasSJ5NHBxrxpfq9NcCM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=fMWObjSjofaOM4Vgb9KuDjPxBK7L2ID3l7Y5NK4tL5kLbBBe55QepI8XvEJq+29pc
	 mHhnJCqBE1Ss9d4MVHsSV2z+7kbWsgyKI1I/nHks/0dmILOw4dLoEHQBbdMJx6vRQI
	 CrKYoJF0qimmH12NDBTRp0IwBGs8ujymRXOJaE4sWBz/d8PXct9EBxO76yM7jocHRO
	 t9+dwoA3Zk5ltg63709eZZq/crJEGJFXrepOm5eR0UVJU3v5zYwvKr99ooV9EbT8kk
	 Z/aQ/0/edeUSNBvqSmasdtaihW/BDqaVakrqWv3c4+CxdCOl4xYjI0D6oQGJssS3C7
	 cO1kct8TdlqmA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BF0764C49D;
	Mon, 23 Nov 2026 13:25:28 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Mon, 23 Nov 2026 15:25:28 +0200
Subject: [PATCH 4/7] iio: imu: adis16475: Use a kfifo buffer for the
 devices with a FIFO
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-adis-fifo-v1-4-f6ad9e493e19@analog.com>
References: <20261123-adis-fifo-v1-0-f6ad9e493e19@analog.com>
In-Reply-To: <20261123-adis-fifo-v1-0-f6ad9e493e19@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
 Radu Sabau <radu.sabau@analog.com>
Cc: linux-iio@vger.kernel.org, linux@analog.com, 
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795440327; l=5523;
 i=radu.sabau@analog.com; s=20261001; h=from:subject:message-id;
 bh=DKqWxjSownX7PQ6rmCCXSFYEawwf4xKEOAeGkoBi/ig=;
 b=+k0pd6ke7ueV2GuH5FZRikSHH2Wi9y+NlqJuVUoakK6bNCyv+S47IJTvfc+Z7JoAfdgN5UTOh
 vrOuMZc8DG9ClH3HZgS0+NpEGF2FPQ0Q0nZ8rE0a5pCLHvwf57HhgQC
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=XOZSO/Ut8qfYw7khL8lUF65Pgl+VLihISyS+Iy9jY8c=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20261001 with
 auth_id=1094
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
Content-Transfer-Encoding: 7bit

From: Radu Sabau <radu.sabau@analog.com>

The ADIS1657x variants read their FIFO from a trigger handler, which runs
from iio_trigger_poll() called in the FIFO interrupt thread, and the
capture depends on the selected trigger.

Switch them to devm_adis_setup_kfifo_buffer(): the FIFO interrupt thread
now reads the FIFO and pushes the samples to a kfifo buffer. The interrupt
is requested disabled and is enabled once the device FIFO is running, and
disabled before it is stopped, from the buffer setup functions. This
replaces the trigger's set_trigger_state(), which did the same through
adis_enable_irq().

The trigger is still registered and trigger/current_trigger is unchanged
for users: the buffer simply does not use it any more, so writing it has
no effect and a buffer can now also be enabled without selecting one.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/imu/adis16475.c | 55 ++++++++++++++++++++++++++++++---------------
 1 file changed, 37 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
index 6922ffb48516..394b13431ae8 100644
--- a/drivers/iio/imu/adis16475.c
+++ b/drivers/iio/imu/adis16475.c
@@ -517,9 +517,26 @@ static int adis16475_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct adis16475 *st = iio_priv(indio_dev);
 	struct adis *adis = &st->adis;
+	int ret;
+
+	ret = adis_update_bits(adis, ADIS16475_REG_FIFO_CTRL,
+			       ADIS16575_FIFO_EN_MASK, (u16)ADIS16575_FIFO_EN(1));
+	if (ret)
+		return ret;
+
+	enable_irq(adis->spi->irq);
 
-	return adis_update_bits(adis, ADIS16475_REG_FIFO_CTRL,
-				ADIS16575_FIFO_EN_MASK, (u16)ADIS16575_FIFO_EN(1));
+	return 0;
+}
+
+static int adis16475_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct adis16475 *st = iio_priv(indio_dev);
+
+	/* Not under the adis lock: this waits for the IRQ thread, which takes it */
+	disable_irq(st->adis.spi->irq);
+
+	return 0;
 }
 
 static int adis16475_buffer_postdisable(struct iio_dev *indio_dev)
@@ -541,6 +558,7 @@ static int adis16475_buffer_postdisable(struct iio_dev *indio_dev)
 
 static const struct iio_buffer_setup_ops adis16475_buffer_ops = {
 	.postenable = adis16475_buffer_postenable,
+	.predisable = adis16475_buffer_predisable,
 	.postdisable = adis16475_buffer_postdisable,
 };
 
@@ -1708,7 +1726,7 @@ static int adis16575_custom_burst_read(struct iio_dev *indio_dev, u8 burst_req,
 }
 
 /*
- * This handler is meant to be used for devices which support burst readings
+ * This IRQ thread is meant to be used for devices which support burst readings
  * from FIFO (namely devices from adis1657x family).
  * In order to pop the FIFO the 0x68 0x00 FIFO pop burst request has to be sent.
  * If the previous device command was not a FIFO pop burst request, the FIFO pop
@@ -1721,12 +1739,12 @@ static int adis16575_custom_burst_read(struct iio_dev *indio_dev, u8 burst_req,
  * different from a 0x68 0x00 or a 0x00 0x00 burst request, the FIFO data popped
  * previously will be lost.
  */
-static irqreturn_t adis16475_trigger_handler_with_fifo(int irq, void *p)
+static irqreturn_t adis16475_fifo_irq_thread(int irq, void *p)
 {
-	struct iio_poll_func *pf = p;
-	struct iio_dev *indio_dev = pf->indio_dev;
+	struct iio_dev *indio_dev = p;
 	struct adis16475 *st = iio_priv(indio_dev);
 	struct adis *adis = &st->adis;
+	s64 timestamp = iio_get_time_ns(indio_dev);
 	int ret;
 	u16 fifo_cnt, i;
 
@@ -1736,10 +1754,7 @@ static irqreturn_t adis16475_trigger_handler_with_fifo(int irq, void *p)
 	if (ret)
 		goto unlock;
 
-	/*
-	 * If no sample is available, nothing can be read. This can happen if
-	 * a the used trigger has a higher frequency than the selected sample rate.
-	 */
+	/* If no sample is available, nothing can be read. */
 	if (!fifo_cnt)
 		goto unlock;
 
@@ -1748,18 +1763,18 @@ static irqreturn_t adis16475_trigger_handler_with_fifo(int irq, void *p)
 	 * next burst request.
 	 */
 	ret = adis16575_custom_burst_read(indio_dev, adis->data->burst_reg_cmd,
-					  pf->timestamp);
+					  timestamp);
 	if (ret)
 		goto unlock;
 
 	for (i = 0; i < fifo_cnt - 1; i++) {
-		ret = adis16475_push_single_sample(indio_dev, pf->timestamp);
+		ret = adis16475_push_single_sample(indio_dev, timestamp);
 		if (ret)
 			goto unlock;
 	}
 
 	/* FIFO read without popping */
-	ret = adis16575_custom_burst_read(indio_dev, 0, pf->timestamp);
+	ret = adis16575_custom_burst_read(indio_dev, 0, timestamp);
 
 unlock:
 	/*
@@ -1767,7 +1782,6 @@ static irqreturn_t adis16475_trigger_handler_with_fifo(int irq, void *p)
 	 * reading data from registers will impact the FIFO reading.
 	 */
 	adis16475_burst32_check(st);
-	iio_trigger_notify_done(indio_dev->trig);
 
 	return IRQ_HANDLED;
 }
@@ -1978,10 +1992,15 @@ static int adis16475_probe(struct spi_device *spi)
 		return ret;
 
 	if (st->adis.data->has_fifo) {
-		ret = devm_adis_setup_buffer_and_trigger_with_attrs(&st->adis, indio_dev,
-								    adis16475_trigger_handler_with_fifo,
-								    &adis16475_buffer_ops,
-								    adis16475_fifo_attributes);
+		ret = devm_adis_setup_kfifo_buffer(&st->adis, indio_dev,
+						   adis16475_fifo_irq_thread,
+						   &adis16475_buffer_ops,
+						   adis16475_fifo_attributes);
+		if (ret)
+			return ret;
+
+		/* Keep the trigger/current_trigger interface of these devices */
+		ret = devm_adis_register_fifo_trigger(&st->adis, indio_dev);
 		if (ret)
 			return ret;
 

-- 
2.43.0


