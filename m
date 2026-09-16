Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch [109.224.244.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49A636655C;
	Wed, 16 Sep 2026 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546204; cv=none; b=Df+/OYgNY2lcfMayoLsVeEYkNYmFyJttUrKADI8HLTB6GhhlwyYOy6nJHTfByNWc17B/QDk19dIBJIwhQe8nx2byvqbkrKy0FQ82iBbDUSaYCR/vmUlCJ3BYSfE8rvQllRfdHaEyr1Lxe+0u7OogdDS82v+CvO0zB62uqk7i2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546204; c=relaxed/simple;
	bh=uPZchZjn6UkglmRiByWIsLTuCMTQTNFVKTPStIfIxjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhqdS9wvEh4SCebxC1FCv1KH2+h3HbaATB/5MFkhJCpeIlHh5M44KFQac2n6PJkxkwN8rf7r5Y5E4qV69j3wUZyKcMYtxTkZGwCBFA+AkWyFnqlyTBPTcPa0zwm4fHC3k5itfZ3t8X46rT4O7qg/k3gLuTIlRPb5DdHFz/WKojc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ELoWZVkI; arc=none smtp.client-ip=109.224.244.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ELoWZVkI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1789546171; x=1789805371;
	bh=CkyR3JWxdNK53MZOpOdoX4HeDh3SJwW8Fzkq3YTz0p0=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ELoWZVkIzpuoTd2ofHXS+rfCNoK+saUH+2Cg0XN3xpCQvu2T8vUz4t4p/oTdLVfdv
	 C8OMXWNny2enT/PX+0XjGMyb2z7p9xdrbOVYqnDaoaMd0S6+sR7PmAl7O3TublRxDL
	 zssYDQXhCyaxRNPKaX8jsMQ5PlHIoWNgtVbxIULABObKFr4pe3K5SAtjvFn0FJl9iK
	 1/pAO6qaPdxX76+sxWS+xKdPJd8NyyWEatK21cOIzBq6v/iTaPC/6WBias1iu8NI5b
	 JxYP2PqKDcBN1sIwEluDKOb9lUJoac8Md+ICavTYY1g/RBu9AiWmhHB1m+ZbZAgzLP
	 eRVFcS4ZoAgpw==
X-Pm-Submission-Id: 4hlBPP2JGkz2ScXW
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 16 Sep 2026 10:08:01 +0200
Subject: [PATCH v9 05/10] iio: accel: mma8452: Only apply trigger type when
 not set by firmware
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mma8452-open-drain-v9-5-0dd24fa2f3d7@geanix.com>
References: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
In-Reply-To: <20260916-mma8452-open-drain-v9-0-0dd24fa2f3d7@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789546157; l=1389;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=uPZchZjn6UkglmRiByWIsLTuCMTQTNFVKTPStIfIxjQ=;
 b=4tlXrY8S4zzMqasjflbJgwYenTe78Qa4kR8UrFELcISGe5eS4BTxm44kq3sAfYPYFuOTXd749
 coSoK/+R8XSCjsiZ1Fa47YwD+9DXchaq6M0mkPMo1xm1LpBwsmOa0t4
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

