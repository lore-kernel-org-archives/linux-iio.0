Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CADD3B52E8;
	Tue, 20 Jan 2026 20:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768941366; cv=none; b=FaRjN6Udcf+fcCr/vHupxdIrm6AfavyaN2ywPXGOBTpAPtDDhkqxb1RMfWSuIf1Jd+ba+EhVEayB0JhMmTUQdDKonBu7c1o3n+Fhx+VuKrIdZIRF3F89X1EDxUiCxkEZ8xBFmh5wVW0F8fEob4AhUH85gJawfzOinN3CN76ngp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768941366; c=relaxed/simple;
	bh=/b0Q91FnP5UMheFU0YI2D/+71cVpc+B6q/mVGqhhD4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nxVpHLNba+78eDaRlRoI75pWcPcsXvW1xH3cvEFvWER64549zx2JtSOxVWhwQ1e3udjRrmQj7DGHWq0Ksdl4RGSFV67Lnm2hqJR81jfPmmT50jmKCmAuKkGoZWib5zvowbJJXUPvn2LcRLF/m1kHR+75m94HWzz/pUwGLqP0hEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOQ6N62Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOQ6N62Z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B8E6C19421;
	Tue, 20 Jan 2026 20:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768941365;
	bh=/b0Q91FnP5UMheFU0YI2D/+71cVpc+B6q/mVGqhhD4c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FOQ6N62ZNpy85VmCZk31desO1F0Vj5PJpWV9uzpVu75uWrS3s/iJLogoXDE1NOHbL
	 j6boPeBpo4nvhs8KhVL67tyL7fuAMdoqTMRtxCPU9X78X/mNRrnpjrYGWjroKj4p5c
	 SEpTCriSZsim6YLN2niGyVEyXd9ajl0PdrRvuWjFTJr4EuFbu6TUV4n1EMl09qPR3O
	 NLi+zitTzARLGh7yAwxTj3kOoPaZ+ZVfAHcxPNfVaKT/CYqhXGgloZ2rD/1u4Np68y
	 jTUEvEX0qSwLQB4rpmIhMK+f1uyOtcEt544xhsRaB/DnTVGA7sz3/Raa5CF/9X/PZG
	 nRCBAY26SaxCw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9D1D262A2;
	Tue, 20 Jan 2026 20:36:05 +0000 (UTC)
From: Shrikant Raskar via B4 Relay <devnull+raskar.shree97.gmail.com@kernel.org>
Date: Wed, 21 Jan 2026 02:05:42 +0530
Subject: [PATCH v6 2/5] iio: proximity: rfd77402: Use kernel helper for
 result polling
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-b4-rfd77402_v5-v6-2-5b944d0605dd@gmail.com>
References: <20260121-b4-rfd77402_v5-v6-0-5b944d0605dd@gmail.com>
In-Reply-To: <20260121-b4-rfd77402_v5-v6-0-5b944d0605dd@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: skhan@linuxfoundation.org, david.hunter.linux@gmail.com, 
 raskar.shree97@gmail.com, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768941363; l=2437;
 i=raskar.shree97@gmail.com; s=20260101; h=from:subject:message-id;
 bh=4u2p7u2sPM3ykf44S/Ovsl7IQD1KSPRmN8mf85upMmM=;
 b=53ab3EfsxHhCijHrEzTVEg3uKP9tyeLSOQaUuHCKCptcrU8GtyklVFuyCg/aNe3Y5WU1tPMRH
 aWjgHEGGrO5ADuKzkuc++SKo54qLyJo1frXwVCF37INIBKx4L8cVKmi
X-Developer-Key: i=raskar.shree97@gmail.com; a=ed25519;
 pk=4m2wXDvY0vlXefvRRzawNcNAif88Cy4XvbLkU6iMG/Y=
X-Endpoint-Received: by B4 Relay for raskar.shree97@gmail.com/20260101 with
 auth_id=589
X-Original-From: Shrikant Raskar <raskar.shree97@gmail.com>
Reply-To: raskar.shree97@gmail.com

From: Shrikant Raskar <raskar.shree97@gmail.com>

Replace the manually written polling loop with read_poll_timeout(),
the kernel's standard helper for waiting on hardware status.
Move the polling logic into a dedicated helper function, as it will
be reused by future updates.

This makes the code easier to read and avoids repeating the same
polling code in the driver.

Signed-off-by: Shrikant Raskar <raskar.shree97@gmail.com>
---
 drivers/iio/proximity/rfd77402.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/proximity/rfd77402.c b/drivers/iio/proximity/rfd77402.c
index 69cc1505b964..716c9330b14e 100644
--- a/drivers/iio/proximity/rfd77402.c
+++ b/drivers/iio/proximity/rfd77402.c
@@ -12,6 +12,7 @@
 
 #include <linux/delay.h>
 #include <linux/i2c.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 
 #include <linux/iio/iio.h>
@@ -110,10 +111,23 @@ static int rfd77402_set_state(struct i2c_client *client, u8 state, u16 check)
 	return 0;
 }
 
-static int rfd77402_measure(struct i2c_client *client)
+static int rfd77402_wait_for_result(struct rfd77402_data *data)
 {
+	struct i2c_client *client = data->client;
+	int ret;
+
+	return read_poll_timeout(i2c_smbus_read_byte_data, ret,
+				 ret & RFD77402_ICSR_RESULT,
+				 10 * USEC_PER_MSEC,
+				 10 * 10 * USEC_PER_MSEC,
+				 false,
+				 client, RFD77402_ICSR);
+}
+
+static int rfd77402_measure(struct rfd77402_data *data)
+{
+	struct i2c_client *client = data->client;
 	int ret;
-	int tries = 10;
 
 	ret = rfd77402_set_state(client, RFD77402_CMD_MCPU_ON,
 				 RFD77402_STATUS_MCPU_ON);
@@ -126,19 +140,9 @@ static int rfd77402_measure(struct i2c_client *client)
 	if (ret < 0)
 		goto err;
 
-	while (tries-- > 0) {
-		ret = i2c_smbus_read_byte_data(client, RFD77402_ICSR);
-		if (ret < 0)
-			goto err;
-		if (ret & RFD77402_ICSR_RESULT)
-			break;
-		msleep(20);
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
@@ -168,7 +172,7 @@ static int rfd77402_read_raw(struct iio_dev *indio_dev,
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


