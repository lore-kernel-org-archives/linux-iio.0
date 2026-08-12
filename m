Received: from mail-106111.protonmail.ch (mail-106111.protonmail.ch [79.135.106.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C347145DF6E
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 14:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786545071; cv=none; b=jzFBlfBdSsD8J6YxX6ZDxW7YlvJoGqfsw96VO02zP4f92UoLOds5O5v3/4vgkWUEIMLtIeYPWfDz9gsgbOUOM/Cd/7p3MEydVmrxjXzfS0zf3strnl4DinPp4MHBmMuA09W879nbajO5z3eAfB4U3CTow0TEFjDTwZzM4EftpSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786545071; c=relaxed/simple;
	bh=zGSxhcoGy7rvndMA3KhI4poiLIO4W4hPtCuAZfoVNGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TL/ro3FAtIctLbn+SOWi3Li+c7xgSOQv48Qrapnrvt7/qbGjJOS9bigi3xAw8+ZjmlUq8Fk69MKsatInnZYqDl8BzBySBn7TAtGWd//G7Hh7XFFuAGEKFW//VNMwsKo0ChYT86UzEKIMMrGoHEMz7f+t2N35CzZRH8JatsRBZHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=n8RsRsJY; arc=none smtp.client-ip=79.135.106.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="n8RsRsJY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786545055; x=1786804255;
	bh=PVcPNHsYd8zoUj9Px+aFfUNm7RUu8fGQewTpTDJazmg=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=n8RsRsJYqm06TvHtv/H5qjTh4+11XUE75mcTTpnmcxcPn1Y35Y0MM5l4Ay3jMcW1a
	 Usu0niCUayKt5jyv7YgmVI3ER40RTFWGSo9y+Pxs6DXKV0hldZJn3gtioJIcAzV0h+
	 Ad24WBwd1Sp833MeHaRT4Q8EJkeHme1vQh+3NCnRrNSxUEvoVlJcwybAysArZUwviA
	 Q0hzsOTvuWGcrpaIKNKploNlM0P/PkfyVmiyuoNkw/Wcw0y47HOGB4zdGxRHG2Lke4
	 K6yKnWEY/Ok3rYAsMORpgWd8jFVJuBEDA37vQtLy5Vnv4v1+BUY0704ppYAgoWN7B6
	 1XViS3FHCuDfA==
X-Pm-Submission-Id: 4hKrWf1zffz2Sd3n
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 12 Aug 2026 16:30:35 +0200
Subject: [PATCH v4 4/6] iio: accel: mma8452: Support interrupt sharing
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-mma8452-open-drain-v4-4-bfca15d02b59@geanix.com>
References: <20260812-mma8452-open-drain-v4-0-bfca15d02b59@geanix.com>
In-Reply-To: <20260812-mma8452-open-drain-v4-0-bfca15d02b59@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786545039; l=1909;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=zGSxhcoGy7rvndMA3KhI4poiLIO4W4hPtCuAZfoVNGE=;
 b=RB+ZIEwhMq4Pv7X2BjjoM+GTn3xaXxhbIP/wYsFI5I3qHw3Lr54WYNBdrAh0YBPm2Aas/FYtX
 cCUnrgn0wY6BZ+tZT80kpWknYSKmr8eV2Smtj3OIjRyrk6OnfHNbLiO
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Adding handling of rutnime PM suspension in the interrupt handler allows
sharing interrupt with other devices.

Keep in mind that the device by default is using push-pull for the irq pin,
which might require additional hardware design to allow interrupt sharing.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 1fb43c5b0b72..106cdd904dbf 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1056,14 +1056,19 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
 	struct iio_dev *indio_dev = p;
 	struct mma8452_data *data = iio_priv(indio_dev);
 	irqreturn_t ret = IRQ_NONE;
+	int pm_status;
 	int src;
 
+	pm_status = pm_runtime_get_if_active(&data->client->dev);
+	if (pm_status == 0)
+		return IRQ_NONE; /* device is powered down */
+
 	src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
 	if (src < 0)
-		return IRQ_NONE;
+		goto out;
 
 	if (!(src & (data->chip_info->enabled_events | MMA8452_INT_DRDY)))
-		return IRQ_NONE;
+		goto out;
 
 	if (src & MMA8452_INT_DRDY) {
 		iio_trigger_poll_nested(indio_dev->trig);
@@ -1089,6 +1094,10 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
 		ret = IRQ_HANDLED;
 	}
 
+out:
+	if (pm_status > 0)
+		pm_runtime_put_autosuspend(&data->client->dev);
+
 	return ret;
 }
 
@@ -1690,7 +1699,7 @@ static int mma8452_probe(struct i2c_client *client)
 			dev_info(dev, "invalid irq type, setting default active low\n");
 			irq_flags = IRQF_TRIGGER_LOW;
 		}
-		irq_flags |= IRQF_ONESHOT;
+		irq_flags |= IRQF_ONESHOT | IRQF_SHARED;
 		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
 					   irq_flags, client->name, indio_dev);
 		if (ret)

-- 
2.55.0

