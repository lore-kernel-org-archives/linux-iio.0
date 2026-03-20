Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BA037BE9D
	for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 22:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774045475; cv=none; b=gWym6qJir29FhEgiKt0qALlYaESMpHYcKGwCajtYFEUg1bXpls2qBX/mQQ7OXqoPCd6hIv6UsflUBNlDaR52nLkDW9T1ApyXZWmtOf/R2w0So4TgVt1njfKjYzuLWU1H1d8xfUGUGFVUdJFE6wrt+8OfwNz56xGtLyhW85dIKsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774045475; c=relaxed/simple;
	bh=DcqeRaeNTz2cvEC9STCbQYR4Z81ZFbiadjKzMth+Dvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yb+LycvesSiz26iDBtMh1o6mzaFWlbX9hTdkslhHdY3nVsNWGDetJo9acWLIfvJKSz//rhhff0KJ1oJbplsbms3WSKyOCzLe7Wgl4DlfFkFZ3paq3b2gv8RqOfEcOO4qI4EbLUZvkhg0Qc4Ag6irM5pP4+OnDBHJEs8xEyfK6RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxX3XFvv; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxX3XFvv"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43b4915161fso961308f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 15:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774045471; x=1774650271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qd4q+zZz8MsM0QKHv87+OJfyCSSecvFPAS7HdQl0+z8=;
        b=XxX3XFvvXCsWFyVDRhQz8aGT3E2Y92bvk7lnS9g1pERTrA8F7+b9KQm8TWw1Gx2qGQ
         1+MJdpSrN1qBOzwX3SbOxAUUHfraAxSOv03Oqo01LV0WLi32AmMQZgBWxJMsHq+7XYoB
         +IvtWutSoBlYUfy31rfUEZwnHWd0SD5U2Gk+oeIQszNnmTAVwhq1uCEUUFItETS9230g
         y+yP7pNRh00qfdpyp22HiiwrKU0MFdAB0FwjXs5I4zHgHhaj+b4rF/D53rGH9j9xKIfq
         aanzkXa6RqeqBtsst3JdWD3czp9OnNq0SI4KszHgd7bVky47d3Ly8mS1cXNUW8C74HF3
         xs5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774045471; x=1774650271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qd4q+zZz8MsM0QKHv87+OJfyCSSecvFPAS7HdQl0+z8=;
        b=KmvlbciNqAgiHyH/5WBfDzVEimluVNrGvkuhkch4CRH0Zbdq+cOPOau/MszSGOKNzP
         lOVGOjVLzQcy59F2JIJsrULM0UbzknKE5uPri01C45jr2IPbH6GfG5Qf7tM6QZ+YDBMl
         h/37qP+VfByVk8J85fPVe+vXo0wqimPbZjIADIAYMqTTOj1ollL8jz28fk/SW+NLn+I/
         GYSi7Vn51/Jak7KEil5BulNcwbTCsdeziSckcL825GYA5azrDsRLj/a+Nbk+RUQRHaAp
         tMpzoz2iYPKkYserbExZNvKIeUzfSswC285UU6s+JOvq9BwCDL9eKngXYkvI5hLo9zqg
         bhtg==
X-Forwarded-Encrypted: i=1; AJvYcCUlAoINgxxF1w0DXadZG/yAUrd5vWc5/vewzfpYtQXlwZEGizd8VilMK1jYtM7SnJazfEw2wt1XTBI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4EWfNarnvTm2hNE0BMR6JHr4t3bLY1+t46hDzQxSzREczENsU
	Yg2moMVjVs9lO7yNRyCg7O9p7i7dYxwiqdTwKsMAhWv4S84p42HyrXC7
X-Gm-Gg: ATEYQzzjjhFeDFOxVKOInFuomoQff9HvQT7mbIGjoCWXImKw2iBSWALAaxGeBTrinWk
	GrPNGMH46GoI2DmrP5g6vkswtS0w3QIIVxJj3YPewvth/fe2KcYxLqgJT+MEjEIXx6QvO1zc1PP
	HeTBnxLke30DIYqrRtr6jDxeC4k4KzgfqxDepfPTLd5Ky1DXVG1CWmnMVVHzAOZ5m81L0BTm7pM
	xbAij+O1HLrC5BJkgn5zxZiIpM9MNHCU+qlMB8Y0JiJxyw2HbNv5FfGfqLNSxvdbklLxzVCDPm9
	xDoueQkeBS1TUEltZA+nQ83YfWhmFh12rh7aYZZjiV/SjZHzn1SXTnr90rf+1ktwDyCocW5Bkj+
	A6wQeDV2k1+lkdLsGkffWJZinaYYxkKdKOS7OMNj7llEw5Ycpjstqo+5uNDE8oyjm1OUoHuyn2x
	IDpbqyGB3AWnc1v2+erGvkdMVGNVfHwtHTpDTEFQ8x161tJJXSbx9ViE+E7w==
X-Received: by 2002:a05:6000:2c0e:b0:439:b744:c5fe with SMTP id ffacd0b85a97d-43b6427d272mr7665769f8f.52.1774045471238;
        Fri, 20 Mar 2026 15:24:31 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:6c9b:a000:bc11:6b0a:79ed:3d9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae016sm9290237f8f.4.2026.03.20.15.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 15:24:30 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] staging: iio: ad5933: use sysfs_emit() in show functions
Date: Fri, 20 Mar 2026 22:24:23 +0000
Message-Id: <20260320222424.53294-3-grondon@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260320222424.53294-1-grondon@gmail.com>
References: <20260319225719.73587-1-grondon@gmail.com>
 <20260320222424.53294-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sprintf() with sysfs_emit() in all sysfs attribute show
functions. sysfs_emit() is the preferred API for sysfs callbacks as
it is aware of the PAGE_SIZE buffer limit.

Also remove the unnecessary (int) cast in ad5933_show_frequency()
and use the correct format specifier %llu for the unsigned long long
freqreg variable.

Signed-off-by: Gabriel Rondon <grondon@gmail.com>
---
 .../staging/iio/impedance-analyzer/ad5933.c   | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
index 85a422329..e5a4f8d7a 100644
--- a/drivers/staging/iio/impedance-analyzer/ad5933.c
+++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
@@ -285,7 +285,7 @@ static ssize_t ad5933_show_frequency(struct device *dev,
 	freqreg = (u64)freqreg * (u64)(st->mclk_hz / 4);
 	do_div(freqreg, BIT(27));
 
-	return sprintf(buf, "%d\n", (int)freqreg);
+	return sysfs_emit(buf, "%llu\n", freqreg);
 }
 
 static ssize_t ad5933_store_frequency(struct device *dev,
@@ -338,27 +338,27 @@ static ssize_t ad5933_show(struct device *dev,
 	mutex_lock(&st->lock);
 	switch ((u32)this_attr->address) {
 	case AD5933_OUT_RANGE:
-		len = sprintf(buf, "%u\n",
-			      st->range_avail[(st->ctrl_hb >> 1) & 0x3]);
+		len = sysfs_emit(buf, "%u\n",
+				 st->range_avail[(st->ctrl_hb >> 1) & 0x3]);
 		break;
 	case AD5933_OUT_RANGE_AVAIL:
-		len = sprintf(buf, "%u %u %u %u\n", st->range_avail[0],
-			      st->range_avail[3], st->range_avail[2],
-			      st->range_avail[1]);
+		len = sysfs_emit(buf, "%u %u %u %u\n", st->range_avail[0],
+				 st->range_avail[3], st->range_avail[2],
+				 st->range_avail[1]);
 		break;
 	case AD5933_OUT_SETTLING_CYCLES:
-		len = sprintf(buf, "%d\n", st->settling_cycles);
+		len = sysfs_emit(buf, "%d\n", st->settling_cycles);
 		break;
 	case AD5933_IN_PGA_GAIN:
-		len = sprintf(buf, "%s\n",
-			      (st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1) ?
-			      "1" : "0.2");
+		len = sysfs_emit(buf, "%s\n",
+				 (st->ctrl_hb & AD5933_CTRL_PGA_GAIN_1) ?
+				 "1" : "0.2");
 		break;
 	case AD5933_IN_PGA_GAIN_AVAIL:
-		len = sprintf(buf, "1 0.2\n");
+		len = sysfs_emit(buf, "1 0.2\n");
 		break;
 	case AD5933_FREQ_POINTS:
-		len = sprintf(buf, "%d\n", st->freq_points);
+		len = sysfs_emit(buf, "%d\n", st->freq_points);
 		break;
 	default:
 		ret = -EINVAL;
-- 
2.33.0

