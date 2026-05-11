Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBED38C41B;
	Mon, 11 May 2026 10:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493849; cv=none; b=HFkBTFg6V+rNwapjQSwwU6fiE8HdLcCuxTtShX8wCcai0I6lszNEQZIS3yakn87eLrqZn8vXfU6addwYrqqlq0C/tFT1n1sjMFL6CXD6wwyMBQZ374kMtJq1kgjPymCmaO+nsYGWM6TYHl6yxFqoYD4R742VtYndi8wLxm1VLG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493849; c=relaxed/simple;
	bh=wNrwPBAxH/ZRlv8+EgsSsrh9pCV6eZXbE6d7MqZdawg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EzmqZ8o1GRff0unncxW9gQjaP9bNJml+2nXNu2lgkzoqRI2mslnJFEE3MapjfJU8TT+7MawHQujZNqgCgl8VWrqrTJUD6MuQ8heg0aa3CizYAJIAPrlEs4i08sbqxOKUXL/79LTkfRuIPIQf4NQLgdGBXSH1dSFcJRm1v5ifl1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSrbkm4c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSrbkm4c"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E5C2C2BD01;
	Mon, 11 May 2026 10:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778493848;
	bh=wNrwPBAxH/ZRlv8+EgsSsrh9pCV6eZXbE6d7MqZdawg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LSrbkm4cBudqCfxEbn0X74QtMiyb9Iao/ZhpWhwEwmU5I72WwpMpVo4Iq3OmHbIyf
	 TasEgSKBT0bmRKoMUd+B5vW4/9zkG9Y2mVDvhAa3044dLNmeSg/86d7YCbhEyoAf0n
	 gl5z+fTw6wLaUuPzN7YzWLMSMKSGoKhPra8PS0e4jDuTEu4sy3pEOUVe3a2m0XlSVF
	 EobZeF7mYKlEoSfqCNHtMssYkQqOuMUWvXod5pfo/RFFthei8ag3xnTGcCkzZs9S0o
	 qkp6+aVZYpL7dt0NpXJSLKUaoKcy8/eYqBFsCEqT5qAY2T0I894FiFMuBNdvDQie8b
	 VlgB65sqI1bnA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 664E1CD37B9;
	Mon, 11 May 2026 10:04:08 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 11 May 2026 12:04:11 +0200
Subject: [PATCH 6/7] iio: light: opt3001: remove unnecessary comments
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-opt3001-cleanup-v1-6-f7879dc3455c@gmail.com>
References: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
In-Reply-To: <20260511-opt3001-cleanup-v1-0-f7879dc3455c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778493846; l=1455;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=CvHqUzEKYCIaa3N5Ba+LTLV0AD0IUgdZt4E0WfgOkO0=;
 b=kq+ViCYTpJEMuFKTmLB8xYd+E7aaOT2pMcseoIDJy1ikaxaUa82+PpyppDf8eTy1eTKdgBeqn
 0SX0Hl8VCUHCP73MvCV+nXy13peu0xGFU+h/9l6Qnt5It/Sg8zwkMVH
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

Remove unnecessary comments as code is self explanatory.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/opt3001.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
index 3719757f6ed7784cbf2e4aa659e5c69a39b0cce2..155794bb28f68a945e20b083e382561ca6ad462e 100644
--- a/drivers/iio/light/opt3001.c
+++ b/drivers/iio/light/opt3001.c
@@ -369,7 +369,6 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 		if (ret == 0)
 			return -ETIMEDOUT;
 	} else {
-		/* Sleep for result ready time */
 		timeout = (opt->int_time == OPT3001_INT_TIME_SHORT) ?
 			OPT3001_RESULT_READY_SHORT : OPT3001_RESULT_READY_LONG;
 		msleep(timeout);
@@ -388,7 +387,6 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
 			goto err;
 		}
 
-		/* Obtain value */
 		ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_RESULT);
 		if (ret < 0) {
 			dev_err(opt->dev, "failed to read register %02x\n",
@@ -919,7 +917,7 @@ static const struct opt3001_chip_info opt3002_chip_information = {
 static const struct i2c_device_id opt3001_id[] = {
 	{ "opt3001", (kernel_ulong_t)&opt3001_chip_information },
 	{ "opt3002", (kernel_ulong_t)&opt3002_chip_information },
-	{ } /* Terminating Entry */
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, opt3001_id);
 

-- 
2.47.3


