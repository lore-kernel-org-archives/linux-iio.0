Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B613839B0;
	Tue, 12 May 2026 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583473; cv=none; b=K/GDz4s9PiBRYVLQG+YeAPAgL1zYkqNJLpOxiMSRajk1E4CwTIsWCr0FR4t7N8izU1Xxtq9Gl0qLgq1PJpQfX1PHTgnh6DIvxgUzYLNd8uielHcBRqkS2vJPoPuSnsGefjQJJMFUUHlodAkU94UdV/kx45Ju7EPJM6Jcl8z4p94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583473; c=relaxed/simple;
	bh=6rT0wjV5Mp5NJt3Q/yrwp0wtVx6Rtz1rqHLINeyPuxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k2j61av5qrm3i/+gdwBKRmdbsTT98j4Ze2h8zPnextC7ZO0UbmFx/YB97FhfY7Txpf6M5tLy4FV/rfvYdQOJjR/XxPSPG4/NEwwbv0uU+bIOVAWYjb8+AH4wzeQzW+SKgj6Ybulj1sXrsyiGMmKDZdUY5xutgT+v4dnLkH8Lnlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jt2Y0lid; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jt2Y0lid"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D58C9C2BCF6;
	Tue, 12 May 2026 10:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778583472;
	bh=6rT0wjV5Mp5NJt3Q/yrwp0wtVx6Rtz1rqHLINeyPuxQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Jt2Y0lidVjFeLy0gLCJTqFKFhi86CHGKiIiBWVGExUZf1G3awfLxkjhFypzcBWG7n
	 xvCXfv5TU82/U72QIiDeTffYPXjFjfRLIBx+YDKEqMQK5W131LG1lPcKgP0sDpHgmV
	 gUaXRLnPWzRRw/GbpcqYFYoH0Dr7jBUIyndWUB0xD80jnYWK0OVxnw2mcDR/TBNhLn
	 AHxUWIEi5SevBg75uS/c4ZjyEoZ5tS0MR6k0WwAd5xzaU3sDO8M3YHljxVnv1KXC5T
	 gk2UTKiPKsDxyDR8HRt1ft4TAmnrL4CBIxJ7rRchLGRr/NTafXy+1psZXLNZ/aUokg
	 J4UjQB53RLC7g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C378BCD4F21;
	Tue, 12 May 2026 10:57:52 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 12 May 2026 12:57:21 +0200
Subject: [PATCH v2 01/10] iio: light: opt3001: move device registration to
 end of probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-opt3001-cleanup-v2-1-8018cf3a8a0a@gmail.com>
References: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
In-Reply-To: <20260512-opt3001-cleanup-v2-0-8018cf3a8a0a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Alexander Koch <mail@alexanderkoch.net>, 
 Michael Hornung <mhornung.linux@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778583471; l=1566;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=nHPjQtXZ5RMpyhB4rSm3vBLNZNU5C/mIRnD5ecXS1Bc=;
 b=6/PIMfcUOxDdRs2DP/ReF8xt/OCjoTdSTgKXfqc2UBjW2HlCSmYeWie3lz4JmV8DWdY0bQi+U
 QIGFQodeiaDA3FKg4h/dkJvoOCJ0wRwW+F05WMK8lB2RhMAhO2r+VBQ
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Move devm_iio_device_register() to end of the opt3001_probe() function
to prevent a race condition where userspace could interact with the
device before the hardware IRQ was set up.

Fixes: ac663db3678a ("iio: light: opt3001: enable operation w/o IRQ")
Reported-by: Jonathan Cameron <jic23@kernel.org>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260511-opt3001-cleanup-v1-0-f7879dc3455c%40gmail.com?part=7
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 53bc455b7bad142695d9fecc6cabb934fb3ace0c..3c79e0c4ca32fedf33e318d047d6ab3f62b6c03b 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -874,12 +874,6 @@ static int opt3001_probe(struct i2c_client *client)
 	iio->modes = INDIO_DIRECT_MODE;
 	iio->info = &opt3001_info;
 
-	ret = devm_iio_device_register(dev, iio);
-	if (ret) {
-		dev_err(dev, "failed to register IIO device\n");
-		return ret;
-	}
-
 	/* Make use of INT pin only if valid IRQ no. is given */
 	if (irq > 0) {
 		ret = request_threaded_irq(irq, NULL, opt3001_irq,
@@ -894,6 +888,10 @@ static int opt3001_probe(struct i2c_client *client)
 		dev_dbg(opt->dev, "enabling interrupt-less operation\n");
 	}
 
+	ret = devm_iio_device_register(dev, iio);
+	if (ret)
+		return dev_err(dev, "failed to register IIO device\n");
+
 	return 0;
 }
 

-- 
2.47.3


