Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B03191F91
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 02:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778292424; cv=none; b=MLPjLsxyKxjiWwfvnTFT2PPv8CcYi6zaB/l0f86L7qBzu6d8vPwDYga3ACTX0W6zB06DXEvC9bH66sAOl47lZTb9bdGf66wSnMCZ3gGmTY+yDVos2xPNG3C0Wq5FBICbCDcSRDCvo3L1dQRPiNSSEZyDnjkyeMfohbteZFWuNuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778292424; c=relaxed/simple;
	bh=0UqRGMGJFyQR4ZU9B1gZnIWfgj1nOftZ7YXBLwSK29o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kKeqQnQXvB5PvcQ7BQwyA39W9pwCSqn/OW5LLfq9Z+8XIMB50pWa5vdube9J+Zh1jUORCKmBUxUOEGWidvqv6+jq99n7AwdlIiHDUx8iDl0+c50Tfi33IEb831uTyOmSkc+J3Vi8ypPbIBzBnCSAyg4n+jyCMgovSQ6Vl3KCtnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ugds3TYL; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ugds3TYL"
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2f7020a928eso3618676eec.1
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 19:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778292421; x=1778897221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ai/n2cnUufP8ldkhBkibpvPnnhM8YVdLaYJ+C13VY6g=;
        b=Ugds3TYL5gFdMZp09S8cJXUKujbz2y1lo9z0ZesarxHJ2TljcbkR9WjOwdqzksLJJE
         B17XduNRAaCwznvRZrG3+3hIuNf+PZhSQEITdreGMgD2ej1j43EFmPUsTjzpVq2yj+Pr
         JE8URPKrRL56zEX8/9VKJBLh0+3q7hTS/Ha79SQSHWY8+FBKyHfr5yNPn4vPK6k/9xMV
         /i/Iqmayzhj+WUUZNcV+kSUKv2/PpW7tnpHfUuzuwnBRA3BOV1tH5Tb4mluDHqoS83kC
         of9En850NJIh5mE2i/LKf2x6VU7LbPyqB7T+Z9bfCqCDyGR0Cktv0VJeEbO0RUh4NODC
         ByYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778292421; x=1778897221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ai/n2cnUufP8ldkhBkibpvPnnhM8YVdLaYJ+C13VY6g=;
        b=P9EknaTcyUrl3azCvJNk+sGx9lBw2dieAoXsS4Qqv6zH/ifHZvN62sBLVyxt6wA1w4
         Z2l77XN4MijUvSIX6hog8F44nxpiAQZ1os4RrPmHcnPfc9UolWQgPhY4Vcd3JYt95FJQ
         +B3qqa1+ZgI1jAXgM23KDbgDwv5oT6tj5Awyn/Ronu8eLoiFkvsB0TsPvqa6c71BXi85
         QQs9l7ZZ0XuadYVeHPiFrnhzrjnCRh9sd7Mn+ezNq5KDqNtAMx0SJrB3NV2Et8rnLeN2
         EvjJ1uhVJqyoguI1tHsSfwel/Twm/pE/GafHRu7QcILoweDuBqlPJhVqMIDByQaHU75F
         bX/A==
X-Forwarded-Encrypted: i=1; AFNElJ8di/W3yUb06yASdez/xhBILlfJnkFndGVN1vY1snAhm9QWghQ2OsNtT7ZeyKNIicg5dKuWTgEsU1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEr5y8D6kR/aVOxf6NUzw1uRs8lfHOAS5CdDI+5jHHI9zCs6iN
	pJEpvx5SIwa398CQMCCJF8GStDOKEtWcBS2u0qI9/DDtFzngtjksZxKR
X-Gm-Gg: Acq92OELW4dWAalLnTACM1A52tJOWOUXGp5D01U675EOer5lt0UzyZ8SilG0pEcKB0P
	tdKvyq37e5FGecS+tQDsKgsUNKo4ut/qa83WaO3jaNllKfFbSIXN9ca7RT9+yAoL91y+q5o3rw9
	Fbaox7mFi1aO+e1qhZHpQtw4c1JIovNHKZSlUan6kG2nv74D6TC83GTewlSPGC+9BlEbHb3DGMa
	qs1CVrw18lg3MiYOhzU79cLXF2nc8McmSWE+RgOlOkjURUNrYDoL72/Igf5O7vKVcgpUXfnbeiM
	63bvHQlnMjMk/rqpMzZDJBscwVAyPNPsgaIa8aCBGK4AKaSkaC6l6IUbBPpUExd2ZMOWBuMGbnU
	BvZ4LjmgN9e1++XNAEL+Z74s84RQ+In/IFFj/IiHLfsLSoTa+6lsgFXo4OLwwhvxqbDFsgF2yt+
	YHVwSrQl/5AG6skMhytSbeoKnmchlpUBg6ta6UeA/2OGtA8yz8zDEXN74=
X-Received: by 2002:a05:7300:b919:b0:2dd:c066:c02 with SMTP id 5a478bee46e88-2f54a87e845mr7917637eec.22.1778292420587;
        Fri, 08 May 2026 19:07:00 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8893441absm6080859eec.31.2026.05.08.19.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:07:00 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] iio: adc: ad7816: propagate SPI error codes
Date: Sat,  9 May 2026 02:06:46 +0000
Message-Id: <20260509020646.82778-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently returns -EIO for SPI read/write failures,
which hides the actual error code returned by the SPI subsystem.

Return the original error code instead to allow better diagnostics
and error handling by callers.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 0e32a2295990..9052203eb4f3 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -222,7 +222,7 @@ static ssize_t ad7816_show_value(struct device *dev,
 
 	ret = ad7816_spi_read(chip, &data);
 	if (ret)
-		return -EIO;
+		return ret;
 
 	data >>= AD7816_VALUE_OFFSET;
 
@@ -320,7 +320,7 @@ static inline ssize_t ad7816_set_oti(struct device *dev,
 
 	ret = ad7816_spi_write(chip, data);
 	if (ret)
-		return -EIO;
+		return ret;
 
 	chip->oti_data[chip->channel_id] = data;
 
-- 
2.34.1

