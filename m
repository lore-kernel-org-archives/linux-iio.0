Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6EE3A16B6
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141226; cv=none; b=jDcdse6VwMjNVIO1VemKmqT+rpwCqUrIIv+9HrodpSDW6WKNoaign19wqZXFSkSnu3+ppwtzw8UxUvN9RoWCFA5v2raPurKuQPP1PPkWB/DxE68EeaFLthV0+oy+HkqHhHYfL7MndVQQgLuWxAMyJsE39Yjqg0qLj0RxiA/5Tms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141226; c=relaxed/simple;
	bh=X7ToDL1mD2pV/uPGqeAfSsw/jzNwbMunFKSKazMXyK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRkMXsgpSZdJidE5UHtYY48OjsHlqlkpQ99ZtFkC/EqHw4tKFP3txOI+UyxIbFTvPcq12J95zdZ70xCZc8t4CUCDg+htWjTNf6H3eR0BSCgj0q3EIvcjtJsXJ6em4nvDy3/HOKZMl6UtgoCwSNWDPAg4R/Y/mJWXg3lUPSblZ4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sqDyIa2r; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sqDyIa2r"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-835386ff122so14447624b3a.3
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 04:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780141224; x=1780746024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rD71LnEcxrWgkmwxQhljbsgghJc7itjZTY4QeFA4Yo=;
        b=sqDyIa2rpkQAkRhmP7/Eb/AFHUMGx6zDdUTW240T/rqEzztPBNNY0C2Cj3uAPG+P4o
         telBXq8R63GOwxPXw2G33h/e7FnjSyI9qngOuuliiuIMfbxLUrGzOCv/3xdqC13P5AY9
         uQHZuTWr6xiZFN9GPBN1rjO1H7pEKv/lGUblRIH8GcV7r9OT1ByWFlFElkN7wsQOO0MT
         botKICdwFlRDDItbSaKUDPvYHYWXNZimTKfYEkK/eLM2RlIt8PuiCKeqjssIxT/5Zp7U
         wB8hpWA2FZiqA35zxDcJr4djs2RyuFeHdNJvBG1DDRlD6NMwGpHAyzW/NSBnDaZN7EfD
         a5rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780141224; x=1780746024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0rD71LnEcxrWgkmwxQhljbsgghJc7itjZTY4QeFA4Yo=;
        b=EZZXYJVS0QFUfCQPvWM+Cww6vd6lgO/DHiw1aqXo/r5MnXdOuuCW+rXQeQdsVxKtxJ
         gyNsXIl/stU4okgo8yLcGNAvcqdEF6ozaBRKYHm5uWQ6W6L2W56D9ivyKJ81Jfb1muhh
         R2pIZB3TAf8oxYWavCKtSHU7U+4ktdQua7EN75MS+jjCTjmq/xzNMA+iZBMVi6h5qjB5
         dHkhhcK+sJHPniVBO7I0D2hQDEB+ECQYgM1gbvd+0pe5Ckn7FzrUJKe62vGxmKjxMC8j
         ycXIzkAnCSZwiPcqKdaj/nXbEMY+NAxsYWNDbyxH7b0Ovza/Ta6DCH+Wwd9TCdU8hSyX
         9wAA==
X-Forwarded-Encrypted: i=1; AFNElJ+ZyTKmqLPoOnXzgJyedN3bIDYLVZgrhh4YVhD4zlWsoaREIKaF49HV97AAZk+TEHLZmHqfzI94Liw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDXLUFSIUWqmqdlflUCsDJ4ueONZuWcv1aoOdb8UhEpz5rVp5O
	ywDFhIM0N8Wo4aSW/YA2WFW+co0ijj6cf/Uk4ZGEEgv2q4BCA4BW1x32
X-Gm-Gg: Acq92OHAvEstjemTT8CaZVBM05uOUbSKHqC6EEZdBxts0nr2nCuxHIIskV+5gbeht94
	B0XAgqjJoR/3ifGxn5OxF6pf2mY5Aq7SwrdNAYjORWfaYC83SHeLfqNBJV/b/mriSopMF0MHIQX
	QuHpaldbX/BQzxYt3mOnQUEv2slAekQ49fl2UwGuzpLVMFYJRMpyTxc9UqKTaXAOZGa4vbUkPlu
	YKdDHZdTpYH1YCJaMaL3afBj5we8F3liC+y1WCuBNHTK9l25Kixc2oZTVw2Roy9b8GrhLcozkji
	Uy1jYSFwSkUIiu6khWkF0HweTKqks6ZPBqvz5y5gu90ImMfjedW1KeEyemdC4VhrjtByFmaKLZs
	+zIJDlqAO71ehwtr5wvCtZwZEEdFUdXtVC3g4LylK09Wr8jejUV64ne4fHrlWdtWL4FMH2U8ybE
	WYxNbUCSNngBGBtTQV4W3y54IDq9R+BFyz01HFJ3capk9U2F7Cl6oEeCXFFQ==
X-Received: by 2002:a05:6a00:1f1a:b0:83d:446c:498f with SMTP id d2e1a72fcca58-84225478b3amr3055273b3a.32.1780141223796;
        Sat, 30 May 2026 04:40:23 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84214b6797esm5467518b3a.26.2026.05.30.04.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 04:40:23 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	apokusinski01@gmail.com,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH 4/4] iio: pressure: mpl3115: add hardware FIFO support
Date: Sat, 30 May 2026 20:39:38 +0900
Message-ID: <20260530113938.171540-5-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260530113938.171540-1-suunj1331@gmail.com>
References: <20260530113938.171540-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the MPL3115A2 hardware FIFO.

The device provides a 32-sample FIFO with configurable
watermark interrupts, allowing buffered data acquisition
with reduced interrupt and CPU overhead.

Use a kfifo-backed IIO buffer when a DRDY interrupt and
SMBus block reads are available, falling back to the
existing triggered buffer implementation otherwise.

When enabled, the driver configures the FIFO in circular
mode and drains accumulated samples on watermark
interrupts.

Overflow conditions are handled by flushing available
samples before resetting the FIFO, avoiding unnecessary
data loss.

The hardware always captures pressure and temperature
samples together, so FIFO operation requires both channels
to be enabled.

Register cache updates are performed only after successful
I2C writes to keep cached and hardware state consistent.

No functional change for non-buffered operation.

Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 drivers/iio/pressure/mpl3115.c | 266 +++++++++++++++++++++++++++++++--
 1 file changed, 256 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
index 90e83e34ec43..26b6490c8c4c 100644
--- a/drivers/iio/pressure/mpl3115.c
+++ b/drivers/iio/pressure/mpl3115.c
@@ -6,7 +6,7 @@
  *
  * (7-bit I2C slave address 0x60)
  *
- * TODO: FIFO buffer, altimeter mode, oversampling, continuous mode,
+ * TODO: altimeter mode, oversampling, continuous mode,
  * user offset correction, raw mode
  */
 
@@ -22,6 +22,7 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/kfifo_buf.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
@@ -31,6 +32,8 @@
 #define MPL3115_OUT_PRESS 0x01 /* MSB first, 20 bit */
 #define MPL3115_OUT_TEMP 0x04 /* MSB first, 12 bit */
 #define MPL3115_WHO_AM_I 0x0c
+#define MPL3115_F_STATUS 0x0d
+#define MPL3115_F_SETUP 0x0f
 #define MPL3115_INT_SOURCE 0x12
 #define MPL3115_PT_DATA_CFG 0x13
 #define MPL3115_PRESS_TGT 0x16 /* MSB first, 16 bit */
@@ -47,9 +50,32 @@
 #define MPL3115_STATUS_TEMP_RDY BIT(1)
 
 #define MPL3115_INT_SRC_DRDY BIT(7)
+#define MPL3115_INT_SRC_FIFO BIT(6)
 #define MPL3115_INT_SRC_PTH BIT(3)
 #define MPL3115_INT_SRC_TTH BIT(2)
 
+#define MPL3115_F_STATUS_F_OVF BIT(7)
+#define MPL3115_F_STATUS_F_CNT GENMASK(5, 0)
+
+#define MPL3115_F_SETUP_F_MODE GENMASK(7, 6)
+#define MPL3115_F_SETUP_F_WMRK GENMASK(5, 0)
+
+enum mpl3115_fifo_mode {
+	MPL3115_F_MODE_DISABLED = 0,
+	MPL3115_F_MODE_CIRCULAR = 1,
+};
+
+#define MPL3115_FIFO_SIZE 32
+#define MPL3115_FIFO_SAMPLE_SIZE 5
+#define MPL3115_DEFAULT_WATERMARK 1
+
+#define MPL3115_BUF_PRESS_OFFSET 0
+#define MPL3115_BUF_TEMP_OFFSET 4
+#define MPL3115_BUF_TS_OFFSET 8
+#define MPL3115_BUF_SIZE (MPL3115_BUF_TS_OFFSET + sizeof(s64))
+
+#define MPL3115_FIFO_SAMPLES_PER_READ 6U
+
 #define MPL3115_PT_DATA_EVENT_ALL GENMASK(2, 0)
 
 #define MPL3115_CTRL1_RESET BIT(2) /* software reset */
@@ -63,8 +89,12 @@
 #define MPL3115_CTRL3_IPOL2 BIT(1)
 
 #define MPL3115_CTRL4_INT_EN_DRDY BIT(7)
+#define MPL3115_CTRL4_INT_EN_FIFO BIT(6)
 #define MPL3115_CTRL4_INT_EN_PTH BIT(3)
 #define MPL3115_CTRL4_INT_EN_TTH BIT(2)
+#define MPL3115_CTRL4_ACTIVE_MASK \
+	(MPL3115_CTRL4_INT_EN_DRDY | \
+	 MPL3115_CTRL4_INT_EN_PTH | MPL3115_CTRL4_INT_EN_TTH)
 
 #define MPL3115_CTRL5_INT_CFG_DRDY BIT(7)
 #define MPL3115_CTRL5_INT_CFG_FIFO BIT(6)
@@ -94,6 +124,9 @@ struct mpl3115_data {
 	struct mutex lock;
 	u8 ctrl_reg1;
 	u8 ctrl_reg4;
+	u8 watermark;
+	u8 fifo_buf[MPL3115_FIFO_SIZE * MPL3115_FIFO_SAMPLE_SIZE]
+		__aligned(IIO_DMA_MINALIGN);
 };
 
 enum mpl3115_irq_pin {
@@ -101,6 +134,25 @@ enum mpl3115_irq_pin {
 	MPL3115_IRQ_INT2,
 };
 
+static int mpl3115_set_active(struct mpl3115_data *data, bool active)
+{
+	u8 reg;
+	int ret;
+
+	if (active)
+		reg = data->ctrl_reg1 | MPL3115_CTRL1_ACTIVE;
+	else
+		reg = data->ctrl_reg1 & ~MPL3115_CTRL1_ACTIVE;
+
+	ret = i2c_smbus_write_byte_data(data->client, MPL3115_CTRL_REG1,
+					reg);
+	if (ret)
+		return ret;
+
+	data->ctrl_reg1 = reg;
+	return 0;
+}
+
 static int mpl3115_request(struct mpl3115_data *data)
 {
 	int ret, tries = 15;
@@ -322,6 +374,109 @@ static irqreturn_t mpl3115_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static int mpl3115_set_fifo(struct mpl3115_data *data,
+			    enum mpl3115_fifo_mode mode)
+{
+	u8 f_setup;
+
+	f_setup = FIELD_PREP(MPL3115_F_SETUP_F_MODE, mode) |
+		  FIELD_PREP(MPL3115_F_SETUP_F_WMRK, data->watermark);
+
+	return i2c_smbus_write_byte_data(data->client, MPL3115_F_SETUP,
+			f_setup);
+}
+
+static int mpl3115_fifo_reset(struct mpl3115_data *data)
+{
+	int ret;
+
+	ret = mpl3115_set_fifo(data, MPL3115_F_MODE_DISABLED);
+	if (ret)
+		return ret;
+
+	return mpl3115_set_fifo(data, MPL3115_F_MODE_CIRCULAR);
+}
+
+static int mpl3115_fifo_transfer(struct mpl3115_data *data,
+				 unsigned int sample_count)
+{
+	unsigned int remaining = sample_count;
+	unsigned int offset = 0;
+	unsigned int batch;
+	int ret;
+
+	while (remaining > 0) {
+		batch = min(remaining, MPL3115_FIFO_SAMPLES_PER_READ);
+
+		ret = i2c_smbus_read_i2c_block_data(data->client,
+						    MPL3115_OUT_PRESS,
+						    batch * MPL3115_FIFO_SAMPLE_SIZE,
+						    &data->fifo_buf[offset]);
+		if (ret < 0)
+			return ret;
+		if (ret != batch * MPL3115_FIFO_SAMPLE_SIZE)
+			return -EIO;
+
+		offset += batch * MPL3115_FIFO_SAMPLE_SIZE;
+		remaining -= batch;
+	}
+
+	return 0;
+}
+
+static int mpl3115_fifo_flush(struct iio_dev *indio_dev)
+{
+	struct mpl3115_data *data = iio_priv(indio_dev);
+	u8 buffer[MPL3115_BUF_SIZE] __aligned(sizeof(s64)) = { };
+	unsigned int sample_count, i;
+	int ret;
+	bool overflow;
+	s64 ts;
+
+	ret = i2c_smbus_read_byte_data(data->client, MPL3115_F_STATUS);
+	if (ret < 0)
+		return ret;
+
+	overflow = FIELD_GET(MPL3115_F_STATUS_F_OVF, ret);
+	sample_count = FIELD_GET(MPL3115_F_STATUS_F_CNT, ret);
+	if (sample_count == 0)
+		return overflow ? mpl3115_fifo_reset(data) : 0;
+
+	ret = mpl3115_fifo_transfer(data, sample_count);
+	if (ret)
+		return ret;
+
+	ts = iio_get_time_ns(indio_dev);
+	for (i = 0; i < sample_count; i++) {
+		u8 *sample = &data->fifo_buf[i * MPL3115_FIFO_SAMPLE_SIZE];
+
+		memcpy(&buffer[MPL3115_BUF_PRESS_OFFSET], &sample[0], 3);
+		memcpy(&buffer[MPL3115_BUF_TEMP_OFFSET], &sample[3], 2);
+
+		iio_push_to_buffers_with_ts(indio_dev, buffer, sizeof(buffer), ts);
+	}
+
+	if (overflow) {
+		dev_warn_ratelimited(&data->client->dev,
+				     "FIFO overflow, samples may be lost\n");
+		return mpl3115_fifo_reset(data);
+	}
+
+	return 0;
+}
+
+static int mpl3115_set_watermark(struct iio_dev *indio_dev, unsigned int value)
+{
+	struct mpl3115_data *data = iio_priv(indio_dev);
+
+	value = clamp_val(value, 1, MPL3115_FIFO_SIZE - 1);
+
+	guard(mutex)(&data->lock);
+	data->watermark = value;
+
+	return 0;
+}
+
 static int mpl3115_config_interrupt(struct mpl3115_data *data,
 				    u8 ctrl_reg1, u8 ctrl_reg4)
 {
@@ -348,6 +503,67 @@ static int mpl3115_config_interrupt(struct mpl3115_data *data,
 	return ret;
 }
 
+static int mpl3115_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct mpl3115_data *data = iio_priv(indio_dev);
+	u8 ctrl_reg4;
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	ret = mpl3115_set_active(data, false);
+	if (ret)
+		return ret;
+
+	ret = mpl3115_set_fifo(data, MPL3115_F_MODE_CIRCULAR);
+	if (ret) {
+		mpl3115_set_active(data, true);
+		return ret;
+	}
+
+	ctrl_reg4 = data->ctrl_reg4;
+	ctrl_reg4 |= MPL3115_CTRL4_INT_EN_FIFO;
+	ctrl_reg4 &= ~MPL3115_CTRL4_INT_EN_DRDY;
+
+	return mpl3115_config_interrupt(data,
+		data->ctrl_reg1 | MPL3115_CTRL1_ACTIVE, ctrl_reg4);
+}
+
+static int mpl3115_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct mpl3115_data *data = iio_priv(indio_dev);
+	u8 ctrl_reg1, ctrl_reg4;
+	int ret;
+
+	guard(mutex)(&data->lock);
+
+	ret = mpl3115_set_active(data, false);
+	if (ret)
+		return ret;
+
+	ret = mpl3115_set_fifo(data, MPL3115_F_MODE_DISABLED);
+	if (ret)
+		return ret;
+
+	ctrl_reg4 = data->ctrl_reg4 & ~MPL3115_CTRL4_INT_EN_FIFO;
+	ctrl_reg1 = data->ctrl_reg1;
+
+	if (ctrl_reg4 & MPL3115_CTRL4_ACTIVE_MASK)
+		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
+
+	return mpl3115_config_interrupt(data, ctrl_reg1, ctrl_reg4);
+}
+
+static const struct iio_buffer_setup_ops mpl3115_buffer_ops = {
+	.postenable = mpl3115_buffer_postenable,
+	.predisable = mpl3115_buffer_predisable,
+};
+
+static const unsigned long mpl3115_scan_masks[] = {
+	BIT(0) | BIT(1),
+	0,
+};
+
 static const struct iio_event_spec mpl3115_temp_press_event[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
@@ -409,10 +625,19 @@ static irqreturn_t mpl3115_interrupt_handler(int irq, void *private)
 	if (ret < 0)
 		return IRQ_NONE;
 
-	if (!(ret & (MPL3115_INT_SRC_TTH | MPL3115_INT_SRC_PTH |
-		     MPL3115_INT_SRC_DRDY)))
+	if (!(ret & (MPL3115_INT_SRC_FIFO | MPL3115_INT_SRC_TTH |
+		     MPL3115_INT_SRC_PTH | MPL3115_INT_SRC_DRDY)))
 		return IRQ_NONE;
 
+	if (ret & MPL3115_INT_SRC_FIFO) {
+		int flush_ret;
+
+		scoped_guard(mutex, &data->lock)
+			flush_ret = mpl3115_fifo_flush(indio_dev);
+		if (flush_ret < 0)
+			goto err_reset_fifo;
+	}
+
 	if (ret & MPL3115_INT_SRC_DRDY)
 		iio_trigger_poll_nested(data->drdy_trig);
 
@@ -444,6 +669,11 @@ static irqreturn_t mpl3115_interrupt_handler(int irq, void *private)
 	}
 
 	return IRQ_HANDLED;
+
+err_reset_fifo:
+	scoped_guard(mutex, &data->lock)
+		mpl3115_fifo_reset(data);
+	return IRQ_HANDLED;
 }
 
 static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool state)
@@ -618,6 +848,7 @@ static const struct iio_info mpl3115_info = {
 	.write_event_config = mpl3115_write_event_config,
 	.read_event_value = mpl3115_read_thresh,
 	.write_event_value = mpl3115_write_thresh,
+	.hwfifo_set_watermark = mpl3115_set_watermark,
 };
 
 static int mpl3115_trigger_probe(struct mpl3115_data *data,
@@ -723,6 +954,7 @@ static int mpl3115_probe(struct i2c_client *client)
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct mpl3115_data *data;
 	struct iio_dev *indio_dev;
+	bool use_fifo;
 	int ret;
 
 	ret = i2c_smbus_read_byte_data(client, MPL3115_WHO_AM_I);
@@ -762,17 +994,31 @@ static int mpl3115_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	data->watermark = MPL3115_DEFAULT_WATERMARK;
+
 	ret = mpl3115_trigger_probe(data, indio_dev);
 	if (ret)
 		return ret;
 
-	ret = devm_iio_triggered_buffer_setup(&client->dev,
-				      indio_dev,
-				      NULL,
-				      mpl3115_trigger_handler,
-				      NULL);
-	if (ret)
-		return ret;
+	use_fifo = data->drdy_trig &&
+	   i2c_check_functionality(client->adapter,
+				   I2C_FUNC_SMBUS_READ_I2C_BLOCK);
+
+	if (use_fifo) {
+		indio_dev->available_scan_masks = mpl3115_scan_masks;
+		ret = devm_iio_kfifo_buffer_setup(&client->dev, indio_dev,
+						  &mpl3115_buffer_ops);
+		if (ret)
+			return ret;
+	} else {
+		ret = devm_iio_triggered_buffer_setup(&client->dev,
+						      indio_dev,
+						      NULL,
+						      mpl3115_trigger_handler,
+						      NULL);
+		if (ret)
+			return ret;
+	}
 
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
-- 
2.52.0

