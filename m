Received: from mail-43170.protonmail.ch (mail-43170.protonmail.ch [185.70.43.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5909945C718
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546204; cv=none; b=dfzXIuZj5jMWowKggrY0jz2kMfc34ONGnoL4WQfx6HUmdGxA2mSU3bTPH2x0YB2GaDncjCzOPZMMhn6uCJVa/J4pyz7S3Ld/Ld6D/8zmeg2HXRK9jvyqzXLISgpchkDgrqp8G4YAdp1vOePvlIRmvEXo65gBMkj9MSxdxVY2wek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546204; c=relaxed/simple;
	bh=UUIyipSh2UKdcm74j22sAz/1TGUuH6UZ/bs/me2KcbE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OybGOZysmJU6B524JmTjdQogfxuvJsjhuMeYriAuwfe+sG6vVdwk/qh9qE4DcYAU59jHOqEM+p5wq9qjwdw8q4iRJxuV1AvFZm5nghO/GDdUDP8+S1j6M9DSEIky0HBaif4WnoEORgAk6GRwdpSOyYtGH0NfRU1MzQAHNMAk0vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=nxC6Kxvm; arc=none smtp.client-ip=185.70.43.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="nxC6Kxvm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1789546178; x=1789805378;
	bh=tkWYX2wJYQV4g1jzkw2V1G4h4mO9GWQu8Y9s7bT56KY=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=nxC6Kxvm42CxwP/zKDWIc1zWA0YrKJ5yalTXVCYigOq9GsblHGWC7mVi1HtFEFKcn
	 gsRXPVc02UmVAzGLczSWsuSsS/c6rsdoAf4iPp1aM6BVykEng9gj4AwlFNqS4eTVgS
	 dB8CKKZMWALAS7JIPTfxh8XHeZQ6CWlUgoodPG36dAD1rhMXWU63BTRIdeZZFOwk4Y
	 ccDP+ohMnGFyTfs/zSxX8l/i4Br3Im0MVD01dXejXOWJFiUA0fWYIF0mEaS2tnLFj2
	 7ZQnGFqORD16k5pusAZdp0zZh2+hKwGG/I9rf7wg0u76J0SREvLHgaY7wjsrcVyDN3
	 U1mZY3P0sZNDg==
X-Pm-Submission-Id: 4hlBPY2DSRz1DDXQ
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 16 Sep 2026 10:08:05 +0200
Subject: [PATCH v9 09/10] iio: accel: mma8452: Use proper error code when
 missing device model
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-mma8452-open-drain-v9-9-0dd24fa2f3d7@geanix.com>
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
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789546157; l=915;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=UUIyipSh2UKdcm74j22sAz/1TGUuH6UZ/bs/me2KcbE=;
 b=9Riz1gDWwFndqbCpuFtrXtnfxYq7x/6bSbwOenD1GUcecvMMnYfPuCSyLEyB8swogmi2eBbIF
 TbRro8cySjNDwMQdjIN87OrHEbkl8r6qjuUEIpHUZ8Uth7wHKC3t4KR
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=

Switch -ENODEV error on i2c_get_match_data() failure to -ENODATA to
satisfy the IIO coding style.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/iio/accel/mma8452.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index 5d44f0066b1e..5aea6bf3312a 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1594,7 +1594,7 @@ static int mma8452_probe(struct i2c_client *client)
 
 	data->chip_info = i2c_get_match_data(client);
 	if (!data->chip_info)
-		return dev_err_probe(dev, -ENODEV, "unknown device model\n");
+		return dev_err_probe(dev, -ENODATA, "unknown device model\n");
 
 	ret = iio_read_mount_matrix(dev, &data->orientation);
 	if (ret)

-- 
2.55.0

