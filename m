Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0194E3E5ECB;
	Tue,  5 May 2026 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966309; cv=none; b=h1w9r8dfMWNUhBcLqxSujQ22xoiw7RSkiyH3DKYPD78XMAcp+kYPWDzexHZv5FUJxMvs7pqF90CXxk66pDE/XzNh1lvL3HKQh7HjfJsvF/vbYJJTtYCdqbTQQiOtcVKY9ZQo22wSEDzG4CZf9b01jYdGi2r7QAAZq1rQJcaXPo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966309; c=relaxed/simple;
	bh=XB5hQM+QnSdZ7tu7UzZwj6js1QbIpCzsw/liFug3EA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I+d4RjK4upEUm/7xt3y6C85gYMa9O2/kcfiGj/5Uy6G2B2qU+xVEj047XwZX2BM0KGrNFg+PKHMRhuAJDHeiEQC4sHiqD834OwCUoFpzymG20k1Ape5ZAhuUqW0FOV8vCR6VZvyJ2FfikSNvY/ZHMkoTWaSp7ynSUjVMfkmT8sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeJwF0mM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeJwF0mM"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D976FC2BCB4;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777966308;
	bh=XB5hQM+QnSdZ7tu7UzZwj6js1QbIpCzsw/liFug3EA8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZeJwF0mMrq7Ijg3HGk/o9y/6iS3NOM6t+ZNj0zewm/QzIJ+owB4fQ2NkM+a9eFupF
	 ovC8loZ2Lg23zzBcOBwhki5wlogAJhgn3QI2l7M+JQlbnLIGz3cwvQSoczlzEEy+vz
	 3jh2bInIjV58ia68w3TpEuRm2Jv2y9KHQ3O/4BEzOfWNTSB/2X+o2CnxRO00nagczC
	 u7kCDrmIvalr5ckgdLKOUWzFBiqh4Sp9mWXiBK0W+zLtlf0Oqde+zTOxMvPj48gd4R
	 Fh72KCrslaCK0iZcphQKV56oogx22pjd3IFXL5Iy1O5t6hqZ8s8bbO98HpLQFny3/P
	 tE2sQdKayf8gg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4565FF885A;
	Tue,  5 May 2026 07:31:48 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 09:31:33 +0200
Subject: [PATCH v5 8/8] iio: light: si1133: use guard(mutex)() macro
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-si1133-checkup-v5-8-5df86a9024ed@gmail.com>
References: <20260505-si1133-checkup-v5-0-5df86a9024ed@gmail.com>
In-Reply-To: <20260505-si1133-checkup-v5-0-5df86a9024ed@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Jean-Francois Dagenais <jeff.dagenais@gmail.com>, 
 =?utf-8?q?Maxime_Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777966306; l=2133;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=q9fHJV5P2E/vSw5lDP/3o1uwN8xdWKVmo0vsI+GT2Fw=;
 b=mW+2K4J6BbmiguHUsxU1fmqeB8QYVI+8lOg0/pKnvKDKOQS8vuc93Sd7LBiedqgWw/Q+IdPA+
 2jVQldFpe1CDTFxcrO0y1WEnydoq38XMRZ+et2oUeq8nf7B1cLATtDK
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Remove mutex_lock()/mutex_unlock() and goto instances and add
guard(mutex)() macro to modernize driver and improve mutex handling.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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


