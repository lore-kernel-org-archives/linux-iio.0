Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6702339E19D
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 12:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772714605; cv=none; b=WxxWOo7pb7JJRGQJQGDr45eXC7sSoGOGQNTi9XHbXICg8cR8Zbk/rx3Yxenm8yBl0qupbyJFvNk9agp26m8919wVV7+ef+O2LK5hWGMv7U+YrRMJsfDz7/fhKFvor9raqz9wWW7ztB2W+j0nk31KA0OdgXV+WFldbh//xDXQqhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772714605; c=relaxed/simple;
	bh=ssrFNnB95raPMoRMwOLoWtOJ4SIUcnFv6ByVRwy2tuo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VhJq7hlXP/5zlBNar/h1cvEnjDW6USeGQh0fDZnvkd79Ch83rKcr9enOESgvZLtGD40bOUEZ9RalPC4m2yQs94a8wAEA9cr6hYZQBTd+i5lo8SFbHSB43Zmlh+sBXDY131qQ1nDh3U20T/BWsnG9XVvmoMkS7DxxB/Ug9VeMEs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNnyHeXL; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNnyHeXL"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c738b98bfd9so396726a12.3
        for <linux-iio@vger.kernel.org>; Thu, 05 Mar 2026 04:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772714604; x=1773319404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reaZ+LQ+82wfnheRZrCROh/DAFmw56+XnIwDQq/iVYE=;
        b=TNnyHeXLkdCK4mRfM/VeZgA3p46lFgIp1Pr8CkhliGZ/EDBs61LEBue/A76n1+01KF
         3yDOkKGbW579SvQQBGRYiBfF+Pxpc8PjXSxDSkou8Okc6fb2eLZCoWA6o/DlvYM08517
         y227xn/r4pAf0EZ4u5tvFn/flcMxszVjD8e+ZAYQ8lv0M9BAnTlQOraUgrYUBY2flqEQ
         8wTpLG822Jka05nF0PkGRdahuJKyFaGZkHPAUcWAklfxaTW/312ZzBizpTCeArYj7VKT
         +x3ffWy6sqCf1zmNEMrpS2woylRFW3XNiEP7oCizDDD4bW/DxWPW11WTpp2+ZHtXyxTs
         e4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772714604; x=1773319404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=reaZ+LQ+82wfnheRZrCROh/DAFmw56+XnIwDQq/iVYE=;
        b=Lz0lGYF1D/6EvZU9TbWYYaTkW0AFmw7XHPS3UtWuhQUu4yaXwm57Pkcs9IZo6exvfw
         V5DWlMVwizjandmF1iOJfA9sfvBYV+FuKCDODqkeDqwZnLCtR5NJSdue7I8WBA+OGrHH
         m2gS/IyJWhZLeIZsB2axW1kStTM5axNfWOFKK2ogiA5Opr8vJGFsfdBwTlbNXJDNUZzc
         wBY+iXz/m1PshyLC/Wo8LOZw6QNO8lMh4xMLyIeK2SNsBefDaFqAhPsX4fKBGHC7Bewy
         ZgLsNjpHYSIs4mJ3aXc+AdgwOvon78xv56u3ySH5IsJjg/cevHNKFAl/32PaNxvF27py
         giEw==
X-Forwarded-Encrypted: i=1; AJvYcCWp/AYywevvc91zjttWVfX2Cb5RUiXLEZChbtUE87ZjtlMk63jYtHoyMWJiYqskfBZReRA3raiC9qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIRBjEaSFmQILaoXqum30GyzK7VrWYcnDlFucKIFrSze7TMCF3
	a9Xpxgb28+iajN9QbQv2gfXDwgHGTRW1Z/fy5CBrsLYRJOkbR+rSgpv9
X-Gm-Gg: ATEYQzytwQsFz9+AqDelZa7lSdkyeKsuMZsuytzwIvPb9CwXdAwB+BuI1h6Q6tk3+y5
	q/3bqMif6hZjzX0O9PvHdxTbnfotgEdC7UFA/mRxqZcV9qphmd/q3dRYEjOtIq0oK83N6qKLa1y
	9l+DD65PVd8y8u/SSkJeq+1yHwV5KAlyt4dYBHzEcD+75aIpKtrfEroxFCAYucF2H5MrB9BDzmU
	G5cYs86b3Xh6NVS0IWnFk0U7yhYGsbmGqp1f9vROGkOZfqGrmJ1tGlugRtK9L7LorHi8zR693rQ
	CwWfcoqgOxkZSOPkE/RaQECZUffVaMtGlPIehh31hNa/nKPCayyArQifZtesT1zk3LqlwizGAdI
	QymuxBjN1ByiH67+RLYByc+6ZVdjy3Xjs7yLmyNqTYrToXlurV163ADWzP7OK/bNHqmIsXo32n/
	QGLzV+B7Z01EPIuQ+RbCzmu5dt2/8Yw13MHOah
X-Received: by 2002:a17:902:d490:b0:2ae:4445:f38e with SMTP id d9443c01a7336-2ae6a9c6543mr52088695ad.12.1772714603579;
        Thu, 05 Mar 2026 04:43:23 -0800 (PST)
Received: from CCY.localdomain ([104.28.156.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6c4dd0sm228351215ad.70.2026.03.05.04.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 04:43:21 -0800 (PST)
From: Chunyang Chen <chenchunyang0908@gmail.com>
To: kuurtb@gmail.com,
	jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chunyang Chen <chenchunyang0908@gmail.com>
Subject: [PATCH v2] iio: adc: ti-ads1018: fix type overflow for data rate
Date: Thu,  5 Mar 2026 20:43:02 +0800
Message-Id: <20260305124302.129637-1-chenchunyang0908@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305021550.120614-1-chenchunyang0908@gmail.com>
References: <20260305021550.120614-1-chenchunyang0908@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable 'drate' is currently defined as u8. However, the data rate
values in ads1018 can reach up to 3300 Hz, which exceeds the maximum
value of 255 that a u8 can hold.

Change the type of 'drate' to u32 to match the data_rate_mode_to_hz
array definition and ensure the data rate is handled correctly.

Fixes: bf0bba486b5b ("iio: adc: ti-ads1018: add ti-ads1018 driver")
Signed-off-by: Chunyang Chen <chenchunyang0908@gmail.com>

---
v2:
- Change drate type to u32 as suggested by Kurt.
- Add Fixes tag as requested by Andy.
---
 drivers/iio/adc/ti-ads1018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1018.c b/drivers/iio/adc/ti-ads1018.c
index 6246b3cab..0780abd0d 100644
--- a/drivers/iio/adc/ti-ads1018.c
+++ b/drivers/iio/adc/ti-ads1018.c
@@ -249,7 +249,7 @@ static int ads1018_single_shot(struct ads1018 *ads1018,
 			       struct iio_chan_spec const *chan, u16 *cnv)
 {
 	u8 max_drate_mode = ads1018->chip_info->num_data_rate_mode_to_hz - 1;
-	u8 drate = ads1018->chip_info->data_rate_mode_to_hz[max_drate_mode];
+	u32 drate = ads1018->chip_info->data_rate_mode_to_hz[max_drate_mode];
 	u8 pga_mode = ads1018->chan_data[chan->scan_index].pga_mode;
 	struct spi_transfer xfer[2] = {
 		{
-- 
2.34.1

