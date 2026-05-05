Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F96439935E;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981562; cv=none; b=smGpGLVB74zeVZEKtINrsgI2HIVuuBY/lZ6tc1ZOV5GHWfaOZR7nTv6j55texCfxlITOtw5gJ39bDTGBkk5hCSpsfaPGTbiJyub/X9rKdDTwWB8ShXi88oCdGVp6Ntji8ckYe5tuMlVGa3R8ysn4g8epCP51AydSw3XPFKXJuhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981562; c=relaxed/simple;
	bh=iKsneH3hjX3g0hqlLVA2JH8ISXd4JIrC/rCQfH+Avwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CYioEs+Rzf3KqUpFcCZdnazYQlvVUUWw7tuLBiqv/OU/gbYHimtiXKoI2fUoCkOvoC4jqwvyqzSNGypqgS0T5NHeTKdA9w7Vt6t5G9TkhziDMl5IcYw+WbqXwDd+od1pJ0TSpwEzwU5UZVCzWJB9E5nX9zlpxFwcvXl1rHvFrbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfPN2Qf6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfPN2Qf6"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E7C80C2BCFC;
	Tue,  5 May 2026 11:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777981562;
	bh=iKsneH3hjX3g0hqlLVA2JH8ISXd4JIrC/rCQfH+Avwc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UfPN2Qf6/4eyMkAvbgJaijHQ07pm/SUaO66PPi/Hidwi7l0sAx5SgNK27awA3o6kB
	 ndP5e+34qgdgEQlbsj5AArkjXn6xZ0fWYq1K1P3jzjY9XCTf3WxEPboG3Rf6hWGAAM
	 skty8TVWdbPd3Me739JggHmkXzAKM37nmD2QrK27K/t0uT06LrtnVTxYVvGgrP14Gz
	 5nEldRmdUANdbfES3bRQpRqcr8HVb/7k0+YM2xhnyk+6BI92kc6d/43aen9L9AngTu
	 nNeO6ym3Lxt76j12qdTQc7M0j9M5fvRimTZWk+WDOOHwvQOLePPvrXL5GThvzXLFoB
	 9L3/QPNPYL2kA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0702CD342F;
	Tue,  5 May 2026 11:46:01 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 13:46:01 +0200
Subject: [PATCH v5 05/18] iio: magnetometer: ak8975: fix wrong errno on
 return
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-magnetometer-fixes-v5-5-831b9b5550fc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777981558; l=2130;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=8BWMSJrKx3tcT795wZWjnllxfUR1fD05C91F7y5HJAA=;
 b=5qu3HWzIigqhQMlmqXYJTFKN8DFPG0fo5wwkRWhRd/CK9TafFmtpBMComlcxDdUr3niE0t4/T
 xP7D2xkGU5IB4Rd25Y+gQFuyL0KWpf1qeq8QoNeLwfr50cXVEsC/iNV
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Joshua Crofts <joshua.crofts1@gmail.com>

The driver currently returns -EINVAL on polling timeout instead of
-ETIMEDOUT.

Replace return code for -ETIMEDOUT and remove unnecessary error
message as -ETIMEDOUT is a standard POSIX error. Also replace
instances of -EINVAL in comments.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 6ca8c24b9fba452b6fed8155957a8e5fcbc6511c..57f50c09cca539c3733f516a1617375e9134c349 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -662,10 +662,8 @@ static int wait_conversion_complete_gpio(struct ak8975_data *data)
 			break;
 		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
 	}
-	if (!timeout_ms) {
-		dev_err(&client->dev, "Conversion timeout happened\n");
-		return -EINVAL;
-	}
+	if (!timeout_ms)
+		return -ETIMEDOUT;
 
 	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST1]);
 	if (ret < 0)
@@ -695,15 +693,13 @@ static int wait_conversion_complete_polled(struct ak8975_data *data)
 			break;
 		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
 	}
-	if (!timeout_ms) {
-		dev_err(&client->dev, "Conversion timeout happened\n");
-		return -EINVAL;
-	}
+	if (!timeout_ms)
+		return -ETIMEDOUT;
 
 	return read_status;
 }
 
-/* Returns 0 if the end of conversion interrupt occurred or -ETIME otherwise */
+/* Returns 0 if the end of conversion interrupt occurred or -ETIMEDOUT otherwise */
 static int wait_conversion_complete_interrupt(struct ak8975_data *data)
 {
 	int ret;
@@ -713,7 +709,7 @@ static int wait_conversion_complete_interrupt(struct ak8975_data *data)
 				 AK8975_DATA_READY_TIMEOUT);
 	clear_bit(0, &data->flags);
 
-	return ret > 0 ? 0 : -ETIME;
+	return ret > 0 ? 0 : -ETIMEDOUT;
 }
 
 static int ak8975_start_read_axis(struct ak8975_data *data,

-- 
2.47.3


