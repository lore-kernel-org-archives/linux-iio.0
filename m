Return-Path: <SRS0=2YCt=SF=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23169C4360F
	for <linux-iio@archiver.kernel.org>; Wed,  3 Apr 2019 06:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2D4C20700
	for <linux-iio@archiver.kernel.org>; Wed,  3 Apr 2019 06:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b="nHCqK7wo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbfDCG3l (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 3 Apr 2019 02:29:41 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38456 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfDCG3l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Apr 2019 02:29:41 -0400
Received: by mail-pl1-f196.google.com with SMTP id g37so7511647plb.5
        for <linux-iio@vger.kernel.org>; Tue, 02 Apr 2019 23:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XP7U60ZYVT0uUBZTkEg4Hm9QJC3LmZWFKNaW0HDMkxI=;
        b=nHCqK7woN2yfUmCyd6wS8NPfEbCp0d2lsi/2/BucuceS+p6e1ugRTLNEjiwLKWm8t/
         l0fD43+XtEgMcUjtlChDeBs7Ctq3zY25++HnI6njHWzgnzoIpjKW9j+V3C5LWWGT7l75
         Cr5iQMaPgZ7HBc/33PX/jVUa45StQvy74p38cwTIZIl7BIAGheQgdC4YNX/GvnxBLqCv
         xPG4JTZQk2tqOrOcpuhBSSa5WovfaRURUJmEBUezUeGSG5e3bN4IpCW6qOqnl/Gzh5qD
         0iuMYox6Uy7/cwbreFMA9JQmx2KsGp0z2kEGZHosrHyyU/Zt0NNdAqrdya7PL2GSiVGS
         DnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XP7U60ZYVT0uUBZTkEg4Hm9QJC3LmZWFKNaW0HDMkxI=;
        b=NUHPkOwCKgLtPjIwJnutQzl0wmkNO1do4EUSbNVVTYyt7HbvoeutF+jDNe8kkUzwLT
         pOyhgIMjgV9YlK380giYYk1yNDsJjtA5KG6OYTdz+gFSkuv/L8xM3ebAUs9fK2/2qENJ
         gRP7CBOTQ+k3xXNj/2ugiP5kVZHODELL2CkDHb9czqD1mnoX01n2O+nFWF0AGt5mDYB+
         F3ZQ89KLzQWSWqG3CYH1nVV0BLbDeoYeFHZBOH2oq0PJP0ToFBkPq4io1MRWLPmcsKmy
         JyRh5IiZcn0EcwpPT3S95c9eLSjedRvHa6OG5nD7DuvVMJA3jk6yqEK7xy1fuBz4W2J1
         K5dg==
X-Gm-Message-State: APjAAAU/cK/rg6JkoBi7JK/vYXgaW62Lxv4274bS2NZ/fpUOk713VMOS
        l3qmtoU56lhUsX/iMzGfvYVDPk6PfhPz7w==
X-Google-Smtp-Source: APXvYqzFAgGoNw4D6bfqQcO/OmbtgB1O8tRSzVWlPBtrTXJ+9GD1YKXDNnqHmRW7eaMFCZHLSSZW3Q==
X-Received: by 2002:a17:902:b713:: with SMTP id d19mr59926975pls.54.1554272980197;
        Tue, 02 Apr 2019 23:29:40 -0700 (PDT)
Received: from stevemo-laptop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id d11sm17226216pgq.6.2019.04.02.23.29.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 02 Apr 2019 23:29:39 -0700 (PDT)
From:   stevemo@skydio.com
To:     jmaneyrol@invensense.com
Cc:     Steve Moskovchenko <stevemo@skydio.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Martin Kelly <mkelly@xevo.com>,
        Jonathan Marek <jonathan@marek.ca>,
        Brian Masney <masneyb@onstation.org>,
        =?UTF-8?q?Randolph=20Maa=C3=9Fen?= <gaireg@gaireg.de>,
        Douglas Fischer <fischerdouglasc@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: imu: mpu6050: Fix FIFO layout for ICM20602
Date:   Tue,  2 Apr 2019 23:28:56 -0700
Message-Id: <20190403062910.5047-1-stevemo@skydio.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190326090238.23651-1-stevemo@skydio.com>
References: <20190326090238.23651-1-stevemo@skydio.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

From: Steve Moskovchenko <stevemo@skydio.com>

The MPU6050 driver has recently gained support for the
ICM20602 IMU, which is very similar to MPU6xxx. However,
the ICM20602's FIFO data specifically includes temperature
readings, which were not present on MPU6xxx parts. As a
result, the driver will under-read the ICM20602's FIFO
register, causing the same (partial) sample to be returned
for all reads, until the FIFO overflows.

Fix this by adding a table of scan elements specifically
for the ICM20602, which takes the extra temperature data
into consideration.

While we're at it, fix the temperature offset and scaling
on ICM20602, since it uses different scale/offset constants
than the rest of the MPU6xxx devices.

Signed-off-by: Steve Moskovchenko <stevemo@skydio.com>
---
v2: Read temperature when running in accel-only mode, too.

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 46 ++++++++++++++++++++--
 drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 20 +++++++++-
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c |  3 ++
 3 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 650de0fefb7b..fedd3f2b0135 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -471,7 +471,10 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 			return IIO_VAL_INT_PLUS_MICRO;
 		case IIO_TEMP:
 			*val = 0;
-			*val2 = INV_MPU6050_TEMP_SCALE;
+			if (st->chip_type == INV_ICM20602)
+				*val2 = INV_ICM20602_TEMP_SCALE;
+			else
+				*val2 = INV_MPU6050_TEMP_SCALE;
 
 			return IIO_VAL_INT_PLUS_MICRO;
 		default:
@@ -480,7 +483,10 @@ inv_mpu6050_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_OFFSET:
 		switch (chan->type) {
 		case IIO_TEMP:
-			*val = INV_MPU6050_TEMP_OFFSET;
+			if (st->chip_type == INV_ICM20602)
+				*val = INV_ICM20602_TEMP_OFFSET;
+			else
+				*val = INV_MPU6050_TEMP_OFFSET;
 
 			return IIO_VAL_INT;
 		default:
@@ -845,6 +851,32 @@ static const struct iio_chan_spec inv_mpu_channels[] = {
 	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_MPU6050_SCAN_ACCL_Z),
 };
 
+static const struct iio_chan_spec inv_icm20602_channels[] = {
+	IIO_CHAN_SOFT_TIMESTAMP(INV_ICM20602_SCAN_TIMESTAMP),
+	{
+		.type = IIO_TEMP,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)
+				| BIT(IIO_CHAN_INFO_OFFSET)
+				| BIT(IIO_CHAN_INFO_SCALE),
+		.scan_index = INV_ICM20602_SCAN_GYRO_TEMP,
+		.scan_type = {
+				.sign = 's',
+				.realbits = 16,
+				.storagebits = 16,
+				.shift = 0,
+				.endianness = IIO_BE,
+			     },
+	},
+
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_X, INV_ICM20602_SCAN_GYRO_X),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Y, INV_ICM20602_SCAN_GYRO_Y),
+	INV_MPU6050_CHAN(IIO_ANGL_VEL, IIO_MOD_Z, INV_ICM20602_SCAN_GYRO_Z),
+
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Y, INV_ICM20602_SCAN_ACCL_Y),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_X, INV_ICM20602_SCAN_ACCL_X),
+	INV_MPU6050_CHAN(IIO_ACCEL, IIO_MOD_Z, INV_ICM20602_SCAN_ACCL_Z),
+};
+
 /*
  * The user can choose any frequency between INV_MPU6050_MIN_FIFO_RATE and
  * INV_MPU6050_MAX_FIFO_RATE, but only these frequencies are matched by the
@@ -1100,8 +1132,14 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		indio_dev->name = name;
 	else
 		indio_dev->name = dev_name(dev);
-	indio_dev->channels = inv_mpu_channels;
-	indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
+
+	if (chip_type == INV_ICM20602) {
+		indio_dev->channels = inv_icm20602_channels;
+		indio_dev->num_channels = ARRAY_SIZE(inv_icm20602_channels);
+	} else {
+		indio_dev->channels = inv_mpu_channels;
+		indio_dev->num_channels = ARRAY_SIZE(inv_mpu_channels);
+	}
 
 	indio_dev->info = &mpu_info;
 	indio_dev->modes = INDIO_BUFFER_TRIGGERED;
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
index 325afd9f5f61..2ed4b98e0cd7 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
@@ -208,6 +208,9 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_BYTES_PER_3AXIS_SENSOR   6
 #define INV_MPU6050_FIFO_COUNT_BYTE          2
 
+/* ICM20602 FIFO samples include temperature readings */
+#define INV_ICM20602_BYTES_PER_TEMP_SENSOR   2
+
 /* mpu6500 registers */
 #define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
 #define INV_MPU6500_REG_ACCEL_OFFSET        0x77
@@ -229,6 +232,9 @@ struct inv_mpu6050_state {
 #define INV_MPU6050_GYRO_CONFIG_FSR_SHIFT    3
 #define INV_MPU6050_ACCL_CONFIG_FSR_SHIFT    3
 
+#define INV_ICM20602_TEMP_OFFSET	     8170
+#define INV_ICM20602_TEMP_SCALE		     3060
+
 /* 6 + 6 round up and plus 8 */
 #define INV_MPU6050_OUTPUT_DATA_SIZE         24
 
@@ -270,7 +276,7 @@ struct inv_mpu6050_state {
 #define INV_ICM20608_WHOAMI_VALUE		0xAF
 #define INV_ICM20602_WHOAMI_VALUE		0x12
 
-/* scan element definition */
+/* scan element definition for generic MPU6xxx devices */
 enum inv_mpu6050_scan {
 	INV_MPU6050_SCAN_ACCL_X,
 	INV_MPU6050_SCAN_ACCL_Y,
@@ -281,6 +287,18 @@ enum inv_mpu6050_scan {
 	INV_MPU6050_SCAN_TIMESTAMP,
 };
 
+/* scan element definition for ICM20602, which includes temperature */
+enum inv_icm20602_scan {
+	INV_ICM20602_SCAN_ACCL_X,
+	INV_ICM20602_SCAN_ACCL_Y,
+	INV_ICM20602_SCAN_ACCL_Z,
+	INV_ICM20602_SCAN_GYRO_TEMP,
+	INV_ICM20602_SCAN_GYRO_X,
+	INV_ICM20602_SCAN_GYRO_Y,
+	INV_ICM20602_SCAN_GYRO_Z,
+	INV_ICM20602_SCAN_TIMESTAMP,
+};
+
 enum inv_mpu6050_filter_e {
 	INV_MPU6050_FILTER_256HZ_NOLPF2 = 0,
 	INV_MPU6050_FILTER_188HZ,
diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index 548e042f7b5b..57bd11bde56b 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -207,6 +207,9 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 	if (st->chip_config.gyro_fifo_enable)
 		bytes_per_datum += INV_MPU6050_BYTES_PER_3AXIS_SENSOR;
 
+	if (st->chip_type == INV_ICM20602)
+		bytes_per_datum += INV_ICM20602_BYTES_PER_TEMP_SENSOR;
+
 	/*
 	 * read fifo_count register to know how many bytes are inside the FIFO
 	 * right now
-- 
2.20.1

