Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794174254;
	b=bp1aN2vN6zgsohQxXNkPpOxarbuB/47f4Xq/G+6xQzt9fVtI3jwnacK3lq5agT9qcYqn
	 l+opBiTZnC30CzlsNfk9JyzviLqy4ZCp/twVL6XUHdJ/fXdjH01gAUc5jIackF7cQorBi
	 73TJISCcUzLLt7rbPOhbvdrBLKt9k063PgxqSF4gZZwWI3//wPwdIf8oSp2zfn0cnzQYw
	 ohjYPpQ+qeCbmr/3FfIg+a7fPay1Eqe3VyLS+49Gt+XIzTv/zihyFGANdUBvLhsXfZ7Im
	 g3asV4YxKpXyF4+usWmmwIM15W+bfTp7yj+fOFVkxTL/2plfAX60nm8y3sB/h1x0UxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794174254;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=d+jQ2dHrLpC84kMshJM1dXjLTtypFksgRBBoVBLKGFI=;
	b=drTCYs6jttDftdkGiV7T++6H4xoLxWoiXWAMQRJ6Rh3mtUWPJfLAdUqgUE2zisw+M8KA
	 S+0d5C2Lf5WxgitZOLqTR5KL2tXyyKcOCXb75PVzRZsk2NYakrnFjmsi3eiTNxMU6uCLk
	 ImqjxoXXDmHMrqYx8DGXXTm0/6mYaUNLKqmV4APHWAaC6qRrxeelMDdjkJW8c8I0oeUOf
	 0kzhXZpz70TThECWPSqyVDawfwTclk4PVZ3JxBYWSS7rBGN9B4hEqD7J2R3trP6LX4csr
	 QBQHG+hlZoJFHAnMw1zB/qYxUQXI6SxDXzGdooP1ZeHnDxAVdgTBM1bkNaNsfcXHcuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ma8za0/7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1788606A326;
	Sun,  8 Nov 2026 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ma8za0/7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FF01F008A2;
	Sun,  8 Nov 2026 21:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794174253;
	bh=d+jQ2dHrLpC84kMshJM1dXjLTtypFksgRBBoVBLKGFI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ma8za0/7WogNukv1yHeLogG5sTbjL4wZ1v1MXcu8o0BUPCXHhAkq+o91u2LTUZ+xQ
	 DYl5zb+iFWIN3XfDEHoQaYfPVu5QAdZmVaJyzJZuyk4Bg+N2u02xz9iuHDNLkhg9ga
	 6dSESYVt6P5eVT6HQq0zx7mI2uTYU2oKvFcjtgCyXU3QBLvr8Hlj8Ww6shWbnsyaLr
	 40+wZlYVq3Tzb27onMMidifkueyfIRu8LXSAN86dMBeanngx7Kk9A6r7KeB5Bcdj8d
	 7OopGC71QO0MN1u4Udc0U1F9pUCsA6tLN82cW/+3KenuHQbnziABFJBhJTN0nrg4Fr
	 9EcVMMotu3k0A==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 08 Nov 2026 22:44:02 +0100
Subject: [PATCH v2 4/5] iio: light: gp2ap020a00f: Prepare for chip variants
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261108-gp2ap030-v2-4-24eaa1b9fe59@kernel.org>
References: <20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org>
In-Reply-To: <20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org>
To: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kyungmin Park <kyungmin.park@samsung.com>
Cc: devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

Introduce chip data for the device name, initialization table and channel
layout, including the channel count. Use I2C/OF match data to select it
during probe, preparing for sensors with shared register layouts and
different initialization settings.

Populate only the GP2AP020A00F data, keeping its register values,
channels and operating behavior unchanged.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/iio/light/gp2ap020a00f.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index dc07d137f084..5464311515c7 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -234,7 +234,15 @@ enum gp2ap020a00f_thresh_val_id {
 	GP2AP020A00F_THRESH_PH,
 };
 
+struct gp2ap020a00f_chip_info {
+	const char *name;
+	const u8 *reg_init_tab;
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+};
+
 struct gp2ap020a00f_data {
+	const struct gp2ap020a00f_chip_info *chip_info;
 	struct i2c_client *client;
 	struct mutex lock;
 	char *buffer;
@@ -1309,6 +1317,13 @@ static const struct iio_chan_spec gp2ap020a00f_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(GP2AP020A00F_CHAN_TIMESTAMP),
 };
 
+static const struct gp2ap020a00f_chip_info gp2ap020a00f_chip_info = {
+	.name = "gp2ap020a00f",
+	.reg_init_tab = gp2ap020a00f_reg_init_tab,
+	.channels = gp2ap020a00f_channels,
+	.num_channels = ARRAY_SIZE(gp2ap020a00f_channels),
+};
+
 static const struct iio_info gp2ap020a00f_info = {
 	.read_raw = &gp2ap020a00f_read_raw,
 	.read_event_value = &gp2ap020a00f_read_event_val,
@@ -1401,7 +1416,6 @@ static const struct iio_buffer_setup_ops gp2ap020a00f_buffer_setup_ops = {
 
 static int gp2ap020a00f_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct device *dev = &client->dev;
 	struct gp2ap020a00f_data *data;
 	struct iio_dev *indio_dev;
@@ -1413,6 +1427,9 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	data = iio_priv(indio_dev);
+	data->chip_info = i2c_get_match_data(client);
+	if (!data->chip_info)
+		return -EINVAL;
 
 	err = devm_regulator_get_enable(dev, "vcc");
 	if (err)
@@ -1435,7 +1452,7 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 
 	/* Initialize device registers */
 	err = regmap_bulk_write(regmap, GP2AP020A00F_OP_REG,
-			gp2ap020a00f_reg_init_tab,
+			data->chip_info->reg_init_tab,
 			ARRAY_SIZE(gp2ap020a00f_reg_init_tab));
 
 	if (err < 0) {
@@ -1451,10 +1468,10 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
 	init_waitqueue_head(&data->data_ready_queue);
 
 	mutex_init(&data->lock);
-	indio_dev->channels = gp2ap020a00f_channels;
-	indio_dev->num_channels = ARRAY_SIZE(gp2ap020a00f_channels);
+	indio_dev->channels = data->chip_info->channels;
+	indio_dev->num_channels = data->chip_info->num_channels;
 	indio_dev->info = &gp2ap020a00f_info;
-	indio_dev->name = id->name;
+	indio_dev->name = data->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	/* Allocate buffer */
@@ -1530,13 +1547,14 @@ static void gp2ap020a00f_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id gp2ap020a00f_id[] = {
-	{ .name = "gp2ap020a00f" },
+	{ .name = "gp2ap020a00f",
+	  .driver_data = (kernel_ulong_t)&gp2ap020a00f_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, gp2ap020a00f_id);
 
 static const struct of_device_id gp2ap020a00f_of_match[] = {
-	{ .compatible = "sharp,gp2ap020a00f" },
+	{ .compatible = "sharp,gp2ap020a00f", .data = &gp2ap020a00f_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, gp2ap020a00f_of_match);

-- 
2.56.0

