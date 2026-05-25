Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9D7320CD9;
	Mon, 25 May 2026 08:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697226; cv=none; b=HyPbApfgTgU+Zw+DBNDeJ17ylHLwAuHKujBunDKhEl3uSYVHziEIEHnUS45rL9T3Y1JfyHuwi7ASI9som+77VT+4RcYf7iiMR3tMbJKwdxNfinhYM0Ucf7qRI3r8qlx3LS1J5GsZbGzHWrHG6VdTWzN5QT1ZoS4UTb4hSWyO3Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697226; c=relaxed/simple;
	bh=6i39pnD/3MQITgaP48uDJxtcF9y8dLaXP0Z/Qq08A9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KhXf1haqtvszAk+eJM11hn8lQeiaqU/0LfwxxqMc77Yzgbyg+6tozKcmMJraPXTuDfo3d/62kibsTA+ViirBKYIhVC2tpn7HX+dzJZ6RgMugOyMF9anMeEnV+JfCnnRSFvy7843sYCGeNBuFiMPp768YTu3O2M90a1/wshoqdcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AHMyGngW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AHMyGngW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9B31C2BCC7;
	Mon, 25 May 2026 08:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779697225;
	bh=6i39pnD/3MQITgaP48uDJxtcF9y8dLaXP0Z/Qq08A9E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AHMyGngWVYFChKEV+6odpmgW7zKX9zQvq1LWqpPdO/pVoSFpILEptqKCzbg+eafC/
	 jRMo4jZZIHQakChfS8J+2MHV2mWtZ3BfwiYwOmcN55CnE3RqTi6Fxr8vKAcUH5q5+h
	 y4glJVX/MeuAve8g8tHtvK6NWBidTMdoxFpemb6qJgp5oerwaTd/GFYCoS2zJ+Bl2p
	 gyfLI1vN2i2FenoGJo7TaTtDx3lPKMlUHy1uYY0sZopzxthZU7bhsfjn8e3NqjFA5f
	 k2SeQCjV1yPkTa/uWoAUw6GYDWMh6becTGC8DMqCS0GmOBg5MMXxs6Lq/aAiYlGRjt
	 Lzgy4PbOfOgUA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8586CD5BCE;
	Mon, 25 May 2026 08:20:25 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 25 May 2026 10:20:15 +0200
Subject: [PATCH v4 1/8] iio: light: opt3001: move device registration to
 end of probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-opt3001-cleanup-v4-1-65b36a174f78@gmail.com>
References: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
In-Reply-To: <20260525-opt3001-cleanup-v4-0-65b36a174f78@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779697227; l=1858;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=oA51opJseD6tk2nABX482iviMQyyuKM5oZpLk6ZwbiU=;
 b=0mU+Q7a50F8VB2hs3UsYYa3wU9govCa5ia2cmCecoGcXjumHMCiiTnKUaT1hQrB/rlrlMZ4MZ
 Z60aEkhTLcABpaQuiKUq/dqrRicFPnU5uWCPcn7YirVrRw8c+Unr4Rb
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Move IIO device registration to the end of the probe() function to
follow standard driver teardown/setup ordering and improve driver
logic. Additionally, switch devm_iio_device_register() to its
unmanaged counterpart as current driver implementation mixes managed
and unmanaged resources, causing potential resource leaks.

Also, add iio_device_unregister() to remove() function to correctly
handle teardown.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 03c7a87b4a8eef13bbdcf48dcaf969781aa76bd1..6a39f116f9312b6933e86d72aefbaaaf1769aca5 100644
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
@@ -894,7 +888,17 @@ static int opt3001_probe(struct i2c_client *client)
 		dev_dbg(opt->dev, "enabling interrupt-less operation\n");
 	}
 
+	ret = iio_device_register(iio);
+	if (ret)
+		goto free_irq;
+
 	return 0;
+
+free_irq:
+	if (irq > 0)
+		free_irq(irq, iio);
+
+	return ret;
 }
 
 static void opt3001_remove(struct i2c_client *client)
@@ -904,6 +908,8 @@ static void opt3001_remove(struct i2c_client *client)
 	int ret;
 	u16 reg;
 
+	iio_device_unregister(iio);
+
 	if (opt->use_irq)
 		free_irq(client->irq, iio);
 

-- 
2.47.3


