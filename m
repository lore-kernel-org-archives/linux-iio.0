Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF31B3AE715
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 12:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810265; cv=none; b=F8svDBXITuxP3yNmplP/tTejptHVO9jL62YN9fNfCOI7PH0ZwX2Z1AO/MtMeqLaOxvn/W+Zma0ZWdIOfNTrz8ldpUYIs+DdPVFh+4o1YY2fufOYzYLdie7K46VyvHOdn/YwU3M2dsekU2IyAvDpEgWpdsdjiED7biE3TRqS2viY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810265; c=relaxed/simple;
	bh=/K/3q3bdgdjW52cOpPc+Q8cdwQV9c4yCPujfH8pkPjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFdBonda7A1YTa6kHDbkX/p8Gbav3CB74zZxQEZSFz0jGro9h4CqlfwuL27ORwqkidaqeIUa+Tj1yCQiDOADfG9sbgFuJDVpGWh43Z/s4nlP4RUkKYrk5Vhneqz0FOyZLDi5euc675UZRbjlMZZsh0KvaOhp/dvTuLxe0vIVx8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oXhGpm6o; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXhGpm6o"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-82faf871346so1982510b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2026 05:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777810263; x=1778415063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5ZGcDGIV6eBL2tESEp+bhDpn4nj603SMEnwICOMNYo=;
        b=oXhGpm6oXF5feMLzzVeKTwz/EejoG5QHDfIeaGOq3DzDxaM8CtE2T0m8V97MNA8qt+
         gG9t2nT+jca5e5zOrwidduDPYo5879hE4Ha9hslh78HzGCKydOFtktwCvn1p1s83esiJ
         GlAcubNy3y+a212O6En3DZDHWNZM+EWIrx19S0wewoXYPPipFtq6Uaoq3Ua49GGV+Zlj
         IPJfHtiqhu4lzKf4vzeeymT7NK9WY7VsPsskns4dYxNR7YZmyesKEvmvL5S752RyC0z4
         rt47FCeUMYcHABKETZGd/ajMtgsv+M7Sb4JnJrEweqAbRlMiqitxVIwLaMiBFtRGB2E5
         cd+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777810263; x=1778415063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x5ZGcDGIV6eBL2tESEp+bhDpn4nj603SMEnwICOMNYo=;
        b=KFv6/Y1BbX6X4v1/lGWPqhk2RemG8Iy84MLAz62O+GzQ+MttO/pJio/anJAzbXLtuh
         hucRwSw8id4JMK1rdvR4KByOwJ7R/MGxsTKPaXcdUaTFclqJzT0HwGbXS8fBUc7C09Oo
         1xza/On7WLz0vWccEJoWQtTCQI5X0cdxJcu14JUfEuTFtYCi0BEUD96POhG1bpZHQAgB
         6V2yQ6etWjxl7jhK3XP+Q96nQ+Vd9p7Af0kjOGNa79F4KnbM//yMdFVmoxaZk/vE/BMW
         VluwGNojnrSA0686pIJdwN5lGXCisSNh5XNR0p77RvXY6a9//WrgQXts8X3R3x+ZDliQ
         QDhg==
X-Forwarded-Encrypted: i=1; AFNElJ/aOP5aHphNUsu4v/RofUo88e2lj3yn44GNMtBDbA9O4svlC5uPGELBHneDqDYH2HXlsydarh5elxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOTAdwbwSAqR5QVHPxfJ08J2jBQjBADv79gs27BJaww+NdjItE
	NEfnEYZNczoMNJzt26lp98bYg6o4Vd7DONfwzW8pFamtxgxXE/QpPBqHcIxgAA==
X-Gm-Gg: AeBDieu9F05s9SWWldwlGqpKhEa9UHN/ibw4NYjPBwyW9d8GTcsQ5ZAHNV71/7hOqXi
	5FUh+NmWajCnQVe+yhEx2wyLjuzzdGRdGzb1D0kJI2Z/Kn9U2dPCT5j5oZk5XO2/gObtaCmOmEe
	JP4sXFv50eYFwbGL9mEVsCRqW8PR1JXRyx+3RmCjKrwE7HAngifv+nMV47giQKuS5+XGGuU2bPD
	/mjjNSPvPNFhY5D+p4fJcwjrVnNz/eKw7uPW10yVG/OC20P0Tz4XMz02sshbLNkK1ecYgwkDjxL
	lQpR3vbcRgLaEgPte3EOKHQXuBzpc11q0p96lYairl9ktIfSIHkD5Puz1U8PDM6gsJsgkoJGW4R
	DTY7U1WamSgUMrI/Qf1PwPt/4uKw+w50s36gr1yqhj9wntSMDAZKWQrV4TVvbxkvm3QwjiXr42Q
	chWnOZg6qdos2ER2Kxr1zH9tWjHzHl1IUOkmzqE+h8hBhKAGsCIexacMRTZ28iyhi9gZxGl4+cZ
	wlzvfemM0GV8VKkF5kXreV1/JC/2wG76I4xM+fGNAhhqv5Z5V5tgenmdz/BMZI9a/uq0Zs=
X-Received: by 2002:a05:6a00:ab89:b0:82f:b5:8044 with SMTP id d2e1a72fcca58-8352d01357dmr6334200b3a.6.1777810263201;
        Sun, 03 May 2026 05:11:03 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8357c4f4530sm1474364b3a.9.2026.05.03.05.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 05:11:02 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 10/11] iio: adc: hx711: pass iio_chan_spec to hx711_reset_read
Date: Sun,  3 May 2026 17:39:39 +0530
Message-ID: <20260503120949.80292-11-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260503120949.80292-1-piyushpatle228@gmail.com>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change hx711_reset_read() to accept the channel descriptor directly and
update its callers accordingly.

Split the existing HX711 channel-selection work into a small helper so a
later variant-specific change can add a matching helper without growing
hx711_reset_read() further.

No functional change.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
 drivers/iio/adc/hx711.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 98fb617ea32b..2229df17f350 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -269,7 +269,22 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
 	return 0;
 }
 
-static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
+static int hx711_set_hx711_channel(struct hx711_data *hx711_data,
+				   const struct iio_chan_spec *chan,
+				   int *trailing_pulses)
+{
+	int ret;
+
+	ret = hx711_set_gain_for_channel(hx711_data, chan->channel);
+	if (ret < 0)
+		return ret;
+
+	*trailing_pulses = hx711_get_gain_to_pulse(hx711_data->gain_set);
+	return 0;
+}
+
+static int hx711_reset_read(struct hx711_data *hx711_data,
+			    const struct iio_chan_spec *chan)
 {
 	int trailing_pulses;
 	int ret;
@@ -283,11 +298,10 @@ static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
 		return -EIO;
 	}
 
-	ret = hx711_set_gain_for_channel(hx711_data, chan);
+	ret = hx711_set_hx711_channel(hx711_data, chan, &trailing_pulses);
 	if (ret < 0)
 		return ret;
 
-	trailing_pulses = hx711_get_gain_to_pulse(hx711_data->gain_set);
 	return hx711_read(hx711_data, trailing_pulses);
 }
 
@@ -301,7 +315,7 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&hx711_data->lock);
 
-		*val = hx711_reset_read(hx711_data, chan->channel);
+		*val = hx711_reset_read(hx711_data, chan);
 
 		mutex_unlock(&hx711_data->lock);
 
@@ -391,8 +405,8 @@ static irqreturn_t hx711_trigger(int irq, void *p)
 	memset(&hx711_data->buffer, 0, sizeof(hx711_data->buffer));
 
 	iio_for_each_active_channel(indio_dev, i) {
-		hx711_data->buffer.channel[j] = hx711_reset_read(hx711_data,
-					indio_dev->channels[i].channel);
+		hx711_data->buffer.channel[j] =
+			hx711_reset_read(hx711_data, &indio_dev->channels[i]);
 		j++;
 	}
 
-- 
2.43.0

