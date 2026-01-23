Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA91A9FB0
	for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769197710; cv=none; b=uz/gZ9pctNtz6VlpvC7M+KN2UEs6Sde5It6vmvrnhHzDwz+C+5b0VaakbZ6VytaZfWjvzwKw0vOb2mmfOmAycii6XsUAaW3op8/xXO8Qd8H0Qv8ahkU9LKighJ0Uo7yhiuZqFnpGGo+MxtMT/jkfj3ClQ+VnCFd0ZBTOdy/MAJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769197710; c=relaxed/simple;
	bh=B1c/vr0GUaEtusnH07mu4sq5q8A1cYkBwTJ7qRZS3NI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tvQkMyayET2z5wnIlH7AwtCoJw2xIop2B1/Xd24JFvvSUmlitHE720VqC8OhXWe8qC5TK1sB9dlivl9USlN64WmMcvSFveIABywKe17xBP9JK8Gr7mRl0NNDy2g/g8wvkHB3QTMuHRcgVB6HJcM2iyC5ovG1u37wekWv3i8/gWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Op7zqKXv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Op7zqKXv"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-81e8a9d521dso1530709b3a.2
        for <linux-iio@vger.kernel.org>; Fri, 23 Jan 2026 11:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769197709; x=1769802509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B3R1HFYAHVqM4kzN3/S5Q8P4MgXYgJzeRc7cvT0rLI4=;
        b=Op7zqKXvfU5ogwzPXBXvV01axqv+ohlWi0Rh25G3HQzM7Nw5WjLwtzsIk3hCduLpQm
         LfwgeEfOI5fJhL85gpx53v2Pm5MTXWOPeiAExf4/eDesI6HdI56GyyHPwhssUiXqAR0I
         Ii3F9N/jEcZvASk2/cmwTYFnwtPucAoPHF/oplIqLr2m1f4iyiczWfzOfAmORCymyMmB
         kuuJZ+8Mgefcpv1npkdc9Am6jIP3E8JZqfp6NTEzOOvBd2ocipMbJ7EOzEw+2dWzWPn/
         XyiUGZNEU5/SCbJ4sY6EDnkJoycK7BMTr5dxhJVPy/GOc6v66OD8eiA7E8MqiHjNLgbv
         y47A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769197709; x=1769802509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3R1HFYAHVqM4kzN3/S5Q8P4MgXYgJzeRc7cvT0rLI4=;
        b=cDBxKjxZz5pHQSj2CcSnWqB4mhH6iFjJ9gYh3V7XIr53paZIK9no5HIL/iEdpdhMHn
         Ea4a+S0vhTmA5bsU0fnqBfhnTClGBIBWefnNkZ3JU2ORbFlRzF7wmDf/Bybd1DD/WG25
         nCvXEg/54QBpv63VJQIILSLZ5DXdXjYrSPWKF1zi1spfNI/W9E4OTEv5rQMsJG4CjAAW
         OU1bHFP7zjr0K4CtUqvu3BI9Iqq/1ARn0JvdG1GKHpxmzihi6lScW7DBxU9+AhJmO6MC
         ZlXXGf/0mDBrTLexGm9TfD46ZzGafQO1d14j//O+HOzNhMJTmyXZdfyntVyXdQ5awlpA
         9sSg==
X-Forwarded-Encrypted: i=1; AJvYcCXlNv9k9j/Z68x4mMygR3qte4HGMhBliIUAwwk8u/O3vDjir0AWubx7XnpyenxkGCSdsz7TknyJHqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFZjouRL80NOzL6p17KqkKrq3MO6YOttrZJ+pyJWkNRS7WPhB/
	2nRp4xCIU7/4wUrQGmrAu2mDd80g03FcxrepmAHhetKzSARUjOBrEXZx
X-Gm-Gg: AZuq6aL3BVxPKcVnNCWnsklMXde7lFjRKFAC0sPcRzQRby3l8AqU4y+93URSWmbqWUx
	Uq7DpwYw4V/sZn+KlQZ/kLBBMQFeMJpgU9C5tdMfFiadqPH38wIayybwWNf+dC41ZmMeCPpfCrA
	jEISxDkA7cDYDjpDaxHNgcPc2ea2S1uBAxlJj8yEbKoj4C/kz0kLRKdRuM00Dhmvofi70luxdaB
	kHCSdqZ/St8Kp2dzmBAqPY+hBL8jrMpgLxJiTwg/IOCRF4B7HhJFtGOTD0Z/PmTXqEN8dlOHxMG
	tDWgFojk3xfQTaC+gbsvoBiVYc1Jfos6puCrwRoJ2+hNoJysZb9gvEPS2uBxKnYbyGm6gF/M7+j
	+nlX12jR4gSPYa21oCUpmeOg5rybO1GoedRjxxEHkTgorWKgTAwvFbCjooQf1555/eByQD7Nswl
	6MFz4VpLE7DFhgWhXuL9pi5C30flXTsxxWDs8=
X-Received: by 2002:a05:6a00:1f04:b0:81f:528b:c091 with SMTP id d2e1a72fcca58-82317da618cmr3147119b3a.22.1769197708811;
        Fri, 23 Jan 2026 11:48:28 -0800 (PST)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82318644bcasm2884618b3a.2.2026.01.23.11.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 11:48:28 -0800 (PST)
From: SeungJu Cheon <suunj1331@gmail.com>
To: antoniu.miclaus@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH v3] iio:frequency:adf4377: Fix duplicated soft reset mask
Date: Sat, 24 Jan 2026 04:47:58 +0900
Message-ID: <20260123194758.15445-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The regmap_read_poll_timeout() uses ADF4377_0000_SOFT_RESET_R_MSK
twice instead of checking both SOFT_RESET_MSK (bit 0) and
SOFT_RESET_R_MSK (bit 7). This causes an incomplete reset status check.

The code first sets both SOFT_RESET and SOFT_RESET_R bits to 1 via
regmap_update_bits(), then polls for them to be cleared. Since we set
both bits before polling, we should be waiting for both to clear.

Fix by using both masks as done in regmap_update_bits() above.

Fixes: eda549e2e524 ("iio:frequency:adf4377: add support for ADF4377")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
v3:
 - Summarize discussion about why both bits need to be checked

v2:
 - Add Fixes tag

 drivers/iio/frequency/adf4377.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index 08833b7035e4..48aa4b015a14 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -501,7 +501,7 @@ static int adf4377_soft_reset(struct adf4377_state *st)
 		return ret;
 
 	return regmap_read_poll_timeout(st->regmap, 0x0, read_val,
-					!(read_val & (ADF4377_0000_SOFT_RESET_R_MSK |
+					!(read_val & (ADF4377_0000_SOFT_RESET_MSK |
 					ADF4377_0000_SOFT_RESET_R_MSK)), 200, 200 * 100);
 }
 
-- 
2.52.0

