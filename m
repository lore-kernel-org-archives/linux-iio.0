Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC12E2C21EE;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561516; cv=none; b=HjOGJy/wJuOfs6iIaQ9cwrmfXJgmH+A139liescw24M13vik9i1U6TNCqi+/ElHmkV7wU3+HV9XE1RRXiTqcGC7KjIkX8K7KOLSTT8zFRnz5GRY4SjtHuQWrGVbY/gMmHc1JBv7OZ3v3r6uhfVeZmwS1b2M0XfO6JO+6peyNPsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561516; c=relaxed/simple;
	bh=wqz0bKGlNUuLDdzAuyBaUgHWch1GriKqzUUO2K+OxAk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M4iyt0mremOhwhAldnaUXeyA8v0xY/nsnVhYsFvUoBh5fYOXL636v6DIrvABlc2ePCYlAYYB4UfquiU6+rDEJBiO+Wm3MShlSDxPFjD+sBZg/83Z0XfKuJ5tWXz0Wg2mU+iUapLdtBoPHibrEzfZ+4pxeqD2ooUHIToJd8GpIEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nstX3A4n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nstX3A4n"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D7F9C2BCC7;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777561516;
	bh=wqz0bKGlNUuLDdzAuyBaUgHWch1GriKqzUUO2K+OxAk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=nstX3A4n7UwgyA8BJyG2xHjs3HrVUAUcTPmOv4UIv6/bUtfgCTPDLWreqJ2ADBGtt
	 HBuKseEYg7B1GNHvBJakyJXXbz2p5fFJ/4Yt/2dS/GuJqm6q5X7WYcoTpyA5j6L8Fa
	 2xp23OIE3nX/4B32m9r99hArsVJ3saIqCipEBnxKKDokRsGkGUzBgosT5Rt0q7oUV8
	 KH8oPav/izCWHTvm4IyYakVC08uUymha/20ZLN9VUPPYK+U5kReFYNpK/N4EYsCZvD
	 APVWaftj58QK7YRHd4Gc/IeChvEx79MAHIVtae/8LiwYpMv3KvwySX3ZOfZMOaXIle
	 ELT8HSBdg55+g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E94FFF8873;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Thu, 30 Apr 2026 17:04:22 +0200
Subject: [PATCH v4 2/8] iio: light: si1133: prevent race condition on
 timeout
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-si1133-checkup-v4-2-fb3e9dce41bf@gmail.com>
References: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
In-Reply-To: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 sashiko-bot <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777561514; l=2070;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=oL3iK2flDthV/Ohs5rDoVs2xKZo+kx/muq+vmqyUtqM=;
 b=Toc4toPVX2TP6iBlB/JtrvzfsFIwpHPceZ7/WUrwS6mCB/4Yu3H9e+d1m4uZ2PxsE3HkH0xId
 vCKida0dVk1ApVBQ51cuzIoplN4hAajFHnajONMbD+mslbvkFpS49sx
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Sashiko reported a bug where the si1133_command exits on timeout
without halting the sensor or masking the interrupt. If the sensor
completes the command later, any subsequent command to the sensor
will cause the IRQ handler to complete immediately, returning stale
data to the driver all while the command hasn't finished yet, shifting
all potential reads in the future.

Fix this by masking the IRQ if wait_for_completion_timeout() fails.
When initiating a new command, do a dummy read of the IRQ_STATUS
register and turn the IRQ back on.

Fixes: e01e7eaf37d8 ("iio: light: introduce si1133")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/message/20260428-si1133-checkup-v2-5-70ad14bfefe2%40gmail.com
Assisted-by: gemini:gemini-3.1-pro-preview
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/si1133.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index c88c79202be2e21abb72067426e31b6bf97c61cf..bf7bf0f1631d49a1d04b89f172646e4afaf46438 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -395,8 +395,14 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 
 	expected_seq = (data->rsp_seq + 1) & SI1133_MAX_CMD_CTR;
 
-	if (cmd == SI1133_CMD_FORCE)
+	if (cmd == SI1133_CMD_FORCE) {
+		/* Flush pending IRQs from a previous timeout. */
+		regmap_read(data->regmap, SI1133_REG_IRQ_STATUS, &resp);
+		regmap_write(data->regmap, SI1133_REG_IRQ_ENABLE,
+			     SI1133_IRQ_CHANNEL_ENABLE);
+
 		reinit_completion(&data->completion);
+	}
 
 	err = regmap_write(data->regmap, SI1133_REG_COMMAND, cmd);
 	if (err) {
@@ -409,6 +415,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 		/* wait for irq */
 		if (!wait_for_completion_timeout(&data->completion,
 			msecs_to_jiffies(SI1133_COMPLETION_TIMEOUT_MS))) {
+			regmap_write(data->regmap, SI1133_REG_IRQ_ENABLE, 0);
 			err = -ETIMEDOUT;
 			goto out;
 		}

-- 
2.47.3


