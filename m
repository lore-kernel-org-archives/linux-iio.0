Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC18432E130
	for <linux-iio@vger.kernel.org>; Sun,  1 Mar 2026 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772396739; cv=none; b=sEB3ngmmQgCrBQiFhdf5Nc92JB4M6ki6bGZSnFTqg5JTxvvskZRtcjq98lZqSjQP4QRKOfLOKav5MmznH30mSR7D7IdCR2vYeD9tZU9AOpGNyBAufUJC3yOL7uUtz3D14ZasdHnqeVzGOi4ltewHdPdauJ9bii08PvKd/HFj0hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772396739; c=relaxed/simple;
	bh=LcB+sMpnVNwP5Hxc7hd6TIyPDdQxqO0tl2qKUWZh7to=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RDipfRmi2mGIN3DHuyMWrBo6CO0i9gBlCiyl1gVOxx5OOICad/nkZC5iHvBDUod4VqmDua5n192xd3Kq4aQeOuNBVBa4ohF2L1a984Nt+Tbdx4OVCDVPNq65bSeg2PVUGs/Y0Y4CO7JBNbnhyMP39npVLxdWMWc1RIsu0P5KyTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=fGMqMVee; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fGMqMVee"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d513bc15c7so5215948a34.1
        for <linux-iio@vger.kernel.org>; Sun, 01 Mar 2026 12:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772396734; x=1773001534; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vt0Qupd8WEsTD7s9mClwuAaT6mwAmhQXmzDPpUDpF44=;
        b=fGMqMVeetsKlc2x4zuspGaa481nIczOd7szWlq9DxO8/Q+1dn+CR2TdEE55fl6YJOV
         JvfO0qVIzI3Qj+z/yRk4KTbZ71XoQD7TDx/ffh2LRR9enHE0zsDGtzlOwIWHlgLMQWyF
         Kk6s5C0DIQpBgsFJVDJ3j2WtMM7hgesuqNfC+CFZjf5GCqh5r3x5w6d4tOeH1/ZBjx1a
         7wOzPWm4c/kIqQmAQsA1Qsu7eNUvhEKBQRrh5qGWSPlXZWZDbjFctLoWzOEYJd3agDNN
         5unboJeGBJUIysZCbCvjNnz5rUOfkxy5EdkXCX7v2Q6msFa2JPwWFsUVrRvbXHKlP+Sm
         b0Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772396734; x=1773001534;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vt0Qupd8WEsTD7s9mClwuAaT6mwAmhQXmzDPpUDpF44=;
        b=eUSMyOppxuS3ALWUxgX0F3jLttuB31v76wT8X4Y23I4Y2KPZTNv30aOZIV6jcezmVU
         w2varo24axqpr6jolJGAQMxO8VIvQKzEWt8DDJxPWngvR3dLmHRpwNbGOTwsZrFLdkGW
         MRybbPr4TVCFWQRRpGdYp2CjSSjkTTOO/txGTAYLu6ZfMsmZiyR756Sh0pTI8+etEvtJ
         u6NzkA4T2BeukgIe57wosvMiEfTgnDr+ck8q1jWzPUs6PWc/X6LKiL6jkI2K/EDTKLd9
         Bn1Yj4fl+4ao2XcQuyBrfJ7lkE9XtT7TyIwS4fz83ZHzR8wmjCwH2R/AfGXYJTIdIonn
         i7zg==
X-Forwarded-Encrypted: i=1; AJvYcCVPa+/Tll7Vythi+a4ffoR7RN1ofUWSNdy8++LpZpdLGAfL+dUYo9R1ii7bKR5iFkPiSP/LKuSaO7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfBPg/QTQgkfREQAmjZ6DXIdV4wE7o5N+WsTFsPoCVOChMCgzP
	p+FsbxGS1zaqySRsGbup59cs2f8PZL2MxRcTH5pyAhcH6WX/3c/xJ4h3AQwppYgtqjZhWjeIoo/
	WlRee
X-Gm-Gg: ATEYQzwzdhpMQ0/BgWULdoXDBaGJtg2KpdhhkqomCBtln4+bTjqOMLZIA+YmiV70z5F
	E2d0xhzlxjpk6p9LOkSFsyLxO2t0/xynn4YGPn40/Q1hjrzSZAx14KI4bkD0752uIguuk4elmkU
	hDszROzw1uRBKrFBHtbTEwjiqaEHR9JV1GzRhE2++8EGBY9K4DQPfjz5KCOp8G+9Lovwemh1xB5
	+XzF9rMZNqMEE2q4uqw5Fr354cVUKbR8myAFfrhIyqgaJjr5D28TDavLISwYpzhywAA9Hah8YLn
	xFzVA513tywblX2wv+Hdp9+tMhnaD5SXoO1iPUjR1wAisdUgkaRgBc8lXI3JXDgp5Phbg2uydsC
	sv+QghNg3AQR3xmVtc3EGPhNXc249GObRzcpS3kS4UOmwMQxmU6yVmwH5CjshGyrp10rfUDE895
	gDidyScdhUhOHBH4XamREiofeIUcXr
X-Received: by 2002:a05:6870:6c10:b0:3e7:ecd7:b292 with SMTP id 586e51a60fabf-41627000a52mr6907854fac.46.1772396733843;
        Sun, 01 Mar 2026 12:25:33 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:8b9c:d657:204d:5a5f])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d277316sm10063025fac.17.2026.03.01.12.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 12:25:33 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Sun, 01 Mar 2026 14:24:52 -0600
Subject: [PATCH 3/4] iio: buffer: cache largest scan element size
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260301-iio-fix-timestamp-alignment-v1-3-1a54980bfb90@baylibre.com>
References: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
In-Reply-To: <20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Lars_M=C3=B6llendorf?= <lars.moellendorf@plating.de>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Lixu Zhang <lixu.zhang@intel.com>, linux-input@vger.kernel.org, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3558; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=LcB+sMpnVNwP5Hxc7hd6TIyPDdQxqO0tl2qKUWZh7to=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBppKCpuTaFWQlUSMrljCvEf1iOJy7zpeU4zm/6/
 EVY/RP6EVGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaaSgqQAKCRDCzCAB/wGP
 wIH7B/9F3hxKaQC3jEziUe9nDueg18GlWretvM/l+UepH6LTejo+R5E57D16jcq4uVvCi7+di7U
 nVCShwaDddDOCqVD/ceUjexAVdx0C2nMZf+/nI11TJbi1tYsmHc0e4smX4rJ/vWq7xOi+BYiPYk
 oHBKEPxUXj6X5xSAofLicul8OjKXVYarGEVaBRW/m8xzeDWOz1oA/KzULAkHdYa/ULilsnhSBMe
 7w10ohtxRbXFrkcVai97AoSQ1dCif4V0kRO4hDuMDzmuXJAUCQ1GazzGPd/gjJmBjUuEYAvneNF
 zY5WjVV1vhK02HtOmbarvU732qYKx471YUYqP0QkARXZHIgr
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Cache the largest scan element size of elements enabled in a scan
buffer. This will be used later to ensure proper alignment of the
timestamp element in the scan buffer.

The new field could not be placed in struct iio_dev_opaque because we
will need to access it in a static inline function later, so we make it
__private instead. It is only intended to be used by core IIO code.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/industrialio-buffer.c | 14 +++++++++++---
 include/linux/iio/iio.h           |  3 +++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 71dfc81cb9e5..83e9392f949f 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -765,7 +765,8 @@ static int iio_storage_bytes_for_timestamp(struct iio_dev *indio_dev)
 
 static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
 				  const unsigned long *mask, bool timestamp,
-				  unsigned int *scan_bytes)
+				  unsigned int *scan_bytes,
+				  unsigned int *largest_element_size)
 {
 	unsigned int bytes = 0;
 	int length, i, largest = 0;
@@ -793,6 +794,9 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
 
 	*scan_bytes = ALIGN(bytes, largest);
 
+	if (largest_element_size)
+		*largest_element_size = largest;
+
 	return 0;
 }
 
@@ -848,7 +852,7 @@ static int iio_buffer_update_bytes_per_datum(struct iio_dev *indio_dev,
 		return 0;
 
 	ret = iio_compute_scan_bytes(indio_dev, buffer->scan_mask,
-				     buffer->scan_timestamp, &bytes);
+				     buffer->scan_timestamp, &bytes, NULL);
 	if (ret)
 		return ret;
 
@@ -892,6 +896,7 @@ struct iio_device_config {
 	unsigned int watermark;
 	const unsigned long *scan_mask;
 	unsigned int scan_bytes;
+	unsigned int largest_scan_element_size;
 	bool scan_timestamp;
 };
 
@@ -997,7 +1002,8 @@ static int iio_verify_update(struct iio_dev *indio_dev,
 	}
 
 	ret = iio_compute_scan_bytes(indio_dev, scan_mask, scan_timestamp,
-				     &config->scan_bytes);
+				     &config->scan_bytes,
+				     &config->largest_scan_element_size);
 	if (ret)
 		return ret;
 
@@ -1155,6 +1161,8 @@ static int iio_enable_buffers(struct iio_dev *indio_dev,
 	indio_dev->active_scan_mask = config->scan_mask;
 	ACCESS_PRIVATE(indio_dev, scan_timestamp) = config->scan_timestamp;
 	indio_dev->scan_bytes = config->scan_bytes;
+	ACCESS_PRIVATE(indio_dev, largest_scan_element_size) =
+		config->largest_scan_element_size;
 	iio_dev_opaque->currentmode = config->mode;
 
 	iio_update_demux(indio_dev);
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index a9ecff191bd9..85bcb5f8ae15 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -584,6 +584,8 @@ struct iio_buffer_setup_ops {
  *			and owner
  * @buffer:		[DRIVER] any buffer present
  * @scan_bytes:		[INTERN] num bytes captured to be fed to buffer demux
+ * @largest_scan_element_size: [INTERN] cache of the largest scan element size
+ *			       among the channels selected in the scan mask
  * @available_scan_masks: [DRIVER] optional array of allowed bitmasks. Sort the
  *			   array in order of preference, the most preferred
  *			   masks first.
@@ -610,6 +612,7 @@ struct iio_dev {
 
 	struct iio_buffer		*buffer;
 	int				scan_bytes;
+	unsigned int			__private largest_scan_element_size;
 
 	const unsigned long		*available_scan_masks;
 	unsigned int			__private masklength;

-- 
2.43.0

