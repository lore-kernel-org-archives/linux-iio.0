Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72103A545E;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777981562; cv=none; b=YfnQ7o0RpyUyBfNKemaskpytIPXIxCFebY7xWwUvMa77Fq0c4BK0mBOt4S/aKT6PIS+WvntcNym0sac+NYZKwR9f7v/zoVGzKuma3YxGxKG9uogZUdDG5VedxQy5yjbF9wGQo5y6U4SOe4K5h/JnfOyyW2VfKhGd+y40GFZifBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777981562; c=relaxed/simple;
	bh=Rpo5ezj3iTFoZ6Doy8L/NCVYOf5Mzo80aZhNp14VQ1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o88uSx4QGTyjegeAlAf6R0SKp8THGVKKXiGC3byLjGYgAHy82dUtlJM5GPTvSHXjKlqyNn22d+NWxZIJ95piMKr1Z30UHTQDCTt7skaj3ejgnkSjcv9BbHmeuTs8EJ6iEqLRWBgPeUg1YEh9cq72W2lBJ5O5UoF+NeBvYyQra6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGgjjhZE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGgjjhZE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 83A96C4AF0E;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777981562;
	bh=Rpo5ezj3iTFoZ6Doy8L/NCVYOf5Mzo80aZhNp14VQ1U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iGgjjhZEALw3BVRSiFOQXedZLgjkWaeAbdPZHFPhUCTziUEUpYw4R20mW2HWL94HE
	 OPkRs7vUJvvRXAQWpT051xeGclaazw4SHPzv4U9Hy8/P9EYdyaI4+rTdNal0DuOxw8
	 9JLIXxm0NkHHVhQdrDorP0X2q/EMozEROjiSy2lXa6sFR9D8H5IiJ2V8/GQbeztMDj
	 5SS3eP118CXYttjlCchSJ22M5T8xfEFjyuIUoWZ1pko1cKxzFW+iBr9PWhRnoVFO3n
	 W48uVMZX982xPLGGxCKZQp3chvio+7Wj8C5gmKQVJltXHQxkLRoHJCW470RgUfw+jX
	 CAygOaSUF5GKA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2AACD3436;
	Tue,  5 May 2026 11:46:02 +0000 (UTC)
From: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Date: Tue, 05 May 2026 13:46:09 +0200
Subject: [PATCH v5 13/18] iio: magnetometer: ak8975: unify return code
 variable name
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-magnetometer-fixes-v5-13-831b9b5550fc@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777981558; l=3874;
 i=joshua.crofts1@gmail.com; s=20260422; h=from:subject:message-id;
 bh=zJS2KqDDT1z1i5VXAW3dS5pr9tJ2+OIn3A8VgRS0jH0=;
 b=o/H8uQyzWX+bu56yNSMWhJHXkGlqLCQoAESUvP1L72fdjxyffrc70uYoQ/6rrz2TAyY75/KVc
 IcjIEjBxZPGCBVkcch/PvGI7+zHC3TnIvRzTs9dVO9KTpaBNhizSUCR
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=Xd+UVoRPiiI0K3LHQ2XIcXmO0jvVuFTv9eTx3lgBphI=
X-Endpoint-Received: by B4 Relay for joshua.crofts1@gmail.com/20260422 with
 auth_id=746
X-Original-From: Joshua Crofts <joshua.crofts1@gmail.com>
Reply-To: joshua.crofts1@gmail.com

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

In one case 'rc' is used in the other 'err', the most use 'ret'.
Make the latter use the former, id est 'ret'.

While at it, drop unneeded ' < 0' checks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/ak8975.c | 46 +++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index fd42e20cd145860bdd1b143409de24b7145f8252..1c05e380a4d4f968f505a7d5c0acbec86ad949e1 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -573,8 +573,8 @@ static irqreturn_t ak8975_irq_handler(int irq, void *data)
 static int ak8975_setup_irq(struct ak8975_data *data)
 {
 	struct i2c_client *client = data->client;
-	int rc;
 	int irq;
+	int ret;
 
 	init_waitqueue_head(&data->data_ready_queue);
 	clear_bit(0, &data->flags);
@@ -583,15 +583,15 @@ static int ak8975_setup_irq(struct ak8975_data *data)
 	else
 		irq = gpiod_to_irq(data->eoc_gpiod);
 
-	rc = devm_request_irq(&client->dev, irq, ak8975_irq_handler,
-			      IRQF_TRIGGER_RISING,
-			      dev_name(&client->dev), data);
-	if (rc < 0)
-		return rc;
+	ret = devm_request_irq(&client->dev, irq, ak8975_irq_handler,
+			       IRQF_TRIGGER_RISING,
+			       dev_name(&client->dev), data);
+	if (ret)
+		return ret;
 
 	data->eoc_irq = irq;
 
-	return rc;
+	return 0;
 }
 
 /*
@@ -907,8 +907,8 @@ static int ak8975_probe(struct i2c_client *client)
 	struct iio_dev *indio_dev;
 	struct gpio_desc *eoc_gpiod;
 	struct gpio_desc *reset_gpiod;
-	int err;
 	const char *name = NULL;
+	int ret;
 
 	/*
 	 * Grab and set up the supplied GPIO.
@@ -943,9 +943,9 @@ static int ak8975_probe(struct i2c_client *client)
 	data->reset_gpiod = reset_gpiod;
 	data->eoc_irq = 0;
 
-	err = iio_read_mount_matrix(&client->dev, &data->orientation);
-	if (err)
-		return err;
+	ret = iio_read_mount_matrix(&client->dev, &data->orientation);
+	if (ret)
+		return ret;
 
 	/* id will be NULL when enumerated via ACPI */
 	data->def = i2c_get_match_data(client);
@@ -966,20 +966,20 @@ static int ak8975_probe(struct i2c_client *client)
 	if (IS_ERR(data->vid))
 		return PTR_ERR(data->vid);
 
-	err = ak8975_power_on(data);
-	if (err)
-		return err;
+	ret = ak8975_power_on(data);
+	if (ret)
+		return ret;
 
-	err = ak8975_who_i_am(client, data->def->type);
-	if (err < 0) {
+	ret = ak8975_who_i_am(client, data->def->type);
+	if (ret) {
 		dev_err(&client->dev, "Unexpected device\n");
 		goto power_off;
 	}
 	dev_dbg(&client->dev, "Asahi compass chip %s\n", name);
 
 	/* Perform some basic start-of-day setup of the device. */
-	err = ak8975_setup(client);
-	if (err < 0) {
+	ret = ak8975_setup(client);
+	if (ret) {
 		dev_err(&client->dev, "%s initialization fails\n", name);
 		goto power_off;
 	}
@@ -992,15 +992,15 @@ static int ak8975_probe(struct i2c_client *client)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->name = name;
 
-	err = iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle_trigger,
+	ret = iio_triggered_buffer_setup(indio_dev, NULL, ak8975_handle_trigger,
 					 NULL);
-	if (err) {
+	if (ret) {
 		dev_err(&client->dev, "triggered buffer setup failed\n");
 		goto power_off;
 	}
 
-	err = iio_device_register(indio_dev);
-	if (err) {
+	ret = iio_device_register(indio_dev);
+	if (ret) {
 		dev_err(&client->dev, "device register failed\n");
 		goto cleanup_buffer;
 	}
@@ -1023,7 +1023,7 @@ static int ak8975_probe(struct i2c_client *client)
 	iio_triggered_buffer_cleanup(indio_dev);
 power_off:
 	ak8975_power_off(data);
-	return err;
+	return ret;
 }
 
 static void ak8975_remove(struct i2c_client *client)

-- 
2.47.3


