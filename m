Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4F12EF660
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 20:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769200731; cv=none; b=i9S5r/04fM/ucIdLPMWh5JCcJoEXiGHEIyRy6M4aVHANa5EPD8L7dQHP12ezBDrJFcwRtc2tP+zQgSs+tPKvapQ/0twWK3Ad5NBcnmb/iXisprmr65/WqXxe8clfHMsU8WbA2bg1o0W15x8/YbrqZNnXpnt6bcH0dNxzKLrfAuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769200731; c=relaxed/simple;
	bh=6K+Y2EpItjAFEVDHoZvaznPDbPUDrOkWEh/VhUaPTSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZhvgnhdnSY4LUngQo0KUdVsx4oIzWyYp92OvjmCVRJGSUQu7P7h53H7cROOCDhqSVgin9BSfY+GNmC9PtdHl0bzR4pI7wnfd4d1CJdm0T2x/NUuH33WamMwUVbWjpxfztBwPeGTi4MlTwGBa7VwzjDMviyp2wY3ipbRvo3nt0oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=aHuYTRoA; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="aHuYTRoA"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-40866616d47so2008598fac.2
        for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 12:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769200726; x=1769805526; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w6oXy9SAavgg4QtAir0K2/dqpzLAUs+ACA4F9zQ5oKI=;
        b=aHuYTRoA/YoRQxZBudut92S/EjpBHG+zzZRndDuCaX+T8h/jK4Dolhntf0jaMqGQB7
         WNNINYqsPLGKBD/+7TIwh2EdUDo1GdXA4c1cNx5s+6Awr3laRexp03vtOT+zn/DAM6xU
         6U3aXYg8VoNLyO2gMbfawha4KAV60BQ9CRvvHSUJe+nCQk6VVBHnjTnqR5V4pThbzepX
         ZJi9V7vS70MA/oGORPVKp9tQ6b4AAUwZJP5d/+hkXOEI1sCyATaM2Nuet/fY7U3Po/tA
         GhnK9IAjzzBIkP5LX1vJQ6RqBIaOd7dmx+pFU+KfFQfxOppesVJl+g/FCaZ1yQ8jfcAo
         7F7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769200726; x=1769805526;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w6oXy9SAavgg4QtAir0K2/dqpzLAUs+ACA4F9zQ5oKI=;
        b=QacKO0md1zzMM++oIdAWHtghpdVwY3Ie98L+/ck4mMcCwPUwN31zcfTg0Nwz88PZ40
         Pb2hAvF9emndo5HNKGhQ5IOuiTM9+fyfbdpL7guIIhy7RqGtoQUGVbHC+fVaXrL1sMBN
         XbZAnJviAHPv90/a4XAfJ1fWHE4zesysS+3ScvbOsq+JaAMftZfIHLTNZcy/eWmGWtDR
         6bQd5GiwmAuMGxS6MyicHZkUoeguIA3ZfyKqfRAYDLGx0dCZa6fwn3Ag8ifYeln9PEAk
         PUx8r5TwhLKm6APzh+ECKHY8uYnqVhTeFaXPAQgESO+Zd6x/rA5p8gtG9gipyvA3EWGs
         vwPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVfp03HC5FYAprN6EFbSywCS/OqOHcD5dNHzxVyr+8IJp+Ab+lttig694NxSEsG1ExZ5i4n42lztc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxji2IcG9IqYt0vjgq+hyT2ZYww4n9YR6BXXhb39cMrlmxtYjc7
	3lZPOLOUYfphlifBJT9hX61WDmbvMZ73NSQEAVjbP733iws4l5nAzGslFQ0vfarF+Cg=
X-Gm-Gg: AZuq6aK0Ow+ccsTX130ErumB9gM8oRXaTBfd9XvWNCKx4F0h5GAD8XnYeSYEZoyxtmQ
	xnJy9BsIaUzME6+2oX/r9DOJF7eRCrEI2DEBWtL+mXDzfoMLAH3Xs+O3a4PfmGwB8sbYwVmwJgG
	fAdTcBQbpsgkNM4ZkBTZ837AtR26lp335G6cDaEBPJToETA0jmy1U+gqJF5fUMtakcKSLr4C8Pz
	Nf8Ff+IuK8dSh9C/dwjb/gUtVEsgC507q8YD0GNzl88wh3ghTtbsoEHwXpZQzuZxmfIGl4cCQFP
	i0IoFkAmjGeex5tgosFJPplqWZ9ZslvUdXINo0yoiLSt8yXitnhLV00ui3M+ZdnhZ0PURfSExuJ
	gm32JeTc4DueDrg+gU3wBe/xO2ZB7iAvQR/1dEaSAVzYLOqPrwsyeZ/yisK7xUCrHkuta4M94c7
	hzdqUv2ojaSq74Og==
X-Received: by 2002:a05:6871:2e89:b0:404:43c1:28b5 with SMTP id 586e51a60fabf-408ab4e60f2mr2227571fac.14.1769200726621;
        Fri, 23 Jan 2026 12:38:46 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:198f:2b50:c48:1875])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-408af888da1sm2167805fac.6.2026.01.23.12.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 12:38:46 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 23 Jan 2026 14:37:27 -0600
Subject: [PATCH v6 4/9] spi: add multi_lane_mode field to struct
 spi_transfer
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260123-spi-add-multi-bus-support-v6-4-12af183c06eb@baylibre.com>
References: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
In-Reply-To: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2129; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=6K+Y2EpItjAFEVDHoZvaznPDbPUDrOkWEh/VhUaPTSM=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBpc9wjnXMHw1tRGqZ6YNmZ5UlrWYkzHUgSrhuv1
 MEsWa4upC6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaXPcIwAKCRDCzCAB/wGP
 wJnnCACUe2jk1jNjSGdqZBZ5TKEPO/eu3xkCUafz2SJHfCZ181UY0qHmVMtSnWIf+S3V+/f+bsJ
 Oj66B//o16b1cSeRpLS652IOro4mwCasABG8beWtnXI/1HrY5nBdzOTcRVdkMEuLfeOfXzLSJwD
 pn7iOLhz+saxfqw6GRfPfrZ7zNyFjahc+lQ8Zp+7oHG5dkEDUUXaI57zx5/iYuzYQjaEIo8IQD0
 lUcVQGnPgkV3RuTKADBgWSZpp4Dv5Bewg8EBSIY/iwgTFBYVK9wz7ahq6dvAo5wMJKia1g1lGwR
 bKzuUnupvn21goJfbbBqv9+k4al0iIxyJak54Xr3Db74duIP
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a new multi_lane_mode field to struct spi_transfer to allow
peripherals that support multiple SPI lanes to be used with a single
SPI controller.

This requires both the peripheral and the controller to have multiple
serializers connected to separate data lanes. It could also be used with
a single controller and multiple peripherals that are functioning as a
single logical device (similar to parallel memories).

Acked-by: Nuno Sá <nuno.sa@analog.com>
Acked-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---

v6 changes: none

v5 changes: none

v4 changes:
* Shortened commit message (useful info will be in docs instead).
* Added whitespace to create clear grouping of macros and the field.

v3 changes:
* Renamed "buses" to "lanes" to reflect devicetree property name change.
---
 include/linux/spi/spi.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index ec8a03ee0d4c..fd8dce4169f7 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -990,6 +990,8 @@ struct spi_res {
  *      (SPI_NBITS_SINGLE) is used.
  * @rx_nbits: number of bits used for reading. If 0 the default
  *      (SPI_NBITS_SINGLE) is used.
+ * @multi_lane_mode: How to serialize data on multiple lanes. One of the
+ *      SPI_MULTI_LANE_MODE_* values.
  * @len: size of rx and tx buffers (in bytes)
  * @speed_hz: Select a speed other than the device default for this
  *      transfer. If 0 the default (from @spi_device) is used.
@@ -1126,6 +1128,12 @@ struct spi_transfer {
 	unsigned	cs_change:1;
 	unsigned	tx_nbits:4;
 	unsigned	rx_nbits:4;
+
+#define SPI_MULTI_LANE_MODE_SINGLE	0 /* only use single lane */
+#define SPI_MULTI_LANE_MODE_STRIPE	1 /* one data word per lane */
+#define SPI_MULTI_LANE_MODE_MIRROR	2 /* same word sent on all lanes */
+	unsigned	multi_lane_mode: 2;
+
 	unsigned	timestamped:1;
 	bool		dtr_mode;
 #define	SPI_NBITS_SINGLE	0x01 /* 1-bit transfer */

-- 
2.43.0

