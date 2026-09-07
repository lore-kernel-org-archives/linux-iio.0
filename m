Received: from mail-43171.protonmail.ch (mail-43171.protonmail.ch [185.70.43.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6620E4FB9D9
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 14:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792697; cv=none; b=k6IlWPsKXcjhD8w9DlINJzNe4eEsYljukjQjsIZ95mQyaYNAuvOs3esFKbUxkOKkcKLAvyZKIerQ35C32D+u6uaHA7I3kbQKIOSDR6GbX+fNe7Ik+nk2dKshI2Is6TUwKI34rr1fPBatXspXenMSuvM4hTuoyEfKQLeWgxgXb0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792697; c=relaxed/simple;
	bh=FxIdIXoSNaCCte0K/xoBAacBHBSvdO4pARP4HR40A4w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SnBo7m149ZxO6D4WpoCqMBFK7d63r66J7E9CPTlCnxS/YBbWn4PmWeZ6stgxLKkG3JPE+CL349VH9NsmQzH9xHlq+mrVxBs0Bo4ve5wbEFbfjek9Jk++nm16cXUVYh7vnBIwIV4A2V50/DzZfOPU5CgwSts8GZM25Vc9QuWwrgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=XcuiQdgJ; arc=none smtp.client-ip=185.70.43.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="XcuiQdgJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1788792679; x=1789051879;
	bh=AOqx3BY6tvy0nrGfle5izkbvmpZC9DpZCxHEczJltAk=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=XcuiQdgJaYEi2/uLEzbHnFAaTFF3NKJiJ75mcmAuYPeBgA0YPd7V7PARMW7Mp//Po
	 kSBpf+0SvWrZPE07jNfjacF9mw3oyOc4LjLzdHC9tEVvqYPUlbAXPXgd779Ng2yrFu
	 V17DfNijorUI9ZZ9RUtFIZB2qkoc172w5puKyVZ6ZyZzjJv01EccivqyGq8K+4P6Bh
	 PHjcPjyT/SkOvWW+pimt7cHxlfXD5b0/ibNS+v3EGj0Fo8lTTHX5SewINltewcZcXF
	 KO6UEgd4WCKrj3Pq9P12+OD28kb45AcjHxQ0HJzUjQ7UHAt9RjO7oOgrSD0jWW0hVu
	 FMqZfI66zfXwA==
X-Pm-Submission-Id: 4hdqlC08cmz2Schr
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 07 Sep 2026 16:50:59 +0200
Subject: [PATCH v8 4/9] iio: accel: mma8452: Only apply trigger type when
 not set by firmware
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-mma8452-open-drain-v8-4-c17407e22118@geanix.com>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
In-Reply-To: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788792664; l=1389;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=FxIdIXoSNaCCte0K/xoBAacBHBSvdO4pARP4HR40A4w=;
 b=JwJklVxPa0HnqAnXyT7O5FTlWn8Plnnhsq0/zaefKnIxUWWm2wVhBCeFE34Q0bwJC6gXdOPNB
 CZbOgyYgk8UCOhmdrakm2nbnzSUmRabJj3z5yrCdIHH8vBQ0BfFczHt
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
index 6c5a8d65c8a4..05851274596e 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1665,9 +1665,16 @@ static int mma8452_probe(struct i2c_client *client)
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

