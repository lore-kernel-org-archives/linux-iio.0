Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DF63128BE
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 09:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777195081; cv=none; b=LUFcA0rbKaLu8qGsL4dw9+UqxLAIOqLh2tjL2LEIJGdneZJHTn1hl3L77hAkNZKL6T7ZL/OIFNjkltkcB7es1pyIZ9rMqAzOgxS22FdLAULsn44gFx+wZnWgPzF9AUJk8lsqyfWb/+MAPumJ1HcB/uSNIlUW8oKxWIW3n7oET/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777195081; c=relaxed/simple;
	bh=oEBXgj2AK10Nj+bseAhxv0IPtj/BYxJP8djzcBoJ6+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L31vIvP8OXrdUDVP38ZB4Ja8SRkS5t6qz+LBElJ7Zl0SpYOwzdRqvJlzJHaiHm1m+8FdcS3v581K/cnWVcCtkCMm2/f2tXOkru6Sa0ohD1H0PqtHmpPK7xfCJOcPnHtn2l+6JbD0qDmBwWs8jx1aZtM3tO4/U7Tyc/sz5G85DxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ohtXgHFR; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ohtXgHFR"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82f8bf96b46so4442755b3a.2
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 02:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777195079; x=1777799879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/+x1NdsI6gqAesdJtZv8kaE6DjjhQ2mtExUzBuE6l8=;
        b=ohtXgHFRbwpPksGJUW53C5wgbJxpbAJCAnSWoKIB1YSEVkC7FQ6p4wGvx6bJ7T4IDJ
         m/NJGD0dMPNvdBpfzYkIYVOmzQrTnhceXY2CQRlJvw9Bpv4XrnWXHdpOEc/QgZBhE1Nt
         pSsw/EDUFOVAHZsDwyHYYrBg1V36LKZrfCkHzmZZ0tAXEberb2dmX6XsnzRWaubriICH
         9b8sAPYygMBx2SiWwSmBfwvKZjrig11ePnfFKNMrh6AmPLSXBurf6dNnr6ujHb1OZfLt
         evaNsApf4Sk6vi26WFEXvOe+y6j/59FwAtJQFsd08+jcZb3FogEV4ylXoXqdZwfzlPLZ
         uKzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777195079; x=1777799879;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n/+x1NdsI6gqAesdJtZv8kaE6DjjhQ2mtExUzBuE6l8=;
        b=W1kf2D1ENPsprxdrhbOvZ30R1hlhVI5c2evVR3AJlKYGaRuTsHMhmtV5l2H5aAub52
         EilMbYzNsw524gLsFKDmEd5BWNQ7UusoQDYFVAPjvSEOXp96OhH9iQzK+8JpUWxjuUrG
         1P7UWd+AC+TUc10mqgtWGxZGvcTB672tafvI9/VxMqaMOxBGVzD6Y9S5L4O+ZPRzjsc9
         T3sxS4/WWZI05QqRnrSDm0as/49FqRMMC+YQUEQALFyTEQWs4TXCBc04qzm1KT4TyxZl
         fINJ3FPxdzcmNGWFIVhZbOUdo6FFLe87htgUAFdJjk25Xx03uGrJyZLeoD0ClYFq7bBT
         vJvw==
X-Forwarded-Encrypted: i=1; AFNElJ87QmqLTWu2nOXAv6tQ0uJaiF4ecJVu9HscfGhvrZ6/cWEDQ86CnLhnNEpn9EpN0NTN/al+ibCglrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6/ghjAto3D/uvByM1XDJKNWpaqm8y5pv0rAOCnP8KR2fIAIr9
	0pE0pR+om5GqZlTJrA0l6H9Jsv8axEzYlFTXNtgT44Az4+mO05LjcKBk
X-Gm-Gg: AeBDievSAe5q04JaPdYbOOjYOPagvc39QEm0TSszOuUcu8s1pSiQnsqO4PPLDjySZoq
	TWWhPDbzxYzuZjO5C06A9zWFDU/Surd3PsGgF1K91AmyZIuRQ/faelLJKsvzyoRrLzqIDIYxtNa
	VRvZ4eq1hMD7C16it/gfXqJwzj4My4SdNssEbK+T87cczVdBm3+wRfa/u8CYcaSpLLNikthBb8x
	JYobSdaOVbaPX29DymvZaaIP9M7gk/E2bE8JMELyhBjomEVje0s8NhmOvzKhqlz+a/0nMDJCyrQ
	9C29V6KiIBE34sG/kmZJVgXd1Yh515V4BOB8KxqTA2mkEDmho3hjnDGmknypTJbTpiMMv1taUuW
	jWd057abUnsSQXb2zhBbBC8lquLJcqq0zSqBuyqqN0arknkKf9ayco6EEHpQKxyIKxb8zkb7tNX
	f/BVxxOdaCwRZ5gsacRLlY5KZ/Dq/Ori+wHXK6YjAECHlvrUmjmbgP8U0UuyU=
X-Received: by 2002:a05:6a00:3492:b0:82f:1d38:f68d with SMTP id d2e1a72fcca58-82f8c8df5e1mr44757491b3a.34.1777195079480;
        Sun, 26 Apr 2026 02:17:59 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e982fd3sm36145226b3a.10.2026.04.26.02.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 02:17:59 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	mingo@kernel.org,
	christophe.jaillet@wanadoo.fr,
	nabijaczleweli@nabijaczleweli.xyz,
	kees@kernel.org,
	kyungmin.park@samsung.com,
	k.wrona@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 9/9] iio: ssp_sensors: reuse embedded RX buffer for SPI transfers
Date: Sun, 26 Apr 2026 14:47:10 +0530
Message-Id: <20260426091710.3722035-10-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260426091710.3722035-1-sanjayembedded@gmail.com>
References: <20260426091710.3722035-1-sanjayembedded@gmail.com>
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

Replace the dynamically allocated RX buffer with a fixed-size,
preallocated buffer embedded in the driver structure and reused for all
SPI receive operations. This removes memory allocation from the
IRQ path, simplifies lifetime management.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v6:
- Replace dynamically allocated RX buffer with embedded fixed-size buffer
- Fix struct layout to satisfy DMA alignment constraints comment from David
- v5 change: https://lore.kernel.org/all/20260406080852.2727453-6-sanjayembedded@gmail.com/
Changes in v5:
- Rebase change on top of latest v5 patch series.
Changes in v4:
- Use preallocated buffer and stash a buffer that gets reused each time instead of a fresh allocation.
- v3 change: https://lore.kernel.org/all/20260315125509.857195-3-sanjayembedded@gmail.com/
Changes in v3:
- prepare series to have all respective cleanup API support for the ssp_sensors following input from Andy Shevchenko
- v2 change: https://lore.kernel.org/all/20260311174151.3441429-1-sanjayembedded@gmail.com/
Changes in v2:
- split series to individual patch
- address review comment from Andy Shevchenko
- v1 change: https://lore.kernel.org/all/20260310200513.2162018-3-sanjayembedded@gmail.com/
---
 drivers/iio/common/ssp_sensors/ssp.h     |  3 +++
 drivers/iio/common/ssp_sensors/ssp_spi.c | 20 ++------------------
 2 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp.h b/drivers/iio/common/ssp_sensors/ssp.h
index f649cdecc277..8295bb7062a3 100644
--- a/drivers/iio/common/ssp_sensors/ssp.h
+++ b/drivers/iio/common/ssp_sensors/ssp.h
@@ -174,6 +174,7 @@ struct ssp_sensorhub_info {
  * @pending_list:	pending list for messages queued to be sent/read
  * @sensor_devs:	registered IIO devices table
  * @enable_refcount:	enable reference count for wdt (watchdog timer)
+ * @rx_buf:		buffer to receive SPI data
  * @header_buffer:	cache aligned buffer for packet header
  */
 struct ssp_data {
@@ -221,6 +222,8 @@ struct ssp_data {
 	struct iio_dev *sensor_devs[SSP_SENSOR_MAX];
 	atomic_t enable_refcount;
 
+	u8 rx_buf[SSP_DATA_PACKET_SIZE];
+
 	__le16 header_buffer[SSP_HEADER_BUFFER_SIZE / sizeof(__le16)] __aligned(IIO_DMA_MINALIGN);
 };
 
diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 870214551f0b..e41da88bf96d 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -339,7 +339,7 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
 /* threaded irq */
 int ssp_irq_msg(struct ssp_data *data)
 {
-	char *buffer;
+	char *buffer = data->rx_buf;
 	u8 msg_type;
 	int ret;
 	u16 length, msg_options;
@@ -383,19 +383,12 @@ int ssp_irq_msg(struct ssp_data *data)
 			 * but the slave should not send such ones - it is to
 			 * check but let's handle this
 			 */
-			buffer = kmalloc(length, GFP_KERNEL | GFP_DMA);
-			if (!buffer) {
-				ret = -ENOMEM;
-				goto _unlock;
-			}
 
 			/* got dead packet so it is always an error */
 			ret = spi_read(data->spi, buffer, length);
 			if (ret >= 0)
 				ret = -EPROTO;
 
-			kfree(buffer);
-
 			dev_err(SSP_DEV, "No match error %x\n",
 				msg_options);
 
@@ -428,22 +421,13 @@ int ssp_irq_msg(struct ssp_data *data)
 		mutex_unlock(&data->pending_lock);
 		break;
 	case SSP_HUB2AP_WRITE:
-		buffer = kzalloc(length, GFP_KERNEL | GFP_DMA);
-		if (!buffer)
-			return -ENOMEM;
-
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

