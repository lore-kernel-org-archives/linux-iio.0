Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F97344DBD;
	Mon, 11 May 2026 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498779; cv=none; b=g6SZta/UTiqV7r609F4oerXlX0ak9BMhvOXf30iNYaoFbGNLRvB/cpoBypBs9QnKjz5idVjfB2EU9vZ2G9x+J0YoVHeHmZs0W9c/MrVWS4I+ca49uu0snVmSaBhlfbwdclHQOvp3XV79HUi47GgbSwQWaT87HuzIJDGTBOVYBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498779; c=relaxed/simple;
	bh=jalThnA4JGejlYZkvJssMvEnPyKalUQVHvdgBmYq1fM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FQ8NErSlhOhUHTFiR8aI3Cyx+Tp58IpB6FC039TeYdTJ5yCEMGQYmQoinkD4nPI3t6CrT2FpYEcIOxC1lIXzLGK1Yo8CU3qfCqsVSxEfwo+ZqOCvS7aNXNBMU63jbjV9h/4cZ95d2ff7uvHy1IzpzBmcG6itvdjB/I4O/ss2ibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY3PsLpZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY3PsLpZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B4A0C2BCC9;
	Mon, 11 May 2026 11:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778498779;
	bh=jalThnA4JGejlYZkvJssMvEnPyKalUQVHvdgBmYq1fM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NY3PsLpZRJy2yE6k9UPa+eavhdWq/SAn0y3D5TmPYf/ztHQNPbEhGTieYE0MIw4DT
	 8dLIBkBNWlSIIN0eDYwooJGj21Ga05PlYYf9gy8Wl4bKyu01cFde5u8F0zetIWIdud
	 Da6P158uplR3UC9ToDcZixMoHTdQl99FWXx8XD903X2vURxOVcuIGqofIS2Y4z5Khm
	 8ThRbnDk/nUFlTm6xdpSaBADxyDQEFAmD6lpz6XNlseyIYtfgJPHStj9/FktVy5JV3
	 z8zkqNewY9o16n9EEQWnfU5cZG4OhO9JB2ugms5Xsc0/znysJWQi/YT4GtNkLjwW8c
	 wUtS6ulnubepA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C36CD4842;
	Mon, 11 May 2026 11:26:19 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 11 May 2026 13:26:10 +0200
Subject: [PATCH v7 1/8] iio: magnetometer: ak8975: modernize polling loops
 with iopoll() macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260511-magnetometer-fixes-post-pickup-v7-1-9d910faa28b6@gmail.com>
References: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
In-Reply-To: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778498777; l=2939;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=kQ9W4qXTnkaxb6Nx4nCjqQxYeSpg8Dr0Owtif3h7z2A=;
 b=5K1lOK3vwdwAa1YCQ5oLKFNufIT/AxyugQS3JPhlgzvpSU3scBX5rPHU/1+MuK6sdPhNFUWTd
 8sWpY6uRc24DaX4wOfMj4N+w8H+H4WU3eAR7CNrb8opF0pWVzgBs8Sm
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

The driver currently uses while loops and msleep() for polling during
conversion waits.

Replace the custom polling loops with readx_poll_timeout() and
read_poll_timeout() macros from <linux/iopoll.h>. This reduces
boilerplate, standardizes timeout handling and improves overall code
readability, keeping the original timing and error behaviour. Add
<linux/time.h> for USEC_PER_MSEC macro instead of using magic numbers.

Assisted-by: Gemini:3.1-Pro
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 43 ++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 6be72e1cc0a8321e767da5e65d54c0fe88712304..b990c123e2808c2078abcfaf6b2ef86c09393e6b 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -24,6 +24,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
+#include <linux/time.h>
 #include <linux/types.h>
 #include <linux/wait.h>
 
@@ -649,16 +650,14 @@ static int wait_conversion_complete_gpio(struct ak8975_data *data,
 {
 	struct i2c_client *client = data->client;
 	int ret;
+	int val;
 
 	/* Wait for the conversion to complete. */
-	while (timeout_ms) {
-		msleep(poll_ms);
-		if (gpiod_get_value(data->eoc_gpiod))
-			break;
-		timeout_ms -= poll_ms;
-	}
-	if (!timeout_ms)
-		return -ETIMEDOUT;
+	ret = readx_poll_timeout(gpiod_get_value, data->eoc_gpiod, val, val != 0,
+				 poll_ms * USEC_PER_MSEC,
+				 timeout_ms * USEC_PER_MSEC);
+	if (ret)
+		return ret;
 
 	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST1]);
 	if (ret < 0)
@@ -672,27 +671,21 @@ static int wait_conversion_complete_polled(struct ak8975_data *data,
 					   unsigned int timeout_ms)
 {
 	struct i2c_client *client = data->client;
-	u8 read_status;
 	int ret;
+	int val;
 
 	/* Wait for the conversion to complete. */
-	while (timeout_ms) {
-		msleep(poll_ms);
-		ret = i2c_smbus_read_byte_data(client,
-					       data->def->ctrl_regs[ST1]);
-		if (ret < 0) {
-			dev_err(&client->dev, "Error in reading ST1\n");
-			return ret;
-		}
-		read_status = ret;
-		if (read_status)
-			break;
-		timeout_ms -= poll_ms;
-	}
-	if (!timeout_ms)
-		return -ETIMEDOUT;
+	ret = read_poll_timeout(i2c_smbus_read_byte_data, val, val != 0,
+				poll_ms * USEC_PER_MSEC,
+				timeout_ms * USEC_PER_MSEC,
+				true,
+				client, data->def->ctrl_regs[ST1]);
+	if (ret)
+		return ret;
+	if (val < 0)
+		dev_err(&client->dev, "Error in reading ST1\n");
 
-	return read_status;
+	return val;
 }
 
 /* Returns 0 if the end of conversion interrupt occurred or -ETIMEDOUT otherwise */

-- 
2.47.3


