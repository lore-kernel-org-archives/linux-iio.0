Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78900377558;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777475150; cv=none; b=QB3SO1/p4NiPs8plo7szDleBpOk7Bwelm3B75EKFLcpMdxgPHvcjXDX5ZM1wH032z/U9svDUv8LWdljkHfMEg8+1Nb4wH+zuWkn2XcISzKuoWlEEVELJWX7iTaSFmT+UQmFvA6TpO9Ig6+GFvQjVlT1ZP+Q+NISjO0gskY++lr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777475150; c=relaxed/simple;
	bh=1q2GA3CyxnnITMccp7VHbuyA4+x6gy/UvThi0EKBPeA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VtYjkjefoJ68Itke3VLvjasRe0yeI8hEMaYNp5oKnqRdXVIjte+TfKqwL8YId8QUSptjqZ3smREVQyho3aFLANX4Rj07vlN2PllVtxICrTpBP5Xakj8fvogTIETJczwCLbJsAxWZ0kYd3t5mO6SUi+TL5+MX3fgQOALfu8uwpao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NppycUrq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NppycUrq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 52DA8C2BCB8;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777475150;
	bh=1q2GA3CyxnnITMccp7VHbuyA4+x6gy/UvThi0EKBPeA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NppycUrq3xzPTDVKIvgR3HYKPVZchMSBY6QE1fdXy69Vhz8ulIU6VQJjeEDc6jEXU
	 7OTWch4DdOJGhUfqgAVUYf8YdTz1sDa2Ehuv4/3v9P7lDxIEzg4SAbk7Xz0s1eZCPS
	 A40YgK6sF7HkUOW6vTsooN4uBvGUkkAhAthzs2TATNcda+tTzIllaPoHnUF1ubw8sq
	 RCo1PN9Oujart+rmGlWC5gUb+A/E11KSJypZCdiE99+G9dugmy+xc+6ezuwE/WWJEq
	 bGwMpdWwuBS6b3CTHPte4m9V4xY9QyYiIYxx1ulvykPqOXJHbO642KnNBgPh5AN7L4
	 Dxv02t/JQ4C8w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C513CD13D2;
	Wed, 29 Apr 2026 15:05:50 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Wed, 29 Apr 2026 17:04:56 +0200
Subject: [PATCH v3 8/8] iio: light: si1133: prevent race condition on
 timeout
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260429-si1133-checkup-v3-8-469f21d960eb@gmail.com>
References: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
In-Reply-To: <20260429-si1133-checkup-v3-0-469f21d960eb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777475147; l=2620;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=wWxVBIcT+WefqGjm1JhnOezGW/VoQWaUnsiRF0Pw7XM=;
 b=1cs2SN0Jy9iDy6Ems50kETdSDCMgC3jQHCvmQfMN8cRZM1xUNCm7U60Dlp65Wi8zQ6T2B4BGg
 wds1Zv3R366CxQQJy9U/RP5Ub6jOGHwX43Apk9Eta1eMZc+fu9V4ZEP
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

Closes: https://sashiko.dev/#/message/20260428-si1133-checkup-v2-5-70ad14bfefe2%40gmail.com
Assisted-by: gemini:gemini-3.1-pro-preview
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/si1133.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index 842a59bc68c20b3206e0c826f86c913f6c66bd7c..91c90f2873ae053eb7cbc8c9c79ce6d91a1ec9dc 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -401,8 +401,14 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 
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
@@ -413,8 +419,13 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 
 	if (cmd == SI1133_CMD_FORCE) {
 		/* wait for irq */
-		if (!wait_for_completion_timeout(&data->completion, timeout))
+		if (!wait_for_completion_timeout(&data->completion, timeout)) {
+			/* Mask the IRQ to prevent delayed interrupt waking up
+			 * any subsequent command.
+			 */
+			regmap_write(data->regmap, SI1133_REG_IRQ_ENABLE, 0);
 			return -ETIMEDOUT;
+		}
 		err = regmap_read(data->regmap, SI1133_REG_RESPONSE0, &resp);
 		if (err)
 			return err;
@@ -431,8 +442,8 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 				 "Failed to read command 0x%02x, ret=%d\n",
 				 cmd, err);
 			/*
-			 * reset counter on err to prevent sofware and hardware
-			 * counters being out of sync
+			 * Reset counter on err to prevent sofware and hardware
+			 * counters being out of sync.
 			 */
 			si1133_cmd_reset_counter(data);
 

-- 
2.47.3


