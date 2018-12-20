Return-Path: <SRS0=mvch=O5=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02821C43387
	for <linux-iio@archiver.kernel.org>; Thu, 20 Dec 2018 06:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8FB220869
	for <linux-iio@archiver.kernel.org>; Thu, 20 Dec 2018 06:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="vVESFltG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbeLTG7n (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 20 Dec 2018 01:59:43 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33537 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbeLTG7n (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 20 Dec 2018 01:59:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id c123so475650pfb.0
        for <linux-iio@vger.kernel.org>; Wed, 19 Dec 2018 22:59:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5bNUFu43BwjMPIpZZ5vmXdTd7wiTbMtV+zsE7NFpEkU=;
        b=vVESFltGSBkNE0oQQ+O+isIvkEBHMQVohDgyI4QlTcqT72uOMmyTD29JJXRfJQuFcS
         K0jG2fftfPELNcTHfBNZvn1Zjk45DfcPkw27FmNgnsMza7301nk4zuYbmuu88x6jjmv2
         3cVuuFfplyLNQlShBA7C+rOspEF5jGD9EOUMvMaq4lzpmMaItqUu8qtTnbXHb1Fgul8F
         hVuqlxULSxfuZEvfkoBekhH/dU9qvPBScRz4tUo+FYBwFTDrs6aFbW5vMUjaN3Piy2hA
         VgCh6hA2X/h0S4MWzXzYfnRp44npjPedHkSkwrZ2/mz+Fx24RwXvdlyV1R33HE29GqPA
         sNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5bNUFu43BwjMPIpZZ5vmXdTd7wiTbMtV+zsE7NFpEkU=;
        b=Z2KQVS5YTmgwDhKXQt11mNx/TySBvKONw5QqobQ61U97/q+IK7T0N5hOHHXKYRrhvs
         bK87n88hzLpe/DBJasrw9yozXW+EDDL81+JBsPvj+UPiqRt7KtJa0Oh4L/jzSvWy2JNl
         yPlkmOr/k+y4UE5vBCKALveH0YESe0+GbD1L9gj9wYXlwXvynEqc/vnnr/m0hxI4En+F
         cIIafPLpeEMmKfvqDCg8umOB5YVjiTI0ciuG6qB7LGjJQtYrQHTZ11cfzVikXHHU7Di7
         x1XBAhUorsLeHOK42LRoYX+4ThAl06Yb02PVYmcWe+wGsZrh7yH2QwgF2iQcSTes60Px
         W8Qw==
X-Gm-Message-State: AA+aEWbv1OucNY0K05Gv2mwg2B9pEPKWfGu1+1b4yyNz4CfOqhJQh361
        i3zncjV9hu1JMOhmiUL5MQgL8g==
X-Google-Smtp-Source: AFSGD/Ue3ZDFBrdNrfUZbKl8USPKYRgKI9F5UEgH+aFmlgA1dkOZCVqimuOCTcfcNXw39MbSGzicEA==
X-Received: by 2002:a63:3858:: with SMTP id h24mr8825021pgn.300.1545289181953;
        Wed, 19 Dec 2018 22:59:41 -0800 (PST)
Received: from limbo.local (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id 83sm29980791pgf.57.2018.12.19.22.59.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 22:59:41 -0800 (PST)
From:   Daniel Drake <drake@endlessm.com>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux@endlessm.com,
        lorenzo.bianconi83@gmail.com, denis.ciocca@st.com,
        hadess@hadess.net, hdegoede@redhat.com
Subject: [PATCH 2/2] iio: st_accel: use ACPI orientation data
Date:   Thu, 20 Dec 2018 14:59:33 +0800
Message-Id: <20181220065933.25964-2-drake@endlessm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181220065933.25964-1-drake@endlessm.com>
References: <20181220065933.25964-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Platform-specific ST accelerometer mount matrix information can be
provided by returning a package of 6 integers from the ACPI _ONT
method. This has been seen on Acer products such as Veriton Z4860G,
Z6860G and A890, which include a ST SMO8840 sensor. We have also
confirmed experimentally that the Windows driver uses such information.

The _ONT data format was explained by a ST vendor contact. However,
strangely enough, the _ONT transformations must be applied after first
applying another mount matrix which we determined experimentally. ST
have not commented on why this is the case, but we imagine that perhaps
earlier devices (before _ONT was introduced) required this translation
and hence it became 'standard.'

Interpret the _ONT data and export the equivalent mount matrix to
userspace.

If no _ONT data is present, no mount matrix is exported.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/iio/accel/st_accel_core.c     | 171 +++++++++++++++++++++++++-
 include/linux/iio/common/st_sensors.h |   1 +
 2 files changed, 171 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 3e6fd5a8ac5b..54cc1a0c6a1d 100644
--- a/drivers/iio/accel/st_accel_core.c
+++ b/drivers/iio/accel/st_accel_core.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/acpi.h>
 #include <linux/errno.h>
 #include <linux/types.h>
 #include <linux/mutex.h>
@@ -917,12 +918,167 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
 #define ST_ACCEL_TRIGGER_OPS NULL
 #endif
 
+static const struct iio_mount_matrix *
+get_mount_matrix(const struct iio_dev *indio_dev,
+		 const struct iio_chan_spec *chan)
+{
+	struct st_sensor_data *adata = iio_priv(indio_dev);
+
+	return adata->mount_matrix;
+}
+
+static const struct iio_chan_spec_ext_info mount_matrix_ext_info[] = {
+	IIO_MOUNT_MATRIX(IIO_SHARED_BY_ALL, get_mount_matrix),
+	{ },
+};
+
+/* Read ST-specific _ONT orientation data from ACPI and generate an
+ * appropriate mount matrix.
+ */
+static int apply_acpi_orientation(struct iio_dev *indio_dev,
+				  struct iio_chan_spec *channels)
+{
+#ifdef CONFIG_ACPI
+	struct st_sensor_data *adata = iio_priv(indio_dev);
+	struct acpi_buffer buffer = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct acpi_device *adev;
+	union acpi_object *ont;
+	union acpi_object *elements;
+	acpi_status status;
+	int ret = -EINVAL;
+	unsigned int val;
+	int i, j;
+	int final_ont[3][3] = { 0 };
+
+	/* For some reason, ST's _ONT translation does not apply directly
+	 * to the data read from the sensor. Another translation must be
+	 * performed first, as described by the matrix below. Perhaps
+	 * ST required this specific translation for the first product
+	 * where the device was mounted?
+	 */
+	const int default_ont[3][3] = {
+		{  0,  1,  0 },
+		{ -1,  0,  0 },
+		{  0,  0, -1 },
+	};
+
+
+	adev = ACPI_COMPANION(adata->dev);
+	if (!adev)
+		return 0;
+
+	/* Read _ONT data, which should be a package of 6 integers. */
+	status = acpi_evaluate_object(adev->handle, "_ONT", NULL, &buffer);
+	if (status == AE_NOT_FOUND) {
+		return 0;
+	} else if (ACPI_FAILURE(status)) {
+		dev_warn(&indio_dev->dev, "failed to execute _ONT: %d\n",
+			 status);
+		return status;
+	}
+
+	ont = buffer.pointer;
+	if (ont->type != ACPI_TYPE_PACKAGE || ont->package.count != 6)
+		goto out;
+
+	/* The first 3 integers provide axis order information.
+	 * e.g. 0 1 2 would indicate normal X,Y,Z ordering.
+	 * e.g. 1 0 2 indicates that data arrives in order Y,X,Z.
+	 */
+	elements = ont->package.elements;
+	for (i = 0; i < 3; i++) {
+		if (elements[i].type != ACPI_TYPE_INTEGER)
+			goto out;
+
+		val = elements[i].integer.value;
+		if (val < 0 || val > 2)
+			goto out;
+
+		/* Avoiding full matrix multiplication, we simply reorder the
+		 * columns in the default_ont matrix according to the
+		 * ordering provided by _ONT.
+		 */
+		final_ont[0][i] = default_ont[0][val];
+		final_ont[1][i] = default_ont[1][val];
+		final_ont[2][i] = default_ont[2][val];
+	}
+
+	/* The final 3 integers provide sign flip information.
+	 * 0 means no change, 1 means flip.
+	 * e.g. 0 0 1 means that Z data should be sign-flipped.
+	 * This is applied after the axis reordering from above.
+	 */
+	elements += 3;
+	for (i = 0; i < 3; i++) {
+		if (elements[i].type != ACPI_TYPE_INTEGER)
+			goto out;
+
+		val = elements[i].integer.value;
+		if (val != 0 && val != 1)
+			goto out;
+		if (!val)
+			continue;
+
+		/* Flip the values in the indicated column */
+		final_ont[0][i] *= -1;
+		final_ont[1][i] *= -1;
+		final_ont[2][i] *= -1;
+	}
+
+	/* Convert our integer matrix to a string-based iio_mount_matrix */
+	adata->mount_matrix = devm_kmalloc(&indio_dev->dev,
+					   sizeof(*adata->mount_matrix),
+					   GFP_KERNEL);
+	if (!adata->mount_matrix) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	for (i = 0; i < 3; i++) {
+		for (j = 0; j < 3; j++) {
+			int matrix_val = final_ont[i][j];
+			char *str_value;
+
+			switch (matrix_val) {
+			case -1:
+				str_value = "-1";
+				break;
+			case 0:
+				str_value = "0";
+				break;
+			case 1:
+				str_value = "1";
+				break;
+			default:
+				goto out;
+			}
+			adata->mount_matrix->rotation[i * 3 + j] = str_value;
+		}
+	}
+
+	/* Expose the mount matrix via ext_info */
+	for (i = 0; i < indio_dev->num_channels; i++)
+		channels[i].ext_info = mount_matrix_ext_info;
+
+	ret = 0;
+	dev_info(&indio_dev->dev, "computed mount matrix from ACPI\n");
+
+out:
+	kfree(buffer.pointer);
+	return ret;
+#else /* !CONFIG_ACPI */
+	return 0;
+#endif
+}
+
 int st_accel_common_probe(struct iio_dev *indio_dev)
 {
 	struct st_sensor_data *adata = iio_priv(indio_dev);
 	struct st_sensors_platform_data *pdata =
 		(struct st_sensors_platform_data *)adata->dev->platform_data;
 	int irq = adata->get_irq_data_ready(indio_dev);
+	struct iio_chan_spec *channels;
+	size_t channels_size;
 	int err;
 
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -941,9 +1097,22 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 
 	adata->num_data_channels = ST_ACCEL_NUMBER_DATA_CHANNELS;
 	adata->multiread_bit = adata->sensor_settings->multi_read_bit;
-	indio_dev->channels = adata->sensor_settings->ch;
 	indio_dev->num_channels = ST_SENSORS_NUMBER_ALL_CHANNELS;
 
+	channels_size = indio_dev->num_channels * sizeof(struct iio_chan_spec);
+	channels = devm_kmemdup(&indio_dev->dev,
+				adata->sensor_settings->ch,
+				channels_size, GFP_KERNEL);
+	if (!channels) {
+		err = -ENOMEM;
+		goto st_accel_power_off;
+	}
+
+	if (apply_acpi_orientation(indio_dev, channels))
+		dev_warn(&indio_dev->dev,
+			 "failed to apply ACPI orientation data: %d\n", err);
+
+	indio_dev->channels = channels;
 	adata->current_fullscale = (struct st_sensor_fullscale_avl *)
 					&adata->sensor_settings->fs.fs_avl[0];
 	adata->odr = adata->sensor_settings->odr.odr_avl[0].hz;
diff --git a/include/linux/iio/common/st_sensors.h b/include/linux/iio/common/st_sensors.h
index f9bd6e8ab138..fe15694128ac 100644
--- a/include/linux/iio/common/st_sensors.h
+++ b/include/linux/iio/common/st_sensors.h
@@ -260,6 +260,7 @@ struct st_sensor_settings {
 struct st_sensor_data {
 	struct device *dev;
 	struct iio_trigger *trig;
+	struct iio_mount_matrix *mount_matrix;
 	struct st_sensor_settings *sensor_settings;
 	struct st_sensor_fullscale_avl *current_fullscale;
 	struct regulator *vdd;
-- 
2.19.1

