Return-Path: <SRS0=fsUv=OM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53B3C04EB9
	for <linux-iio@archiver.kernel.org>; Mon,  3 Dec 2018 06:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3D32082F
	for <linux-iio@archiver.kernel.org>; Mon,  3 Dec 2018 06:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="b2ctu0ln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F3D32082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-iio-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725830AbeLCG5Q (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 3 Dec 2018 01:57:16 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43047 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeLCG5Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Dec 2018 01:57:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id gn14so5955963plb.10
        for <linux-iio@vger.kernel.org>; Sun, 02 Dec 2018 22:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8tc7A4FjnoxoNwdmFsfVNg2gPdX9HggINGuSe8ruKaw=;
        b=b2ctu0lngGZPneNwXWQhM9EwPeZtbkjN0b0tORWwiy0HfKFBCVRWJFwUtd1r9oXDuO
         2oP+EZCkUc4F9qNepsx8PdrG+1jpflr6E+WcVbUkOr2Q71ZLz0rn03ILwy+IT07KgfOj
         EhKVahwaYBrWqSXQrpWa5POwTcw0dxAnVngH6tv7a9cgE2HxPcp603HUVjT/orYuaZDF
         dxl3pOxkda+BSX/bmC1c1WhyBNYQryXWgt5MlAEyzes0OjEPAig1N0ZjwJzeeoObJL+3
         0Mb8y8RqsSK5Yfu8UnoEMR4+ZGYusB8Bbu4Y6V7W9clDhNZVh+VHirSVyNsjn+EzU663
         Figg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8tc7A4FjnoxoNwdmFsfVNg2gPdX9HggINGuSe8ruKaw=;
        b=gKgal5Xo80T9bULGQZ5iLkHd0dLcuPN/goBQ1B1H7kKGLfYkQfnYs6N9MY8tiK3h1d
         j6ZG+7g45tzJFuRszjgCN800jEdCxOtw6/seKgOcijihBwQ+ggHLaI2I7jczogEIntal
         cajIkGK5vWFllZ2QRvM/dTiTymahMyl+rCYynjy/FyZYxsy97SrysuO02RmPYQ7+gSS5
         kxB3y+fai3GvfjGLJxFEZpAqG1J5L6FDWrLpIfHhiMEjxHLoCHkRQTIYgSs1q7GN8/Ik
         ngFsKXKS1bf0OGohDVLl1D8F6KtwvywSwr+grl8/1czPZqKIC+wUi/Cg2QjkZYVS78h+
         7HRA==
X-Gm-Message-State: AA+aEWbxoroHmMvzidyNC3+DDlXzPWkbJgiuRyTAv8hxRJKYeHP7i0hH
        Hs8XV08e2SEkjz/dEKXVJGzh8uJ6bWE=
X-Google-Smtp-Source: AFSGD/UDak6ttN3wXjJcyM0JDcf7QWqHX6lwFdHNVR6yfuZlI2/YABpUGj1yQUnfbOiPVvJQ8AcQtA==
X-Received: by 2002:a17:902:bcc7:: with SMTP id o7mr15116168pls.281.1543820232534;
        Sun, 02 Dec 2018 22:57:12 -0800 (PST)
Received: from limbo.local (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id p6sm16159118pfn.53.2018.12.02.22.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Dec 2018 22:57:11 -0800 (PST)
From:   Daniel Drake <drake@endlessm.com>
To:     jic23@jic23.retrosnub.co.uk
Cc:     linux-iio@vger.kernel.org, denis.ciocca@st.com, hadess@hadess.net,
        linux@endlessm.com, hdegoede@redhat.com
Subject: [PATCH] Re: Inconsistent SMO8840 accelerometer data between Windows and Linux
Date:   Mon,  3 Dec 2018 14:57:07 +0800
Message-Id: <20181203065707.3428-1-drake@endlessm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181201162852.7007d1c9@archlinux>
References: <20181201162852.7007d1c9@archlinux>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Jonathan Cameron wrote:
> If we want to support their ONT we'll need to do this first, then
> apply ONT on top of that by forming the relevant mount matrix and
> outputting that to userspace.
> If you fancy having a go it would be good to have this support!

Cool, I didn't realise that there was a way to export mount matrices.
It looks like iio-sensor-proxy doesn't read that attribute yet, I will
submit a patch for that.

For the kernel changes, here is my initial attempt, comments welcome.
I had to drop the const typing from iio_mount_matrix otherwise it's
difficult to dynamically construct it.

Also I'm not sure whether we should apply this "default_ont" like Windows
does even when _ONT is not present?

I would also love to hear from ST about how this situation happened and
if this is the right way forward.

Regarding other devices with _ONT, the only other device we found
is Asus P4540UQ, a system that we worked on 2 years ago and no longer
have access to. I don't think we tested the accelerometer. The ACPI data
indicates SMO8820, with Y and Z axis values requiring sign flip.

Thanks
Daniel
---
 drivers/iio/accel/st_accel_core.c     | 161 +++++++++++++++++++++++++-
 include/linux/iio/common/st_sensors.h |   1 +
 include/linux/iio/iio.h               |   2 +-
 3 files changed, 162 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/st_accel_core.c b/drivers/iio/accel/st_accel_core.c
index 3e6fd5a8ac5b..3eb4e4b55596 100644
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
@@ -917,12 +918,157 @@ static const struct iio_trigger_ops st_accel_trigger_ops = {
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
+	if (ACPI_FAILURE(status)) {
+		ret = status;
+		goto out;
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
+	if (!adata->mount_matrix)
+		goto out;
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
+
+out:
+	kfree(buffer.pointer);
+	return ret;
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
@@ -941,9 +1087,22 @@ int st_accel_common_probe(struct iio_dev *indio_dev)
 
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
+	err = apply_acpi_orientation(indio_dev, channels);
+	if (err < 0)
+		goto st_accel_power_off;
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
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a74cb177dc6f..d3094ffeb9da 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -125,7 +125,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
  *            main hardware
  */
 struct iio_mount_matrix {
-	const char *rotation[9];
+	char *rotation[9];
 };
 
 ssize_t iio_show_mount_matrix(struct iio_dev *indio_dev, uintptr_t priv,
-- 
2.19.1

