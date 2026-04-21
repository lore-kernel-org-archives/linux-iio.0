Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5483B4EB7
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 10:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776766053; cv=none; b=KX4Sd5Tr1JLR2qWR9Bm8LnrN5ZAsC58v+mNQP9TTZ9NSY0Z4jVZlIHa+QyVYjev/U8Iv2wBpRPEXr9SED9ki6kGxBP8xoiwCvlMxn0Wh31t5aJjuAcoFzdZrMt14jas491mcGJ8BTWIX6v4uHxtHEc1sd1JxjO26Q0YbL7mCPs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776766053; c=relaxed/simple;
	bh=uGnCrDcHqdMBp00UrXvV1RoASwvo3lyR3NSMunjbafo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pl2da9N6jJy8u9oTACxG+RbMFTdeytjjdJVAb43aHoZFIyLVzrcDFv6e4ZHaJZW6xZptQS155lukQXi9kcUwmfFlGsCXVO7CEwrpwFyl+EGjz3RwnUxmatKdJTg2VKy+tPfHc3QGH4n+SUyYy9J8F1c+767swqIV28DPnwIgKxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p6teRMKx; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6teRMKx"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-676a89de629so930287a12.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 03:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776766050; x=1777370850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Br2jImMMYeE7t2tYM9ZpVum10sRJKQ+6TUXHeuHOpkg=;
        b=p6teRMKxN98FSJAflunBFpu322PbuzrLwwrK/rVQK3GkN7ral0wJZ6cd+80uUzgOlP
         zeBtoFhlDDVLFg/FKVCSdWTZLrzVgMqIWDsSWU72LInqRfQliv0nEC+6RH/NYkdGZ1sz
         +NvteHVDIcWAXAGsXlC/Dy0Hx1jw1rE6xTAB59q3rSMVwTseqrCOodY3pIRbv76XDJQb
         LTIFGqtEYi/DW6pO0u3Mf7IXaxAMtvBqTyyyEWVSzkNs/oduOWpdKCd+IaKo5/efdV3T
         cCWtIhiEWk0DO+si9oOI1ol7f7MfDxzEWqxOqnRO/7w/qpmEYJU8BHyvK8TlxKstQgtj
         GDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776766050; x=1777370850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Br2jImMMYeE7t2tYM9ZpVum10sRJKQ+6TUXHeuHOpkg=;
        b=Q0nE8C//16AzIdlaq3Gd4oU9KjYsmA73tiUZiS/DLCJMVwxZ8LjtCjUlg6ztPLJ8fP
         YXkmBiGhzx+mbtXpPkhQvymrIOVDvgfClDpMuTEFYLFELQ4e1WYpDnj/n7Dv1kSxcr2r
         jmZeZDNGwixSp2yoLT1khC7q+fUZQNR7ll6b+rTA3q2/V6kMr1V2E+HH07hilaHNci7g
         2sYt+jEN7X1Okc7lhsqFDp0GRZLzGGtY1B5MfuaR/yOiOVXb7Tu5rr9ZAOmqrPifFqS7
         LSbk8TW509zoozZoBBsx95F10xzfuaqPmONIufJIYAYbUgLjpI5dIBRq+d9oatY6siTu
         kmpA==
X-Forwarded-Encrypted: i=1; AFNElJ+n0EPTKdUyHdAA9VcS7+oeLdJ5+W2CkbElRDk3fqY8Z2061ptL4QwSiT6E79YQwyxOq0bao9/r4XA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj38f7T69LGQEeRyexwqjYiWxmek5WaIsoMAvJUKvZCxDx16jc
	EO9HAiSq9FkQewsBhO09P+MpRxma+Xy6oliadQS80yO8c6Zy2j7xjfKO
X-Gm-Gg: AeBDietEkxseWHQERZ4SGXPf2knkjKcdJMkwWUl5wPvHaMFMtBSA/X0MSYLEIUk8EOw
	5WuqSAp0HtX4WhlE9vS8fXvnMuOt5FEv035pMliAB72PqOayQlxFygXzVxzmTvXVgFHwSvwV+Tj
	wFpUSaRXj+mOyzK8HAof6e86cn+0YSjrBj39Vs7i10rJZimkvTQTMVjyT/YE+t1aJcgvOfeAVoo
	fsyhNlmWHBHY9cJQRCAi7kn0mhYV/GxGPB6dpFVpuX/SeJluHhC53qufGr3gl931BLunFDXQe6O
	S0gkOuC1fPTOP438FXwz4rYrgUi9a2ANxk4Z/JIg4rCKPVELps1cpW9TvlGb2wUtWPcSTmp/9oG
	W0AG5AtH5A1pd8H6mPu9vCr6qNqY5RxOQ4T/FYsORdoOA5q2MLx1xPTruo4s7nznBZQv6DQLzG5
	qcIZGkKJGuEw2IQpEo9F64HwcUi9FUaL+Wg3TBl1aftFALjedr/tPiw1P64yxU4rbzRfEt2US0A
	0n9scvAoenTHSeg6OjmbLxped6vVH1BcJ/IzjMedItDZ8HD/Bvt0OErQxivEaV8SOsp9Hg+Mrqw
	vClSQcmGuRf8EdNRXksTo1VPNTXr0Nw6bvjc9CnZHvYGiefZHqhdlVtajyPqZB8kiE30MMudVXU
	GUNG/erh2ufcrpDZZSX82iyqfa6KTdZFJ8xVcFXa1ZAagbANUNbs5vSTy8Pu3wC+LvaWX72U8V6
	iQaN411baDA+Ho6B6UPw==
X-Received: by 2002:a17:906:f593:b0:ba5:234:13cb with SMTP id a640c23a62f3a-ba502347802mr760983166b.4.1776766049603;
        Tue, 21 Apr 2026 03:07:29 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (238.77.147.34.bc.googleusercontent.com. [34.147.77.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba4550468d6sm428078766b.52.2026.04.21.03.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:07:29 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v2 4/4] iio: magnetometer: ak8975: modernize polling loops with iopoll() macros
Date: Tue, 21 Apr 2026 10:07:22 +0000
Message-ID: <20260421100722.1296-5-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421100722.1296-1-joshua.crofts1@gmail.com>
References: <20260421100722.1296-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently uses while loops and msleep() for polling during
conversion waits.

Replace the custom polling loops with readx_poll_timeout() and
read_poll_timeout() macros from <linux/iopoll.h>. This reduces
boilerplate, standardizes timeout handling and improves overall code
readability, keeping the original timing and error behaviour.

Assisted-by: Gemini:3.1-Pro
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 44 ++++++++++++++-----------------
 1 file changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index d0d95d3914a..1b9386b7521 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -21,9 +21,11 @@
 #include <linux/array_size.h>
 #include <linux/delay.h>
 #include <linux/dev_printk.h>
+#include <linux/iopoll.h>
 #include <linux/irqreturn.h>
 #include <linux/minmax.h>
 #include <linux/property.h>
+#include <linux/time.h>
 #include <linux/types.h>
 #include <linux/wait.h>
 
@@ -653,17 +655,15 @@ static int ak8975_setup(struct i2c_client *client)
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
-	if (!timeout_ms) {
+	ret = readx_poll_timeout(gpiod_get_value, data->eoc_gpiod, val,
+				 val != 0,
+				 AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
+				 AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC);
+	if (ret) {
 		dev_err(&client->dev, "Conversion timeout happened\n");
 		return -EINVAL;
 	}
@@ -678,30 +678,26 @@ static int wait_conversion_complete_gpio(struct ak8975_data *data)
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
+	if (val < 0) {
+		dev_err(&client->dev, "Error in reading ST1\n");
+		return val;
 	}
-	if (!timeout_ms) {
+
+	if (ret == -ETIMEDOUT) {
 		dev_err(&client->dev, "Conversion timeout happened\n");
 		return -EINVAL;
 	}
 
-	return read_status;
+	return val;
 }
 
 /* Returns 0 if the end of conversion interrupt occurred or -ETIME otherwise */
-- 
2.47.3

