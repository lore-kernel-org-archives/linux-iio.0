Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603DD476045
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 08:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790584010; cv=none; b=oc5idU00NaJ/M6aPSJrSYbi7+V2udaqEAhV2XbsVbVo2i5/WYzUW8eRuUwcXXxa+vLg3Qt9wOXiHjrpDbtFIP1tCGbyBaVt+WJZb1YsNNE3/5HXC1rI4vQWKvR3B5h+bBD5R9fJCvA5/uEjt/9vKm3F6xfbIC/4PS0PWm/Ad3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790584010; c=relaxed/simple;
	bh=uPZchZjn6UkglmRiByWIsLTuCMTQTNFVKTPStIfIxjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=px3oJ7UnZzCxh0Mrmmw1ax72bf0CeHpnRWLXVi+dQK4mEOxu7SyzjhOeI7Z3258KOcMVS2XKW0cmfdd+0zVHO2f//q+7x1tE7mIodQ5m7IWhUQAQkwGWzeDGQczoHb6p9aBYfGbtL5Ss1H9Tj7n0zqrSdPrsGVcNwCq2TrllfZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=BOndjyZ5; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="BOndjyZ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1790583997; x=1790843197;
	bh=CkyR3JWxdNK53MZOpOdoX4HeDh3SJwW8Fzkq3YTz0p0=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=BOndjyZ562mSeKe/YeUjruRO1KLhULB/knx87kCYnJ8Pmzmcy4RVwqz88ykR5aUhr
	 ATXYbPJbQ7YURwlCvGGyqOh9j4Q41/SADn5k3Br2cppnuITROWY8PMV+j42MXXSDgt
	 3HcJjuIIdee83dFTUOnd1CaVYia1p1VxGKxxi1blHKd82V+h+R2mXk9pO4zii5vUkF
	 2Iw3Alckv07TdUd7J9R0Fx6uVeQOJb6XVhaK1Fay9lPOu89FF/m8wwFn91PFMT+0nx
	 BIEaInCkCNPGihGDnYz6c3m2nrFNK7K9p/L0tqbrMxNrazHp+34iAmKOoA8OEJwMsq
	 zMHd+rXD6lSBA==
X-Pm-Submission-Id: 4htZCY1VWPz2ScDC
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 28 Sep 2026 10:26:21 +0200
Subject: [PATCH v10 05/10] iio: accel: mma8452: Only apply trigger type
 when not set by firmware
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-mma8452-open-drain-v10-5-b906fb408386@geanix.com>
References: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
In-Reply-To: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790583982; l=1389;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=uPZchZjn6UkglmRiByWIsLTuCMTQTNFVKTPStIfIxjQ=;
 b=AxpHNoe2UZf+1XzA5GOSvktWHnuOvxZRVU0yZYmOQTSA/WVbtTqiiSG9N1ww2sIQoQGIpYTSe
 nLGN/CwwvkxBDY43jWeEQMaHgUeJUxKiBMksWnvyWzTTtlrpYk3zOBU
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
index 8d70fe89110c..72b4ab32775a 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1669,9 +1669,16 @@ static int mma8452_probe(struct i2c_client *client)
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

