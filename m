Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30A03A0E81
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778321486; cv=none; b=mmKIceeHF/Qb775RRp9ehhvjWZ1LU9MjYGuwVnDFVfeXlJLrSnUlDzh85GL6+bO/2wcvEJRFLFrK1m93/LpekF3aTF9LsCq5ZQ7uzKDU6jIFD572voN+dznYARXhgeT40PqdTvKwh2s9HJAH2mVoo4uBjPK6R1AJisdYMMIeudw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778321486; c=relaxed/simple;
	bh=/ypM8gwlCiAeCIMJp+GRH1JKDXxEaGiFEs725h5oIl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qe7CYZGKg1TrpPenwoAJaru1OWT4Kex3DWRdorSt5jMrYQcd61jST0QUXKjkT/4vZuOSb+wBGQxkD2Yoha7spDBBSY06SFll/rY0yUS4lCUrsGuBAP25J+3/4kjpiYnnbF8AC5EHlIDcgsy3ODGXGd4wcMpkY2613rJhE4svyro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ku0O9Kab; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku0O9Kab"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c801912c903so1214817a12.0
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 03:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778321484; x=1778926284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxEj5NvBAWz6r+Pm4CowXogfvDTiNULt7IFl/LWJs1M=;
        b=ku0O9KabwFNfEXhEDmk4E5umbV+EVBGQybz+RG5IRB961Bt/uhVCgb1iFurwzxqXwi
         6rB8nxIzfp48jn7JCo0biv5sCJBHWHnbuCpKjzBn/0EPtEvlhXvdJQxlLLNC4s1oFx+q
         CvAbf8Ptv0yNSd8EggetIKklX4cZEuyh1dzc+iNvsDyOSqVe6/mtawIBCAD9PA1VBq7y
         MOxkPGntyzlCZB8YkHYl9Y1TC+K3WcKzxi/3OmvFGl7Wg338RbCkIQR5wbqNdGoTqBCr
         05UpS/oh+ZzELhToE88oFwGuEbViqznxYZnXG0rKVznimYGljigIXNQ2wKFk9YysCEKG
         2HSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778321484; x=1778926284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YxEj5NvBAWz6r+Pm4CowXogfvDTiNULt7IFl/LWJs1M=;
        b=lJx+7c8ZpVvASz1e1X5Z6w47ql0vailDxi2fXXzZW1gKq2uBOWOZvETZDHunf3yPVl
         FQxJgUdoLKZmOi8oQGTBZzEWsSfVfHh7VoiI7qbtcN8ZoGwB7hch7lwpPZzldWF8UK1W
         zRL8zYutbnaHBepiJXK7PniPlmloJn4ECwIBYeHW/0a9BdB5RF/gZWARl1yBaxZpG1dz
         ydncBgA1QqA+cKd8AdZpak9YhGD9FHX4laocQnjIsFDZeEf4URIr+JzYWIbTb+DuR99z
         DekAgpE8hPSuG5+f/vCC9e5Xav8OQVdzmgsnfRUjELERRuz69VvZYpHzXSJp9Al52phC
         HuDQ==
X-Forwarded-Encrypted: i=1; AFNElJ82aMK/9xhxsLgpHcodgoDuAjy5rWe/bhiCVSzs1C35eB7UkxWmRALJIdWe227VVxlD2bVZRsllgm4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqrcdeep5xtbsALyAmveWhVeM6p59kDbO7aqIn+NPpxA04GdKM
	tXqZ4ghjZ/8/pJeCSAwu3qVyh5Uf9Iu5Jl2Fo227ZCNm3CLA1hLRnDLOoziRAw==
X-Gm-Gg: Acq92OF/Jr0hdqNmzZ1jHARtGxmYLygHPOd/NhH6l+oOvy7GVH0oWw5hVu2/psfQYlK
	osAawzkAibfjlBcBnlSzhorU9KS6JoOLtNBfvvXleyjrkKIcXoY71NtW2fNXurgSWiQLt5JD9xp
	ADUGtiy+fKfjpDzHFMdD+1bIBebrPuhwm5V+Vh6eeLdPE5qGm/wqwRrKVpBhpMVVM8KLaIlymYY
	1FZAuHN7pdkS6NYaEM9ZfYGH11eJ/kU7JazmdbwqsS/3SPfYLuXHVdjhSPJAUIb48s2N6pD729J
	2pciU2+q91Y81AWWDK1xVPGI6TsvkpyXGGZbdEY6LlzSvGpkXB0RXXZBUMNUpYjPTBjWZjIo6qg
	XRyy1jiIL5wa6yV1bof2UvBFvVLoZH4acBbC5Ma4HHIM1h869kRPsw8M5TlHXVXGmb/08I1o/bN
	Qf1Kpy+pSXEYXHcSzfmwbHpEeJOCstFv4F1TyY6mZzoGONWhMD
X-Received: by 2002:a17:902:d588:b0:2b9:cd2d:6f13 with SMTP id d9443c01a7336-2bc7a9a62ccmr21182805ad.10.1778321484030;
        Sat, 09 May 2026 03:11:24 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e83084sm47335365ad.61.2026.05.09.03.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 03:11:23 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 9/9] iio: humidity: hid-sensor-humidity: drop hid_sensor_remove_trigger() using devm API
Date: Sat,  9 May 2026 15:40:40 +0530
Message-Id: <20260509101040.791404-10-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509101040.791404-1-sanjayembedded@gmail.com>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Use devm_hid_sensor_setup_trigger() to automatically release resources
during failure, unbind or removal of driver using devres framework.

This is done in a way to simplify the setup, remove goto and avoid manual
resource cleanup in teardown path.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
changes in v3:
- Update commit message based on review comment from Andy
- Based on discussion using parent device of HID platform driver used
  with devres framework for this driver
- v2 link -> https://lore.kernel.org/all/20260429175918.2541914-5-sanjayembedded@gmail.com/
---
 drivers/iio/humidity/hid-sensor-humidity.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index d310ec43a118..4d4282e4b6e4 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -234,8 +234,8 @@ static int hid_humidity_probe(struct platform_device *pdev)
 
 	atomic_set(&humid_st->common_attributes.data_ready, 0);
 
-	ret = hid_sensor_setup_trigger(indio_dev, name,
-				       &humid_st->common_attributes);
+	ret = devm_hid_sensor_setup_trigger(dev, indio_dev, name,
+					    &humid_st->common_attributes);
 	if (ret)
 		return ret;
 
@@ -245,7 +245,7 @@ static int hid_humidity_probe(struct platform_device *pdev)
 	ret = sensor_hub_register_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY,
 					   &humidity_callbacks);
 	if (ret)
-		goto error_remove_trigger;
+		return ret;
 
 	ret = iio_device_register(indio_dev);
 	if (ret)
@@ -255,8 +255,6 @@ static int hid_humidity_probe(struct platform_device *pdev)
 
 error_remove_callback:
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
-error_remove_trigger:
-	hid_sensor_remove_trigger(&humid_st->common_attributes);
 	return ret;
 }
 
@@ -265,11 +263,9 @@ static void hid_humidity_remove(struct platform_device *pdev)
 {
 	struct hid_sensor_hub_device *hsdev = dev_get_platdata(&pdev->dev);
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
-	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
 
 	iio_device_unregister(indio_dev);
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_HUMIDITY);
-	hid_sensor_remove_trigger(&humid_st->common_attributes);
 }
 
 static const struct platform_device_id hid_humidity_ids[] = {
-- 
2.34.1

