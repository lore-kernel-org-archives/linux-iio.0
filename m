Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E73D3C3C02
	for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 08:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785400285; cv=none; b=LK68ciC5sudbaLHWblXwf27Sj7l1jr1nrrQwJrrSDzf8NwepO0O1Xyg3VvwwKwj0FHWGwQ6JWnC3g/7LBnQy8YiPrTQuf/mj81s6PDmsYH5ODJFkIkiXEEqmbmCfhQIEQKsx9YGm46mcgsa5fcOZsZGAECZaquQ7BEKfTVg6pB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785400285; c=relaxed/simple;
	bh=6S007LrtwyqtUck3rOCd6Zn/0JT+xbUIfbbS8rOxwh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=md6hbNDwk1GYoVAy0zVHVL6ufzptsWnD9YsyuCxPKC4VBL2O97QI8iK9IuYvQYxUBIOGKQYsLv9luK0/ZhhNRTtRAJac5o1IH1QorgKI4AA+GnI+bdconrtsZrhcLSbgQJWRUnR8qt1Vo7cjTLGTVkGtUDz6NajDxGjmpKPj0ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sHYtlAIy; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sHYtlAIy"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4957799b92fso1443465e9.1
        for <linux-iio@vger.kernel.org>; Thu, 30 Jul 2026 01:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785400277; x=1786005077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GSoYF8RMispW0WpelgNiIoj0SQ+qS+NgX4k+ltVbdLo=;
        b=sHYtlAIyFxeZ1Lka0QHHGC1ZuHdFR5GAZzst71YxuQ50XSqUNIOdcqfmMIRHXJKg5D
         A7UyUG8tIbrDOFWj2W9kMUtkU/Sclb8jzqLPvp+XfeA0vY8yEHe0MqJFkLrtdd/B2oEC
         N4y/u2F4jfo2ErZsEGRtTShrDwFYCA4UWic438eO/RjOfOY2IFViRUW3B1qJQl9082eF
         KEbJFsOK7fqkozMYC/JzYH5AogFLIIYZX8BiZajBUW6NFXnX4pBn/NZOMZ6iO9/DKCi+
         cNTmndbAOsQL4cmXGGRtJrYLO1f0tet5kTM5xGP7grgJl2oWkAac+6wuuSRjd4waXYKc
         5rpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785400277; x=1786005077;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GSoYF8RMispW0WpelgNiIoj0SQ+qS+NgX4k+ltVbdLo=;
        b=lNrv94vHH9PlsZVjzZ4BqhZwMwSpZfRu0s0Wqs4eOrp8laiCtfWyUusl2YaHoMyrgV
         2PwMKRQ9s7TwAIZB1x+ShKy3vZC5VEFsJN2xYxWWnqyaVXdx3NG9kma4+cr6mIeDXlQz
         HsWOVauVz25iDMVGXodQIKcuAO5UNHP7fDyk9XcxMuLschLDnJeMXU4yOVwvLeqgMjKu
         yPczgtzVbJDzJXQt63J/q0idvoVOuiZFjBTk37/qFXDeog4KSnUOgE7NrHN5zgIreoWW
         7zg4mwdFn/Y6lX6iinaLnWvbg8YtiFaAEeRT4mZFqZmV8zYsHkykDkA2j27O9BV3iHUS
         8rfg==
X-Forwarded-Encrypted: i=1; AHgh+RqmSbK9BuboSMXq3Wx8r+D7cJhBgSYer/rVempOalmc4gTEYx0HEd3kj/K/zgBwqsfdTwCHpjlePTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaDA1FU/VxrkkkZ/gzeAEWRK4O/uVAcIoubfZk7a97cmu4E3gC
	cAHZn7k7wooDQm+L2UWCe096HJcdsTzz0udZ6m8pb2MynPjS45Os0GEy
X-Gm-Gg: AR+sD10Dwvcq03hIiFr4+NZAcTj04TpEk29Wu8qL54WbmW1ZDyC3mat/4vLuiWv+M0h
	i1m5ul+AGparyZlu0GA+1drBZn0Q2vQ1Bb8qgPIZT6VQWbv7IBHVvT6mYnkRYqwHAb2NepbRNjv
	i7bBl3cRRrFrzQk7eN3iUdZHF/ql5/+IDB9cazlY8BCOwh5S/NgPdTxL64Gf0lF/9RNu3cwC6ly
	MYU2pZKm117Kkxm9eQm8KnIKEynW7W9BGNiW5uAEsdHdEBWCazhObn6RQVMuRBYFKuOmBF0t4De
	NrgPsjAjsrDsu/yk7/+jLfhG9jtpJYMU/26yd676Y2Kn6BWHfqh6NewJeVwhCCJqj9nBFDhoHrk
	0A5sq6Q/AWlH/LWmyEJHR194XtsLhgmub9brrUjXmql/JNE2WlIjbg63o41fVirhYePVBnJc2so
	eL9XJ3ipe7QDWaJE05NRdZ1hswmJAwwEiD2zh9iFF3WkmfdMq5Z6KpO+UzhDAfFN8tuAJed3V0m
	eUrWdwdIO3XSOQ2J9VMKjGosTKXGEiRiqTLJC1dLjZOppPNb7jRkOB7rSCKBUX10wE5Npykkl8L
	tEDeWdNDhiVEmg==
X-Received: by 2002:a05:600c:46cb:b0:495:6274:56bd with SMTP id 5b1f17b1804b1-49800ed4c5cmr21470335e9.4.1785400277162;
        Thu, 30 Jul 2026 01:31:17 -0700 (PDT)
Received: from fedora ([149.3.87.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc893fe58sm6966268f8f.31.2026.07.30.01.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 01:31:16 -0700 (PDT)
From: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
To: joshua.crofts1@gmail.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
Subject: [PATCH v2] iio: light: veml3328: reshape scale array for readability
Date: Thu, 30 Jul 2026 12:29:34 +0400
Message-ID: <20260730082932.79484-3-giorgitchankvetadze1997@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>

The veml3328_scale_vals array is declared as a flattened [4][8] array,
so accessing a scale value requires calculating the offset of its
(val, val2) pair using gain_inx * 2.

Reshape the array as [4][4][2], with separate dimensions for integration
time, gain and the scale value pair. This removes the manual stride
calculation and makes the relationship between the indexes and values
explicit.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
---
Changes in v2:
- Reshape veml3328_scale_vals as [4][4][2], as suggested by
  David Lechner.
- Update read and write paths to access the scale value pair directly.

Link to v1:
https://lore.kernel.org/r/20260727112726.211344-1-giorgitchankvetadze1997@gmail.com

 drivers/iio/light/veml3328.c | 39 +++++++++++++++++++++++++++---------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/light/veml3328.c b/drivers/iio/light/veml3328.c
index 7ff1753925c4..ef0bb82e54e0 100644
--- a/drivers/iio/light/veml3328.c
+++ b/drivers/iio/light/veml3328.c
@@ -91,11 +91,31 @@ static const struct iio_chan_spec veml3328_channels[] = {
  * Gain indexes: 0 (x0.5), 1 (x1), 2 (x2), 3 (x4)
  * IT indexes: 0 (50ms), 1 (100ms), 2 (200ms), 3 (400ms)
  */
-static const int veml3328_scale_vals[4][8] = {
-	{ 0, 768000, 0, 384000, 0, 192000, 0, 96000 },
-	{ 0, 384000, 0, 192000, 0, 96000,  0, 48000 },
-	{ 0, 192000, 0, 96000,  0, 48000,  0, 24000 },
-	{ 0, 96000,  0, 48000,  0, 24000,  0, 12000 },
+static const int veml3328_scale_vals[4][4][2] = {
+	{ /* 50 ms */
+		{ 0, 768000 },
+		{ 0, 384000 },
+		{ 0, 192000 },
+		{ 0, 96000 },
+	},
+	{ /* 100 ms */
+		{ 0, 384000 },
+		{ 0, 192000 },
+		{ 0, 96000 },
+		{ 0, 48000 },
+	},
+	{ /* 200 ms */
+		{ 0, 192000 },
+		{ 0, 96000 },
+		{ 0, 48000 },
+		{ 0, 24000 },
+	},
+	{ /* 400 ms */
+		{ 0, 96000 },
+		{ 0, 48000 },
+		{ 0, 24000 },
+		{ 0, 12000 },
+	},
 };
 
 /* integration times in microseconds */
@@ -184,9 +204,8 @@ static int veml3328_read_raw(struct iio_dev *indio_dev,
 		if (it_inx >= ARRAY_SIZE(veml3328_it_times) || gain_inx >= 4)
 			return -EINVAL;
 
-		/* Stride by 2 through the flattened array to match (val, val2) */
-		*val = veml3328_scale_vals[it_inx][gain_inx * 2];
-		*val2 = veml3328_scale_vals[it_inx][gain_inx * 2 + 1];
+		*val = veml3328_scale_vals[it_inx][gain_inx][0];
+		*val2 = veml3328_scale_vals[it_inx][gain_inx][1];
 
 		return IIO_VAL_INT_PLUS_MICRO;
 
@@ -282,8 +301,8 @@ static int veml3328_write_raw(struct iio_dev *indio_dev,
 			return -EINVAL;
 
 		for (i = 0; i < 4; i++) {
-			if (val == veml3328_scale_vals[it_inx][i * 2] &&
-			    val2 == veml3328_scale_vals[it_inx][i * 2 + 1])
+			if (val == veml3328_scale_vals[it_inx][i][0] &&
+			    val2 == veml3328_scale_vals[it_inx][i][1])
 				break;
 		}
 
-- 
2.52.0

