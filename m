Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E6D229B36;
	Mon, 26 Jan 2026 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769455977; cv=none; b=QErnZTq8A+0SHDNrSNgzzrrUc82Wysq4w+OPZK8efppzzIyA5n7ERLKn5cL3GfntpxP92eEQUQ4O4vBv+EsV768pWF5N1vshhlsxbtm3LFOlvbljOXkSgW3STXzvKJCwyHIsR2JiNi/Uua8svXkii4Ofu45wBTXcP5+6+ebT1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769455977; c=relaxed/simple;
	bh=zrUq5ENAi3Z+qXaInwuaEEZHH0IudunLkXOrczIMXE8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ScWQiuW58CfC3P7Xk+WYYkhmww+7POIlM7kG4snVCaFg9zFY3HpsgabHyHug4nNtfX2Pcmmp5LzOhU5h5lR8CeMcwUPeLZKw+eiWNQCU8sIEv4clihZIvjTJ//iB4RQwEkKWZdY1Uss0yTTlPRfL+XuZAMRG3I5PV6m/00EdtHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kc4Dp4rU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kc4Dp4rU"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2560DC2BC87;
	Mon, 26 Jan 2026 19:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769455977;
	bh=zrUq5ENAi3Z+qXaInwuaEEZHH0IudunLkXOrczIMXE8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Kc4Dp4rUD69ploPqIqucHlbbhutzWSZF5Ts7z1dRkSHCoB6srZTi823ABn069yDib
	 1kwdVbPbbVRJ7RnQ45hrkDJAZzzOtg38u3+Ezisb2zhMgguMd0GCJY6x9dMGfW+pa6
	 Vxy0TAIxrmhe7Qak3CdfJRyE8iimHwytiNOOxPPEg2JQX/L+r9KbDscnY6iaoWVngr
	 9pFOliNLYE4RWedati4RRYeKSMdu8DtNQ5PdfVcWjaw2q0mGEB9rkLPzSdrd8VTOPt
	 m2PGZqJrwFRmPIDXS4C4SMvvcTjykaP5XQyRqFPwTYFGfGjd66d1WlvczjZk5VRIcY
	 YK3C2wpej5Fiw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18CF9D19516;
	Mon, 26 Jan 2026 19:32:57 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Tue, 27 Jan 2026 01:02:17 +0530
Subject: [PATCH v7 3/6] iio: proximity: rfd77402: Use kernel helper for
 result polling
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-b4-rfd77402_v5-v7-3-3e7f2d452da2@gmail.com>
References: <20260127-b4-rfd77402_v5-v7-0-3e7f2d452da2@gmail.com>
In-Reply-To: <20260127-b4-rfd77402_v5-v7-0-3e7f2d452da2@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
 raskar.shree97@gmail.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769455974; l=2451;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=GyqcFmUsAy59m10EhtcPMTwAsyYHutaUajRpRjdu6Ms=;
 b=+Huqw5P4nCzHOOIQ/ElzXdFHwhrzWHrCzDNxAqiic/8Kg9/mktXpRLmKMC21Vb5buHJEVMRju
 3frLnqujykkBBq+tgFIWg+SSP+vo4/sSbECyAolSKtO/zTrjKXSKGMC
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

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/proximity/rfd77402.c | 38 +++++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 3e14660a4bb1..6b23fb3bfe1d 100644
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
@@ -126,19 +144,9 @@ static int rfd77402_measure(struct i2c_client *client)
 	if (ret < 0)
 		goto err;
 
-	while (tries-- > 0) {
-		ret = i2c_smbus_read_byte_data(client, RFD77402_ICSR);
-		if (ret < 0)
-			goto err;
-		if (ret & RFD77402_ICSR_RESULT)
-			break;
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
@@ -168,7 +176,7 @@ static int rfd77402_read_raw(struct iio_dev *indio_dev,
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


