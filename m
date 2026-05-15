Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00923F8882
	for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 17:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866880; cv=none; b=gdB9svNpS2+8ZQ/byWfGgibpVotmH8A9JN9q4InFCuregwj+5jtGXMn73A/tgTO2i4GYWY0o4Y9v3IhRIzIhXUdFghVPrXMWL6yyUu3WX8u3WsW2BorS7evxQSU8GykFXi+mfp2WGdFwlRg/p2bug3rjMcsxsdN0e9Xjefpnb8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866880; c=relaxed/simple;
	bh=4RiR+ZXEajF7MeBQ0TdkfqGWEbJftjIU7gULv29t+Q8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OFcuNNqA2TyQn6zRWUu+cKqE4Letck4po4Lrh0XJ8XxF61xTlLEFcRRm/ZYZzJ3TRoiGBZ+irM4U7jtrTOp0vEI+XXWDdPPzTJbgEJSaZbp7CLR6S7+Pwdg4TDzd/h3GSC5xHQHq83sVLEjifhW4RFpATL7OD68KWyIbtFRcWYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PI6dYQ3q; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PI6dYQ3q"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8383fb7143aso46082b3a.3
        for <linux-iio@vger.kernel.org>; Fri, 15 May 2026 10:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778866878; x=1779471678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFFgsQxDV1wnCquFjABZPsKXi5LVlrEz4bXpwyRs9wI=;
        b=PI6dYQ3qL+yHRxHK9ghKhrUultc8CCq3H884B9spwy2M+3l3dNKOb+GmEdFZDCyyEd
         MThBGb0J7eMzyISXi1MwFZBSKKriL9EaoLyFXB/0tZonUvqWyijR07QjXS2TvLeqp0rI
         bgKqzmAyuA2bszEuU/Gp9AC6ftcjUh2GWw7MFlgJzgx5sUDG6gEePlPDkIvd3AIqY9rv
         LIxmGlN6ufQyfXbSORJyvQnJaTFIaRitFHoa4vgbSSL8RXoXaX0h8I1Beqm0PRm0iT3v
         xvqOAzfDezv4NZEtsV74QgO47qSi4r6QJ1CgCMevJnr+MT7LE+kacvRsK9XrYnPBeBjT
         +5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866878; x=1779471678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iFFgsQxDV1wnCquFjABZPsKXi5LVlrEz4bXpwyRs9wI=;
        b=LmLchO8hwq8w3OCBMpkqGDl/xvDJ+AZPyg3FsZIM/QpS2sHj6kpYoJuEJDeyPmGN7H
         OIqKXhQV+NrUHNuUbAyyVHa9rJ2orzEtPwMQGy1NhpM4PugUG97KnxmiTMwShqNb4wq2
         sjacmqF3CmW+BxO9sM7TaFdwto+kkuG1qwjHjR6NWZZNmlsJL+mkjsT8bAfhysOkUZE6
         4J2NOqzbVVHyW38nNAVvw64MH3/H+PKUZ97aSjvd8A+nndZczwJ91MORldu8ab/otf4t
         LufEQzhHoRf2N7NCzJBgbssxYNr9C0najf7Qi4SWZKjVzF8nxNE4hkTmWKQMLOkyR6eJ
         RcKA==
X-Forwarded-Encrypted: i=1; AFNElJ8eAn/ZxAWGN6cnYMifywGhwb8mJ6bYLQdZIz/4jQn+n09n9aBuHKlGF9kHUwsDOtBX2CZCmSHImew=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/0thsPH8aPiI5o8q2OLPBfGWOQdhRwjK96nkpnowmY5jklSEi
	qC68FUkXAbO7Xq8hibJtnkGetGl2df9T7YsPeR1YvbJ9HX+p4E10cYDH
X-Gm-Gg: Acq92OFWUWyta9lvlceI1sIwKj62q4ux5hQKmodJE6eTpberzn+5+OShePAxftK0PeC
	hdIUyq5/P+JwH7YwQVYLdVRIQ8swCPPnXTNhGhP1T0NjmPuMC0GWbc/6+TpCxO+8+fjCTiXltzB
	EV3OAR02Xg3AUSE4AhGiUVQZk0jDer7EkKpk/5212pW+ljsY3vhOb5ZXeiGQvBhG7aFOOMlS4ta
	qx3PCi+yC/nKlVHHHjz1psgld4RgnT8bN/B5oX+r6+tN3wFhCUfUpXYxGDk7QxLm3I/wHrXTMuu
	9vJzvnYTo0R0EiMu3v9zlRBuY3wqVBsBzPthBto4VHlP0f2TZ6BmWZHDuY/Lko+JhiFyQ1arXfq
	fqf+gbgkCArPCaIOfkSyrQqEFwOpDw+z3/8csBtzICHfzWayDid5OUIQrzKWnG79UU/mI8bcnM2
	kdPMABQwx+B3rtcKip1k8O8H3aNoVii0uOaZwnv1LTMfmKgU/XEjUzMhDaBY4=
X-Received: by 2002:a05:6a00:3928:b0:82f:4191:da10 with SMTP id d2e1a72fcca58-83f33bc89d7mr5727837b3a.6.1778866878104;
        Fri, 15 May 2026 10:41:18 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f2875f0fbsm5579034b3a.57.2026.05.15.10.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 10:41:17 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	tglx@kernel.org,
	christophe.jaillet@wanadoo.fr,
	mingo@kernel.org,
	kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz,
	kyungmin.park@samsung.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 12/12] iio: ssp_sensors: reuse embedded RX buffer for SPI transfers
Date: Fri, 15 May 2026 23:10:17 +0530
Message-Id: <20260515174017.3962168-13-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515174017.3962168-1-sanjayembedded@gmail.com>
References: <20260515174017.3962168-1-sanjayembedded@gmail.com>
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
- Address review comment of Jonathan and use __aligned(IIO_DMA_MINALIGN)
  and have buffer assignment specific to block instead of top.
- Regarding DMA and size discussion point are open to check
- v7 change: https://lore.kernel.org/all/20260426091710.3722035-10-sanjayembedded@gmail.com/
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
 drivers/iio/common/ssp_sensors/ssp_spi.c | 17 +++--------------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp.h b/drivers/iio/common/ssp_sensors/ssp.h
index f649cdecc277..6d7409db014e 100644
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
 
+	u8 rx_buf[SSP_DATA_PACKET_SIZE] __aligned(IIO_DMA_MINALIGN);
+
 	__le16 header_buffer[SSP_HEADER_BUFFER_SIZE / sizeof(__le16)] __aligned(IIO_DMA_MINALIGN);
 };
 
diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
index 172b4bbd298c..d6919e86aa95 100644
--- a/drivers/iio/common/ssp_sensors/ssp_spi.c
+++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
@@ -396,17 +396,13 @@ int ssp_irq_msg(struct ssp_data *data)
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
 
@@ -438,22 +434,15 @@ int ssp_irq_msg(struct ssp_data *data)
 		return ret;
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
 			return ret;
 		}
 
-		ret = ssp_parse_dataframe(data, buffer, length);
-
-		kfree(buffer);
-		return ret;
-
+		return ssp_parse_dataframe(data, buffer, length);
 	default:
 		dev_err(SSP_DEV, "unknown msg type\n");
 		return -EPROTO;
-- 
2.34.1

