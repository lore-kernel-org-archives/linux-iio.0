Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64FD3B8BCE
	for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 11:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768994892; cv=none; b=GC++qw5eLBk3ZbtC3A2jaAbQjhg5MMQLop35fs1pBIdTkhF88sBq+auu2ccRm1+bJqebtZFuetIZ2TtQonoBKrjbXUJ6QcImHpgvvuXoTVMMus8yNKY+CqZbS+//UKPX3wQ2LIdgpFZf+2EyhJBC8+PT8nTXtuGk54dNZ5o98PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768994892; c=relaxed/simple;
	bh=aBIjT8HJMfYZDveJouRj4sa520yQuhHwAmIb09eSjwY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lgEXUqO04IlhxZXruThiFJtwPzrQ9ulpLijgpTAwBUUv0goOC09cM7uWIJbGCEAEIdYeAaLOpTyLdIzEg+jdxAHB7kwHC0hFX9pvyHei/Di/1NiPkH90A/8L/zBWsnReH/qVVenMgg7NBMYXx0LLs+XuoX3GS+YpjUs/8D2YqFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KSl8BK9g; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KSl8BK9g"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ee0291921so45486605e9.3
        for <linux-iio@vger.kernel.org>; Wed, 21 Jan 2026 03:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768994881; x=1769599681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RHmHZviAuhOhpKSUpCtTa1iFHF2rU7EWwgoioRxdGwg=;
        b=KSl8BK9gcJkSKmrqq3WFUUCtvw2Wtrsdh45wtM9NPfEfn57NEBqC14Y74HGLlsrcS1
         wu2PbiFRMFUGni932D9hmzML30R4L9GTwzIWDDBfmJlF5zCrByfs9gMCUoaN29Tjo8I1
         GqAyw3sxBp2lqquEZgej8U1CPCJlKHbAJIg1HfHEY1sHE7HyoX1YjWCps7PQBLkJBS1X
         q6M6yEAJ8D8kOF24ww2uzcUjSrw3ugZR4pQXruKks+q5zEJLvxiFOOq+E/lbuDyOfsKV
         fRH2TakQmYsuosM/YWtJtsnkQhW1bOwZo0MvdhQkxj8hiRUXnZPrBBS6aYWoKIIwCCZ4
         uQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768994881; x=1769599681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RHmHZviAuhOhpKSUpCtTa1iFHF2rU7EWwgoioRxdGwg=;
        b=l6iaynm5edJmkwzljhUtZgYnN2zpl6nzQf0ETMs/3qV0LfdO2rcCM1DyJ3/sm/y5cH
         /RmZ1+56IfKjTu28DYdWXxMVPukJCPpDvnUJ2FHSiOu/rAtEknnutTjxHVbRCLfMVY+I
         pUgx8wb3+pBT+aRbRpL1UejzGcAdk31jGROL8sNox3RxWLxoQk+zAoccv1/QmdOhGXOj
         Got70nkRnaTFVjv7jN22r/7SrOWffFHCRy5dc3E6XgR8vwCpSQivUddiRbTgak3J5LMD
         m/5tV/ieMLlHNv0hK/9sJDJXUg3DOYI10lfwgVIzgtXB2rcJNN6WnYo762+FgZY9mXtQ
         7GKw==
X-Forwarded-Encrypted: i=1; AJvYcCW9ghZuWFlMd7dLcTJ+K8rC1LtMcBVNzfNMCg82/VWXokHus6jaxI+IHbBCB2cOSTUmHkmSdf8lN1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrVHhY+P9obfRp+pGVrHJSG+KL9liHg4UCj+5DAWjwIn7MT+e7
	hO9aDyFvL1dr4ssfSgqNxAD28N56osAy+7JipeUd6vkPyEu2fdZmLIL2vDDTjQ932n8=
X-Gm-Gg: AZuq6aLeVa+zNfKOzCjJeC48rl93z+ous4pxVMllhhajXz/cw+YCA2PfV4F8dET1izB
	gWRv3U6bLYN6WBBmU1Y103yyhVO1cfjus6vSi42iVTHtM61NXYwguwWD9CwrO2TF+2ke7mf0pFB
	ZiNLjMUwSrJfSECraFORm/3nDvKpOVC29lB3C3R5X6m89DYfPziApgNhIGwr+P8PrLrSTuDCavB
	doIqZPgJtqXIk5s+oCEO43VYqwo7TTqCOx/M/bUMXP7/RWVqVtOmITM9rRepdwf7W4arghdgEBS
	vU7V0a29at2T3uvQp2qgmyWDHq8KWpQFJ+JvvQILhNOyVTaagum0rKVou7n9LTkFRgka62ZWfOa
	IDGxTVUZiAI5MLrra/wPwPM+UH+antgpqFcVxB0ZDTwi5wZBFwYcXJ8mdokF6s6rrxV6v+mj35O
	4fVQ==
X-Received: by 2002:a05:600c:46ce:b0:477:7b16:5f9f with SMTP id 5b1f17b1804b1-4801eb0efe0mr254560075e9.31.1768994881124;
        Wed, 21 Jan 2026 03:28:01 -0800 (PST)
Received: from localhost ([151.44.214.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48042bffa0bsm18954715e9.4.2026.01.21.03.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 03:28:00 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] iio: imu: st_lsm6dsx: Set FIFO ODR for accelerometer and gyroscope only
Date: Wed, 21 Jan 2026 12:27:55 +0100
Message-Id: <20260121112758.1831077-2-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260121112758.1831077-1-flavra@baylibre.com>
References: <20260121112758.1831077-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1747; i=flavra@baylibre.com; h=from:subject; bh=aBIjT8HJMfYZDveJouRj4sa520yQuhHwAmIb09eSjwY=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpcLgjKHlBS2+YWZdjOWGvX/xqPbpahixKnyHdW ADRDgnr6CSJAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaXC4IwAKCRDt8TtzzpQ2 X3AMC/9hgJMDUYxdaPmbp4yWgBAy3dxaVDE+5FfmjOXtxam3QSfObJFfYqMqQX0p9YWWN7Ot0ix 2pvqAJmHYilgiPaa5U/+KkSJkSynqL2oXqZPnD/uHDmRQQRU9lxGubE9bQ17Qxls8n9lYL6igHG 18Yz0y8cNTh1CFqSDVMNezvpKF5+p14RshaG+61tgSwIWDzvkITIfP9wv2phA3mUdI4O0VJ3SYI 2aG5vRQTJffY3rQ0tUv+/xNxKfXJpCtbh0s12ZA4UNd13MLBzqxDp09LN8it3mpBXxgPHgINM6e 5Qan/u4u/Qz2ZY4lcmgyCMjQc7SSQeR80ogvyBlPMSLzcWc54Eh4+kKa38kKAeUqI7eTn7tdcc1 0M5fegAX84tl9SlD3/xYlbcfDwH4TEqu9AMqvbU1lDgKfwdMycbBK145QDB4sis4T+cmfuh5xHJ VTI6GNlqVv5fmh29KUQRWK03BefclTaRPDzTYaJRMJyBDA9dvyES+hyaEwUruwuyy90Xk=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

The st_lsm6dsx_set_fifo_odr() function, which is called when enabling and
disabling the hardware FIFO, checks the contents of the hw->settings->batch
array at index sensor->id, and then sets the current ODR value in sensor
registers that depend on whether the register address is set in the above
array element. This logic is valid for internal sensors only, i.e. the
accelerometer and gyroscope; however, since commit c91c1c844ebd ("iio: imu:
st_lsm6dsx: add i2c embedded controller support"), this function is called
also when configuring the hardware FIFO for external sensors (i.e. sensors
accessed through the sensor hub functionality), which can result in
unrelated device registers being written.

Add a check to the beginning of st_lsm6dsx_set_fifo_odr() so that it does
not touch any registers unless it is called for internal sensors.

Fixes: c91c1c844ebd ("iio: imu: st_lsm6dsx: add i2c embedded controller support")
Signed-off-by: Francesco Lavra <flavra@baylibre.com>
---
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 55d877745575..1ee2fc5f5f1f 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -225,6 +225,10 @@ static int st_lsm6dsx_set_fifo_odr(struct st_lsm6dsx_sensor *sensor,
 	const struct st_lsm6dsx_reg *batch_reg;
 	u8 data;
 
+	/* Only internal sensors have a FIFO ODR configuration register. */
+	if (sensor->id >= ARRAY_SIZE(hw->settings->batch))
+		return 0;
+
 	batch_reg = &hw->settings->batch[sensor->id];
 	if (batch_reg->addr) {
 		int val;
-- 
2.39.5

