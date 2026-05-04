Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F60038B143;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888115; cv=none; b=YgDr8Ld254jYhh6zifLmNb2rjeWFRJPDl8p0iSctA6U+D48zukIHtkVCe/B8uf1ydyBTywdjDwZZzP79frSZvz1mDvfMGgg7bP2iJIXVSoIKL9I1da+F4LD5tiXuTDY1XtjDNU4j1N2UmafuuKaBGD6l0fKrr2M0K+TQyN72bQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888115; c=relaxed/simple;
	bh=L2RFxzFqcmR6ZbffbpXe0Lrf2wSpdAmicH5pR+ybaCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yit+97TFP2T/66OXWgLR0jMc6wa4xeVQhpYK8bAKM2qxlpcbRQ4doWlIuOiCD31Udtun74cGwOQy1Xgs842oLpc/BXNyK6KRc6XzVbEOoszoekP5PZdzBK+YzRK0i9OphC/CJ39LzMUKkySlPJTsXZDM9cU1rvuwcmSkNeecszo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vB4Wm5Fa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vB4Wm5Fa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 425CFC2BCF7;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777888115;
	bh=L2RFxzFqcmR6ZbffbpXe0Lrf2wSpdAmicH5pR+ybaCU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vB4Wm5FaIztozeI2HqhCO06cgx/bEsckMlb2CSRxH7lCKuryuXOQJd0j7O4r3mMjO
	 jacnJNl9HjJ/gpa/aCxOkfwc7lhYlt4quW7JWGQ8OOa3fJFKQxmw0Dh+m5d98DLgEU
	 m8SDkDq54ITZ9TMlEKBMv306T8hLohUDVeZUxSrqEQc+OY3kCSpAlMpBQOj4oE2vFl
	 4wFaCgq5XEwbnvWQt8CrOzNi3qpX7uDwZRfXfSSS/7P6qlNUGVeGpAWB2+pgFMlxRP
	 Pz023BHYayVq0e+4O7hn0gdo2X6U66hqtKJcb0zExp4OwgsLEMZtHwE16inUG5nCvO
	 /yj6ShvaVB0YQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B1EDCD3430;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 04 May 2026 11:48:23 +0200
Subject: [PATCH v4 11/17] iio: magnetometer: ak8975: reduce usage of magic
 lengths of the buffer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-magnetometer-fixes-v4-11-a291c2a7c71a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777888112; l=1861;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=rDrOq3pd2pOssWC4w5NSLBzhEZL5wqsAhnMlBUMsUAw=;
 b=xpEilhhQQBS1oFvUyZvqUyZ2+4m3gSD+asCKlCr5c66+t7A4uji+HUVwJzDsP1qBlMfPe80w2
 yNWRrHkfCXjCIwU14d3WRWK048+Vx/usnyzngqWI5ObB7AQY+p/lKI8
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reduce usage of magic lengths of the supplied buffer by replacing them
with the corresponding sizeof():s.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index c354ebaba11c86c24ebe2dbc2b20c11f18015151..5f3e8fadf68e1806841a9561fe6aacded08c85ac 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -490,8 +490,10 @@ static int ak8975_who_i_am(struct i2c_client *client,
 	 * AK8975   |  DEVICE_ID |  NA
 	 * AK8963   |  DEVICE_ID |  NA
 	 */
-	ret = i2c_smbus_read_i2c_block_data_or_emulated(
-			client, AK09912_REG_WIA1, 2, wia_val);
+	ret = i2c_smbus_read_i2c_block_data_or_emulated(client,
+							AK09912_REG_WIA1,
+							sizeof(wia_val),
+							wia_val);
 	if (ret < 0) {
 		dev_err(&client->dev, "Error reading WIA\n");
 		return ret;
@@ -610,9 +612,10 @@ static int ak8975_setup(struct i2c_client *client)
 	}
 
 	/* Get asa data and store in the device data. */
-	ret = i2c_smbus_read_i2c_block_data_or_emulated(
-			client, data->def->ctrl_regs[ASA_BASE],
-			3, data->asa);
+	ret = i2c_smbus_read_i2c_block_data_or_emulated(client,
+							data->def->ctrl_regs[ASA_BASE],
+							sizeof(data->asa),
+							data->asa);
 	if (ret < 0) {
 		dev_err(&client->dev, "Not able to read asa data\n");
 		return ret;
@@ -863,7 +866,7 @@ static void ak8975_fill_buffer(struct iio_dev *indio_dev)
 	 */
 	ret = i2c_smbus_read_i2c_block_data_or_emulated(client,
 							def->data_regs[0],
-							3 * sizeof(fval[0]),
+							sizeof(fval),
 							(u8 *)fval);
 	if (ret < 0)
 		goto unlock;

-- 
2.47.3


