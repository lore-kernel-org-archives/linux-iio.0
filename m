Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794998744;
	b=zR3njxYT0o+yfjiSgC+AfUbsOo3mlytDfwlthzSjhIikVQ7d529ahvpX0bcQTQtcCFWE
	 BZOI+1NJV0L0giAItVRlOtPRWRiG6OBoqjhLlxkwUaCXsEZBbJTgPXU8s7VakftohH2n3
	 lH9PYOgMKuvXqi1HYf42+tPnTzZGRYh+t03EypeUVgyFPW6mD9veWMsi1bm+0nmyI36W3
	 CU3TCIaoQCFM2W3SoV3bn7XUf9MdidSYN0B6PDWBwxcJr66TUY5EK6E8LppD0tlSVv/2c
	 L0pFIUPVIXoPYVitBcV0mwrJdu9LqBmOHsFCwCDA8R+ootTgnBZRTDXIFclFtBg9csQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794998744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AiXntOOWWCJfb4TGuJ6oSSVg/cGdXJUJaojShUwh9+Q=;
	b=nW98f/9zvjql3VbVnVgRMMPHSbjL8HKJUrAJ6Tf7Yf2MhudUX+d7jK7z0JosMEuXhkiV
	 ppeDOG670VpQ+TQouZ+hdRIN+zBYGSxvyPlF+aWAmF9fQp9EI1pwCV4XOMBbZzoa/qrue
	 ke/xw1yZ0sQ2Cruy1E4LMwUDo/4pW1yzAETKec8cSJZx2dp4g9p6HC8jhBipTbNjg5BAE
	 J5vPXfYGOwmLYXEhqaFMxzkaR0Ju6KxqLvQR5qQXtPkX+38zQBCl5r0npcVVAnJtXfo7X
	 QvXP5KfOhOtnAwPHjTmPdt5K8vA+qlYHKWN19Mqnbl0xLOM0b+rROHkKpnToESn3Czw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JhHoGZx3;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC56606A330
	for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 10:45:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DC56606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JhHoGZx3
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-382ecd5cf2cso455488eec.1
        for <linux-iio@vger.kernel.org>; Wed, 18 Nov 2026 02:45:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794998743; x=1795603543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AiXntOOWWCJfb4TGuJ6oSSVg/cGdXJUJaojShUwh9+Q=;
        b=JhHoGZx37+/5tKT3WzBQUpRpgtGpD23sl0PwUs2dAjeTw0boTHa7nxbxGiiO3oG8Se
         I9x+BeyiZ4/igwRhoe1gHfstgfayg0y3IJ3ObCFWJLCK18igY6YJUkQH/dK9eB22yQZi
         miXjQn3tPfylhk07UnLAYdcMvzGSGZmXC+TBV+NWElmWGVL+mQaEiEm/c6bjD2bVSU80
         nPZbJAPgK8hksQbkKQHjivbqTcBTXY5DcBmuU5wopD/FHfH2aBI/85i5madrJ3PFpDfS
         DrhenMUwGOUX4BJBTu9ARuTmLO4JDH+0QraTz3Ftx6aWE5cppkUQx8u7gytN56ZEw7zh
         RKGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794998743; x=1795603543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AiXntOOWWCJfb4TGuJ6oSSVg/cGdXJUJaojShUwh9+Q=;
        b=JVJgD4LHbzpBuMrZDn8bH36oPQzl5zzwrP5OzzKjkFeUcjSA/a4bGDyABbBTARglDB
         U8lbbHUFrIDPB5DSVefe16SC2HG6V6Raz4hwSHiX4dL7rPlBaNDB8AasabwV9b+DxGan
         GcNME6eqHZjdudHE4A3leCWDNkqw5l5gaQjMQPS4vxDd8LaYgUuBLUCV01khKUrUmHeC
         mZQ5+ZcIIx7NpqP9Mku2cr58COGCU/XdJfVkqV1d+ouJTuR+xo3VXb96HghCs1daj0G3
         VcAEjfnBHo5SVhB4k2JhLt94E67HOEIw+sOR5dXklVQaF0chm6/SCiA+aplhmMndKhLm
         b9Nw==
X-Forwarded-Encrypted: i=1; AL+hErHxYSdEgv9hvOgy3UiRWL3PQQACQuvgYGSFbSJYyW90zDHfDFciqZz+lfl+D7oB2WD7qS74vIW80js=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ERate/N+Uf9DPkXnZ3LlvnocTBWNPWED90tMkxInpWJ+lGctE
	3sU/ZQ/ZXF4w2cbxrXwg3GxvS87GBVdx0VfpHzl8TeOGwGxBlnv1frG6
X-Gm-Gg: AZFdTZc4b637Tpc8HMju7IEYlSJAwZQFf5VA3+Q4F0ig0HSnSPmsD0Jz3wnAw45XH5a
	PA9fXn+08+jDOjObw3bSdRYXPaZKP+mwdl5BVn34WRK5A94SCx2jeyTfmLIrIPtRLwe/JYTKccJ
	/zUgHr9nF724fo3Dl9aNMIVWdOmCW+p6p2dLEK817CojmDhR5S6ApiBlW3nuUFcR6bUvkL5f6zx
	yBolCOIsnRstgcJdgHmwH4ST5H8hnsMMt7NVKmaLocS/RViprzZgsH9Pr3Fi8mR9xLMbzgcfsPc
	/2RzTAzseFxH+kRwvHBPmoTcrBkNeWMJCGd3j+4PqbFQwOV0zuYVr8LWxIgaCC0EFxIdAYbtgyc
	3QzBgUN6+bWgmmanu4SAwOlJAtw+CIPaOGY6aoGYlhMCRuONU0HqXvZp/eXMbO4v5Zu5Vs+Snuu
	CExtnyTb0kQdResnMvqDadWBCdEsON4lQdA3/k4b6JRNvc7p4rPU048Za3/OL1DHOM+9hax4Nkw
	pOxX3s9THpD5MaHfgE+YpB1dz4Ud75KnrH81bnPeFaeNWG2I36k4JwpbiQYrhllZDg4vD8erMU3
	9eM9TAh0CL4tcDk5yefPRPHZvR8RKoiXOwSqoVhXWcbnLnXn12xM+miYodzlFbRC3v3FIYovPFC
	PIYeUjN7CqIIBGJMIuqdDUMWIDukkBOnJYRDUUVaNJIe+l6eDX7SSny3WBgWtJVzaGeKQWnf9Z/
	eUt8vSeh7PWftYvv/1eEq+CI3jO9oUOOExwL3KyTo/ty1aj9ekYBDH/547KQAvD4g=
X-Received: by 2002:a05:7300:e9c8:10b0:37a:15c:b8c5 with SMTP id 5a478bee46e88-3810bf52de9mr5393573eec.2.1794998743427;
        Wed, 18 Nov 2026 02:45:43 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a6304efbsm11906478eec.7.2026.11.18.02.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 02:45:42 -0800 (PST)
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
Subject: [PATCH v3] iio: light: bh1745: fix 16-bit register accesses
Date: Wed, 18 Nov 2026 16:15:32 +0530
Message-ID: <20261118104534.159876-1-kapoorarnav43@gmail.com>
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
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Changes in v3:
- Include linux/types.h for __le16 (Andy)
- Add Matti's Reviewed-by
- Rebase on the current fixes-togreg

v2: https://lore.kernel.org/all/20261117110327.198084-1-kapoorarnav43@gmail.com/
v1: https://lore.kernel.org/all/20261116194214.45174-1-kapoorarnav43@gmail.com/

Compile-tested only (W=1, checkpatch --strict clean); I don't have
BH1745 hardware.

 drivers/iio/light/bh1745.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
index 2b8ff36071b8..d312ea278f2b 100644
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
 
@@ -741,18 +753,18 @@ static irqreturn_t bh1745_trigger_handler(int interrupt, void *p)
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

base-commit: 51b83d4cb0f5c1342868c7aa1edbf0c4867477aa
-- 
2.53.0

