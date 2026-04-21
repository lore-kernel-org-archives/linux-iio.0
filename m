Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D443A453D
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810190; cv=none; b=RZY2p4uI4EUhDqXqD1dWWykqQQmFT1Fp6yp45L40mEKxfkfct6XBLIvmKe0YUCsIfuuY8aZ5q+1UuDZMD6SJyFsbUTI3aPIzulrMPgqXmh3CPgYD0GRnxhwK9rzTmoPTv/P5VB04Vsn9aZpZVwQ/EhxhNIc4WcY8OHVnus98ZY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810190; c=relaxed/simple;
	bh=/ce94Mc3GWWXNTYD7wFEvd4pPvHbahgXZy3vsWas94Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMwzhHPG0h7XU25agivwI+UuCG58XKE7QhxBKZdgkH7GmH92VaBvrNkjURTn2nLshA7fcBL2bGc0fMPu0Ig6tsExFWnX1Q6QLtW6qP19aJSCxeEkBrT5m27vQp/A2F0FfQOQGn1EaFVwn9NMimDWHmG6xZB8ypYpBRlAuUAQGvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=KzlCfEy6; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="KzlCfEy6"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c637089ccso432264c88.1
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 15:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776810189; x=1777414989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=alV0/ZcmCtMRPsl8aXibbmAcoGCSPLj/Q0zsgAAjvt8=;
        b=KzlCfEy6F0yKE/3VBW7eQCO/ny1qWFnlxRfy8NaYM7Jk+ACe7RJJ8/s0NrDze07PoD
         Af3lULyNp8elCxkOX7C8hGAfqPXtFlHKLA1fw+5t9FIagzyzu549PhCFoli8+7BgVV26
         Q875w8S5umOLLI/xfnfxGEVxlvaOnp5DAuD0EASGW5iuKf/nfnp3RbTiI7oR97znuExD
         6xS38qsM5xJDICYeKJqKxeFj/+gfBtyuKYn9nWFISmSvhcLvgIhiMEgbCQDmCqscJgMo
         /6ASvmcFmsM3peZ3S8bG/DtH1KV0ePxnpbaZKIzVO+xHATihTVoQVZ+8297wrqO8/MfO
         kPWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810189; x=1777414989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=alV0/ZcmCtMRPsl8aXibbmAcoGCSPLj/Q0zsgAAjvt8=;
        b=TcBcdckTV6F903Vaiu6rF1aXd6prrV0D5rjvbIi3AUcjGAJgcaDZDlUb4t7eXo20FO
         yNzdA6nOCgqQqmmWEaQVyPC+3tSEoNdP2ALnf5DnVf6tMAHAdEXzL6E9pn+xxisqlCwK
         9MPqIw81sjnvs4d5VsDEQlDIuNM/+6yrE5DHy4B9d+Opg6In21eIb5zWgQ0o7C4wdrw0
         kmUAPVTwXSTtip34Ky4nsRWPviWEicAyVsV+cdnBf1SWL8UMFmzKFbA55UHlbHxKkAKA
         1OLNkhqMQ2oTLn3pO8/xtbnsx7gYSBAMem/wkilX29oKRkZub56bAcWQHb7F7zKAeB+s
         LCnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+hmp2GrvnqPnWTJHbw/og+lSfu8NxfMl4QTd9qQfPFAlztvI9ObYchereoQKhc2I+4Suq7Dync5WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8z0FFFx1NZqg22IMvFJOTvOLKr/SIT/Z/fWNAabJ9cu1ELDjB
	grfk/rZ477bfg8iOIXM/UNGIh5R/JKoU9hILh8dJY4r+WLmtRbP3iUxBgMbqh4SEssU=
X-Gm-Gg: AeBDies+pzJfwXEY0K4OiTBdqvo8QYZ4GBxFwqvhXCYFalMWA5v7AfdG8GBkJ7kk7tE
	lgByPRnxiYDxP9C/EfWmsIyqeVgT394giTdch+3EN4qxCci1MZpa8Zz+WZZb9Nk6Evk5YdF7/U3
	ZWq98FLICmoTyZJdxcYYwYd7Jv4ynm0dt8a3uGFThG5pPkMAra+F4ZuF0ySpQYH419tuATeEVAK
	kkPKqz48bXUHU3WVHFP9D8a3JUfRnc6RlFr+TYaIPyuHUMAMDK3NrEJMAI5exCgFcYK3FjMOB9w
	JbstWewVhFybtJ57YJwOCpU7560xZkuEzgTfTfOtLnueOtUy3VKa9el3js3ZFobqWWU0+h6k/m0
	/iBJPaa6wHLP7kBRkCl0bzso+FfmmtqWdGVVC0N7EmwapgQejFvIj6CcfGq3XuY0v4BaquUD/wV
	hGq1TRuYNLUXnnOe96AAotT6tMDjqqh5pyr9U8L6Z5zpnu4QCf
X-Received: by 2002:a05:7022:f016:b0:12c:44a5:fb54 with SMTP id a92af1059eb24-12c73f66c7fmr9811185c88.7.1776810188618;
        Tue, 21 Apr 2026 15:23:08 -0700 (PDT)
Received: from natalia-pc ([187.116.73.68])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c831d5b29sm20129785c88.8.2026.04.21.15.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:23:08 -0700 (PDT)
From: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>
To: andy@kernel.org,
	bentiss@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jikos@kernel.org,
	nuno.sa@analog.com,
	srinivas.pandruvada@linux.intel.com
Cc: =?UTF-8?q?Nat=C3=A1lia=20Salvino=20Andr=C3=A9?= <natalia.andre@ime.usp.br>,
	Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>,
	linux-iio@vger.kernel.org,
	linux-input@vger.kernel.org
Subject: [PATCH v2 7/7] iio: pressure: HID: Replace method press_adjust_channel_bit_mask()
Date: Tue, 21 Apr 2026 19:20:39 -0300
Message-ID: <20260421222210.16016-8-natalia.andre@ime.usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260421222210.16016-1-natalia.andre@ime.usp.br>
References: <20260421222210.16016-1-natalia.andre@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace method press_adjust_channel_bit_mask()
with helper method hid_sensor_adjust_channel_bit_mask().

Signed-off-by: Natália Salvino André <natalia.andre@ime.usp.br>
Co-developed-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
Signed-off-by: Pietro Di Consolo Gregorio <pietro.gregorio@usp.br>
---
 drivers/iio/pressure/hid-sensor-press.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index 5f1d6abda3e4..fd9dafe4945a 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -53,17 +53,6 @@ static const struct iio_chan_spec press_channels[] = {
 
 };
 
-/* Adjust channel real bits based on report descriptor */
-static void press_adjust_channel_bit_mask(struct iio_chan_spec *channels,
-					int channel, int size)
-{
-	channels[channel].scan_type.sign = 's';
-	/* Real storage bits will change based on the report desc. */
-	channels[channel].scan_type.realbits = size * 8;
-	/* Maximum size of a sample to capture is u32 */
-	channels[channel].scan_type.storagebits = sizeof(u32) * 8;
-}
-
 /* Channel read_raw handler */
 static int press_read_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -225,8 +214,8 @@ static int press_parse_report(struct platform_device *pdev,
 			&st->press_attr);
 	if (ret < 0)
 		return ret;
-	press_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_PRESSURE,
-					st->press_attr.size);
+	hid_sensor_adjust_channel_bit_mask(channels, CHANNEL_SCAN_INDEX_PRESSURE,
+									   st->press_attr.size);
 
 	dev_dbg(&pdev->dev, "press %x:%x\n", st->press_attr.index,
 			st->press_attr.report_id);
-- 
2.51.0

