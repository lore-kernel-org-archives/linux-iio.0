Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913416;
	b=wYzfdAkMB/MRMvVqKbqzkZ0q3tyish/MGqt9bc/pYXftI+o4/ldHKhE6oUiy2hzD95o/
	 uYYBGPNO7FhvyPygvICY/VROhf7/Cbvdu60LqGkocBYIrVZkEwZOiqRaP4GTm395kHqwo
	 9iMqc4m8PDfirjiUWHYJ03XmirEmse8alUc2nkQZQnteKqyfIHJAaeF6hBqC6zBZ25Vru
	 6/ZHKHjHPSuMrsTH2ZKp/3w44MAa5jiaZGLmOYkX8b1abfrwkYozB0f+KG7Naj3BrTYZe
	 qKFsGCXtFIUt0CFFAStWslmBLTbjC2j4SSYwt29b3VCfEagFzWxTzl0V3G24wkt4REA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913416;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pBP2YxVQh3ontLZCFQlFA3EEOT/EhtaV+AKjxMibSVc=;
	b=i1vX6fMWpfgGBUQ2lgRcJa3mUaFOFoxMszNldg5H1e4tkAituwm4PsSZ4X+zwlRL+Pkn
	 15vICSZowhWvT25wi90mZBOz3tEeWXff43cLMv7HsyZEyfd6JRIbQPTmo3kxVeHiRNO09
	 +OljrhFOvr4LFmPehIBBFXWDRKrmhY1cUzGjKt7VVYtago9IK8CMaEVpt1EfYebO11x8e
	 OSkoLEU52GnWHTj9SdDgySlpc40eM2txtacAlBX1yJBRklbfs6z7J2wmX+dmCQ5zQjb4X
	 vvB6P4wjyvTZUkE7Oms3PtOk7x6uZ8VylUyCgdnnJW17BVFq9H+DNAnd+zuvYBvpNeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pF61gJfK;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67253606A31C
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 11:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67253606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pF61gJfK
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1438d9363fbso557205c88.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 03:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794913414; x=1795518214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pBP2YxVQh3ontLZCFQlFA3EEOT/EhtaV+AKjxMibSVc=;
        b=pF61gJfKJ82vwmSaya6jxWXA610wiYhVQsAj/HvXjfpTHVeax7PbmHAte2c/h1w1mv
         reDfDdZzjY3MBA9fwLSs+zrj2yqW9lM/K7Q4Trsu/9pSH/qcg6lOXeDEeXAJB/G1Hi0R
         DKcM0nSXVkx3hEIGq2RMIYO23o2lFgVAoFAcfe1cnGmSCPx5Ldy9keqCt/4T1GFV8uKE
         UWMO5Gz4VzOwUTNUHJmHue/NXA1Wh7qdppzBBO3XXQaVSse7AZasMovdxMxfh5vrocmJ
         gotAmVGsD5MOk+r1ZtO8ks4CfEqrBCSDYFKholpwb0Cpi2tmKm/H5JsnezACSW1T7O7n
         cKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794913414; x=1795518214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pBP2YxVQh3ontLZCFQlFA3EEOT/EhtaV+AKjxMibSVc=;
        b=PucqQ7+0BlA3DSbXVaPtKszCih86C2SVhpTVsL4S+IYcNAr7aC8ucbQVcueSe8KUKE
         atgO1OUQrrMfbIlrzpHKUEpPiL0vi8gh+iqxq0H+aaEsQTIuZaB+TS8wIX+EiSXfZWMb
         iYhfhbWv019+/e3QKxV9KopxXotQagqmHtd9oP73D3mFQgS0ad9ilrCo0Ds0I4Y5tPJR
         cMjyJhchTNHXEOdNQE6j0fmNtUQWKYPwGkeo1XJn5JeAsT6JoPITk3yHAT51TDdfp9q+
         a0+Qd40JKj50Kryg3YQGUozS/FeZ0NtyeyEg+3fFrdAwdpQfVCbU+DuKCLQ7XhztPlvE
         YlGQ==
X-Forwarded-Encrypted: i=1; AL+hErEi92wbLpwbKIB7qNbTv26oJw7XpSkUCuhLejnzI7aBOBk3CxeqDDdPbBmXNcYhuO/3TquiJHIvXgg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Tfpxv/DEXfGp8LKBewaQ0oRBNFkDFwwuNTo5a8ZnpfKp5DihD
	dAKywKeqKxKjzZ/oaiUd1p/Zf2CZCPAZiijkTjWTsWsYHsQqDqj+bRV/GkDwgmCb7kw=
X-Gm-Gg: AYBFou3FbSS1ZI5Qv8q0HOEEnw92c1dN9dXdRVQ7t4bY/KpZpPEGqlvh5i38Z5pWg4+
	ILEIpyWVUCIbbMreYJMxujrXtBwIfmF9JbriODGUwsqAJWJHDX5jCEqEixkp2jPCnIBym/eXVnj
	URbT0j0FxncG6epUgZyXfvBRg8i5lfbCbFYwRnB3CO4W8qrDpYMyXqTQdsU3lKZznjswj94gUim
	cCqaAKVzkkiID0d70b6cv0Dd+UqCjy4Mm14e2ZKXzvvmZl6MbrJmSHIpSj5QKgRMDlrZXk4hiFA
	3FjH/3pyJiygEx7FbwKrb7qJ8Uiv91p2WPjP2BopeRhemenw637F9zYWH3JBadSOebmlmDZAHQA
	5AuT/BFWvemNw3YUDIxjsRe1U9/uJbp4peD8uKdJilS6huxrXXeZXdQJsVcW09gxTp2+6pS8N9e
	NooVH+jWEghYAtkfzFZ/rWrc3Xmfw6yK+1y7Oa/9uyc4ei3P7XmhmfBC02fTb+T+87ydMDVeNZi
	evZ+UO/dGrIejAwZ7CqorK2xsy1VE9Lw2EZ1llvE/3pUUgzTFPzWDpk/WcAouTNIyvFNsSLPmoD
	EAU8hQKByGH1LEowmUhpID8fStWIYOYFScNPThvdUV35DMAw9uQZo7vq5nU0Bfm87pBLjiW4S/i
	LEyAwmv2QHBtIAb1b8G9l5GxcAcpTVCh4xXukAo0WK4d0LcX4/X2jbguEuFgS2vLp81wcxHPf2M
	RFcxOvZLXecrnzbXy3bFpnTDB+jOATKqCIL+nP8E4LKQ==
X-Received: by 2002:a05:701a:8458:10b0:1a7:77ae:11f6 with SMTP id a92af1059eb24-1b53a3e47dcmr1951148c88.17.1794913414396;
        Tue, 17 Nov 2026 03:03:34 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316d9c2sm36604525c88.7.2026.11.17.03.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 03:03:33 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2] iio: light: bh1745: fix 16-bit register accesses
Date: Tue, 17 Nov 2026 16:33:25 +0530
Message-ID: <20261117110327.198084-1-kapoorarnav43@gmail.com>
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
  little-endian, in a u16 to a buffer whose scan type is IIO_CPU, so
  user space gets the samples byte-swapped on big-endian.

Use an __le16 buffer for all of them and convert with le16_to_cpu() /
cpu_to_le16().

Fixes: eab35358aae7 ("iio: light: ROHM BH1745 colour sensor")
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Changes in v2:
- Include asm/byteorder.h for le16_to_cpu() / cpu_to_le16() (Andy)
- Reword the trigger handler bullet: the samples are byte-swapped on
  big-endian because the scan type is IIO_CPU (Andy)
- Add Andy's Reviewed-by

v1: https://lore.kernel.org/all/20261116194214.45174-1-kapoorarnav43@gmail.com/

Compile-tested only (W=1, checkpatch --strict clean); I don't have
BH1745 hardware.

 drivers/iio/light/bh1745.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
index 2b8ff36071b8..e2c03cd0d1e3 100644
--- a/drivers/iio/light/bh1745.c
+++ b/drivers/iio/light/bh1745.c
@@ -17,6 +17,8 @@
 #include <linux/bits.h>
 #include <linux/bitfield.h>
 
+#include <asm/byteorder.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
@@ -421,19 +423,20 @@ static int bh1745_read_raw(struct iio_dev *indio_dev,
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
 
@@ -503,6 +506,7 @@ static int bh1745_read_thresh(struct iio_dev *indio_dev,
 			      enum iio_event_info info, int *val, int *val2)
 {
 	struct bh1745_data *data = iio_priv(indio_dev);
+	__le16 value;
 	int ret;
 
 	switch (info) {
@@ -510,18 +514,22 @@ static int bh1745_read_thresh(struct iio_dev *indio_dev,
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
@@ -547,6 +555,7 @@ static int bh1745_write_thresh(struct iio_dev *indio_dev,
 			       enum iio_event_info info, int val, int val2)
 {
 	struct bh1745_data *data = iio_priv(indio_dev);
+	__le16 value;
 	int ret;
 
 	switch (info) {
@@ -554,10 +563,12 @@ static int bh1745_write_thresh(struct iio_dev *indio_dev,
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
 
@@ -565,7 +576,7 @@ static int bh1745_write_thresh(struct iio_dev *indio_dev,
 
 		case IIO_EV_DIR_FALLING:
 			ret = regmap_bulk_write(data->regmap, BH1745_TL_LSB,
-						&val, 2);
+						&value, sizeof(value));
 			if (ret)
 				return ret;
 
@@ -741,18 +752,18 @@ static irqreturn_t bh1745_trigger_handler(int interrupt, void *p)
 		u16 chans[4];
 		aligned_s64 timestamp;
 	} scan = { };
-	u16 value;
+	__le16 value;
 	int ret;
 	int i;
 	int j = 0;
 
 	iio_for_each_active_channel(indio_dev, i) {
 		ret = regmap_bulk_read(data->regmap, BH1745_RED_LSB + 2 * i,
-				       &value, 2);
+				       &value, sizeof(value));
 		if (ret)
 			goto err;
 
-		scan.chans[j++] = value;
+		scan.chans[j++] = le16_to_cpu(value);
 	}
 
 	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),

base-commit: a6d9114f68c4b5507b2d945bd6d1e37415f913c5
-- 
2.53.0

