Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7241E3CF661;
	Mon, 18 May 2026 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090641; cv=none; b=BC43JaQ0IjGQNtGhoiTnWia2JmdGr+ntCr9hQ3N7VSl81uMhIZ44DkWFFP1/VxhOXj5fUfhfqgTXUlYoGU8NoXWBYhl9mpS/wrpX/EHTxxlcNPAcZvhe/3HxJ+45EqlB/q9E0chDYPZX0F0R5yzn8OCnJ9pK6UawmpLhW+Xobhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090641; c=relaxed/simple;
	bh=mGXE+EiZgClXKlHPEe60/woCdIm+nCYs9yjo0CMy4PA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R1Yl4tHs5+umak8XZGOHKxFjStJZKdCXLm3gnxG/zrVjw3d3FniLpcPmI4uh47PjIisqJlAJRqtycKy+KZlnA1O69xfHoYMoQtbaMMNnFQOQOtBfyh+1BrjNWHcyKhHEAjoBq7XrzqhWxvXDAkgrZIrmj9QdZl/CHoabo/+512E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcuBizfE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcuBizfE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38413C2BCC6;
	Mon, 18 May 2026 07:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779090640;
	bh=mGXE+EiZgClXKlHPEe60/woCdIm+nCYs9yjo0CMy4PA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=JcuBizfEo5vGFkOg4NbHdzGN/DglyFNQusdz5Na2P5RSmoai4ZWRvH7+CnJiSias/
	 2UrPJnTHyUGqpKr6+OjlrCJ9f4g9/jRxvt97LYRCNcYuRM9kmr1JOZsz8hU6ewKqS7
	 mSD57ygid65nzS0PyllxMeuS+GFbNVmjxt3vjq0QmK5J7E+UmX8X0fW4/27wX3BAGK
	 WGeY+sgjkXVb6p21LhumsxWM9GaHoLNid1KgDiTb2Zxf4n+T3J6qYWV+GV8srVg1Sn
	 JLwVX2pGjtwju5+H3B+P2TcirlhlRUeJ7RQJm6zFJeK3pthJyjcG5Us7wYvfYXDTRS
	 ONo0e5hDM39TQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3FDCD4F52;
	Mon, 18 May 2026 07:50:40 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Mon, 18 May 2026 09:50:26 +0200
Subject: [PATCH v8 2/5] iio: magnetometer: ak8975: unify messages with help
 of dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260518-magnetometer-fixes-post-pickup-v8-2-088d610108a0@gmail.com>
References: <20260518-magnetometer-fixes-post-pickup-v8-0-088d610108a0@gmail.com>
In-Reply-To: <20260518-magnetometer-fixes-post-pickup-v8-0-088d610108a0@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779090640; l=2737;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=2kbW615Mv/xUTO+xPzb4dUlB6TkMmy9QpDavmVUaJbY=;
 b=I4XXT7/pz1eAh0xTKhSW6xAzWYqVEw1N9TltuBLfxUgXME7G+Nlc6wv2zFBXxHxQdv9eVaQ3L
 kH4+ZFe6zCDD4vGXwLRGpfejH4luAUM+Eds/qtVa8bRkHRqMp+WcerW
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
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index de4402201783430fc69369f1accaab35145e9f0c..e7cd28ab37aaeb2b68758a42ba40a87c71bd1e24 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -495,14 +495,10 @@ static int ak8975_who_i_am(const struct ak8975_data *data,
 							AK09912_REG_WIA1,
 							sizeof(wia_val),
 							wia_val);
-	if (ret < 0) {
-		dev_err(&client->dev, "Error reading WIA\n");
-		return ret;
-	}
-	if (ret != sizeof(wia_val)) {
-		dev_err(&client->dev, "Error reading WIA\n");
-		return -EIO;
-	}
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret, "Error reading WIA\n");
+	if (ret != sizeof(wia_val))
+		return dev_err_probe(&client->dev, -EIO, "Error reading WIA\n");
 
 	if (wia_val[0] != AK8975_DEVICE_ID)
 		return -ENODEV;
@@ -1033,18 +1029,15 @@ static int ak8975_probe(struct i2c_client *client)
 		return ret;
 
 	ret = ak8975_who_i_am(data, data->def->type);
-	if (ret) {
-		dev_err(&client->dev, "Unexpected device\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Unexpected device\n");
+
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
@@ -1060,20 +1053,16 @@ static int ak8975_probe(struct i2c_client *client)
 	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 					      ak8975_handle_trigger,
 					      &ak8975_buffer_setup_ops);
-	if (ret) {
-		dev_err(&client->dev, "triggered buffer setup failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "triggered buffer setup failed\n");
 
 	ret = devm_pm_runtime_enable(dev);
 	if (ret)
 		return ret;
 
 	ret = devm_iio_device_register(dev, indio_dev);
-	if (ret) {
-		dev_err(&client->dev, "device register failed\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "device register failed\n");
 
 	/*
 	 * The device comes online in 500us, so add two orders of magnitude

-- 
2.47.3


