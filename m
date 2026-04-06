Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ACF30B501
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 08:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775462955; cv=none; b=Fj00WUpolk+hme9Mmxmjbm5+RrV2JsdUJgTinaPk6Woem6Ld7z/ZsvRXkpAn6WTEvWT7IQ3BY6uFFRgC+s+t8yaDfOY5LCEczh+m4a8xb4UPNjQImIYcPxOsYt0K86VzW5S7JsrKNYFAssEDjH2vOExYcFZjLJG1ZKWLzTbIYd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775462955; c=relaxed/simple;
	bh=3i4QqeQ0eDQeBGKnXpTijfSwGZD4a29IZdK8uDi6MJY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NELId7xbaD+/6ypSlFYoZ2q+KbsRlmP4g9+G1EBaGG7fCxhBcZ+xDwbApRP9v4O4psN/w8PN2iWcZ3+Zki7AB0TN/+Mn0Ca2j2NVBEdZxDnCU2Zm8m9DlqcH8lgUzknLRuRtEma8dhvjvJiA06mo/1APDS/wyVYHHf7Wo/b6SOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CInyr+4f; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CInyr+4f"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35d95017a68so1953098a91.3
        for <linux-iio@vger.kernel.org>; Mon, 06 Apr 2026 01:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775462954; x=1776067754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1j46ShQPfwpy3gXgQwfnfKhYctHDdp6l3ofiQ/AUxA=;
        b=CInyr+4fhIk3yodd1Qyt7miOi8o9pEfni4ZcjuJJdYq1T1itstxgj5ia7WsvtwdUax
         aTW1I7MigomBd5NXyCwuzVoqD48OzmhmrhilFpjnd2uwAg8h1QWhaxLjUi751LsAjiDC
         7YdKSx9TYojI8eR0Qd1u9iLNRtNjw65MCqfIZjySlYs+O2BwUfZZeCiXGHkM0Kx3U3c5
         oO2GbWSx22BZW0w6RVIZe5/Ok2SWupKRT/MGtsaUyT7JlmZpHPSfDVp7vXuoHIBmLvlF
         IJJBHiiuYkp5F1Igsl/LlexnQB9Yr+/MFSpxX1Y6d5bznckZFIXgrud8iEyg3H7JyA2v
         OgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775462954; x=1776067754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W1j46ShQPfwpy3gXgQwfnfKhYctHDdp6l3ofiQ/AUxA=;
        b=nBHdciypWuasX4rKAwTLczT/qJ+LYlUehhMLan38p/fxYr8EavLj5ihejrm08qVnaA
         DRSi6fx2mNf8AXotDE0K6nJbaiWbPA401PtEtkuhRMNCeBHssMRWNQleYpfpNxmgp2mq
         6cLOxnT4G0JXKbVqPggSNplQE/6FR121e/u8vD23nAelAMof4XLUixm/6dDucBp9o5Nu
         XMWTgNIgwKwcSf1jBceXD4hoGHsS5dbj0LPnQ2akxLkWVCvEpTHdYBzN+p5ISR5W2D4Z
         YHWGYhs9en4BmSVa1YhtPYwUfdgYtUc21EP35bO1pX3GH+e3WayH7U1s80jg6Yr0tepq
         CsbA==
X-Forwarded-Encrypted: i=1; AJvYcCVuWPvAcyJUT1Uf4mcqxkGhnXnSM8eX0ypuPK5niolaB6tzp9O9O4wZLoQ9SY0TCsASurjmplBUqiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXleDohH1Kt4OsxuI7BvTjY07Gj4/X4cj9uWJB90lg6Wyam+TG
	o50Iy76XHMHAMti+O1gGvBpXIvjlLQjPt8qspCndN84Zp9dJd8LpOyC1krUFdQ==
X-Gm-Gg: AeBDievYlnuhxV7XTZiAcwbQXZ9GYtyiengegJjcS3JLXyr+vxWvZGJGmi/cWMtdO2U
	52/WrgWsRq8X3Ds1pwhNGGOHmHZXpZGPhx4LS2Gs0i1xrl9oYR6X77GhCRveONMVclJaFQHjMfw
	vkwrmkpQ2cyQ3Oybf0VfwcS/pUhw0P5ODkGvTDFo9EP8CV05e14XhAngy09k/CKn7E8tCX6BZ9g
	oPoh02TwrOyZS3DNNiApSB2bKaVZCbtbcucl2tHcBfw1nEkMtV1L9nZQ8l5S+mdJDpLMVebJJg/
	9DD/0sIg6MvOKJJmtNiRgWQTl2xTbpdbrDwJDzpALC7JTd+V3d4FjbbKaBNFqjUNFJig7emj2bL
	/p9jG/kwleQI13nJS5BVMf6EWV377wasCh+3FHSMsWt96ipUDP1WTdeVWnskC58VP55lk/m4ZcG
	Mmhn7blA7tZEcXJq6UbXl7CrSp9SxkFbALQJDX47+DL9SWWR8n
X-Received: by 2002:a17:903:17cb:b0:2b2:50f6:cdd9 with SMTP id d9443c01a7336-2b2817cf037mr128244145ad.8.1775462954078;
        Mon, 06 Apr 2026 01:09:14 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af19sm127961835ad.50.2026.04.06.01.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 01:09:13 -0700 (PDT)
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
Subject: [PATCH v5 5/5] iio: ssp_sensors: reuse preallocated RX buffer for SPI transfers
Date: Mon,  6 Apr 2026 13:38:52 +0530
Message-Id: <20260406080852.2727453-6-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260406080852.2727453-1-sanjayembedded@gmail.com>
References: <20260406080852.2727453-1-sanjayembedded@gmail.com>
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
Changes in v5:
- Rebase change on top of latest v5 patch series.
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
 drivers/iio/common/ssp_sensors/ssp_dev.c | 12 ++++++++++++
 drivers/iio/common/ssp_sensors/ssp_spi.c | 19 +++----------------
 3 files changed, 20 insertions(+), 16 deletions(-)

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
index aab28f2a0f75..2a8d6f040ae4 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -516,6 +516,18 @@ static int ssp_probe(struct spi_device *spi)
 		goto err_setup_spi;
 	}
 
+	data->rx_buf_size = SSP_DATA_PACKET_SIZE;
+	data->rx_buf = devm_kzalloc(&spi->dev,
+				    data->rx_buf_size,
+				    GFP_KERNEL | GFP_DMA);
+
+	if (!data->rx_buf) {
+		dev_err(&spi->dev,
+			"Failed to allocate memory for rx_buf\n");
+		ret = -ENOMEM;
+		goto err_setup_spi;
+	}
+
 	for (i = 0; i < SSP_SENSOR_MAX; ++i) {
 		data->delay_buf[i] = SSP_DEFAULT_POLLING_DELAY;
 		data->batch_latency_buf[i] = 0;
diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 7c1780e15acf..2f7445e8b4d1 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -383,19 +383,13 @@ int ssp_irq_msg(struct ssp_data *data)
 			 * but the slave should not send such ones - it is to
 			 * check but let's handle this
 			 */
-			buffer = kmalloc(length, GFP_KERNEL | GFP_DMA);
-			if (!buffer) {
-				ret = -ENOMEM;
-				goto _unlock;
-			}
+			buffer = data->rx_buf;
 
 			/* got dead packet so it is always an error */
 			ret = spi_read(data->spi, buffer, length);
 			if (ret >= 0)
 				ret = -EPROTO;
 
-			kfree(buffer);
-
 			dev_err(SSP_DEV, "No match error %x\n",
 				msg_options);
 
@@ -428,22 +422,15 @@ int ssp_irq_msg(struct ssp_data *data)
 		mutex_unlock(&data->pending_lock);
 		break;
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

