Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01020388371;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888115; cv=none; b=Zjh9Vlv8TzWSqrlfg93gTSZjGrTSLlpNF7wVxDI86j57NOban5tpmmxRQkBRpfsHFhWrVgIYZmgPUBJPkhvSII9B5qCg329QmjRbSUu+jNQI/wHCStSEVQn/YI/dWLNLiR6TqpFi9HxIbw7Aj6quEkX5JDIGwUNzRDdVRk/x97c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888115; c=relaxed/simple;
	bh=BUDkYNMkYEk61zOz0NxunnO9uxC4YjPK5Byrp01dd7E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RzjsWBbPdZuEKtWDD6Y91smInOTnJBBv8oSvQeN8z1OLaOzB/xFJyYG7uNrWbCgGDNqnk0gX0tgS7oR8b/sNfYMF+qsV8/Bnk4lNpBogMHTStMbRBHKcFV1gs02DyV+fUtoiUO9jmDloqTteA3HfvGhM9joKXX2BX3QMQcBQvno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqKMXpA2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqKMXpA2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D8259C2BCB8;
	Mon,  4 May 2026 09:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777888114;
	bh=BUDkYNMkYEk61zOz0NxunnO9uxC4YjPK5Byrp01dd7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sqKMXpA2QaiAT5SawApfidJBmdkQSLfcXq9p8m7ttezgN/1pJyOGVxU8PmfYLpzQh
	 QeAdoY4NFpR7W9oir5v4PtCvGQ2+cm5OELp0M2RgEKI7w2VNnwmynqhEdvC1wMEir4
	 abwKHdYNIub5ugEsvtBOCQaBhOkfjv1ZhOc2T/cqtY8ZxZ5ziDrN8wpkUQXQFHj5mA
	 SK4ANw0m5Cqg4XWbLYpISxoEuKAUuO0GNaBrCxv8mWY1ZJbhMekJSZPiqh+rjydzia
	 6xb422C1w/1r1/+ZIUyvOPXbP++CFtsNa7jeRQcLOz2HQY+WqIfNRj4A2FiM5F6yKC
	 0j8qVb/1twT5Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D158FCD3436;
	Mon,  4 May 2026 09:48:34 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 04 May 2026 11:48:17 +0200
Subject: [PATCH v4 05/17] iio: magnetometer: ak8975: fix wrong errno on
 return
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-magnetometer-fixes-v4-5-a291c2a7c71a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777888111; l=2202;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=9ktKUq7LUuC30Nz9Y4JUVYutq/hQ0HQt0x6idr2JCxo=;
 b=MsXORgSWCSqZKGyJVv3GS3nKQXvavEmrU1hMGojhecTzGE/QwyuoYgmDE8/Bhs2PyAbl8sq27
 2aMk+sJm+9GDIYpC+1jWDFmNEBNBpUeULIXjlOFahDmEHy6d3WfPAQF
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
Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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


