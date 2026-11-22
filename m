Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795317864;
	b=cDxWSP84Nb8n8zvvlugg5BfmAMDUWx8w97foKvN3wGdkizgtRK3VjSEIoczSvRIL3bxi
	 baVy4FkN6J8hIno9JVE8cx6Fy0ezyie67E2fxS1g3Kpkf9rY5VJQj3p+Yo9qzzkXfyNFo
	 hpkMumJZAWiWW0yHyXq5ELyDefstqFpTbIifXbX1GfOUkK2sIK+9FpOwWM7C5/Innhu8u
	 UmnBLAhPhgmFRZ330T4GCSyQ++TXNeQIF3FW/ILWx1HhKMYSBfVabRZ7l6ibsABiyohJk
	 Hd4qGG8MiVla7I5znNyOgGWEOdyWp6HyaNyNkMByjyexa41k+YnLm498LKMKFn7bn6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795317864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aOEFqW5lAtaSkNAkzmdyW59DFMhZhiBwu6iv961rMbY=;
	b=iE14ig16ParWrE20DcVWPbUGCwq/jfIqULQ98W71bdNu9h259m1g3kBkNNrPtK1uYB9U
	 rtSHD/S9dMotvY/Zec8+TdrSD1IpPlolhcOvSMBWau5TTpDjLhesb0PwGcIJWZPTL9JYz
	 7VaMav0BcLasb4bAQ4inKQ/8fI+qVXxsytfl7b2BiYYgXSmwoUcNJRz18RxQgTwsggZPu
	 NXpILTDX5CP4+a6ixnt2xnldTgn7KCVr31hIhE4pg/u7oY2OhBOr+8Q8qGIghdrd1jmoF
	 zMF5RtokWvqhWMU8xf/QZBcEmkYKesgYbiKJVAvl0wAVQrNtrBnSxZhfdJWGnD1ofBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dXDsO4qb;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C32A606A32A
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 03:24:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C32A606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dXDsO4qb
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-386ab9ab619so5668eec.1
        for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 19:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795317863; x=1795922663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aOEFqW5lAtaSkNAkzmdyW59DFMhZhiBwu6iv961rMbY=;
        b=dXDsO4qb0doDtTMPH3tLoq9v83nS7b29jfcyAu/fHLbG1yUJbLOtM4zTPtgZOhgdhR
         xyUTRUoHjmXB93YQticpO+2B0ZudRoXzH7Pa1W/ErCR/2wT0ky97OhdCZP3nQiUy0mZZ
         FGK/P/6ETNynPyEEZOEGBraKyCE/WXOFl9ykOIW39ySwK7KjhcGodOEN3eHjZfKmK4PA
         FSmmTHazG5LH+n0LwdfeclARlcGr+pthC3oQMe4ude1jYjLwCCBkfy27poDq3Q4FQZS4
         uL/aQhdfhy2Z4c7cVHMplBZ/yr0rTo8QqHqsVV6a1gdr+q0n/hN0MQNtWe2K4qgERlpr
         cF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795317863; x=1795922663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aOEFqW5lAtaSkNAkzmdyW59DFMhZhiBwu6iv961rMbY=;
        b=L57exOgVoRrJBea5xUURb7QnYPC0cKoDz1MwF27x/LlGLzsmEBnlIxXegcUiOcUNxV
         qd8ivUVJmmZssZLDKW9AinfxGahsGw28XazI/krr303Te2b9gIjhd6oxJryGYFgCtrkp
         ZOsdZdICN/+bsGRYfAGFs4VgB9WMNYfaBo3aRehqPWDtyLhOff5qV0CHgvNdOQkDP8dU
         TBV+taayIh6FhSTULjq48p2cRuzBRcBAUyrE1ONkBmhlx6ajnmoe/3uRlHHNZfOwjW89
         SXk7akDI7hBQDEKjYoZk8cGy6zmKs9oGkgdXNlroVaaU+qmMGXDXUH2uEw/L1v1uc5p6
         fnJQ==
X-Forwarded-Encrypted: i=1; AL+hErGvQLbQSWvXUHdS8dJJQQFIUkIkn5i5tGKA6dG89UjX+RvhoB7Ww/BlHb3LGaPzBtmAWlIdw1PtRKg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZEEQTDgRd8Mpkt/jjiHjiCF+WJZzn0hvs9/I+5inf6B3Igtko
	mUjCg+yGcQLUPTHuEP5b5gJ2f1iCMvKdIJcTx5yRm5SsXz+WidoFYDfR
X-Gm-Gg: AZFdTZfSMgXVQMGmj+Tg4Zpu8nakidH5nQolIr1o/HIUf1YiNjF1jKihvjN0CVzp6n7
	C+gQjzaXeSP3LgncnUbUGcCvm0xekD5vITW6ETr1fT6C6zcmWES+z6VZR9nvsbHhbRIhyeKikSi
	eCZa0VmZ0ZdpVcm6AQH6xeEB763r+1V5Zhyo7Cww8wje8jltX5Hz10PJtFIxTIKYHfPZl5oLScx
	fLryF9FoMw5v7WqKPut/y1N4kRvazuq6K3br7i5rNaQ03ebvMCYXV4ylHD+sIitCk3KPZAlKn8T
	UqnIMKIsrwfnEban4kvGW+ha6QgQIAmIyv6KzC+AOSssdT46G65/X8+Edjmkz1DyGVCshvMqyKc
	AQg+v4a9E2OP1lu5AjpPPaRmTM45ZA7vNg4bIRlvzk/rsDiX5oguJs3J1qfVpc3DEfaePrMy3Lr
	Dafzq6xuULm3pUgz7LeKJpPxMlVD9TKxD1Vs2C19lf6+dDNJlYsmyKQrMOnQvXjnp4D83BWfBNa
	WRL1DCUCoQ44HopAg5NKHEa30iXTIIdDLuFB0hQhfotQrCPtihL2qbVl27k0Eo2tzuX5bIx4CS0
	HszzUO9LxXqZfPDh38Ym1G4eWvB7lVRJIqefC8YXdza/YIaTGa1tZowg/wVuxJO7spZjj0nxVLA
	/RLPLJcZDJvZrXrjSirLtuERe5RdwJ2ySg1Y8UDcFgB6cKnwLA8U0FlStiZVAnDWsY9kkPAYVt5
	LvPzouVjVgtjCK54Mh2ULEpZd21i/W4xm7MIFRgEVEjw==
X-Received: by 2002:a05:7301:391c:b0:384:df31:69fd with SMTP id 5a478bee46e88-3856fb6a672mr9572437eec.14.1795317863249;
        Sat, 21 Nov 2026 19:24:23 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385c6830815sm18931379eec.20.2026.11.21.19.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 19:24:22 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v4] iio: light: bh1745: fix 16-bit register accesses
Date: Sun, 22 Nov 2026 08:54:13 +0530
Message-ID: <20261122032415.20042-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 16-bit colour data and threshold registers are little-endian
LSB/MSB pairs, but the driver accesses them through regmap_bulk_read()
and regmap_bulk_write() with an int or u16 buffer and no byte-order
conversion:

- bh1745_read_raw() reads 2 bytes into an uninitialised int, so the
  upper 16 bits returned to user space are stack contents.
- bh1745_read_thresh() reads 2 bytes straight into *val, which the IIO
  core leaves uninitialised, with the same result for the event
  threshold attributes.
- bh1745_write_thresh() writes the first 2 bytes of an int, which are
  the upper (zero) bytes on big-endian.
- bh1745_trigger_handler() pushes the raw register bytes, which are
  little-endian, to a buffer whose scan type is IIO_CPU, so user space
  gets the samples byte-swapped on big-endian.

Use an __le16 for the sysfs paths and convert with le16_to_cpu() /
cpu_to_le16(). For the buffer, read straight into the scan and mark the
channels IIO_LE, leaving the conversion to user space as usual.

Fixes: eab35358aae7 ("iio: light: ROHM BH1745 colour sensor")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Changes in v4:
- Mark the channels IIO_LE and push the samples little-endian instead
  of converting them in the trigger handler (Jonathan)
- Read straight into scan.chans[] (Jonathan)

v3: https://lore.kernel.org/all/20261118104534.159876-1-kapoorarnav43@gmail.com/
v2: https://lore.kernel.org/all/20261117110327.198084-1-kapoorarnav43@gmail.com/
v1: https://lore.kernel.org/all/20261116194214.45174-1-kapoorarnav43@gmail.com/

Compile-tested only (W=1, checkpatch --strict clean); I don't have
BH1745 hardware.

 drivers/iio/light/bh1745.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
index 2b8ff36071b8..68baf5cc14b5 100644
--- a/drivers/iio/light/bh1745.c
+++ b/drivers/iio/light/bh1745.c
@@ -16,6 +16,9 @@
 #include <linux/regmap.h>
 #include <linux/bits.h>
 #include <linux/bitfield.h>
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -210,7 +213,7 @@ static const struct iio_event_spec bh1745_event_spec[] = {
 			.sign = 'u',                                    \
 			.realbits = 16,                                 \
 			.storagebits = 16,                              \
-			.endianness = IIO_CPU,                          \
+			.endianness = IIO_LE,                           \
 		},                                                      \
 	}
 
@@ -421,19 +424,20 @@ static int bh1745_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long mask)
 {
 	struct bh1745_data *data = iio_priv(indio_dev);
+	__le16 value;
 	int ret;
-	int value;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		if (!iio_device_claim_direct(indio_dev))
 			return -EBUSY;
 
-		ret = regmap_bulk_read(data->regmap, chan->address, &value, 2);
+		ret = regmap_bulk_read(data->regmap, chan->address, &value,
+				       sizeof(value));
 		iio_device_release_direct(indio_dev);
 		if (ret)
 			return ret;
-		*val = value;
+		*val = le16_to_cpu(value);
 
 		return IIO_VAL_INT;
 
@@ -503,6 +507,7 @@ static int bh1745_read_thresh(struct iio_dev *indio_dev,
 			      enum iio_event_info info, int *val, int *val2)
 {
 	struct bh1745_data *data = iio_priv(indio_dev);
+	__le16 value;
 	int ret;
 
 	switch (info) {
@@ -510,18 +515,22 @@ static int bh1745_read_thresh(struct iio_dev *indio_dev,
 		switch (dir) {
 		case IIO_EV_DIR_RISING:
 			ret = regmap_bulk_read(data->regmap, BH1745_TH_LSB,
-					       val, 2);
+					       &value, sizeof(value));
 			if (ret)
 				return ret;
 
+			*val = le16_to_cpu(value);
+
 			return IIO_VAL_INT;
 
 		case IIO_EV_DIR_FALLING:
 			ret = regmap_bulk_read(data->regmap, BH1745_TL_LSB,
-					       val, 2);
+					       &value, sizeof(value));
 			if (ret)
 				return ret;
 
+			*val = le16_to_cpu(value);
+
 			return IIO_VAL_INT;
 
 		default:
@@ -547,6 +556,7 @@ static int bh1745_write_thresh(struct iio_dev *indio_dev,
 			       enum iio_event_info info, int val, int val2)
 {
 	struct bh1745_data *data = iio_priv(indio_dev);
+	__le16 value;
 	int ret;
 
 	switch (info) {
@@ -554,10 +564,12 @@ static int bh1745_write_thresh(struct iio_dev *indio_dev,
 		if (val < 0x0 || val > 0xFFFF)
 			return -EINVAL;
 
+		value = cpu_to_le16(val);
+
 		switch (dir) {
 		case IIO_EV_DIR_RISING:
 			ret = regmap_bulk_write(data->regmap, BH1745_TH_LSB,
-						&val, 2);
+						&value, sizeof(value));
 			if (ret)
 				return ret;
 
@@ -565,7 +577,7 @@ static int bh1745_write_thresh(struct iio_dev *indio_dev,
 
 		case IIO_EV_DIR_FALLING:
 			ret = regmap_bulk_write(data->regmap, BH1745_TL_LSB,
-						&val, 2);
+						&value, sizeof(value));
 			if (ret)
 				return ret;
 
@@ -738,21 +750,18 @@ static irqreturn_t bh1745_trigger_handler(int interrupt, void *p)
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct bh1745_data *data = iio_priv(indio_dev);
 	struct {
-		u16 chans[4];
+		__le16 chans[4];
 		aligned_s64 timestamp;
 	} scan = { };
-	u16 value;
 	int ret;
 	int i;
 	int j = 0;
 
 	iio_for_each_active_channel(indio_dev, i) {
 		ret = regmap_bulk_read(data->regmap, BH1745_RED_LSB + 2 * i,
-				       &value, 2);
+				       &scan.chans[j++], sizeof(scan.chans[0]));
 		if (ret)
 			goto err;
-
-		scan.chans[j++] = value;
 	}
 
 	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),

base-commit: 51b83d4cb0f5c1342868c7aa1edbf0c4867477aa
-- 
2.53.0

