Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249F739EF27
	for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 22:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779141800; cv=none; b=OQuFKWiIhjZSw40TZrrux0dEat67xiHRkfGRDKh7W3xcW9pnD7d1DOwB1LkEpIJw8llAPDomVrWHcG2Ec5vzBiMbPn3oyzlB1fCemklBUNRtDsdDhLUs0jic9y14T6pZQtD/TvvVKxI4ZTl2GvsKxbuDHN+i8ZBnZMFeYJJdras=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779141800; c=relaxed/simple;
	bh=WhtpzRjiFjKxJX+KV+nt4yvclp6WLo5XCxauQPqKOP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2vuG2WVZ4pj5zVLAhTT0W0l4uYeEn0BK+nd+51OdLJ2+kawhQxi0wYhMbHG1FDQ1WUbKMhSuyoXVeM0nRCgN5QjAqCSUvglVc6FErjKJQwXVasIyAY/i87KWz7mOCBkXUK6Vjvt5r+L+Bmhn+0BrdVPuVkvzY5GjOnrfjeZIbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oCBPhy4A; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCBPhy4A"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8354461da74so1204577b3a.1
        for <linux-iio@vger.kernel.org>; Mon, 18 May 2026 15:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779141798; x=1779746598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6ABU32L9kWqfPPVPaRPH2nySKI3U/9YaJ4r872onSA=;
        b=oCBPhy4AmK525XiIB86YO///xcN+QvPc98HT+XVD45MgYHHdtWQ9nldP2nyu9sGkyF
         6euCte2hFUYnphhd/U4+/9KBCLWviEg4lqtX+wIX88nmj5PZdX7udhgMzZ7PgyLjGIdN
         IWcejE7ICjaaU3xVHgXLEvgADgpuAi6DUTw7nlnWzJfOyTPG7Wj3gNuxTnPjT7HH1R2l
         icJMNZ4QP3v1UnxjE+y8vCqmr6aPhpaUIus0Vv2q59DWVwDMEy+pN9OSaa87f4jiPzAI
         Y9rAhGlWRU8ftOmhANQOCJG5pFcFi5GeF241XXDbcMNPbdEvUCjThuai6qb1+JBmxvUK
         LqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779141798; x=1779746598;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c6ABU32L9kWqfPPVPaRPH2nySKI3U/9YaJ4r872onSA=;
        b=Gy8Hc7hNGbqyvJXwok9C8l3gMTkvLoZfWl8a+hJtgkqXoqqU6UIHP80z/CKJqdkMZ4
         pyHNt0PzBCXcoV52YD0r69WlgHHBORxFI2O6/WyRzq5wci0ebTT48Qn87lLmnrdYeJzy
         2Sqnx+qt3aGuZoPo/rVmHGSQD6/aeIdYg8Juz9xywYXLNeJpSDWT75TOFedD+X4Y3bEi
         96BVluAzeItNRZ1QtpYBli5sCyOOz1db3v2doCkDcGNYL6opUStHyuIat/UYPP3kGTvz
         DjN9xUPoPtCZsq7q3niM3u5f/KR1GciyoJ+hUFTf+zQCrk+uU3Q7VQfmL87t5bat/uLW
         JM1w==
X-Gm-Message-State: AOJu0YxSySNFGbaqgB7XkzL8//0C1UIKUMz5plnDkixGXeV7ccv3XNwc
	12d/5TD6fEg132uqQvVLhKCAa/Di31Dp5OoHZfTSHxA16clxgBW56vRF
X-Gm-Gg: Acq92OFRXea9MoeMLIxEcXJGiv9Eom7H+GMdezdWZIpINe7D97BXOKQ7Ky+Dl44U+Je
	32j6+9t61NpozwD+pv74h6R1E9uXCNaF3DgT47xYIyIsNmrSVKnWQgOF2ikbSN/76VLhMMhvHDq
	B0Vq8V5O6V9SWkrUuCUDVA7UngPJuBjUNl3sA1rUzzmVlR2m5jBlw/WxET/Q//F4Wr/aTofp3i0
	oSWnXGhM4Un/ET2V6OIxQ7FIj2zlKHBvn0+vBy0+QDoa9GNFvLki5WPZsq9W8g8jsX5uBVLT6zc
	BzI95dR3TkNORVc5JgIo4gob10yGNDnfL+2UNWn4nr6bTHDUCN5DdcHauI/V4HP1CRUf4CuwVaR
	qOGqovkcdCtv2bqsiwVHMDYnXZhuEdFGUWmCU3Rpno1KfQGcDJG37oiYUY3tI1Zk5o/maqXd09b
	kC6N5I31Sn8tQk9AjvVMXQm3+dZNb2w77yNy75rny61w9d84aiYTDupTP2QTwuJmcVusCj5G/7u
	U0+GmZIvMmx8YfoqNMunFzgm/V2cxk1Smb7bb908XumrQA47w6YwwMnQhgx
X-Received: by 2002:a05:6a00:94f1:b0:83e:cc27:9af7 with SMTP id d2e1a72fcca58-83f33d39f79mr17554373b3a.31.1779141798573;
        Mon, 18 May 2026 15:03:18 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f1977b128sm15772960b3a.22.2026.05.18.15.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 15:03:18 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Klinger <ak@it-klinger.de>,
	Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v9 10/11] iio: adc: hx711: pass iio_chan_spec to hx711_reset_read
Date: Tue, 19 May 2026 03:32:26 +0530
Message-ID: <20260518220228.63322-11-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518220228.63322-1-piyushpatle228@gmail.com>
References: <20260518220228.63322-1-piyushpatle228@gmail.com>
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
No change from v8.
 drivers/iio/adc/hx711.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 0db2d2db9242..183568196d52 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -269,7 +269,23 @@ static int hx711_set_gain_for_channel(struct hx711_data *hx711_data, int chan)
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
+
+	return 0;
+}
+
+static int hx711_reset_read(struct hx711_data *hx711_data,
+			    const struct iio_chan_spec *chan)
 {
 	int trailing_pulses;
 	int ret;
@@ -283,11 +299,10 @@ static int hx711_reset_read(struct hx711_data *hx711_data, int chan)
 		return -EIO;
 	}
 
-	ret = hx711_set_gain_for_channel(hx711_data, chan);
+	ret = hx711_set_hx711_channel(hx711_data, chan, &trailing_pulses);
 	if (ret < 0)
 		return ret;
 
-	trailing_pulses = hx711_get_gain_to_pulse(hx711_data->gain_set);
 	return hx711_read(hx711_data, trailing_pulses);
 }
 
@@ -301,7 +316,7 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_RAW:
 		mutex_lock(&hx711_data->lock);
 
-		*val = hx711_reset_read(hx711_data, chan->channel);
+		*val = hx711_reset_read(hx711_data, chan);
 
 		mutex_unlock(&hx711_data->lock);
 
@@ -391,8 +406,8 @@ static irqreturn_t hx711_trigger(int irq, void *p)
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

