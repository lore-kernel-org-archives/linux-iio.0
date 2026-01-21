Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66FF3E9F68
	for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 11:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994890; cv=none; b=HTU+jBUzBj0LJLhosrxKls/J/VHQTomgZ/7xq7jMvmM/U7eCEtno9K/DN659y0Js2GB0+WbI110QT/iDcLDOF+fcJWPadBpZypvAz5rDYrR+vlwWC6yKqJdh3MURcf9QY3qJsH+7HnAuMytxRwFkMIvcZmMNCpMDHfO6RfCqemk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994890; c=relaxed/simple;
	bh=MkM0A/HsyN7aXTv8muMJJ3kq/6hFQVpMJ9om7R8iWDM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BUMMEtRFmq79FtR2POFrEUmiz8WLp+Y7BEPbI6zq7DXI7fJr/88VnwRcrSYHC/Uw0+ujdceaADGbJ3J2iKgSwz79aPeUYhOZlrNe7P5p6Anft6JEGNBMTcVkgogt3COoin52ov/liu+rrHzh2/Y3je2H+NEn6zMu+Mf9CGwK7Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bq4Ves3L; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bq4Ves3L"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee937ecf2so7068095e9.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 03:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768994882; x=1769599682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2z+T2tcANuxuNpL/O66Pi5lTdKISXJnPtDtrt0skqs=;
        b=bq4Ves3LXZqE1++Te3nY59Obxc/WPIlItaO/CVuw8IqY26M9mxIUaxn2uVUhnMhdTF
         t4DONFEXC1D8ajmIFigXQWs3AHd+aNQDunt96U6cDIqmgIP3VfcLs7a7b+ukO1hXYNJY
         QfMwSGTOuxJQ6DaUWT7mMC/C7P6eNXKeWle67i+sV0nVh4QhcmPLPD+geUJON339CVpm
         jGKYGfLHnEo1DnIM8x2/gj/AVf8qFtuOlafXCBEyFSVn3sWoukdJ2t6xZffGq3PA5Z8G
         95/Hd3A1ItTJaygYZJVITU0lJUKgATdUR85lAyungZYfrIFFxkod3ukyLyL3vFMmL5x3
         yk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768994882; x=1769599682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X2z+T2tcANuxuNpL/O66Pi5lTdKISXJnPtDtrt0skqs=;
        b=w1wbjp06Tb2UlxvI3qmoS+3HTljygJ+sfhZolbx4dgkGn76FHFTpxDttmcgX9BdA9E
         BTN/fOM57NH237aI7PPJDXsmEqzncdJF1oQoRve2doLtmwhxowHMyf+rRvSVxAGQ0ivK
         RU5tXsfRykXiMs5juWuWswha89N3g+wbz31owaVGOPopsamfP/jX22ME+bX3KiteUgcC
         hikTbPn4dBlrZAIzspfxjOaJjbpV4nJKvnZlxZWOTbKsCrCPwbNHXv29wFlVV0GcSxYn
         dh+E0TtKRoG7yoaBufAHEDKF+Y2vP7Z4LRVIto331fk6Bm9mL8bSv57y7veyltsX+qjC
         qRbg==
X-Forwarded-Encrypted: i=1; AJvYcCWoG3ctgjXIS4VvarrAxbrJvpckrt1/VWilZ6O5Ztn55GV/ohM0xgbKBX5DsT4Dg3GYvKA7qz2l4gg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynf/t1OdN4oq6Uh9ClhqU6wF7i7j6Tk0rF5HVvurhRdM4ockfY
	xhZkeL6sUsfX3TN64RfZKn9jRGM9FqgmZd/rkEXR5uFYfumlkYo+czfUBp2eWRIyL90=
X-Gm-Gg: AZuq6aJ6na/86oNX+noGKWlVqMIJfJve4qlavByBJkJxPIP2wjR4GG1yISamhltNyn1
	hpIvgeSlOlwUoesvV4XeG7LTesEGKYabAYooTcdA3FkIF3Ncm7bMZzgRoY5xu+thk7rEPT/ZVBM
	8djUPXOsb93Jk0F6C2nzURJ9nqjgLvNsVMD8EBYtIkZ5QQ4CXebdSPQGkfkEWoXlp29PeUR7Fbr
	5abb4j/+jDeKzquvCTb8UrsOCtCKDufzyugfG5Pgq0eIOpnF03D+TPu10AVCb7SS/nX8+8A/+3S
	XD/obLAfJ1Yk/eTuK6Zosud9mVL2SPSQ4VKrwSglv3faTUjrs7/JmL9vu8L/rA8HTIIEsfptSVI
	xr+9kRdTUAZoKVVkBrudU15EblAfirhd+vjhJVNI1Cbwf1db6hdI1hC10UqvgA7oMAU4KMmtoYp
	rmYQ==
X-Received: by 2002:a05:600d:2388:b0:47e:e7de:7c41 with SMTP id 5b1f17b1804b1-47f44d4ca19mr173497225e9.16.1768994882439;
        Wed, 21 Jan 2026 03:28:02 -0800 (PST)
Received: from localhost ([151.44.214.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4804249be6dsm20449535e9.2.2026.01.21.03.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 03:28:02 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/4] iio: imu: st_lsm6dsx: Set buffer sampling frequency for accelerometer only
Date: Wed, 21 Jan 2026 12:27:56 +0100
Message-Id: <20260121112758.1831077-3-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260121112758.1831077-1-flavra@baylibre.com>
References: <20260121112758.1831077-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119; i=flavra@baylibre.com; h=from:subject; bh=MkM0A/HsyN7aXTv8muMJJ3kq/6hFQVpMJ9om7R8iWDM=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpcLgk8/bTUHWtdx2A2C6OfJtUtmuStD+mgbvOu BhcilH85FCJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaXC4JAAKCRDt8TtzzpQ2 X5BPDACqhoUNb5Yimeprn6CI6G7CeLZG9f5b61beCNrNQvg2rYESfcllSOM7i6TiFjMM7SDAilS Rv8QCNt4uXyUElmvxbyzH3zOEVx6UkaxdDs3pWyeCXzNtJf/hVKQMHP/YbP0WJmfFg+x4xJHPSw 835CKjItAL0Tmdwup14gl20As0UceAJeXjMujiKEI6cJTllrtEFJt5C0Ewol167SwVi2Y5Z+iDw 1dyF1+OwRGtvqiMFvUX87n1s7xfACJ4LsCK1SZJbQVLw2cYfcP2Qxm7tJ1zkq4zNYsxP4GRpxEf Y1ATY+K/TdEQ/o4PoOySDq+cLJrdce+c/a0nRCrS+Bvz0DKBdZSuNgQrILsnUZhzWEB0C77Jg1+ xniQLgcX/bcCDn5xn0tY/cHxX3fSvfKr2XlIk9UrSE50zNsKu6BczT1x+fUWeuR5a4eAij3ywMW AKAhaqblfyAbE+CSwvTcG+06lqH3Yz1NI3hzsvI7fpQWDLzqZs8XNtR67c1OnQIVjDytA=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The st_lsm6dsx_hwfifo_odr_store() function, which is called when userspace
writes the buffer sampling frequency sysfs attribute, calls
st_lsm6dsx_check_odr(), which accesses the odr_table array at index
`sensor->id`; since this array is only 2 entries long, an access for any
sensor type other than accelerometer or gyroscope is an out-of-bounds
access.

The motivation for being able to set a buffer frequency different from the
sensor sampling frequency is to support use cases that need accurate event
detection (which requires a high sampling frequency) while retrieving
sensor data at low frequency. Since all the supported event types are
generated from acceleration data only, do not create the buffer sampling
frequency attribute for sensor types other than the accelerometer.

Fixes: 6b648a36c200 ("iio: imu: st_lsm6dsx: Decouple sensor ODR from FIFO batch data rate")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 1ee2fc5f5f1f..5b28a3ffcc3d 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -862,12 +862,21 @@ int st_lsm6dsx_fifo_setup(struct st_lsm6dsx_hw *hw)
 	int i, ret;
 
 	for (i = 0; i < ST_LSM6DSX_ID_MAX; i++) {
+		const struct iio_dev_attr **attrs;
+
 		if (!hw->iio_devs[i])
 			continue;
 
+		/*
+		 * For the accelerometer, allow setting FIFO sampling frequency
+		 * values different from the sensor sampling frequency, which
+		 * may be needed to keep FIFO data rate low while sampling
+		 * acceleration data at high rates for accurate event detection.
+		 */
+		attrs = i == ST_LSM6DSX_ID_ACC ? st_lsm6dsx_buffer_attrs : NULL;
 		ret = devm_iio_kfifo_buffer_setup_ext(hw->dev, hw->iio_devs[i],
 						      &st_lsm6dsx_buffer_ops,
-						      st_lsm6dsx_buffer_attrs);
+						      attrs);
 		if (ret)
 			return ret;
 	}
-- 
2.39.5

