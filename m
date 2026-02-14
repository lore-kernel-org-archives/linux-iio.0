Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E2323C8A0
	for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771094816; cv=none; b=a/3WRaZlQQy30tgAeDQFSfdlncq+zjjWVCleCi+T3Yg8X3w8s3NaQ2AOxAbLl45DT+2yCsZoxOxYFX3xu7570E5cPNF9lqnvmd3nemYzJj5EmzpSyGPTz8O/eqLKHfxs9OPlyAqLDy+BvTth+rU2zmWRGpuuF+zzQf+X7hhuIRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771094816; c=relaxed/simple;
	bh=PWt5A979gquISWmjM7f7KHwIRvk4VF7v3XQUNs8S3zc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tF0ULatsiRePvruuaWnraSgZeUrsA6+soa+LPImXFXDu7BH8cj1qq2TuufrjlMU9802oOc81hQVDyTygtnaI+P1Mo6sZniLr0upTWK9RQDPsTvNrLBQ7Vmvj3rjJmfJuNYiA3V8QTNbQ/enJbNKP+Z/kcT/a9REdnQ4K9UToFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TU/V9pVU; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TU/V9pVU"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64ad2a2851cso1867905d50.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Feb 2026 10:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771094814; x=1771699614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kIuq6pEzWYh2fE6reqj+zT5+zDErtmRcMuJdTOpJN4U=;
        b=TU/V9pVU9gxIDh93IB0xktIpjG05J3Qd5C0AqBrfLcRl8xjAJtLclHfLXO9T3paeh+
         5BdL3u+MDiSNzW3ROvK3HBsn2IPrEN/jgT1bWwIY2Iss867DsXiGMSb60UXQwSCHTsbf
         YRK55bfHuf3oA2WUMxerBsENWfsRCvrWITGVH6uI9iY1yE4YPhTb3Wpb9VQVY/yxWd+V
         dReLWHM6IEFUOd1lkfQ5DqJWM4K42cPvx9IpWCFBKqjoOdUEwiAQNJSf1iZZuXOwu7kZ
         w3ozJymK6+fInlzaupk0QzlHGXwysX5Lr5DHJSMJQ9WFYoo1cq5PBKDkbNyerGLW2m/b
         FgRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771094814; x=1771699614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIuq6pEzWYh2fE6reqj+zT5+zDErtmRcMuJdTOpJN4U=;
        b=vajOIa12j7crBwLNOO3EySaowPFjnTXn8A5XqW+gZUgIWStsqet+sIzsI9oIy0hvAJ
         gCzTQUjKNQYq8dJOJKjO8FsLjVLdBIzYBEEeCBqkuhpCAxAv/Ah6Nq/BcTGN4+gciwtY
         bqQSfJRtUeWYx1Bbd7zkJCWlhya6eg82xjUSO3da8MsSiFykDfo9+vrVgigV0+0fWTNo
         S6LgOFD+LB30G83HAEK7UxaMNOQaiG0z6mKybc1kOJa2KomDpUrs+guz/rbPGfcAg7Om
         BVCyePluF151CJpaCmn9RBipj1Gtai3uBP79q0lUZeMvc8zPnyDI/p7HO9js9tcM4Rcv
         JSpA==
X-Forwarded-Encrypted: i=1; AJvYcCU38LfzdEMfnS9cOTvdgJM3OeNtDLOdm/pyfyLU1YgCBg8VF0gff1jM9o7t0rtDyd5ErXjh9xKRH+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP8qpjfSVM+wzjph6vydUEKaKYrIo7VSj+Zx6hYS5g+JNQDwLr
	hJMiCtZ0mDSXkqWNpFWcuQgz61qzw/E/9PsGug3rKN+sA40L7uq1zW+l
X-Gm-Gg: AZuq6aIow3FW3puEl+yDW7H7EyaHJGudK+4EOB19FYjMKuprIpyUJZL+L00nXyCJfy7
	r9Li6L8+h0ItPePnHdCRu3ig819PWGmAVfZ1tWJIux384UwhHt83WoUdNbo2QCzTHmZN5okEJRs
	uITvzLv1IR+BbHu3wkdsX3gOEcu687ZTwCBoUkTisQ6tjaOjcOyDLFMzmTIJ23+yTxGTyoekiVI
	aiF3rl/n0pnquTa/6sUXL27mcvHEb4p2ganfGyVXj+DSBiLkOay2guzTvp83g9wqD/gK/21/d4E
	16iLb/G7Cav7Z8vEmvQ80YEWrIbZdYtDDSlbslUDyfBV5qn+4HfFExG7oq1NkXxhRGVi6SVYI7I
	XLbs8bbIu3I4MWpxLoT0I2l2w3LzNRkutsJ68FBZaNZ2CZ2eVNlB12RktlFeMCCZ6btiqb1/kuz
	2eOoCYZ8QZolkW3FuSH8Fp6c2t5eaH9/1yayA12aHOJElXRzo2l7U7I1BmSFiLTzMfGNDvSX1Kk
	dU/c4c1hOp4TIHnh6pbMLaqPlTpsrhIcBWPx5hW4ms=
X-Received: by 2002:a05:690e:400a:b0:64a:fd80:85d with SMTP id 956f58d0204a3-64c21b58c19mr2401923d50.65.1771094814508;
        Sat, 14 Feb 2026 10:46:54 -0800 (PST)
Received: from tux ([2601:7c0:c37c:4c00:e3a8:26f7:7e08:88e1])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c22fd6ca2sm1539684d50.23.2026.02.14.10.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 10:46:54 -0800 (PST)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>
Subject: [PATCH v3] iio: adc: ad7768-1: Fix ERR_PTR dereference in ad7768_fill_scale_tbl
Date: Sat, 14 Feb 2026 12:46:37 -0600
Message-ID: <20260214184637.16985-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function iio_get_current_scan_type() can return an error pointer,
the return value scan_type is not checked for this and immediately
dereferenced which can cause a kernel panic.

Add check for IS_ERR() and propagate the error back.

Fixes: ff085189cb17 ("iio: adc: ad7768-1: add support for ADAQ776x-1 ADC Family")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202602051234.5gArzLyZ-lkp@intel.com/
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
v3:
- Fix typo and added changelog.
v2:
- Add credit to bots and Dan Carpenter.
- Propgate the error back instead of just returning.

 drivers/iio/adc/ad7768-1.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
index fcd8aea7152e..e16dede687d3 100644
--- a/drivers/iio/adc/ad7768-1.c
+++ b/drivers/iio/adc/ad7768-1.c
@@ -531,7 +531,7 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static void ad7768_fill_scale_tbl(struct iio_dev *dev)
+static int ad7768_fill_scale_tbl(struct iio_dev *dev)
 {
 	struct ad7768_state *st = iio_priv(dev);
 	const struct iio_scan_type *scan_type;
@@ -541,6 +541,11 @@ static void ad7768_fill_scale_tbl(struct iio_dev *dev)
 	u64 tmp2;
 
 	scan_type = iio_get_current_scan_type(dev, &dev->channels[0]);
+	if (IS_ERR(scan_type)) {
+		dev_err(&st->spi->dev, "Failed to get scan type.\n");
+		return PTR_ERR(scan_type);
+	}
+
 	if (scan_type->sign == 's')
 		val2 = scan_type->realbits - 1;
 	else
@@ -565,6 +570,8 @@ static void ad7768_fill_scale_tbl(struct iio_dev *dev)
 		st->scale_tbl[i][0] = tmp0; /* Integer part */
 		st->scale_tbl[i][1] = abs(tmp1); /* Fractional part */
 	}
+
+	return 0;
 }
 
 static int ad7768_set_sinc3_dec_rate(struct ad7768_state *st,
@@ -669,7 +676,9 @@ static int ad7768_configure_dig_fil(struct iio_dev *dev,
 	}
 
 	/* Update scale table: scale values vary according to the precision */
-	ad7768_fill_scale_tbl(dev);
+	ret = ad7768_fill_scale_tbl(dev);
+	if (ret)
+		return ret;
 
 	ad7768_fill_samp_freq_tbl(st);
 
-- 
2.53.0

