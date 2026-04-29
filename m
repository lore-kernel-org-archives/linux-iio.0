Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465BC3750DB;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475150; cv=none; b=o4/vmtDkY6rrQTm+wjaJJ9TWUCh3pCZBkip3Dp5qfNroW1mPq2ZXDkPu7gr/dAMExIOTFYUb+/xpOWCnVwNd+cVe/q3JypgXbwIs+hyswsBYj8FADoQPP7DSSmDNfkmfxz8fDnifZ2JAv50Tkaz+KwmKK2PtXKqXcFkqSKnqDXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475150; c=relaxed/simple;
	bh=DaRxNVHmK0ihBUzE86Hvs7kynsgkJi/LTdtP2UDKHac=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fOqOzzXMez0UmS3dofLYnpNct8WbU5faEXNU9XJGZzSVfXm7A95pNHVM7Wtq/924eAisL/WnPvnm7kwXEbgc3H7vxyzstS/YrXhWDMdueSBmekXraTuYO0dGBowhrT8qkmLEZQuy+DdfmtRKbtj7ugapNrtPP5xSCBWBWA4JmSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jptzpIXe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jptzpIXe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24AE0C2BCFA;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777475150;
	bh=DaRxNVHmK0ihBUzE86Hvs7kynsgkJi/LTdtP2UDKHac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jptzpIXeYVimrnPQTXhxOWy70o5h6gY29KT3EmDT9PNBxTHY/6whOxMQQd+PPzTMw
	 QU9bozeOJtll0tDCQwDPmqW5obNLVVIF87xLAGckentH+rcSVWd8UK/MiO28zVHnZs
	 zx4rrMNWK+oQqJ46kT+Ds/zStR/lQMwvaDa5coZ3L0Jzmow4bw6MXtKnpLHGJ3KvF8
	 QRMEDQTk5R/gK1iYJCqw1FxzpoBpKvAmC8z95aRurbZvl5MmewTVYjKs++fOh2Ucq8
	 rCfh/eQKEoR8/zfIaB7ou15BDtgZO49jy6eTd13BO3pcYekWcqEwDrEJSuA9KyfNPK
	 Wb2kosggfCsVg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E482FF8875;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Wed, 29 Apr 2026 17:04:53 +0200
Subject: [PATCH v3 5/8] iio: light: si1133: use guard(mutex)() macro
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-si1133-checkup-v3-5-469f21d960eb@gmail.com>
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
In-Reply-To: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777475147; l=2115;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=E69eUronemB3l0JbXsHYCddkenZNL8ZsjA84TtbMePo=;
 b=lGhGn3IlE+PPDM9OtJMTLULyr6D1Ke4pNMiJa4EXBJh0mnrqJJA5iwvNkbVjhL85GxEyX4k3U
 7PikWelQvhtCEGKAg6oU5Xy87jSOLKLWd8EEXsLgklDV9E3rEl+Fny+
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Remove mutex_lock()/mutex_unlock() and goto instances and add
guard(mutex)() macro to modernize driver and improve mutex handling.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/si1133.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index f46485304877a89eff3616c62d5d2a4459bd0c5f..939189d8c18a85ad64d8c05dfb83b5989f524791 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -8,6 +8,7 @@
 
 #include <linux/array_size.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
@@ -395,7 +396,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 	int err;
 	int expected_seq;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	expected_seq = (data->rsp_seq + 1) & SI1133_MAX_CMD_CTR;
 
@@ -406,19 +407,17 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 	if (err) {
 		dev_warn(dev, "Failed to write command 0x%02x, ret=%d\n", cmd,
 			 err);
-		goto out;
+		return err;
 	}
 
 	if (cmd == SI1133_CMD_FORCE) {
 		/* wait for irq */
 		if (!wait_for_completion_timeout(&data->completion,
-			msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS))) {
-			err = -ETIMEDOUT;
-			goto out;
-		}
+			msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS)))
+			return -ETIMEDOUT;
 		err = regmap_read(data->regmap, SI1133_REG_RESPONSE0, &resp);
 		if (err)
-			goto out;
+			return err;
 	} else {
 		err = regmap_read_poll_timeout(data->regmap,
 					       SI1133_REG_RESPONSE0, resp,
@@ -431,7 +430,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 			dev_warn(dev,
 				 "Failed to read command 0x%02x, ret=%d\n",
 				 cmd, err);
-			goto out;
+			return err;
 		}
 	}
 
@@ -442,9 +441,6 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 		data->rsp_seq = expected_seq;
 	}
 
-out:
-	mutex_unlock(&data->mutex);
-
 	return err;
 }
 

-- 
2.47.3


