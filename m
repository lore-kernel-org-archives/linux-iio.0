Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D225F41F5D4
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 08:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127381; cv=none; b=Y6tp9FJyzuvrifEafQzPslsJHfy7dFcR1092IpvnC2gyR5yO5gRjb47+MvetZiTfxJ0UXGbM8m2XPKXJtaxpwk9DpVAWbCG8I+bY0g88rBKMgts8Nc7vKPmXOosxLevGWr8tvTYvSVC2CVuPi0tybCrlh23q+Uw44q/CozJ8Lb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127381; c=relaxed/simple;
	bh=aD1+TxIcp78KfszYueEmzVsPlop8UEkQflASuNmtvRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NXQwSTyvcyB8eRIH8qohRUfm3jrbHtZ0cX9eca5ZrtuHzwMn3KC5hkP8dzosf3sb1tC0VTL9W8BuGbs8GaHDpVViSXy4T/EDJ2W5h27x5ZP/jpy0N+8YhLBqr4c5WxKd6is4N2lay3sqZlUcOaQRjbJjCF7Merwi4QSF0l5J8PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=sGJq7oCA; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="sGJq7oCA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787127351; x=1787386551;
	bh=xweKzoAR9wLr7rzqBzvxfCqFwEihx3bUT7MsiLoLTp4=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=sGJq7oCAWq9jhAFRjEl/ovTzWOK4OZp1fMmrOAE11O/SRSCJsPjlTfyELq6t+2qQO
	 ljPLAooT+6TEuaHFSU51Ts2VWzQ1r4KtPRU6LEg5HguLX6U+JR6JecJLhhBD6t6uuN
	 87xan5MVIhMnETnVh/n+8CmqWkeSCsVhinnP5Vm+VrytjQNqaht3gJzahTzrfaxtMe
	 SfHmUXVdMkYmTK4YR8ZyNIhSHosu9bMt6vkhQGvK0Bz1IMTDgUB8fJx0n9XuyUHHb2
	 17FxOCaNt8SMRzTWdeBIapqdBx/qUwqc2F8bvD710rHl5XMelXMadyn+TCk6WFGrYu
	 x7jiYuDYYEMlA==
X-Pm-Submission-Id: 4hPzsd2zKlz1DFFG
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 19 Aug 2026 10:15:30 +0200
Subject: [PATCH RESEND v5 3/6] iio: accel: mma8452: Only apply trigger type
 when not set by firmware
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-mma8452-open-drain-v5-3-d8aa590d7c36@geanix.com>
References: <20260819-mma8452-open-drain-v5-0-d8aa590d7c36@geanix.com>
In-Reply-To: <20260819-mma8452-open-drain-v5-0-d8aa590d7c36@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787127340; l=1389;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=aD1+TxIcp78KfszYueEmzVsPlop8UEkQflASuNmtvRA=;
 b=2XeXuJmtJmlrCNU2j1MdwNb0aN2tp0Ika+vEiUeDyvvwMraAEwLZgzCYMqTDmjiGUIEAZbntm
 5FS7GPltJwtCr06uh7YbJUIrFprsvx7DkcksCXczOQ6KBOz7xrdXc8F
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

