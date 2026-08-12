Received: from mail-43172.protonmail.ch (mail-43172.protonmail.ch [185.70.43.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59B5374A0B
	for <linux-iio@vger.kernel.org>; Wed, 12 Aug 2026 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786545069; cv=none; b=m0JIxoO6eQphefwUZlVL72A7/HlDgr5+Lo8CvVW3cwuqC9SY7rQM0BIcOy2gRI2tNYz51AwTxzWmD2J5SIoV47nKq2F2S6VGY9XnDz70hIb26IzXHQ3LP4RXpsfU4KCI1m6evgSqzxIZTc8ZgTlw52WFKMTmAvAL3Z20zJld86Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786545069; c=relaxed/simple;
	bh=aD1+TxIcp78KfszYueEmzVsPlop8UEkQflASuNmtvRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FYPySxPsUM/F51dbUvSPhAyq9ChkWloHtOFJCKXxAYnX9/3Kozz9MRt0u235hdgsSNDAcFCyOcyr7ISIP+uu5tk86E+DRjgnfyoKxBurpiiZoI6UeauwmQPqGPrS4gYEn8Qkp9zRBGy/O9tn9i4OVxRls1jzGyG2G5r4yVxDDes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=yRW6IOqj; arc=none smtp.client-ip=185.70.43.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="yRW6IOqj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1786545053; x=1786804253;
	bh=xweKzoAR9wLr7rzqBzvxfCqFwEihx3bUT7MsiLoLTp4=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=yRW6IOqjTNs4UWftQA9Z60Tlsna1h5jrExISnrqHoYuE6kJ2y0BFwMoD+UYsGXyrm
	 nsJ/9Whyfi7cKJGM9gvQkCh7V7iNMu7FDGvQ0TpBmm3y45v2EyuJsxXwenVXVAX/9c
	 W1Xkn5187HzwmI0A1tTI20p83bqMFNtHkJiIxL/LyL0KSbS5UXKmSvRVy2CDYJn9Vn
	 hBGUJhe1xlJp12cKYr6s8bkwSqkZKSMOWncjldHkZf8MF4yZdmW3IiDgVtM+VyNG22
	 UK+JPUtQ+ZdwDW4JO6v1mK92iu6/P28uDfPzcb2GtBK4Vqza3E7YKjY8z527IcAqaQ
	 qH0khcCxSEKBQ==
X-Pm-Submission-Id: 4hKrWZ743Mz2Sd3Q
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 12 Aug 2026 16:30:34 +0200
Subject: [PATCH v4 3/6] iio: accel: mma8452: Only apply trigger type when
 not set by firmware
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-mma8452-open-drain-v4-3-bfca15d02b59@geanix.com>
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
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786545039; l=1389;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=aD1+TxIcp78KfszYueEmzVsPlop8UEkQflASuNmtvRA=;
 b=plvrepN09F9TqWMA1j7OeVwpGJ9fiMRX1/jeNkfWhmsBEFfF2SHhL9rTQo+jovZwgxVGcSNVe
 5Hah3U6RWmyBfM8w3SDGErX8oSNza+pwfingcD1VkFyMI1cKNWFVVaR
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

