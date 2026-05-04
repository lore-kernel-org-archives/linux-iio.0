Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A44338C2DB;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777888115; cv=none; b=XlcV1oqsFECPy+oL+LE7K6p/uZyeE6OREK357he40jWbyEclXXFGxvK/St8DNdKziAYlfkiFQU9phzRoqKtiLbUdYZlxYtFJ/mL0sO36bOTuLgaHlTtZ6kmAhBnl/cRh3bZLXG90dSwxX/i+wCCPvu6jU7PSOlvQmEInD8mKAV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777888115; c=relaxed/simple;
	bh=XCHZSzX0B6av20cy7yBlmtD8BkdxfmtbL9aw51ux5E8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FfiJ7jDJnfGierxmAImE2MdjRfxjDUkcziOtprRcStZeXLKq7SA6gvvFbDe9SUbC5kxrQgPsDIqaAmRJmneuJYIuVj18ME+HAa9s+AeAbZ+VeNYhMs1feULg+yAKGLD/Ol+hh8VFUrnFpuXHPPB9ovYkAQ8cq4JfVS8TYe++UKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4n0IGbe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4n0IGbe"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D16CC2BCFD;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777888115;
	bh=XCHZSzX0B6av20cy7yBlmtD8BkdxfmtbL9aw51ux5E8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=S4n0IGbexSsLbfAK5DXgeckuyuBsPXaImPZlj30HSccWy2VitPo9eTCxQN/nJJYkt
	 Y1cTbwMGqiC5S8lAOx3MeKMb3lTzZfnZce6GYnPpwiyKN+8ChcX+gWn/io8+to2BfN
	 CjTkaWFPPZItqadDYMnJ/KmaYlcVVSfZX+I7dAu0vN/2W8Rz6BdRJliiF1hN6qpWdC
	 yPC7gsoHjZyEMb1a+0YkRo2fscxXCwUuKdTd7HvMegN+bPKz9sN7gbt0UM0QcJ1gpo
	 s7teWbDKASoXtdAzzzhSq/R62LeYjV3uKCJBbFNEOvvVQZGOwz8XROiOXHKV4XBi+Y
	 H64N3eOSpo4Rg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76412CD3430;
	Mon,  4 May 2026 09:48:35 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 04 May 2026 11:48:27 +0200
Subject: [PATCH v4 15/17] iio: magnetometer: ak8975: unify messages with
 help of dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-magnetometer-fixes-v4-15-a291c2a7c71a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777888112; l=2364;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=D4aD3QXa789hKTdTDhB5MScOEW0jAsWOxyrjZ2UQS+w=;
 b=6N32LwsLjmDxnBC/w/lu8/5k/WIOAk53PKhxC5V0K8jdlijmx6SPIWDCkEmu/fqFrOPMMV5X9
 vsr78MZxfiiBDjY7KahVXpajsm0pQTrMVrIEZPVLdKb7TCFLxbItMhV
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Unify error messages that might appear during probe phase by
switching to use dev_err_probe().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 30 ++++++++++--------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 6fba20c613aa40b07771fe9d7ebfc29d8a2a2b7d..861a12ba8cfcc3724573b332b3f5bc243b67b1de 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -495,10 +495,8 @@ static int ak8975_who_i_am(const struct ak8975_data *data,
 							AK09912_REG_WIA1,
 							sizeof(wia_val),
 							wia_val);
-	if (ret < 0) {
-		dev_err(&client->dev, "Error reading WIA\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret, "Error reading WIA\n");
 
 	if (wia_val[0] != AK8975_DEVICE_ID)
 		return -ENODEV;
@@ -996,18 +994,14 @@ static int ak8975_probe(struct i2c_client *client)
 		return ret;
 
 	ret = ak8975_who_i_am(data, data->def->type);
-	if (ret) {
-		dev_err(&client->dev, "Unexpected device\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Unexpected device\n");
 	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
 
 	/* Perform some basic start-of-day setup of the device. */
 	ret = ak8975_setup(data);
-	if (ret) {
-		dev_err(&client->dev, "%s initialization fails\n", name);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "%s initialization fails\n", name);
 
 	ret = devm_mutex_init(dev, &data->lock);
 	if (ret)
@@ -1022,16 +1016,12 @@ static int ak8975_probe(struct i2c_client *client)
 
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      ak8975_handle_trigger, NULL);
-	if (ret) {
-		dev_err(&client->dev, "triggered buffer setup failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "triggered buffer setup failed\n");
 
 	ret = devm_iio_device_register(dev, indio_dev);
-	if (ret) {
-		dev_err(&client->dev, "device register failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "device register failed\n");
 
 	/* Enable runtime PM */
 	ret = devm_pm_runtime_enable(dev);

-- 
2.47.3


