Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305803CAE83
	for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774941939; cv=none; b=QRJHoU9pjLKoYhmkn5Vs6IBoQvJspobou4CKVVPxH03MUeNKfPRAOOTHbPP2xdN+9OvCj34xtHSsBEaL4AxyqQMCNN9thEotUEz7Xhl781+yzO+2hgyZiwaz09CE8iTjCV05ARTYFM7U5Eb7UU4IcDtlExZ6yxFz8YtHQEUlgKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774941939; c=relaxed/simple;
	bh=tvHGLlUW0934gu/EunJKAraP8P2NLrTeFjBRV1t97OQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qilgUmmvSRH5sxyIbO6hr3OlHn4B2MpyyuyhBp40lIMOoH2J0xdSEOa/66wf7TXmY4sMxqSgpm5U+HhnIGJsFwUbSSxNtHy7vlIzkf0dq5WGsQmO4HLlcGNJMdh10cf4gkm5mo8q1POdwDQtyvSIjDNnwGXMlzv/dO/vTIuPcQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AE2BwzNS; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AE2BwzNS"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2ad9516a653so23374165ad.0
        for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 00:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774941937; x=1775546737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5w9449oT/0NgVOnXXa2/F/Il+1HxCjHPZUwGwVZnks=;
        b=AE2BwzNStX/aqv5GG+uKISpAIOQt3chiknc/pOxZWA6GIQJVK/3YWd/euGU4/FvtjM
         8mqzumuiPsXyD/5/BdHVjOJLhXKetJzVc7eBzeFHyP91nNTI6gQeDPW/nx9V9X6EQ38y
         nf5HZRnN2AK0UoIeBe1q5hoNi+7j4BnIW+RjiSUzDdlo2OKXgF6xHuekVSgtG4rNDJTp
         OTh/y2jiTYZ2FKf1jEdTWNLpZRWW0sS6Mv+aUoY6IIksfANHTOEQJw5+ldmHQiKpzu7I
         CD190+iZjAjzHNBJGp894q7gci9behB3NzI7fg/OOrFS0rNDNGosiN42kZlttRPSM6E0
         OVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774941937; x=1775546737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5w9449oT/0NgVOnXXa2/F/Il+1HxCjHPZUwGwVZnks=;
        b=EmsuNiKA0shS4eOkjfFXfYF4PXwhPpqUWu7BaLnHgVeO798YMsgPpZfHW5B9e/ptut
         /XdJ8l+ZxV0mErItVkj13djr7szGyMMguQslp0rLkZVvGDvrLtpp7/G+OpqX5V5VcImw
         NJgqbqUuNAO0gnQ18P/HB/cUbE6az2XpM3WqLDJVBCBRE4kSX/7V5yXLA8LdF2MmfTt6
         6MVAOA9w6c5XOmYTaVSBzR9dR0mSZVdNCI6fDLPoJyDU/KXAiZrAyADec9fFb1IAh2iQ
         AdvhcRpSPp2RWn/Er2c6rNdjE6/1kdW8QraxnWIGfBQsiwreY2ulhi7bfWFtznSCO3Ip
         U/6g==
X-Forwarded-Encrypted: i=1; AJvYcCX2p/BDlthhH/gC4e6HOtRn30OtG8RwItbNEAI6SMKeTO9lDoMewp5ZAON7vKx6W9nq8fT/5ttaRQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO5kjRfGoLBJug+8+QJzj7k6sgYTq/sfq5//i7WFf6vYoL7Trs
	9Fftt/CWq/FgAlt410lfkKo6wS6ecl3H9EzAGM55sOLCA247sSbUvKO+
X-Gm-Gg: ATEYQzy60EAqJ4aR2/vLMrmS19JmPUkTTiVMwASCusCmDdEvBar0X3xnJCDhlRKQcnu
	pMIUzB+/gD0DudDl9vNfcywvspHc152Pvxf5iHQ2T23B0fWUoxD5Pn34XGRsDQ7q/VPkC28C5L3
	f+62+NVmb2iC+v3K/shZs5RgrMP122v9P6ng/DTY2bRACx90DFhxcxFcjucqi3bkmbz74jJLulV
	7nB44pgTtm0ZSWdD5U1+uIwWDhyU3jUEpRJmapAYqMkx/FK8R9BmmbTdSVlOQXJORvJa7ftjA76
	mMYgxZzVzA+7GwNhwg0bEtKBl4mkjdPMx49RNR6IGLm6yvjVhM6BPqFMYYzI3dxw64dMmofv08i
	xyaAfivF5DR4wfa6OFsOKioBLIBfV9YKjuRnoVa2CQ4vdmfBrZckoPK28NGgvi3kDnItbFbGDEb
	d+253wF34rQHibF74i+r50L6u7jErCLK5+RY0oQI0=
X-Received: by 2002:a17:903:46cd:b0:2ae:8253:1452 with SMTP id d9443c01a7336-2b0cdc1f89bmr165259805ad.11.1774941937496;
        Tue, 31 Mar 2026 00:25:37 -0700 (PDT)
Received: from Mahmudul.. ([2400:c600:5412:6527:d590:8704:ff8:2ffd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242642956sm109272495ad.6.2026.03.31.00.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 00:25:37 -0700 (PDT)
From: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Subject: [PATCH v4 3/4] staging: iio: adc: ad7816: replace sprintf() with sysfs_emit()
Date: Tue, 31 Mar 2026 13:24:52 +0600
Message-Id: <20260331072453.6530-4-mdmahmudulhasan1511@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260331072453.6530-1-mdmahmudulhasan1511@gmail.com>
References: <20260331072453.6530-1-mdmahmudulhasan1511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sprintf() with sysfs_emit() in all show attributes.
sysfs_emit() is the preferred way to return values in sysfs
callbacks as it is safer and handles page boundary checks
automatically.

Signed-off-by: Md. Mahmudul Hasan Mabud <mdmahmudulhasan1511@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 253ef2262..790b04544 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -129,9 +129,7 @@ static ssize_t ad7816_show_mode(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
-	if (chip->mode)
-		return sprintf(buf, "power-save\n");
-	return sprintf(buf, "full\n");
+	return sysfs_emit(buf, "%s\n", ad7816_modes[chip->mode]);
 }
 
 static ssize_t ad7816_store_mode(struct device *dev,
@@ -162,7 +160,7 @@ static ssize_t ad7816_show_available_modes(struct device *dev,
 					   struct device_attribute *attr,
 					   char *buf)
 {
-	return sprintf(buf, "full\npower-save\n");
+	return sysfs_emit(buf, "full\npower-save\n");
 }
 
 static IIO_DEVICE_ATTR(available_modes, 0444, ad7816_show_available_modes,
@@ -175,7 +173,7 @@ static ssize_t ad7816_show_channel(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
-	return sprintf(buf, "%d\n", chip->channel_id);
+	return sysfs_emit(buf, "%d\n", chip->channel_id);
 }
 
 static ssize_t ad7816_store_channel(struct device *dev,
@@ -237,9 +235,9 @@ static ssize_t ad7816_show_value(struct device *dev,
 		data &= AD7816_TEMP_FLOAT_MASK;
 		if (value < 0)
 			data = BIT(AD7816_TEMP_FLOAT_OFFSET) - data;
-		return sprintf(buf, "%d.%.2d\n", value, data * 25);
+		return sysfs_emit(buf, "%d.%.2d\n", value, data * 25);
 	}
-	return sprintf(buf, "%u\n", data);
+	return sysfs_emit(buf, "%u\n", data);
 }
 
 static IIO_DEVICE_ATTR(value, 0444, ad7816_show_value, NULL, 0);
@@ -287,9 +285,9 @@ static ssize_t ad7816_show_oti(struct device *dev,
 		value = AD7816_BOUND_VALUE_MIN +
 			(chip->oti_data[chip->channel_id] -
 			AD7816_BOUND_VALUE_BASE);
-		return sprintf(buf, "%d\n", value);
+		return sysfs_emit(buf, "%d\n", value);
 	}
-	return sprintf(buf, "%u\n", chip->oti_data[chip->channel_id]);
+	return sysfs_emit(buf, "%u\n", chip->oti_data[chip->channel_id]);
 }
 
 static inline ssize_t ad7816_set_oti(struct device *dev,
-- 
2.34.1

