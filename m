Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2E235E929
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 04:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791694684; cv=none; b=Gd3+s6P1n2OkfjRA+VN9XGg0gSlkEoezMY87xmZra3Uvo8EVYiUfkAABzvx0htgjSADTsiReDIVEFDMaBL8n+IuXC+Iz9GABZTtN0QHEm/Hdx+g4PoffVWEVvLLWHuJkcik4ZyulHGPQFHg4q+T7Feg+KZgySvzLKIVHiVSuItc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791694684; c=relaxed/simple;
	bh=xkS8M4l2w1WFAhmOfNI73nhqeFMjm4NxPGA8pTC2vS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NNKYyKzNiv/+B+8fH2/uCqLmMcYvjjh7FhDEWkpI7/fjv1zFnYfgdYVY2lVbPigKIs3QrhSuHjjWU1B8OdU5kto4Z6wSkt07ajdQmCnqaN5GtOjrBa1pdciSirz5ZYx8HMYNxJ3yWjgIt/DYNVLEAIdaLdUQuw80mWPTCLADfic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q1M7DLQ/; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q1M7DLQ/"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-356b1e20700so1240825eec.1
        for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 21:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791694682; x=1792299482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PlBNtjJaQI29T4Fj8iplz4IyL89FE26M9Rd4i6F+2vc=;
        b=q1M7DLQ/vjf3NI+xA6y114NoOQXG198jHF4SVxo91eN3FlZDEYsf5SAV1TS/IhYjfM
         AcwHmrUC1nC3qK6/t7KQP4Ofo206xvJtRZtA0Zgm9Sy91HUIQ4A3Ih/PugSwK43QdsXg
         z3Rd0hI+GNhyUhFL8Tx346tzs+bIl0gByS5yXdZp+w005X4XV6x9bLZ9HOPRBmnR5Jh9
         9TQyac8oS0jUbj0kpw2sE0hhLuhpzYjpA6EmMPqyEquuqfSTX1/nSL0yXhJtM7mwnBc8
         Nohag200BNjvdggw46nWrO4OEulJ+0QsFf2OThWLLGC2VN4qKQKPissaHtstvxLpUN7N
         LW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791694682; x=1792299482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PlBNtjJaQI29T4Fj8iplz4IyL89FE26M9Rd4i6F+2vc=;
        b=2Yp2DtaBXzg2+0TiHXmiracgRuum7nDHMD85KOKhldYyjSBsR/YP+5BAJS03nDbftx
         WvZS0VLtVWCBtBUaXQ+rJyclUfSZsKTFq+ZobRjT2epkQqSLDf0vUV8XV3fT5sHctTLP
         tRmRM8fkeMu/qV9HCTgrFP42ZsC6qTwE6mCP788ilfQkIrLVgJJLZfcHylaq3PaooMAT
         yHZOaAszuuP8AcbXuhpFDDTkmrJvZ5QH3uW8baeHUb+7gZlYRLPk0t25ju9P1zvpWJY2
         HwAqyEfVzi3Am0CSkHWsEngrXrY3853J6xDzzFOP3XMtvYkwSRhuRsrzutv6bsqYB2vK
         wDhA==
X-Forwarded-Encrypted: i=1; AKwUvByA/HbZkUK4uU4MzjjC7K6u9FBV6qH3YtPMqcZfMHDVYIkkmvGpmW+VZggZ0wqamH5/yzFSKVJkvCI=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+GgQ5cg2ukgEd/CHvArrxYrFcfnC+LeSfEgYJ+FK1x6vQ5FWl
	Av12UQkW9az9P4R6ZwWFZOkthWH/PWpXCVRlwEXokuEFsS+k4ufZ1H6Q
X-Gm-Gg: AYBFou09xCdb4LckP/Oi10HfGA8WVUWZrGzyGHBSdu6QYIU+w74F+7zB9upxr4n4Lx3
	D8OXsetC6tsdkJ/eY21gckIFV8ehM/V3austFUvj2B3VKqIcneMa2n09B+5+5BZNhe7qoi1N/Sx
	UwnlRkHcy7OUQks1KGSlwO/stGPKA6jG2zpE+9SBXbLqz0dtuYQUXNghfax7gW9NjPke//hhjPe
	jJ1VgjamLkLe/fWYQqoI4YU26pQcsqWewhtC8ibjLzxqWQ2YNpEnyHWFCSnUNPsyD2pbXM1Nviu
	F7hNAspaxwvlHYWOkV1wMBrD7NU+j+61xeF5du+BUxgoSPNeROV4fB9joW8FecEqzzeq14kxuwT
	rY08SUXJkzikGneYmJcN9jS8rswFffm2PC/GvhoDkHVL1vXrSW79xJ2ZMY5fE/diPjF+DEqK32X
	XN986dmJzgkVhUhmkyQwgQC9HY3Z9gSqa3ZY+IbwU8XB+Ymswx3fH9Ktr1YnMymE0QwZkGQvcir
	wAgFI0TXNyEQWeqz2/B6b9609L+03hBPMuSm4dKt+tCvtsDkTGUt4DPq8i745m9xS5fpG1sjEZZ
	lRuVpFrC/2K8saEXJWptO/gLBn9+Qr8=
X-Received: by 2002:a05:7022:28d:10b0:15d:d7a2:3a88 with SMTP id a92af1059eb24-16a5dbfdef7mr7612123c88.18.1791694681466;
        Sat, 10 Oct 2026 21:58:01 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.212])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a6021e49sm18649135c88.20.2026.10.10.21.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 21:58:01 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH] iio: imu: inv_mpu6050: fix kernel-doc warnings
Date: Sun, 11 Oct 2026 10:27:49 +0530
Message-ID: <20261011045754.358335-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scripts/kernel-doc -Wall reports several warnings for the inv_mpu6050
driver:

- inv_mpu_magn_get_scale() only describes @st, not @chan, @val and @val2.
- Eight functions use "Returns ..." in the body instead of a "Return:"
  section, and inv_mpu6050_set_enable() and
  inv_mpu_data_rdy_trigger_set_state() do not describe their return
  value at all, e.g.:

    Warning: .../inv_mpu_aux.c:87 No description found for return value
    of 'inv_mpu_aux_init'

- int_pin_cfg in struct inv_mpu6050_reg_map is documented with a ';'
  instead of a ':' after the name, so kernel-doc does not see it, and
  user_ctrl in struct inv_mpu6050_chip_config and startup_time in
  struct inv_mpu6050_hw are not documented.

Describe the missing parameters, members and return values, and convert
the return value descriptions to "Return:" sections. Where the return
value was described before the long description, move it after it, so
the description is not parsed as part of the return value section.

With this change, scripts/kernel-doc -Wall reports no warnings for
drivers/iio/imu/inv_mpu6050/. Comment-only change.

Assisted-by: LLM
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Comment-only change, checked with scripts/kernel-doc -Wall.

 drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c     |  6 +++---
 drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c     |  2 +-
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h     |  4 +++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c    | 14 +++++++-------
 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h    |  5 ++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c |  4 ++++
 6 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
index 970cf5c47f68..d40d53eef8ed 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_aux.c
@@ -82,7 +82,7 @@ static int inv_mpu_i2c_master_xfer(const struct inv_mpu6050_state *st)
  * inv_mpu_aux_init() - init i2c auxiliary bus
  * @st: driver internal state
  *
- * Returns 0 on success, a negative error code otherwise.
+ * Return: 0 on success, a negative error code otherwise.
  */
 int inv_mpu_aux_init(const struct inv_mpu6050_state *st)
 {
@@ -130,7 +130,7 @@ int inv_mpu_aux_init(const struct inv_mpu6050_state *st)
  * @val: buffer for storing read bytes
  * @size: number of bytes to read
  *
- *  Returns 0 on success, a negative error code otherwise.
+ * Return: 0 on success, a negative error code otherwise.
  */
 int inv_mpu_aux_read(const struct inv_mpu6050_state *st, uint8_t addr,
 		     uint8_t reg, uint8_t *val, size_t size)
@@ -170,7 +170,7 @@ int inv_mpu_aux_read(const struct inv_mpu6050_state *st, uint8_t addr,
  * @reg: chip register address
  * @val: 1 byte value to write
  *
- *  Returns 0 on success, a negative error code otherwise.
+ * Return: 0 on success, a negative error code otherwise.
  */
 int inv_mpu_aux_write(const struct inv_mpu6050_state *st, uint8_t addr,
 		      uint8_t reg, uint8_t val)
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
index 9ef6ab74af8b..c796841c0501 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
@@ -93,7 +93,7 @@ static int inv_mpu_i2c_aux_setup(struct iio_dev *indio_dev)
  *  inv_mpu_probe() - probe function.
  *  @client:          i2c client.
  *
- *  Returns 0 on success, a negative error code otherwise.
+ *  Return: 0 on success, a negative error code otherwise.
  */
 static int inv_mpu_probe(struct i2c_client *client)
 {
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 6239b1a803f7..db609d8c98b8 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -39,7 +39,7 @@
  *  @int_status:	Interrupt status register.
  *  @pwr_mgmt_1:	Controls chip's power state and clock source.
  *  @pwr_mgmt_2:	Controls power state of individual sensors.
- *  @int_pin_cfg;	Controls interrupt pin configuration.
+ *  @int_pin_cfg:	Controls interrupt pin configuration.
  *  @accl_offset:	Controls the accelerometer calibration offset.
  *  @gyro_offset:	Controls the gyroscope calibration offset.
  *  @i2c_if:		Controls the i2c interface
@@ -114,6 +114,7 @@ enum inv_devices {
  *  @temp_fifo_enable:	enable temp data output
  *  @magn_fifo_enable:	enable magn data output
  *  @divider:		chip sample rate divider (sample rate divider - 1)
+ *  @user_ctrl:		cached value of the USER_CTRL register
  *  @roc_threshold:	save ROC threshold (WoM) set value
  */
 struct inv_mpu6050_chip_config {
@@ -150,6 +151,7 @@ struct inv_mpu6050_chip_config {
  *  @config:    configuration of the chip.
  *  @fifo_size:	size of the FIFO in bytes.
  *  @temp:	offset and scale to apply to raw temperature.
+ *  @startup_time: accel and gyro startup times in milliseconds.
  */
 struct inv_mpu6050_hw {
 	u8 whoami;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
index 6b858fdfd1c6..7c95bad60081 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
@@ -144,10 +144,10 @@ static int inv_magn_init(struct inv_mpu6050_state *st)
  * inv_mpu_magn_probe() - probe and setup magnetometer chip
  * @st: driver internal state
  *
- * Returns 0 on success, a negative error code otherwise
- *
  * It is probing the chip and setting up all needed i2c transfers.
  * Noop if there is no magnetometer in the chip.
+ *
+ * Return: 0 on success, a negative error code otherwise.
  */
 int inv_mpu_magn_probe(struct inv_mpu6050_state *st)
 {
@@ -225,11 +225,11 @@ int inv_mpu_magn_probe(struct inv_mpu6050_state *st)
  * @st: driver internal state
  * @fifo_rate: mpu set fifo rate
  *
- * Returns 0 on success, a negative error code otherwise
- *
  * Limit sampling frequency to the maximum value supported by the
  * magnetometer chip. Resulting in duplicated data for higher frequencies.
  * Noop if there is no magnetometer in the chip.
+ *
+ * Return: 0 on success, a negative error code otherwise.
  */
 int inv_mpu_magn_set_rate(const struct inv_mpu6050_state *st, int fifo_rate)
 {
@@ -255,9 +255,9 @@ int inv_mpu_magn_set_rate(const struct inv_mpu6050_state *st, int fifo_rate)
  * inv_mpu_magn_set_orient() - fill magnetometer mounting matrix
  * @st: driver internal state
  *
- * Returns 0 on success, a negative error code otherwise
- *
  * Fill magnetometer mounting matrix using the provided chip matrix.
+ *
+ * Return: 0 on success, a negative error code otherwise.
  */
 int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
 {
@@ -317,7 +317,7 @@ int inv_mpu_magn_set_orient(struct inv_mpu6050_state *st)
  * @axis: IIO modifier axis value
  * @val: store corresponding axis value
  *
- * Returns 0 on success, a negative error code otherwise
+ * Return: 0 on success, a negative error code otherwise.
  */
 int inv_mpu_magn_read(struct inv_mpu6050_state *st, int axis, int *val)
 {
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
index 185c000c697c..ec2fc80adf72 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.h
@@ -18,8 +18,11 @@ int inv_mpu_magn_probe(struct inv_mpu6050_state *st);
 /**
  * inv_mpu_magn_get_scale() - get magnetometer scale value
  * @st: driver internal state
+ * @chan: magnetometer channel to get the scale for
+ * @val: integer part of the scale, always 0
+ * @val2: micro part of the scale, the raw to Gauss conversion coefficient
  *
- * Returns IIO data format.
+ * Return: IIO_VAL_INT_PLUS_MICRO, the IIO format of @val and @val2.
  */
 static inline int inv_mpu_magn_get_scale(const struct inv_mpu6050_state *st,
 					 const struct iio_chan_spec *chan,
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
index 22c1ce66f99e..5b76c3a7fbd8 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
@@ -159,6 +159,8 @@ int inv_mpu6050_prepare_fifo(struct inv_mpu6050_state *st, bool enable)
  *  inv_mpu6050_set_enable() - enable chip functions.
  *  @indio_dev:	Device driver instance.
  *  @enable: enable/disable
+ *
+ *  Return: 0 on success, a negative error code otherwise.
  */
 static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
 {
@@ -208,6 +210,8 @@ static int inv_mpu6050_set_enable(struct iio_dev *indio_dev, bool enable)
  * inv_mpu_data_rdy_trigger_set_state() - set data ready interrupt state
  * @trig: Trigger instance
  * @state: Desired trigger state
+ *
+ * Return: 0 on success, a negative error code otherwise.
  */
 static int inv_mpu_data_rdy_trigger_set_state(struct iio_trigger *trig,
 					      bool state)
-- 
2.53.0

