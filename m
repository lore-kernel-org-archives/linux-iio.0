Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6893ECBD2
	for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772118683; cv=none; b=Qsw7b+6mzJMDf8OLZOHJuhI5OsVzEQ67OUEwm+GnMrBeRFRWb/x1lsY5QWMjP/TU1wPXlre2LxnNEwF9M+ZToO0FBoXKBUj/O+mHAMknr+qohBYeL5PxaP3xexAelYdQea7s8aecn7/4vLNh73hKoSxEhdk6nkzA9G/a+LW76oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772118683; c=relaxed/simple;
	bh=eC4OcRhmLSDkTtLlMg/lYgJlFKVw7QIYt47QGv08+I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kXhkSGW6DSROLTUAV66XAUxB/tYhLChBQoEZl55Bm04I76LLqY/fr7XwavTwhSjsOVfI4ieOdHRGSFKf3G2WHtYYUXkO1n6Ncw5Kc3/fk+UeFUcvFu5nAaT84FCVLLgvpj0xzGOn8MKFCVK71dhWlC0XSIFgUD9CR0NBYcoNHBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gebXlT+A; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gebXlT+A"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-897002b7576so16272416d6.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Feb 2026 07:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772118681; x=1772723481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGlQ2VVKxMQ5I859rXP6Jbm/Xm1NZz+UcI5mRp04U9Q=;
        b=gebXlT+AP54M//lpF04hAmIH87YXQCKgkSN5tgPkkVkYzHkvJHel53XnaW0yZ9KGsH
         oHuPae8Yx4PCBSZ+cwRSpi1p7UrEaXN9wr/hCMCixVivdFN/gVXCCwfNBP++xybY7V/+
         ErAFPtvaasTeIiQXyA2f4HGJYxgxQLTxgmO/qD73xX8zGNHxCHwQtPhVaM57lnrnzZrU
         cS3EgAMnGj/GoBQXoEFwB96EQde0ZwWT/b+FnjWAWPsnPLgwpZqyVGUXzCwImXa1Ia8R
         Ur02mTGegOaXQPRLeOxkCblFe0INypb9GE32HQUztDbZIFpYQ9OOV6qvCZ8pGYsvOE6B
         j9hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772118681; x=1772723481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xGlQ2VVKxMQ5I859rXP6Jbm/Xm1NZz+UcI5mRp04U9Q=;
        b=NLKAH4+ct6pg3PsY+TzsbTQNcW2Q2XE0eICaGCf0DJ+QOeP8Yb4AKzz4HSNoDscTiH
         QXRVPukRKRzExnXAAMtteeqQX3MfHQEpzH99PU6mfXQb3qKLVjrA0EPP7+ZdPUFbLXtB
         n8gugwtm7haPqaAu2f2VJBApAvYb1h9eOpypvm4LgV2H/d12G6zo7PDD4dPSSfVKNS5s
         +AK6a9/hcryatmrvFTzhy11m/iSJpV7KkX4qzMx4w/OSDcm4pR4ENazRCL7vF0ZwS36J
         z9Rt2ic3TCS8k0Cji/Y6jWzju7LzJr97sUm5YSZA+/XGjn7sKeNVc6ABx8o07tE3QolK
         aB9A==
X-Gm-Message-State: AOJu0YyRrs0lD0GXDYyHTSns5tIddzcW7cnw43ffEsNfHZq+0AIhN4Rz
	rUoWTyWY1mrPXeXRv+Pwh6abAS5QFrNwan2B66iNsfdjUyVuQacnkdi67X/t5YBc
X-Gm-Gg: ATEYQzwyGhjzzNNoP3DB4hTHKLzcC1gMZ3VLsfjzmtatybl+B5kabY6O5cekZ3cCDY/
	cY/YLI+HkrxPUX3VEogT86pRS3840Qw1OYnFnsMP+cXzj1MPYCy0l9I9wPrnTsBvS4B1tQ+4cJ1
	zxr7XBxRXLB0nMEKuqifUYQN7z9rr6acC7R/NaQvFShBRr9IL3SfMypNvn0vjvwuCPKO+pyNrL0
	fqUTfdjRl8471K88J02J9EggubIcPiIcrSHybzs5K0sH9Xz9IyvKmwqdyut/yJ8ukA/rsyR7S4b
	szqOLk3Jy8EJHD2xDxyMSke9457RPqtjkR6kb/CqOXH34dM1Ni+9J/wu+uKef73wmXyj898bCFA
	MOW7n8FgATj3edvJZ3pehXBec5SibZcBDyEGZI3TRifKUO/7s9SNZ9J12CyqEtCENghHNZTHwo6
	kB/BdSjVAl7OZwBOFD2eZa7TMehrfx/JV7vvi9YNSbPCWUqqL9VynAxauS9WRXiHki/R5UuZMg
X-Received: by 2002:a05:6214:258d:b0:895:4a0f:ea79 with SMTP id 6a1803df08f44-899c8017569mr30789216d6.44.1772118680750;
        Thu, 26 Feb 2026 07:11:20 -0800 (PST)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c738e661sm19275136d6.43.2026.02.26.07.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 07:11:20 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v6 2/5] iio: core: Add IIO_EV_INFO_SCALE to event info
Date: Thu, 26 Feb 2026 15:11:03 +0000
Message-ID: <20260226151108.22383-3-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260226151108.22383-1-0rayn.dev@gmail.com>
References: <20260226151108.22383-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support for IIO_EV_INFO_SCALE in the internal enum
iio_event_info to allow proper ABI compliance.

This allows drivers (like the ADXL345) to expose event scale
attributes using the standard IIO ABI rather than manual
device attributes.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/industrialio-event.c | 1 +
 include/linux/iio/types.h        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 4149efcd5539..a0d6fcf2a9c9 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -256,6 +256,7 @@ static const char * const iio_ev_info_text[] = {
 	[IIO_EV_INFO_TAP2_MIN_DELAY] = "tap2_min_delay",
 	[IIO_EV_INFO_RUNNING_PERIOD] = "runningperiod",
 	[IIO_EV_INFO_RUNNING_COUNT] = "runningcount",
+	[IIO_EV_INFO_SCALE] = "scale",
 };
 
 static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr *attr)
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 34eebad12d2c..4e3099defc1d 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -21,6 +21,7 @@ enum iio_event_info {
 	IIO_EV_INFO_TAP2_MIN_DELAY,
 	IIO_EV_INFO_RUNNING_PERIOD,
 	IIO_EV_INFO_RUNNING_COUNT,
+	IIO_EV_INFO_SCALE,
 };
 
 #define IIO_VAL_INT 1
-- 
2.47.3

