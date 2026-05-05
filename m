Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A8B39A06A;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981562; cv=none; b=LhRy+k3ww0FozNnjPAIB3fgnW6kZreI90h7vS7Yskdx451ccLg60JxvL/RAUCN7KPhBj1PPrY6H3wdd37ObFtui17KZQJEOSFgtv/twHPNN+CfMOiaVl3cMJ0CPOTjlC2OGCcg4DXdCwEWwXSoQC8Alv9V907lJCtKZzgfoxq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981562; c=relaxed/simple;
	bh=9npR7wrcacX2lmVhsXinZNG2gouAhwEMn2L3fI5GMlc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bvRarX5A0v2Jkb9JEdL1mY2rl6yFShPrVJM47GcM8r0+Qvoqa2zh78xhNN8QAIduTqP/csUVvC0nmf1La2lsXXF5jLl0eKFVQ6w5JLP+AKfObrKn2XbCsTYmSyQAvDX5tJ5I5eeGbl8taoth4JUbfHpDfaA1P5nHYH/pZILAKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpmlTFFJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpmlTFFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13F93C2BCFB;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777981562;
	bh=9npR7wrcacX2lmVhsXinZNG2gouAhwEMn2L3fI5GMlc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fpmlTFFJYxJyQI5aqmH49oOpSzM0Vt/NkRlXxB19xTb92D2HS4fDQu9LLveD8fRzm
	 NBWYgm9NqdvHsZ8JA+thqGrq2vtR4gopR9Eo1hmfd8X7Itd+lBK7RrpvOqmpF24EU2
	 ufcfZdE9Zlh0VVvep/kvbtUjhmJPGM+8Wyuz91GG0Q2ZREE5wGBpDf5BqRkh7YEJ13
	 p2TOHN5pz4T8LKGFh5jln3JeuvgET9udrRjhSKSHm/okdiIQtjshbEXMbGBXHSu6ZM
	 CxMY2UjwQBAh9VUXY9r4GYEJD9S4pQfrazsxvlJBYLlio0ZpFpyXgvn6u07GnBGOee
	 Iicu81W1RW0BA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB20CD3436;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 13:46:03 +0200
Subject: [PATCH v5 07/18] iio: magnetometer: ak8975: modernize polling
 loops with iopoll() macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-magnetometer-fixes-v5-7-831b9b5550fc@gmail.com>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
In-Reply-To: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777981558; l=2913;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=V41QhCKldiQvyAMY8Wu1TqUXJlT45yolrTnhX4Txgr8=;
 b=BqJ2KGQy3/p/0g3joi4VPc0mD29AXJAYWOiDU9iOTwAoxTwiphXL3qsqyfj70EzO5uq6jZDX1
 9ogfvjyMexJDsteFregXyvvgYDrrF++cOOJZjSh6X7cLlLJysyQqH8P
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
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 43 +++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 83878ea28b91d8316d2cc31e57fde6da957af689..129c98c97071b4cf8efa3abf2364a3abbde129ba 100644
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
@@ -672,27 +671,23 @@ static int wait_conversion_complete_polled(struct ak8975_data *data,
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
+	ret = read_poll_timeout(i2c_smbus_read_byte_data, val, val != 0,
+				poll_ms * USEC_PER_MSEC,
+				timeout_ms * USEC_PER_MSEC,
+				true,
+				client, data->def->ctrl_regs[ST1]);
+	if (ret)
+		return ret;
+	if (val < 0) {
+		dev_err(&client->dev, "Error in reading ST1\n");
+		return val;
 	}
-	if (!timeout_ms)
-		return -ETIMEDOUT;
 
-	return read_status;
+	return val;
 }
 
 /* Returns 0 if the end of conversion interrupt occurred or -ETIMEDOUT otherwise */

-- 
2.47.3


