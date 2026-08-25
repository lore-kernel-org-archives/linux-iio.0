Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch [79.135.106.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCFB3E024F
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 08:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787646497; cv=none; b=nLpNL9deF1v+5gvkcFpl5aArt7+WyP1ul7pRLwQKv7xbijH1+gl25fEN4XyZMXpHlHNc6nwFtWsXG391x9g9in/hz02eQpYJo5hdX5Tpxt5LkTZAEB4bWkOdqWAS4RGPfBPaaBYrphaUdtStpMVbu6ejDDhCNIHYtni8AWzsYZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787646497; c=relaxed/simple;
	bh=aD1+TxIcp78KfszYueEmzVsPlop8UEkQflASuNmtvRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o2uTqTLTy9q6npBy7N0gY3/MXRHnYShgC65iYPpmjEkEQ+jdMsYugVWmXvyTU5hYskkWwNw067ojxmWi2kWwVrrKrcGARmn8WJkv6eBSHw+PR2Owyr4Ue6t+gVHzDDgmmYEG6uFlbaKTIJpOAwe/jxnmaCWR81T1wrLiT/eI6nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=ul/X2vNF; arc=none smtp.client-ip=79.135.106.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="ul/X2vNF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1787646484; x=1787905684;
	bh=xweKzoAR9wLr7rzqBzvxfCqFwEihx3bUT7MsiLoLTp4=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ul/X2vNFk0iVPPjy+m0Ax4MnSPMBCHXtk/dImQIDaaPycV1iyihT9Rhkt7JRLpL7s
	 OkuXb+UHnmvTN86byV7TwQ0LDpGnmBNeGckISVRNuy8vmVt0JxjszFcJisUyTtVVE5
	 SkqZQ/oNrgV8EKEKM6oLw1tJW5yQ+3FZq/KkytPknUZOJNHBs5koxuaw1KhZLQMXRL
	 r0KHideBZE2+mG5osx5PN2ASRP25WhM97tSe5NOj+Gk4TJeEPBgwFgiLkJFjXnaWMD
	 j42hvUX+CcPZGMaUanIbiKzP9YRmxvz4Rf58Nl/UC74EJopmrrd8nwuJUMgfMn+gBL
	 PvWMgHVnod7Lg==
X-Pm-Submission-Id: 4hTgrt5JWxz1DDXD
From: Esben Haabendal <esben@geanix.com>
Date: Tue, 25 Aug 2026 10:27:41 +0200
Subject: [PATCH v6 3/9] iio: accel: mma8452: Only apply trigger type when
 not set by firmware
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-mma8452-open-drain-v6-3-9b252804ee80@geanix.com>
References: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
In-Reply-To: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787646470; l=1389;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=aD1+TxIcp78KfszYueEmzVsPlop8UEkQflASuNmtvRA=;
 b=fvfyaz9bxeB75nk4qWf7Vf0CktM60chtF7H1qLj1GSngVB/hsiu0F2hdx3iqaiU2w0pjYHleR
 Dp2CPYho582DWpY0Mc3bS1JJfvzxxOb4UwtceERnhu2d+4X4mPrzrcb
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

