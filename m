Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDDF2D7D2E;
	Thu, 30 Apr 2026 15:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777561517; cv=none; b=RGMqms6LiCgIrf9OOJ1VGD3C6AmbYZ0hwHuvPr0OKO+JRl0jrzaB/J676BdC75cjHhe1X5qgZomoA+BKMgePzMYJXDSB4x0TZ/6Rtkr629ghxtzPoaBZdR5k420K95e1a7Jv5G/oSKBYTS5jXpsZhqZvPNfxjrFHyk9dDglOvq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777561517; c=relaxed/simple;
	bh=v2fcODw29MsB1Lp4repod1a+CCrIfcImlu/1vQqn97w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h9Lzds+mWJD67fuHhyj1P551g83I5o/x8HJZut9oBN3kdxrBaG7fIADxlsDDCgzs+6FLcoTK9rhvlnPGF6Ti/uaHV3t36adG2hxDUmtn4wEqmA9/e52zacz3IZJsJlRU6n8WNMN4ne++Vg0n8iIf9y77x+g8Jmt/FrXLGiBJ5S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbjTlXw6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbjTlXw6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D66E2C2BCFA;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777561516;
	bh=v2fcODw29MsB1Lp4repod1a+CCrIfcImlu/1vQqn97w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=MbjTlXw6lOFOJqtlmWjT808VEnEnbfRzbq4K39JKZbSoB98v80r4UCWIZ+Eq/vDSx
	 CgWr4TiHpi7aCNz0bFq+NH4ULHUjU2jKMs7HipRRKEIWYZoA4gzr8zhZfvJZryKqLt
	 89ASzXCuC1GMOZrBsnn8TYJ/HYTpdVJ+I3+Y+IE0W2RZBzomIttnVjwFfmnciOVeoq
	 o2XiNKFN1Ug/PH5d3hLecwM8rtEepOJoEhtaq52qsZD1TjTlSG8EAuFsqZj6/P6DyF
	 lGyUnVXlP6NHjeVy4DwVfCz3V4eoMoQoSwQQd0fgAc5gJc4//s9eC2yol54jUJvCM9
	 e7NnxMnNuydQw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0496CD13DE;
	Thu, 30 Apr 2026 15:05:16 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Thu, 30 Apr 2026 17:04:28 +0200
Subject: [PATCH v4 8/8] iio: light: si1133: use guard(mutex)() macro
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-si1133-checkup-v4-8-fb3e9dce41bf@gmail.com>
References: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
In-Reply-To: <20260430-si1133-checkup-v4-0-fb3e9dce41bf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777561514; l=2067;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=hBsegK4uny44/3ElandWq2RObKs2rVS7S5iCG8OtnzI=;
 b=BhO2lyHy83TTyuEIn31CvhLukmjqDyGJ1qQZfhg46gSeO7xuZ5ZweiIpyTNtbJHrFN+uNAJsP
 gj6wHpBDhfdCZSPcIholerVQltO7Tx168IbLTI/MDmnGB3E0ujVjvwU
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
 drivers/iio/light/si1133.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/si1133.c b/drivers/iio/light/si1133.c
index a3e4ab25acdc105d3800994f4391a7e4291e1c74..55660dccfc7956e77b1d8105b7261221176c1736 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -8,6 +8,7 @@
 
 #include <linux/array_size.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
@@ -396,7 +397,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 	int err;
 	int expected_seq;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	expected_seq = (data->rsp_seq + 1) & SI1133_MAX_CMD_CTR;
 
@@ -413,19 +414,18 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 	if (err) {
 		dev_warn(dev, "Failed to write command 0x%02x, ret=%d\n", cmd,
 			 err);
-		goto out;
+		return err;
 	}
 
 	if (cmd == SI1133_CMD_FORCE) {
 		/* wait for irq */
 		if (!wait_for_completion_timeout(&data->completion, timeout)) {
 			regmap_write(data->regmap, SI1133_REG_IRQ_ENABLE, 0);
-			err = -ETIMEDOUT;
-			goto out;
+			return -ETIMEDOUT;
 		}
 		err = regmap_read(data->regmap, SI1133_REG_RESPONSE0, &resp);
 		if (err)
-			goto out;
+			return err;
 	} else {
 		err = regmap_read_poll_timeout(data->regmap,
 					       SI1133_REG_RESPONSE0, resp,
@@ -443,7 +443,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 			 * counters being out of sync.
 			 */
 			si1133_cmd_reset_counter(data);
-			goto out;
+			return err;
 		}
 	}
 
@@ -454,9 +454,6 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 		data->rsp_seq = expected_seq;
 	}
 
-out:
-	mutex_unlock(&data->mutex);
-
 	return err;
 }
 

-- 
2.47.3


