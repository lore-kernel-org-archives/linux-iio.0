Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB25D3F6C28
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 12:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788178665; cv=none; b=FOy2kfsG1MdbsXoonQo3hsBZ0OwSyul61PWy6S70GHJ0regQSnOoRgNfmx/6WCnoTBQT7jOaaiCa/153hKJyju6vB28HeE54f8FyOGX4kAOfsF6bkow/LztXuwzq2Q6K7i+A/1mCuDghiInzwEqAI4LYu6aHBDRtRVaDzt3LEZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788178665; c=relaxed/simple;
	bh=aD1+TxIcp78KfszYueEmzVsPlop8UEkQflASuNmtvRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ie8Q+/WopGSxlJOlIjU0xJ0K5VgVzuINuX4l0HFNuhyUjF5bpOJNZx7TNz1t7E5S0X3ZRioumlkNIrdFdf3AtP6eH6WQuquhwEwGtqF2ga62UBaUMDjXk8UNLlUCynYYxyTJWbI5unxR9lB1RKcV2ByjhMcyqRpiRTK/ZXSwcnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=49zG4L22; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="49zG4L22"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788178639; x=1788437839;
	bh=xweKzoAR9wLr7rzqBzvxfCqFwEihx3bUT7MsiLoLTp4=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=49zG4L22IfC7dVhThq5AnP2NrzHFhwH+kEJAR4box1zVmzn/XpHTVPElj4MHqz3Je
	 DAA5G2sjn0Nb+URTZZbbVtNQ39UJgGndN8jxm/qH4A7K0X/dQMco2L3GFHWGwFJj5t
	 L3Fz6WMs/yKuSqqgQqDKCJLcB6Kws4MJfXERs4MylvcAWmGZ52ojL+By7b6dyUwY7P
	 nfN5bqomnCb415d1xOSkuOFDLfA2z8k/wU8LXbYN71ByEazxFHgSYT0HU4ZHkuizq0
	 Axl6s19MI/MjzUVrdoMmlc43xXZ5rga8TVWDfBTP2GSWXP1VRH51CkArgDt0quSqGz
	 ynlO9y88Lwaog==
X-Pm-Submission-Id: 4hYSfh5qxyz1DFFp
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 31 Aug 2026 14:17:06 +0200
Subject: [PATCH v7 3/8] iio: accel: mma8452: Only apply trigger type when
 not set by firmware
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-mma8452-open-drain-v7-3-22946812c928@geanix.com>
References: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
In-Reply-To: <20260831-mma8452-open-drain-v7-0-22946812c928@geanix.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, 
 Sean Nyekjaer <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, 
 Christoph Muellner <christoph.muellner@theobroma-systems.com>
Cc: Esben Haabendal <esben@geanix.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788178627; l=1389;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=aD1+TxIcp78KfszYueEmzVsPlop8UEkQflASuNmtvRA=;
 b=VGVpIIYEqZWiXv48NpOK1UQHXFarekRjQt99Mgr3MaK1Xftp5mrrpzN72xYPHX3FJ0FndBImq
 OBaafudRkjrC7Bn1QUJsfxU8ST4HHDObDKweLr2cpslq5ymEfS4Qr2b
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Instead of unconditionally overriding the trigger type, it is better to
only apply a default when no trigger type is set by firmware. This should
be reasonably backward compatible, and should only potentially cause
problems if systems exist where firmware specifies an incorrect trigger
type. With a bit of luck, there are no such systems.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index f645a5c6fd1c..1fb43c5b0b72 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1683,9 +1683,16 @@ static int mma8452_probe(struct i2c_client *client)
 		goto trigger_cleanup;
 
 	if (client->irq) {
+		unsigned long irq_flags;
+
+		irq_flags = irq_get_trigger_type(client->irq);
+		if (irq_flags == IRQ_TYPE_NONE) {
+			dev_info(dev, "invalid irq type, setting default active low\n");
+			irq_flags = IRQF_TRIGGER_LOW;
+		}
+		irq_flags |= IRQF_ONESHOT;
 		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
-					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-					   client->name, indio_dev);
+					   irq_flags, client->name, indio_dev);
 		if (ret)
 			goto buffer_cleanup;
 	}

-- 
2.55.0

