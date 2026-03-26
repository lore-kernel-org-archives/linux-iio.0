Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADED3B6C05
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774513116; cv=none; b=oCCDaDr2gi80+4hcIfPsCRcP0wZelOLvqBoiiF6KZbV2kTGuFBJAuOrw57F48PeSCJbVGSqHCefd+sc0+mJCFO0zeD0O5r8tS8nzx1A99ZOQgFIp6s2f0o9PtxPRVqi5kh34lrrv16MDlxvX5ZPU7+fQ5kZqwLnk4c3nVDyWALk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774513116; c=relaxed/simple;
	bh=03TGsdT9IN22DWIa4T5/yk8qhebU5uz/xxamWSKzVpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OceHMv6e/1RH9Iz8z5Ymb8a3Q8McIf4XVQH01ThUi9aqId4QmZ6CA6hGm1IyGdAoT9wdFptQVVKETVLQ+OzSeQpJ3u6E2LeerpugEUnF46lsFswo5ilwF6TVmNDHD2/lXa7lunkoWZPGowZt8Q4SHDsb6dL/sU0m0ebXg0UKcSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NaRxx/km; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NaRxx/km"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad9f316d68so3477685ad.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 01:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774513115; x=1775117915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+be2bfxKoFJe+3GjEg/OypoIWjV3Qxq5fDkIn81zME=;
        b=NaRxx/kmMkKBnOXXmNWrb3AONvUekpph4voEHXdcNntgbU2KS2q+G6B2k8L/ULfetT
         PBlXOCAIJv6oX6YUnG5IKo2yYLEG1/bJAXaOOlsPFD5geY84v+6CkTOgqiDvCQnWSORm
         ZTZArwVlHGCi2KWnZiwcxgpzF8A4zAL7QE47D4argcogLvFMbPyLIijnBQV2FmHwWolh
         lVdfx97gGdaNDwMKLE2aDGD387gcK0wE+0r6e7BYjTSzGx0tBAXuhuV4AxXbcOhbuOd+
         FizBqk19nyLRpoiOoNl7BVeOh7lxNnTw+WekivkrE1Gcic3sVaAhZYzuOdlCENtrECf3
         q1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774513115; x=1775117915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e+be2bfxKoFJe+3GjEg/OypoIWjV3Qxq5fDkIn81zME=;
        b=j0wajl532iSHuYJpVLJsvhaL+3XSXOo1PJUGOrhUYm159WwjOcO2v7Hf4n+mWbKpm8
         zU0BQLAjj3I/iwB+HsT8czT1xbMxv/Mtv+0OvX/oVmqdqKGnjY7H+zLVqUPjeLuo+ZCL
         jKj2jLVEpBBMUpPy5CF2M9HRql6BqstZM/rIb8vhM8pOWLKk8Y1RincVGvB0sg5CDgMD
         5VWJiZe7GvT3HJkyJW8Rva0l3VJ+u+DBmjasQl6x5VDzKIlIDciLJ1uBrC8RYlQT7cWh
         U1sNmetiet/GOtivnLcTKKOXQ7RXVeL+XWDo0YMsyShgbXjYdVpQuD+5ZewT1rhuIkL9
         BETQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVLWiCwNa7LuXQcltwOrXMue65RbFtfdsOwaSqGht4TVlEbwJqu6MBu8wYbVVr6/MyPhqmPZdKLuk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6wMYo7O4tW965EoyMf6q2bQagIOUPvaE680t9O5rLCb+8asY/
	yp1S9+FWETNB8Y3plr0OzxWm7LHSS3Lchj64BIsnE/YZA7Yv7lKXYkOp
X-Gm-Gg: ATEYQzzsEDgGvd26Ba/qJYWU4S5WobazaHxr3LRykoqRZZBap9o+WMckt0KyeTgCOMw
	GFegB1Jq7I89pygQ57Mvt2slieDeRVGtuEqG+MOfjB8Fjzfl+UNqgQbmF+sqAGKcU1ymfdcfWKA
	qvQGjoUZ/pNjgAh2nZ+q0IUxFfsvoG2QgH+I4vdkRLEVIzY1CsNNkIBn3+Y+09QqGEpT8wi8XWp
	hG6hIIdCpOVwa/p7FLfFluEm7GR5gbOuQzko6GsUAxvyGNpx2meG19iJ5IOJ04fSXnWdWscCM95
	vE8X1c1hwAg/MlwldGrI6y76wj9WAYsTGBXycyL8g3D7oLOpEjdawOu05zrdwbgs3ENrgFLabVE
	d3PK9IbVhBGcI3jJAYyxUl7Mi6lqqQvQFMILQRRO095zDK1oarKFUj8qscDavLUbCZ1kOnLrq9+
	itV+TpFgkfzsVlHlpEP8Pn8DAMjk966JTJxhHQidM/rWhbsc+bxcMTHJrozII=
X-Received: by 2002:a17:903:1aac:b0:2ae:5797:e082 with SMTP id d9443c01a7336-2b0b0a758ffmr78266915ad.24.1774513114611;
        Thu, 26 Mar 2026 01:18:34 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc87e6cfsm21855535ad.39.2026.03.26.01.18.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 01:18:34 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: kees@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sanjayembeddedse@gmail.com
Subject: [PATCH v4 4/4] iio: ssp_sensors: reuse preallocated RX buffer for SPI transfers
Date: Thu, 26 Mar 2026 13:48:15 +0530
Message-Id: <20260326081815.925373-5-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260326081815.925373-1-sanjayembedded@gmail.com>
References: <20260326081815.925373-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Avoid allocating a temporary DMA buffer in the interrupt context when
handling hub-to-AP and AP-to-hub SPI write messages.

Preallocate RX buffer during probe and reuse it for SPI receive
operations. This removes repeated kzalloc() calls from the IRQ
path, reduces allocation overhead, and avoids potential allocation
failures under memory pressure.

The RX buffer size is tracked and allocated using devm_kzalloc(), ensuring
proper lifetime management tied to the device.

No functional change intended; this is an internal optimization and
robustness improvement.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v4:
- Use preallocated buffer and stash a buffer that gets reused each time instead of a fresh allocation.
- Link to v3: https://lore.kernel.org/all/20260315125509.857195-3-sanjayembedded@gmail.com/
Changes in v3:
- prepare series to have all respective cleanup API support for the ssp_sensors following input from Andy Shevchenko
- Link to v2 https://lore.kernel.org/all/20260311174151.3441429-1-sanjayembedded@gmail.com/
Changes in v2:
- split series to individual patch
- address review comment from Andy Shevchenko
- Link to v1 https://lore.kernel.org/all/20260310200513.2162018-3-sanjayembedded@gmail.com/
---
 drivers/iio/common/ssp_sensors/ssp.h     |  5 +++++
 drivers/iio/common/ssp_sensors/ssp_dev.c | 11 +++++++++++
 drivers/iio/common/ssp_sensors/ssp_spi.c | 17 +++--------------
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp.h b/drivers/iio/common/ssp_sensors/ssp.h
index f649cdecc277..aa125fd1bed5 100644
--- a/drivers/iio/common/ssp_sensors/ssp.h
+++ b/drivers/iio/common/ssp_sensors/ssp.h
@@ -175,6 +175,8 @@ struct ssp_sensorhub_info {
  * @sensor_devs:	registered IIO devices table
  * @enable_refcount:	enable reference count for wdt (watchdog timer)
  * @header_buffer:	cache aligned buffer for packet header
+ * @rx_buf:		buffer to receive SPI data
+ * @rx_buf_size:	allocated size of rx_buf
  */
 struct ssp_data {
 	struct spi_device *spi;
@@ -222,6 +224,9 @@ struct ssp_data {
 	atomic_t enable_refcount;
 
 	__le16 header_buffer[SSP_HEADER_BUFFER_SIZE / sizeof(__le16)] __aligned(IIO_DMA_MINALIGN);
+
+	u8 *rx_buf;
+	size_t rx_buf_size;
 };
 
 void ssp_clean_pending_list(struct ssp_data *data);
diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index da09c9f3ceb6..35e07132c4a1 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -512,6 +512,17 @@ static int ssp_probe(struct spi_device *spi)
 
 	mutex_init(&data->comm_lock);
 
+	data->rx_buf_size = SSP_DATA_PACKET_SIZE;
+	data->rx_buf = devm_kzalloc(&spi->dev,
+				    data->rx_buf_size,
+				    GFP_KERNEL | GFP_DMA);
+
+	if (!data->rx_buf) {
+		dev_err(&spi->dev,
+			"Failed to allocate memory for rx_buf\n");
+		return -ENOMEM;
+	}
+
 	for (i = 0; i < SSP_SENSOR_MAX; ++i) {
 		data->delay_buf[i] = SSP_DEFAULT_POLLING_DELAY;
 		data->batch_latency_buf[i] = 0;
diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 61a4e978d9b2..08cf31fe9dd4 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -369,17 +369,13 @@ int ssp_irq_msg(struct ssp_data *data)
 			 * but the slave should not send such ones - it is to
 			 * check but let's handle this
 			 */
-			buffer = kmalloc(length, GFP_KERNEL | GFP_DMA);
-			if (!buffer)
-				return -ENOMEM;
+			buffer = data->rx_buf;
 
 			/* got dead packet so it is always an error */
 			ret = spi_read(data->spi, buffer, length);
 			if (ret >= 0)
 				ret = -EPROTO;
 
-			kfree(buffer);
-
 			dev_err(SSP_DEV, "No match error %x\n",
 				msg_options);
 
@@ -411,22 +407,15 @@ int ssp_irq_msg(struct ssp_data *data)
 		break;
 	}
 	case SSP_HUB2AP_WRITE:
-		buffer = kzalloc(length, GFP_KERNEL | GFP_DMA);
-		if (!buffer)
-			return -ENOMEM;
+		buffer = data->rx_buf;
 
 		ret = spi_read(data->spi, buffer, length);
 		if (ret < 0) {
 			dev_err(SSP_DEV, "spi read fail\n");
-			kfree(buffer);
 			break;
 		}
 
-		ret = ssp_parse_dataframe(data, buffer, length);
-
-		kfree(buffer);
-		break;
-
+		return ssp_parse_dataframe(data, buffer, length);
 	default:
 		dev_err(SSP_DEV, "unknown msg type\n");
 		return -EPROTO;
-- 
2.34.1

