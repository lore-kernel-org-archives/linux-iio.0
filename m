Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF42B1E47CC
	for <linux-iio@vger.kernel.org>; Thu,  5 Mar 2026 02:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772677082; cv=none; b=VvkydYxeRMglrsMhzLkFMqSkwXaF2WEFG4IbTSAIC9XMeETLnjiTBWHgBmUZDzlot9s8QvDeg/U1E6nLL59rVwzfLCTxagOCiPcqTKHA76locqgp1vzWu5KniFIXrUMnUuYai9XRSAggRi8s3EjpkTloaW/H92AM/AZvlk7zbxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772677082; c=relaxed/simple;
	bh=Lz26gbthIWagTqnUPsQBey4+wo0D6+5E2mtqiyeq63o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KIVam7rNSFRq5XGc3Dad8fwqN8Y8KH6LU1s++7hqoPXnw/8GZsV7Tbn2sT8vhszQsjBJovpSaVRAeBx+9pvV18gZDnN9Pv0NI3qMmI2AwB9Xka6D6eW2PMQ8zuAcdPagdeZIAwcOzk9np4MP2w0SQNYrf7DcbmWBdnIOUgx5MEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DPYB1G0W; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPYB1G0W"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3585ec417f6so3076942a91.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 18:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772677079; x=1773281879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PuzV3qKHgloifZ8kVZz5P5iRG9Rp+GKiy8GOZiALluo=;
        b=DPYB1G0Wx0IiZ2RNB64E1j8ERGoq7r/5ILDCuEId7cgnUpjiRQC77NUbr997sydQ7v
         ++Xbc5GCL1bG+rTU3sK8A6P1bXYMnX77KiLow3PoXrwfhBneOJqindb2ePXzqml/ImXh
         Tzqm5pyE7n5aWet/XmUNrpL0bltH3P8yCdGV53Y/HN9QfQelutKi5KEbRgCqkqG/M+6p
         47yfxoufZ/c+vHyNnBuDo1IlPPG5O9UooMV/BPuAT/G+HxzE8rO4XkEsURmMHCMN+LbK
         IxvgeMFKtWbInAI7eq0S8F9HIekFpdnWolAi9cdD21ckfHvftXY9qWkDg4TYN62Ygfv6
         4uTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772677079; x=1773281879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PuzV3qKHgloifZ8kVZz5P5iRG9Rp+GKiy8GOZiALluo=;
        b=kvJV1PCxZyk3cknhzBHuOzNWSZ6mvhob/B/Ziu1IY6gc3muaVlD1Hfl4BR8EsCNG7f
         v8Msu2VoM8iWjmYXUW3U/kJdQfh8e1T4TXyUtHTQryWWpOQKkSTYlYYNMU/1T7P6px/h
         zeJBTLOkt7OzeYd9RWCVf6irMkz2rUGaamkb9341uhLgb4muelFkH/+XRFCt/OVATvcq
         /CjWYSAZHrjXui0jixOi53jfAe49tDnbH90P0jc+z1FbGRnJoLJlIJJPSHYJsHJKxjBl
         a8x4r14V3DvfUdf6WfCmO7qobtx3+sQFoFLyNQUV7x9fd2Uw5XKN0XRFYUxEvQUu4lUn
         0X/A==
X-Forwarded-Encrypted: i=1; AJvYcCWMHG/dwPDRYhYmE6Z1dlH/Wd2xT+RmK65+/kkZqEaYVsckmtXgsvNCjX1YikVYDRWaWlZlt3X0vKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq9TC4WKohhuiOcZv1xO/HJe5CTNwLlXpj1YGDo34hyGXW2vX8
	11dOHDCVY+TkLaLL5f3xp5BAaN2qMttSKISX/x5r/UR3alkJhjDuNF3F
X-Gm-Gg: ATEYQzw/qKlvAanKn9taEdb5vxv+J8ArTk4IfF/cZZiKCP9VzEvULJVfOYt5F1XMlRQ
	FWc6A+Mn4ou1Tm0uRnDda4/1efLr4h2PYKHRrCtANLygnXpWp/wO9FspAs+78KnKs8etuMjJkDI
	tLMI1tZpDg38ASC4LDf3rMfvxS/Dfrfki+JnQ9+TlxorNson7p17dHY6Wfr8IsWxox4a48fgRCj
	0ZQtTpyA9B+wWRzcoJkp3gkXua5VXYbOOvqJ/Hk7N+QAU+MdS0P/GsaUoFUHGva3nwDQp1nBv2t
	4NMlbo64ZI5YSBOvZmcPfen9N9gqrSlzXJXlHay9vgAGdvm+vc98eNeXhbEETxBAmQ+kTcQCA90
	o6n3JpCpe3rGRjTJtJpxAWhJIvJmksyatFLpSsDa962M/rnqKsG8MTOF8sNcDw67Fz5zfv/CDYB
	6nzFm+wlx/+LF5N/f9ahQz+qqCi40TqC05FChO
X-Received: by 2002:a17:90a:bb81:b0:359:8dfc:d39a with SMTP id 98e67ed59e1d1-359b1b8c914mr508440a91.4.1772677078634;
        Wed, 04 Mar 2026 18:17:58 -0800 (PST)
Received: from CCY.localdomain ([104.28.156.107])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2d6f21fsm262098a91.16.2026.03.04.18.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 18:17:58 -0800 (PST)
From: Chunyang Chen <chenchunyang0908@gmail.com>
To: kuurtb@gmail.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chunyang Chen <chenchunyang0908@gmail.com>
Subject: [PATCH] iio: adc: ti-ads1018: fix type overflow for data rate
Date: Thu,  5 Mar 2026 10:15:50 +0800
Message-Id: <20260305021550.120614-1-chenchunyang0908@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable 'drate' is currently defined as u8. However, the data rate
values in ads1018 can reach up to 3300 Hz (e.g., in ads1018_data_rate[]),
which exceeds the maximum value of 255 that a u8 can hold.

Change the type of 'drate' to u16 to prevent integer overflow and
ensure the data rate is handled correctly.

Signed-off-by: Chunyang Chen <chenchunyang0908@gmail.com>
---
 drivers/iio/adc/ti-ads1018.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1018.c b/drivers/iio/adc/ti-ads1018.c
index 6246b3cab..049b8c00f 100644
--- a/drivers/iio/adc/ti-ads1018.c
+++ b/drivers/iio/adc/ti-ads1018.c
@@ -249,7 +249,7 @@ static int ads1018_single_shot(struct ads1018 *ads1018,
 			       struct iio_chan_spec const *chan, u16 *cnv)
 {
 	u8 max_drate_mode = ads1018->chip_info->num_data_rate_mode_to_hz - 1;
-	u8 drate = ads1018->chip_info->data_rate_mode_to_hz[max_drate_mode];
+	u16 drate = ads1018->chip_info->data_rate_mode_to_hz[max_drate_mode];
 	u8 pga_mode = ads1018->chan_data[chan->scan_index].pga_mode;
 	struct spi_transfer xfer[2] = {
 		{
-- 
2.34.1

