Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B3C3C5548
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221998; cv=none; b=mDTxM9FqKcV58I/9NDoJ7DhQBszKmzWF3mShOjwgQfab/ESgz8Y3Fei6sVxTKjjjzrO4YdhaTx/t8dYqDSd7KeistzphefVR5Yp86VwqV59jCUvyVgb5MM2fooWEQNuXzLxTME7NutZwzopUvujRvH/MJqn3xHUq6NrDNNU9tg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221998; c=relaxed/simple;
	bh=Ez+0uGQ52+IUV8Lt9xv4qouXLy2kKV9GFqAUQ9JNWMk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLo02dVFf+/JuKT5JRa8tUnqKVwZROC7BXu8Kp6bmBiq9mWeTju0w5ZZZ6RzJXmohbPNRAciF7IMIxJ+Fj3388kfHreMSHYfNdMgqx3w6Lrq/8YSSTM7nHdUkQpnk7JwqwjjiqJ0JXO0kqhADvz62o7lpSVFS9sOE1Yc06tjl0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIwqwa9l; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIwqwa9l"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-356337f058aso8156914a91.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 02:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773221996; x=1773826796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HOeJvDxArRmAukka7WzQkPiarwYqVEMJb3GhbN84k5c=;
        b=FIwqwa9l/du8/wifzJyehYVy+DGcViqmVnqrBOEn/npk9M5VnL2BWV5iJcZDBvA2Gj
         piM/NSY39bADboWeo0v8bx6XTQv24HLCSD72g6/v/rAaI8FSAZ4ILZRHoG5YgqOAIAOD
         aeadhgS40FDmaPRR3q07ohON6CK3evCRIAZfu3/NJpyqQRVHZr8oHVXQoLq2w96k75ry
         KU0H3JAsYIbHFCdHei9oK5ThSMN5j6ymVjgEuB6YZVGya0G9wWMZSV0MQLryMcdLTCe2
         90g5Y8ZhB/bsJHTi/Rr6VBwIV28f7vnMMrD66YAWb4EYTvpSpn15OXd35bdt2kdmxTQA
         I9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773221996; x=1773826796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HOeJvDxArRmAukka7WzQkPiarwYqVEMJb3GhbN84k5c=;
        b=NArbFucm5y7wQ7ciEqm/KUIg62sI0bQmfimMM/BFspT+MMOxD9OLCtnXCokALQzEU+
         kwzCnrl1dmkXgCSqt5GKCGFa49dVGn+6R7HlZsAoHh0N2seB3SJo/Qvp7JLZAY9A696e
         pgwuqZU5gmF+aES66wE6XwlHvcwHbzdfNf4+U9sA1ijUN0UgZ/9t/4QtYNNk5sM1pEZR
         EqnPsPErNrvCB1NBGdnpe0/V4/mJKQf/DwMDfvJYW378fpG59+I79L7Xh4r2oXCoITJ7
         l8T52xMeO78S0/S8joz9d94Ugc9UMdFro6OW5pmvD3smjIfcCL15/hZHVvhL7GXHl9/u
         RUPA==
X-Forwarded-Encrypted: i=1; AJvYcCX8Ppmiyy0yv5ambAUBoXCedBYjprRc9xIhOKqQgg80jnzI3Xwa9E+YWAa0FQ5jMNV+mi39kJoxPAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydzfPyBul9a3MEgH8FSckqzL/WznW6NvefMtPXW5Ydy/gIofaZ
	LlVwSDriUArSwAi4nUHslmDLbUiVzHSzqu9RPcgLV+xYJ7qXX21CVxES
X-Gm-Gg: ATEYQzyGZ86bpvywBvHcjuAxsOP4mCdL0GmSoR1DDlTzgzrlJ1QhWAPUA7aWOIldLrH
	vUIEwQCygsGCdS31SSP4/JqB+FGKZWkpmt99s8QiwBfpll8oX33jFUMCIqahne3Lr3+ngweP5i1
	hTIo8NIrdBdzIdZEwfP5JhIKU0fDv4bn8hC3cD/4v2AC6VBcjOHiRpoQF/02mJotXiZFmsyqc71
	8EYlV4k71+xEqQ9QnY3tUazUosnYG7WjKPFM86RwJTAbXsbXzX8Nhp9hA8nnzbGnASC+A3G3vpF
	/Wz+/kboCXHN/fAYMLnarVwsKIdJehYCdt3q+xVQK6+E/5s1qnisLFwrUyFYfxmRLUpX25oQwVY
	qqtxoT3UoijKYaEd1/NgWjpNc/DVxc6Nr2uZevJuDP5oDdFIvLDClhVnFHu705D0R6wtkPwEHxH
	hAynWMDDzE2i5WtTtVSrDVvEdE
X-Received: by 2002:a17:90b:48d0:b0:359:79d1:60f4 with SMTP id 98e67ed59e1d1-35a01261525mr1809976a91.15.1773221996544;
        Wed, 11 Mar 2026 02:39:56 -0700 (PDT)
Received: from fedora ([2401:4900:1c6a:27e8:1c1d:af76:30f5:4937])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a022710edsm852623a91.5.2026.03.11.02.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 02:39:56 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	dlechner@baylibre.com,
	i.shihao.999@gmail.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	nuno.sa@analog.com,
	mazziesaccount@gmail.com,
	daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com
Subject: [PATCH v4 1/6] iio: accel: fix typo celcius to Celsius
Date: Wed, 11 Mar 2026 15:09:28 +0530
Message-ID: <20260311093933.21333-2-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311093933.21333-1-i.shihao.999@gmail.com>
References: <20260311093933.21333-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix incorrect spelling in comments
- celcius -> Celsius

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 drivers/iio/accel/adis16201.c | 2 +-
 drivers/iio/accel/adis16209.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adis16201.c b/drivers/iio/accel/adis16201.c
index 5127e58eebc7..ba0f97944c6d 100644
--- a/drivers/iio/accel/adis16201.c
+++ b/drivers/iio/accel/adis16201.c
@@ -147,7 +147,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
		/*
		 * The raw ADC value is 1278 when the temperature
		 * is 25 degrees and the scale factor per milli
-		 * degree celcius is -470.
+		 * degree Celsius is -470.
		 */
		*val = 25000 / -470 - 1278;
		return IIO_VAL_INT;
diff --git a/drivers/iio/accel/adis16209.c b/drivers/iio/accel/adis16209.c
index 41ffd92f27fd..04e169f221c4 100644
--- a/drivers/iio/accel/adis16209.c
+++ b/drivers/iio/accel/adis16209.c
@@ -186,7 +186,7 @@ static int adis16209_read_raw(struct iio_dev *indio_dev,
		/*
		 * The raw ADC value is 0x4FE when the temperature
		 * is 45 degrees and the scale factor per milli
-		 * degree celcius is -470.
+		 * degree Celsius is -470.
		 */
		*val = 25000 / -470 - 0x4FE;
		return IIO_VAL_INT;
--
2.53.0
