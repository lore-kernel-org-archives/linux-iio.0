Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0891036EAA7
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894671; cv=none; b=Jh5rH5KCKJk2XB6F+frzObRnYT55H/xZli0IVKQT/KjGfDyEXjMkYHvcf1gqPHZhhSmX3C3XwjgQ6fCqefqm/TqSwNWjZnk8Ck4JebH/hva7kFLdAsZze3Ek2GrsZtwDQxM7krYlWQKkeRxzjCXvqjGqmLIxrLKO9CWMI7UdItU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894671; c=relaxed/simple;
	bh=Mc846RV35bT6iP3fArUd1CRV+Tf3YyEFa0/aDDYCJ1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NLo+lak7O2vgcuaaO2QkPZ7An51H1B3Mamkf/lKqPA3gLZ4C2t62PNZ0zdU2h+H4L1EL5loR8AwdgReGqSzJJu1whf+KpYONqZUAvxCN4WyQBXJTITFmKv9N3YNpVnqW/TVTIRx2UKKc1EkOlrfN5BG2hpBrYUDwlDcDQ2kpHno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQ0QolDP; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQ0QolDP"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-82c20b9fb15so2173687b3a.3
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 11:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774894669; x=1775499469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PpGXMoX9YPHZwP7oVnaLSkpSaXw3E3SWpCp8C56AwzE=;
        b=eQ0QolDPbbvCYFig/gBnzeM5G37ecNxycy2CraA/uE1cDKgivnn7XqJ3NNt5WiUYn+
         8q7iEMJ/XwmWES3udgT3eqgYw1jZ318qGoxT8axSRUQOc+c7ybnKEyn/LS9ICst8idnO
         yF+pS8y7j+xtkFCMK0Mkd3w0fpH9R4TEqxhXp+Rdi5ZJ9/yr5vjozDbOUyu4Q1H7N285
         jSuFV/4iK0KwMpPCB1zoG3/XHaWhSRIZVSX/r7yLfF2leGcfNJztmdFzTbDI1vcxeR+q
         rCeNbiu/acqeeZishxYgm/khB7D3RZ/frpzPX8OnFoYvjs7iE0Ta+mXPkQBwFvKUqz/e
         otUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774894669; x=1775499469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PpGXMoX9YPHZwP7oVnaLSkpSaXw3E3SWpCp8C56AwzE=;
        b=itEva3yasvHTz15OuzAzkho6wr9agGpDfiwbiVYQAXwtwuiEDngxluqMq8ZuIyQ2QG
         JRJnm+d/qYbprKP/DI6UUk2ctwCP8bn3Xk9L00pEZp5eNzFUZEjB2+YmcwkKkqcrKnJO
         pZJqjr7Dgts3QjoWp0+tMfX1fIYMCOKzHAHMjmfhXoBwbl5l4GSYaDG3Uql9Ka7z7WzU
         Habo+45tOdcXnoihb4RNRbsWoWq2vGax7IkmNd8VtkAlNi75UPmG7i0pGRK+f89kuE2w
         b3Fd0BVJUfMNkNV00V/409Js7nkaFdrr2KdVUI31aTZUR7k1UseUrNghCljkRBr9AwOv
         o+HQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/b6DueolahUkg7B+jA+P/f4yIG+MM2rpl2X7gGW4SDjAgVWW+LCDOQBmwAPxCmB8X6xfphMPiZKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxImCX3fWARlcsyiXwKUnz3KW9JhoFmX0iXfwFIWUaOBhREzaRC
	l2/KT0if/2t7ojbYan4tlSjVQeFJz8ew03t0lF4CV9T/t6uhOLgTdB99
X-Gm-Gg: ATEYQzy4XUHa6nV/5osPxXHmmmXjhIg8xM0NMkC7oOofZZ5vADrdMz8Q2pHsKA3ceSr
	hEKHPECz3xes9oeQUGrADaz/RZJuO+9FJDTV84LarCe3yb2VMmAxvJAq4sOv43cuMix9PooRbGk
	0eIty/fpdQ+9eATvdeF3kE/p9gS2P6wg6ds/90aVbCPYCnGkHmjUSUPObRKoIY2r44g0QhZdxZs
	v9/rXywqEdT3ZGiHSyJcMm8iaCbO84O2jA0oFYoYOsQVU5FYAXXN0nFKNxbUv10RVLwifqo3f34
	KHc6GHWrBZBwJGbH2RnEGPnoe+/UFgMnm1NUowfXys7z+BdhifUnGT0VflC0sor0WSC4mdc6/N9
	eAk8i7EuFj//phtZaRNuZr52xYrzh09zuBD8CSBawspRFyIcFbKBFlNwwOfHeWkCB6vLKvori7H
	0Vg1yHinbPhCkvvMlODJLudPYPkTZPWMy4DGEOESW6qRmPmnvQPm8=
X-Received: by 2002:a05:6a00:94d2:b0:829:7a62:5f with SMTP id d2e1a72fcca58-82c95e5ab81mr12051966b3a.9.1774894669426;
        Mon, 30 Mar 2026 11:17:49 -0700 (PDT)
Received: from Mahmudul.. ([2400:c600:545e:6508:42eb:3d78:89be:591b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85d4d90sm10099966b3a.36.2026.03.30.11.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:17:49 -0700 (PDT)
From: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Subject: [PATCH v3 2/4] staging: iio: adc: ad7816: use sysfs_match_string() for mode selection
Date: Tue, 31 Mar 2026 00:17:08 +0600
Message-Id: <20260330181710.23258-3-mdmahmudulhasan1511@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330181710.23258-1-mdmahmudulhasan1511@gmail.com>
References: <20260330181710.23258-1-mdmahmudulhasan1511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual strcmp() logic with sysfs_match_string() to simplify
the mode selection process. This reduces boilerplate code and
leverages standard kernel helper functions for string matching.

Signed-off-by: Md. Mahmudul Hasan Mabud <mdmahmudulhasan1511@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 5acfceb90..f9a0a5a69 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -58,6 +58,11 @@ enum ad7816_type {
 	ID_AD7818,
 };
 
+static const char * const ad7816_modes[] = {
+	[AD7816_FULL] = "full",
+	[AD7816_PD] = "power-save",
+};
+
 /*
  * ad7816 data access by SPI
  */
@@ -135,14 +140,14 @@ static ssize_t ad7816_store_mode(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
+	int ret;
 
-	if (strcmp(buf, "full") == 0) {
-		gpiod_set_value(chip->rdwr_pin, 1);
-		chip->mode = AD7816_FULL;
-	} else {
-		gpiod_set_value(chip->rdwr_pin, 0);
-		chip->mode = AD7816_PD;
-	}
+	ret = sysfs_match_string(ad7816_modes, buf);
+	if (ret < 0)
+		return ret;
+
+	chip->mode = ret;
+	gpiod_set_value(chip->rdwr_pin, ret == AD7816_FULL);
 
 	return len;
 }
-- 
2.34.1

