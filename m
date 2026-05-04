Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3FD388394;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888115; cv=none; b=FV2KOavnlF4WU5v5bAMxhQbNkMTDh10vl1+v5TBM6lfNEvHb+xwfyklzHTBp04K/5SJwnYPbHpQF3XyUQzoYxdZpFu+67XUIFM11XyoTDVq2MfUmYmaMOahYfpdfb2rjtH2Z9rkvUBOMbqw8qIYzUjSnAL8sEi8XzQbTLZBPNSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888115; c=relaxed/simple;
	bh=AVjY5my06SRMpeceBcFyOk68HKZ9lOshUQpqVpgruJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G9CNDJW+tBZYeAWpYOlBbcspF4PToPtaTItruhtLf6yiQE3aJPzZ/7gKmdaI8dTRYstuvci7+vd1TgcDOVCKoJqj8JEnu3uvw8/0osf3bCSeb2h4uReQtar2/lrwu0bceROZa4joIxB51AOqOg78Vxpnhyqblgoah4Tnbi/NS/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpRmH1N9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpRmH1N9"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED45EC2BCFB;
	Mon,  4 May 2026 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777888115;
	bh=AVjY5my06SRMpeceBcFyOk68HKZ9lOshUQpqVpgruJQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LpRmH1N9AcQuCA8cJ3shI7YMrlqCo86HPmHVRNydj0wMfoup/6Rp5SgDs4HTxg9ca
	 Jv24oPOh8RoE7R+fUqsWpQ5KDQW7l78RBoyu0n4Jg1DyeAxkgaqDBySBKRIOtn1rsc
	 JlXDLMo1gJnr3hQXCTMNr0BRrIGxRoQD3GhoDDh5F2J2wie5zyopg65MwjokVSY9yC
	 N1Y/ecIY1mQS37ta5h3fizT0gGG8VFyYAX3pLmGM7C5QzGzM1AsiX0gCnfxK8Zos+4
	 iv241nGe5Q+VqtLGsA9U9JeDCeCkJ25b15e57/zoHPT44UDC9oqXuGsd8r3pQl7xrd
	 DaKklz5OX563g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0737CD3426;
	Mon,  4 May 2026 09:48:34 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 04 May 2026 11:48:18 +0200
Subject: [PATCH v4 06/17] iio: magnetometer: ak8975: modernize polling
 loops with iopoll() macros
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-magnetometer-fixes-v4-6-a291c2a7c71a@gmail.com>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
In-Reply-To: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777888111; l=3362;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=hktgxAMIWkT3d4BfrJ2NbYY6onqoBjLzuppRGAxqibY=;
 b=gPXY2wRCBytC/D+3F52ieO7TFh8D2zbu4+u1GKvPpk0gCLC4FmzogL4wWZdGp/NVcftqcsgGR
 yXBcP6GwmDtDOFpGSP1yM9V1/sXshjofBfjnLDCIONGBpxilwosY3Vc
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
Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 45 +++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 57f50c09cca539c3733f516a1617375e9134c349..2e750c151435da57926969a63ba9fe996d774e7a 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -23,6 +23,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
+#include <linux/time.h>
 #include <linux/types.h>
 #include <linux/wait.h>
 
@@ -652,18 +653,15 @@ static int ak8975_setup(struct i2c_client *client)
 static int wait_conversion_complete_gpio(struct ak8975_data *data)
 {
 	struct i2c_client *client = data->client;
-	u32 timeout_ms = AK8975_MAX_CONVERSION_TIMEOUT;
 	int ret;
+	int val;
 
 	/* Wait for the conversion to complete. */
-	while (timeout_ms) {
-		msleep(AK8975_CONVERSION_DONE_POLL_TIME);
-		if (gpiod_get_value(data->eoc_gpiod))
-			break;
-		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
-	}
-	if (!timeout_ms)
-		return -ETIMEDOUT;
+	ret = readx_poll_timeout(gpiod_get_value, data->eoc_gpiod, val, val != 0,
+				 AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
+				 AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC);
+	if (ret)
+		return ret;
 
 	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST1]);
 	if (ret < 0)
@@ -675,28 +673,23 @@ static int wait_conversion_complete_gpio(struct ak8975_data *data)
 static int wait_conversion_complete_polled(struct ak8975_data *data)
 {
 	struct i2c_client *client = data->client;
-	u8 read_status;
-	u32 timeout_ms = AK8975_MAX_CONVERSION_TIMEOUT;
 	int ret;
+	int val;
 
 	/* Wait for the conversion to complete. */
-	while (timeout_ms) {
-		msleep(AK8975_CONVERSION_DONE_POLL_TIME);
-		ret = i2c_smbus_read_byte_data(client,
-					       data->def->ctrl_regs[ST1]);
-		if (ret < 0) {
-			dev_err(&client->dev, "Error in reading ST1\n");
-			return ret;
-		}
-		read_status = ret;
-		if (read_status)
-			break;
-		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
+	ret = read_poll_timeout(i2c_smbus_read_byte_data, val, val != 0,
+				AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
+				AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC,
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


