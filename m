Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858144;
	b=QFG0cWxINmUlvLnQLhmvuKr9znoxtJDiDgbxC2yCY88QG+o9e/rv018IjOgYxWOSXNMJ
	 mfN/2FBY6UqEruU1tOrAk84F5t6dIpFmryJ/jjn0tct/f3gAGarROO5gSdgJOKKzsATYQ
	 PO/9sgPYGX76UDnNB6TBQ2gYtVfar4vcssNh591vq9ATv7+uP4aeTNCMRqL5Zfl9pQIWN
	 z2o7ihJBiDLL9dAVuvqH/zvErw8732DG0BROaai+1tTReUMadSGqd0KzGM3U2eaDWAVyd
	 DrGWfSDOroYgWL2IugHTdjddJka76+pvs3UV+qJ8Nkywu77DbFkxcGg1u5WHaWaxVxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YQ2w1SKYNQZpDiN+RPlgH5e5kIzAXTbHX2JmN1bVYs8=;
	b=OrJ7l4cB7tqKZ5UHDAfBfdB4uFYtkzOKOzLh8LREqlJsKFEdAksejEMXDURYGfGRC9k2
	 izil+3099OquyxYsqbCvYOD7q0zkA3sYxzehXGVKBbn28QVkjD8KElTqJhrnoC2MLoobz
	 e/8ACJPVc4cSZnaROERqO/og5jSXQ0V/NTh0esNENI8siBG7c105LWzvG+oSzOqtiZiKn
	 Tnxlf4dtAURrGIa1+t9LheaSTUVkIyN/3S4FUHMbeFbkko0J4CPnHws+O5XzhWQmBNn4i
	 tYfAOWjmRHu99jnbLugmnTIX1QBxM/WXHaiXn5RrgK+PXjdrbOsmxeZTZgLoGNke3Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="E/0nh+BP";
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B16606A322
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 19:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15B16606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=E/0nh+BP
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-37628596783so6474523eec.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 11:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794858143; x=1795462943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YQ2w1SKYNQZpDiN+RPlgH5e5kIzAXTbHX2JmN1bVYs8=;
        b=E/0nh+BPbckGUnmAJe4GE0O8g2kmQhtn83sBlsn6Y6a04e4BISc5m2L5hTs8UDvzb3
         bYgz38bh4PLy/HK0ueN7+vPC6ApKmZseRXUgu6VHsmxiSNX4QXnWPn2tt0Xdp8bdBow7
         s0K1VO/EU0ZH+Zsw2UDxxmp97O1j82ms48rXuF24tbc8BEwQomHrzLeAnDTnbOWBysN+
         Nba2PmAvy1FGSbJpDZArGIKwhX0e1K00rDja9wDqDSAKCq15IWG+88tOpiSNa1xD6aXI
         +7k/lAFovvO9Tp0KfypCpnNi0+NG9dv4UD2kkbDGkmWMxwf2nqyJzFARVY2u+CvwugC1
         lTsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858143; x=1795462943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YQ2w1SKYNQZpDiN+RPlgH5e5kIzAXTbHX2JmN1bVYs8=;
        b=oNzfh5E298TOpG6lObcVgx9uOnPZ1/YrHtzX+y7ygNXBf6PY4Xc6Kn902DIBOPZDyF
         reUYDaklL0v48zgK/f4/nuEPUMPvwlwYKMcb0VZzAOo71NZJ5cHGnE+w4Bh/rApeVC7q
         e3HU+GIsNgSN3sQmua5oJl3PZi7YEJ3M3vTYrcHBaE3nVsl2B6+xoJo8S3vM66l1mAyv
         nRtsN6im3qguwNJDhac+unodG/tO6q790ZjZrF4s2Ale0p03HQX3GoPQbLVQMHAQTbCk
         5L+sKaPIqnCekLxURcW4wnhnNkNKWr1RbL86SPM2Xe2TkCVF0VxC8ZvSg94TdGuPpS/S
         Y06g==
X-Forwarded-Encrypted: i=1; AL+hErF4lFTyxT42CJP+xv3fZAHkqMvXhxcNoT75M9zRLpmqxtHkaNuCsq9GdkfD9mze3D2dkt2L9arnEhQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ir7xtUadJi1s8hCEdmpz8/0CNeuNHJJ19tpJLA+J+BDmyyipK
	TJ0YiecQPE600k3vbSQtUpd8BgZN81KS17vy8yBGusGpbTHzEE29LneV
X-Gm-Gg: AZFdTZcqG74lyeMfMbL2rBRa++V/5scISza5mJoklSoOTT/+1E6LJeS/KnSNgMcvghc
	5xcLYAkCwugmpJXywO8Ho2iIiVBO0V5jVXOf3nsKQRZxRpjjeaOaFxn8X25HI+u/iVYqhQKW23A
	A90SLDfwGGM21pS0RL3rh0mgbXy/Tl+ead/gw7Fxlh+elVgmK8NlmGj12+8zY7aLlB7JdtNDFCv
	SHVkALsczI6ebPle1uzlU/qB4gxh0BEVPMaPPyvbjAtEsJPQYm2LPObHef9VGQEBrYJzmGVqUaw
	Ri/2HhbE/Wi76bl/nTjPY+HtSXU847C0iAAw0AQYasOk114IiDzoRgu9UPpaG0mhHZUMYgj50zE
	HEAC7EzA31n9FqCUD8Cy12sE8eE5iX2P4jatn2svXehEKMS0pwQQTPqXHB7xn6WTwImrFdhoFL+
	gQpVsBmCxv5jlS1mxTv9/rfVJF9oC5UnuggJaGoWxaAWEwy8c11Fk8d+OTMTqORyaVwL3JUvli5
	OrMmjXc2dmoOHTdlmAvUun1uny/HM5DlQorfwjozNTrhDXyRr5Q2/B5eKxcOEPmmYBD32tySIeT
	DQ4c/wUsZhbGYM0pw4OPV6P/FF6+Vtyt/pVEO/ivQ6LPM3HuDX5YMZjQYPOwEaXRW0K42/UWfzt
	wEq2B81XtM3YomwJxVaJQ4fbE/0sJquVoXvDIKaaHw3H5YjtATrD3YMqI1FC+tlq02S38pbDRsG
	wlFQjG43H6v56VS6RhXmOvysrJDqfBKY6l391H4XJO1ZxunvAp1cn1+F7PnKStyeo=
X-Received: by 2002:a05:7301:d189:b0:36e:e349:f2cb with SMTP id 5a478bee46e88-3796628e28amr11639657eec.19.1794858143008;
        Mon, 16 Nov 2026 11:42:23 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-380e031f3e5sm3238446eec.12.2026.11.16.11.42.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 11:42:22 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mudit Sharma <muditsharma.info@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH] iio: light: bh1745: fix 16-bit register accesses
Date: Tue, 17 Nov 2026 01:12:10 +0530
Message-ID: <20261116194214.45174-1-kapoorarnav43@gmail.com>
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
- bh1745_trigger_handler() stores the raw bytes in a u16 although the
  scan type is IIO_CPU.

Use an __le16 buffer for all of them and convert with le16_to_cpu() /
cpu_to_le16().

Fixes: eab35358aae7 ("iio: light: ROHM BH1745 colour sensor")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Compile-tested only (W=1, checkpatch --strict clean); I don't have
BH1745 hardware. On little-endian the raw read currently returns the
register value plus whatever was on the stack in the upper 16 bits of
the uninitialised int; the threshold read has the same problem through
iio_ev_value_show(), whose val is not initialised either.

 drivers/iio/light/bh1745.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/bh1745.c b/drivers/iio/light/bh1745.c
index 2b8ff36071b8..9c14499f848a 100644
--- a/drivers/iio/light/bh1745.c
+++ b/drivers/iio/light/bh1745.c
@@ -421,19 +421,20 @@ static int bh1745_read_raw(struct iio_dev *indio_dev,
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
 
@@ -503,6 +504,7 @@ static int bh1745_read_thresh(struct iio_dev *indio_dev,
 			      enum iio_event_info info, int *val, int *val2)
 {
 	struct bh1745_data *data = iio_priv(indio_dev);
+	__le16 value;
 	int ret;
 
 	switch (info) {
@@ -510,18 +512,22 @@ static int bh1745_read_thresh(struct iio_dev *indio_dev,
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
@@ -547,6 +553,7 @@ static int bh1745_write_thresh(struct iio_dev *indio_dev,
 			       enum iio_event_info info, int val, int val2)
 {
 	struct bh1745_data *data = iio_priv(indio_dev);
+	__le16 value;
 	int ret;
 
 	switch (info) {
@@ -554,10 +561,12 @@ static int bh1745_write_thresh(struct iio_dev *indio_dev,
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
 
@@ -565,7 +574,7 @@ static int bh1745_write_thresh(struct iio_dev *indio_dev,
 
 		case IIO_EV_DIR_FALLING:
 			ret = regmap_bulk_write(data->regmap, BH1745_TL_LSB,
-						&val, 2);
+						&value, sizeof(value));
 			if (ret)
 				return ret;
 
@@ -741,18 +750,18 @@ static irqreturn_t bh1745_trigger_handler(int interrupt, void *p)
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

