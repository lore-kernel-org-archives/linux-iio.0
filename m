Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F277E392835
	for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 10:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772014602; cv=none; b=VQV+kVXSnUfacIqYEopgPjUUe/r7KtsJypbgWAOwW+DCp3Mz+aPGh32Glr2jY7Dq6n6uyNuNPNDJfvpeqxdCmGIk4OCmXXH2ecC8yn2dE91KyoexWrfOaleKwclMbGse6pA2jhxmhzeOOoS/7JVlDY+PGaYe2tFJO0Kn42AGNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772014602; c=relaxed/simple;
	bh=MkM0A/HsyN7aXTv8muMJJ3kq/6hFQVpMJ9om7R8iWDM=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YIDAQIGAPEHJZDVeoQ3yyRf428wwhy074iYFSk9gbIK6cTwUl7jVRrKGHKYN8CjFouErFx9fpAY3D0dM97+OKuK+zL2k2phUj6YLo47uRiLFExGKrfJelwyh55dR1PIPQLv3q0EDYiVH9F4z9iZWMOTDvU6yecQbn1C0lZkK2vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IkpbnSpW; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IkpbnSpW"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-436317c80f7so482305f8f.1
        for <linux-iio@vger.kernel.org>; Wed, 25 Feb 2026 02:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772014594; x=1772619394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2z+T2tcANuxuNpL/O66Pi5lTdKISXJnPtDtrt0skqs=;
        b=IkpbnSpWj9fH7fdR38mZDb00p8SeYsuF+OBJE8FuJWjEh8G6e1AXM5a6sbREiw5Ann
         IYPUxrdUipZQHGH3JE5x9jZyGJxgAnHyyHUf18k8G1Nm9JBy14D4/e0itvhbYPtDChOZ
         wWnROTDjQUHtfIpR8KMtBKNwidGDo1Dg4R0R+1Y20y3yOehJuCepo4sHus2UNrLG2tQW
         FR2PMfFc5OmLPDJZTvlAaVIi3MnrCpH3Tu0404ntF34LC1NKgEdHM1q/OSjYyAweSNWk
         dICVgaC8ppe+fvJPtxjkcArW/85A65moQJlFMNFxJHwoakZiOmcLkvNniInyT20yDcif
         LJlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772014594; x=1772619394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X2z+T2tcANuxuNpL/O66Pi5lTdKISXJnPtDtrt0skqs=;
        b=Nr0wAvj0PG9O7GTP0AGwQ/NQHudsf5wPHx/gFkFiZ9yDQF3GiN8+mP6MzyxR2zAJW9
         GqThfvPl2CJzDdzyypcXCjwxcz1GLTBZ3qqTNK4W2LhTb939oQhr4saYeh84bJel83nN
         dH79t4wKksKCLJMhsTu8vVSXHPIZ1jVWVUuoTiz5tJeHgWNHeodC8kCuRzY9ekOFdHRJ
         5nGDfonPe2PgWjJfpf/xV+5lMu2Pc576w0BpTAGV49UFNluzZdkC7x+nltHeIs8okG6i
         YOLkxZUAobkISzcDtmGD/6gyPnV2CkSRyrPGznPW048FwE+gibEQXh6P+6TLfTN1xA6E
         cU8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6wnSxlM/sIljpXoqbOz2zg7dlxFV/CUrbaXAPZ7ap5DioBM2hukmmDTYuPUgK5+YSsfIHxcnegYc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMKpyof9thjK3Bd2O0B5ndqKjWddOSLxwF/SX4Ch4eDSEN1ZMI
	UNwxBURbt79dDEaer4JN+eY2ZgLS8Aik0QWx/fpYhdteBlZU3/DKsAA7gEANtx6bQqY=
X-Gm-Gg: ATEYQzxtDhIk/A+jhDE2rJKyR1QN+v3j7YIpRHhQbRPwfANUr4pTdyYFthC/5XHEyQU
	MBoHxhcYc4Cw73uOcBKfIrCxYGehcJmTFIZq+MbC7t1UTuvx3yx8A6LHx42FLD/g0J2ZTbDNg8g
	MjdFR9apyyLx+F7KqETn7V2FawTl+UeJTqVYnMZQX2b8v3imDdefXbmiTzqxWIC2IsFg6DoQK9y
	wrG0eRJt3RSMZpUVmaBkztf1DyMNl68m2xojhKe/gqu9RAgW+lB4wiovTQspsZBJ2lZiBK3flUM
	LmYk7rPJwp1221wg/yswigVG69q+x6fyhENsuVCc+8LVHlRjTrZTK7lTFmobqtBLtzt/jNo5B9j
	t2zOsDEVMV+EpkaKIyd2PzvwowGZ2zYaEKJL2Pw15SR7WpySbIQHTNbx582CT8omfUqnNjA==
X-Received: by 2002:a5d:5e01:0:b0:439:8c7f:712c with SMTP id ffacd0b85a97d-4398d8353b0mr4778086f8f.8.1772014594085;
        Wed, 25 Feb 2026 02:16:34 -0800 (PST)
Received: from localhost ([151.35.220.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c09897sm34079861f8f.17.2026.02.25.02.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:16:33 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/7] iio: imu: st_lsm6dsx: Set buffer sampling frequency for accelerometer only
Date: Wed, 25 Feb 2026 11:16:32 +0100
Message-Id: <20260225101632.2368093-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260225100421.2366864-1-flavra@baylibre.com>
References: <20260225100421.2366864-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119; i=flavra@baylibre.com; h=from:subject; bh=MkM0A/HsyN7aXTv8muMJJ3kq/6hFQVpMJ9om7R8iWDM=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpnswA8/bTUHWtdx2A2C6OfJtUtmuStD+mgbvOu BhcilH85FCJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaZ7MAAAKCRDt8TtzzpQ2 XxcxC/4mi0bYTfmbqrOktzvKdp87g5AtpcS1BRGlzfz/A9yu3n30TYNRt1M+ZKgawcc0C0fuxxx msnjbwr53H6AygeGBz+QURrbVacojfcnWIGTmhjYGrQJ9r5gb+GwXgM1W9JOHPdTO/S1qjCkiG5 mPBRv6O1cwdEBnEA5A/vBuGzMNi/5hR5V7baYcinrzwdr/YsvZ+ltvmbS2WH8+cdRod6YmqW1ej lPSNy2Cnob1E/mAguT2LNmfYo7PWRv+aPHR7G/8De+h0WIMod0YHAbSiJPmckjkcSO9MPMqGtVc KoN0MX8lckX0S2Dv3c8jwp/Zq+eu03INmofCSTMGzW842Ow/cok6YhA60HeQKOSv2Zb/NqsTvhv 8dlWvgFHTncjQToYw7FB2fWEePsnmfptOzLE/YiI6SHDbgbbtWB7t9gkj2vh9mTIc/Sj8p0dero OVFcf5E1MPi3tNq2C494i79bxDxh4UgEy9PZOLMdOLllYCQJ6MFsBGEGwIN7TyCnljNk4=
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

