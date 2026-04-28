Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77884418E6;
	Tue, 28 Apr 2026 13:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382316; cv=none; b=uyrrZP/E3MdkeD4EiQalI3cQcBBQdet6MlWlfCdTjlswDYnIVXM78rJfZWu0UH3XBrsMhNX2OB+jovdZGzuSORmj5zuaagTSj+4aZnlZB1LWuBTUv62+QGNFLCE96qALJq7apIZKXM2fk6HL/WWVatNgaD22Hk5CbstcAh2uGZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382316; c=relaxed/simple;
	bh=H1coTGSLtrZl7CmThJiiya5f1xJf3QLNF2DO1wXAqmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qtC/8YYV4mLUWiXQnqTN3J4067+VA5hhqQGnu+lsnU82vRlJYNCwXSdnhZdC6tld25wFso0y7BookPrCshUXv1cK6KmMTkPSM9c5gXO/LwvwuZwARye5G/W+1DuEN4ADlKI7LySHwVZrtPuTAdmgEXgU3dJlcYDvLuM7pQlB4RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhlHHsoj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhlHHsoj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86C6CC2BCC4;
	Tue, 28 Apr 2026 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777382316;
	bh=H1coTGSLtrZl7CmThJiiya5f1xJf3QLNF2DO1wXAqmw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=lhlHHsojD85BUf5pxM9k/qyq/w0b6CU1HSLc/5CIfSVQgCYQa/h1GsSKdv7eI+IUC
	 IY81ErRVdpJ9eHHfIp3wwytDKVH9jxxFQOTqojkGhBMgg9GCNTbvGcNpUH0WahIZhl
	 s7fRBdVubUNhTLyfnDYLQ8fG5wmXRXo5KVPf7JFfwcVIkontylS2zF7WLFUb198SEd
	 eA5Hl8eIEig4ifrG92kt2hwrXt75bT3/dFMn1HSd9WjoPB7oujxYmqg2Y0rPTd3/l9
	 LlEsKxKHYeGNv4liiDlTg0JQnSrsmUC2aLsWPlKjzzOyZIMzBHM149TJZiMkWObbdK
	 3YCf6sY4UKAsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E592FF885A;
	Tue, 28 Apr 2026 13:18:36 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 28 Apr 2026 15:18:37 +0200
Subject: [PATCH v2 5/5] iio: light: si1133: use guard(mutex)() macro
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-si1133-checkup-v2-5-70ad14bfefe2@gmail.com>
References: <20260428-si1133-checkup-v2-0-70ad14bfefe2@gmail.com>
In-Reply-To: <20260428-si1133-checkup-v2-0-70ad14bfefe2@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777382314; l=2115;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=GjpeLCBEZ33hvOHDtnqIc83HA4qlDRcZtYHurZdxMdI=;
 b=HCFYRM9n+KCvW2xqz9Qnj51nvSA24dcEEA4pWjEHT3GFVF3EdbP3iNYGKAVauKaBRRHcW7TRt
 QhsGncuxC4dDiIbkyMyV+uv5a4tevbAtFiUk7Y/DWAjxkw+M1EoA9SF
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
index f2a79675c026c86bb56d85a65cd035d7540d0ef8..3b40defda383bcbe731dc0b413903e0267f03b01 100644
--- a/drivers/iio/light/si1133.c
+++ b/drivers/iio/light/si1133.c
@@ -8,6 +8,7 @@
 
 #include <linux/array_size.h>
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
@@ -392,7 +393,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 	int err;
 	int expected_seq;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	expected_seq = (data->rsp_seq + 1) & SI1133_MAX_CMD_CTR;
 
@@ -403,19 +404,17 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
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
@@ -428,7 +427,7 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 			dev_warn(dev,
 				 "Failed to read command 0x%02x, ret=%d\n",
 				 cmd, err);
-			goto out;
+			return err;
 		}
 	}
 
@@ -439,9 +438,6 @@ static int si1133_command(struct si1133_data *data, u8 cmd)
 		data->rsp_seq = expected_seq;
 	}
 
-out:
-	mutex_unlock(&data->mutex);
-
 	return err;
 }
 

-- 
2.47.3


