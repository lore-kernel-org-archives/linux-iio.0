Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5D336F419;
	Wed, 28 Jan 2026 17:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769622745; cv=none; b=ABjSYZDBsfzBnxqDa2p6RCvNpj6wEsRXQqarCs51iS3sJQcWAsPBMsZmfGRvUZLyxRddEL2XvRXhcB5deQCEl7VAFGIk1ebbBMuUSjjzklFnPiJo0sqtXg4blhWU1lSeOL+LVDZcwYv+//3FAIvfqPctaQiO2FvpwjO6etweXIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769622745; c=relaxed/simple;
	bh=4tJj96U9qFSrGieIw/gjdBhix/rTIvNHOgPYwUx+IOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OZ+un1iFTMdPJkIF/BpKh2eK5Eas3g8b6XP4zEoLaAVl+7HO4a1JiBD/zosNBnDb41WnCSvJ+Mpcguf0OcKM54sJ3Auc4mkhNLtoK0Fmt+iYS+qoxrflh9HIVGHEL3cco6rjMJMKG0RiX1jK/wS/rznRc5f0T7+FFPyBjg+5C5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewkSXla1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewkSXla1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCB0BC2BC87;
	Wed, 28 Jan 2026 17:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769622744;
	bh=4tJj96U9qFSrGieIw/gjdBhix/rTIvNHOgPYwUx+IOg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ewkSXla18wECa4OA+U/1NaLpMhRaiqMr8d8ck8RzFiBV552htWUNTvfSSMNd55jdC
	 g+qNzUgothLUkWG1K1o9BQG/c3AYBCSBhShL8n9rgpgxTjIcYck174rWnzCIcCBGN/
	 7DG2SuZyVkI3tcuAlU8rYLilJeEbDVnSWpduhdm0ifGAVTHcYQZJvoZ89GX49iO/NC
	 rCxPUMT4+rJb8sIo9rInRLNzMF22zKfB62CPNP1twyXzVtDv1wmdemXvOiIjXM/ziF
	 frOwyW1ax06ZZefHAcqvAYWIBtxY/dSfw8C5egrUnSxAzq3Xx/0DJtAKi3PmATST8C
	 3wO7MguBBNnNg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CDBD46BE0;
	Wed, 28 Jan 2026 17:52:24 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Wed, 28 Jan 2026 23:21:50 +0530
Subject: [PATCH v8 3/6] iio: proximity: rfd77402: Use kernel helper for
 result polling
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-b4-rfd77402_v5-v8-3-36388fe7b95e@gmail.com>
References: <20260128-b4-rfd77402_v5-v8-0-36388fe7b95e@gmail.com>
In-Reply-To: <20260128-b4-rfd77402_v5-v8-0-36388fe7b95e@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
 raskar.shree97@gmail.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769622737; l=2657;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=6OtSw9hct5Sdy2Egtuw6lfbO+mzxyEk1Ae48lz1rrqc=;
 b=/kOg1WvB1nYjyi2vYeez8dj4ndGboMLuuO8yhUVNAsN2r7KZ0wBJmzCAqywdKXPda2/q79TqH
 q+wBKKgUgDwDMCA9tBCjgTtshXpuzYmUPmyry7sg3QudKApy9f4ZhAl
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

From: Shrikant Raskar <raskar.shree97@gmail.com>

Replace the manually written polling loop with read_poll_timeout(),
the kernel's standard helper for waiting on hardware status.This
makes the code easier to read.

Move the polling logic into a dedicated helper function, as it will
be reused by future updates.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/proximity/rfd77402.c | 42 ++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 8f7debf0e61f..6b23fb3bfe1d 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -12,6 +12,7 @@
 
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 
 #include <linux/iio/iio.h>
@@ -110,10 +111,27 @@ static int rfd77402_set_state(struct i2c_client *client, u8 state, u16 check)
 	return 0;
 }
 
-static int rfd77402_measure(struct i2c_client *client)
+static int rfd77402_wait_for_result(struct rfd77402_data *data)
 {
+	struct i2c_client *client = data->client;
+	int val, ret;
+
+	ret = read_poll_timeout(i2c_smbus_read_byte_data, val,
+				 (val < 0) || (val & RFD77402_ICSR_RESULT),
+				 10 * USEC_PER_MSEC,
+				 10 * 10 * USEC_PER_MSEC,
+				 false,
+				 client, RFD77402_ICSR);
+	if (val < 0)
+		return val;
+
+	return ret;
+}
+
+static int rfd77402_measure(struct rfd77402_data *data)
+{
+	struct i2c_client *client = data->client;
 	int ret;
-	int tries = 10;
 
 	ret = rfd77402_set_state(client, RFD77402_CMD_MCPU_ON,
 				 RFD77402_STATUS_MCPU_ON);
@@ -126,23 +144,9 @@ static int rfd77402_measure(struct i2c_client *client)
 	if (ret < 0)
 		goto err;
 
-	while (tries-- > 0) {
-		ret = i2c_smbus_read_byte_data(client, RFD77402_ICSR);
-		if (ret < 0)
-			goto err;
-		if (ret & RFD77402_ICSR_RESULT)
-			break;
-		/*
-		 * As per RFD77402 datasheet section '3.1.1 Single Measure',
-		 * the suggested timeout value for single measure is 100ms.
-		 */
-		msleep(10);
-	}
-
-	if (tries < 0) {
-		ret = -ETIMEDOUT;
+	ret = rfd77402_wait_for_result(data);
+	if (ret < 0)
 		goto err;
-	}
 
 	ret = i2c_smbus_read_word_data(client, RFD77402_RESULT_R);
 	if (ret < 0)
@@ -172,7 +176,7 @@ static int rfd77402_read_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&data->lock);
-		ret = rfd77402_measure(data->client);
+		ret = rfd77402_measure(data);
 		mutex_unlock(&data->lock);
 		if (ret < 0)
 			return ret;

-- 
2.43.0


