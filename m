Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D05B3A2569
	for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774856966; cv=none; b=qvpgMt/X+4EgOjds72EdpC5Et3R02UXjl+eTd1vbj/nh9YR1QqNdBjPUxRsKFpwwn75YTizqaCdlrIEMzAo0TR8V6yhNiQDOew1A19/YRCrJVnYXAE1bZi3IWkdPNK3DybHYs2jhuQanWXCaeQrxpFo7/OUdTq/x7brDd5mmtpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774856966; c=relaxed/simple;
	bh=FCVDxyeZ6U2fZuvPyn9vj+/wrDMAtqBJkQdHDs14xXw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fuTHcpmsb4IjZU4F3h5tbkXwNjFpKyQZ70ObiEr5czlebD6Hav12FyxuFSbgY723sK2NKcppL+MC8iU+vhy8R7XfqYMZ9ZMzaj9qPlb+/nIUxT38LOQVvpelO9CeggaFl6dDD7+VmIJ8nKePIHct2yYF/5R3hbtl572mDkAcW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n371viW6; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n371viW6"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3567e2b4159so2823703a91.0
        for <linux-iio@vger.kernel.org>; Mon, 30 Mar 2026 00:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774856964; x=1775461764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GvYJ6ECT5bnsGVUpQ7Kcf/RMUFHIPygDIp49KCLMYss=;
        b=n371viW6RTrs74jBErdKb/w8EmUA1dy1sYYd7vY66c16YT9AQY6sq/f39RGqzU/hNT
         jU09fzKQ+vtrHsnLkPp7WoubhMXXSrxupudKkQd9ZV5Si4/uB+5VgPybZ7bsrFm7EWw/
         GpaPfeQFCaqGsqZtm+acpOOGcBdd6a71wJfbcvRmZCyCVJfpwV6CYcqz4U3lM3APvgv/
         C49UYaivY9XDDBs1rV1Y27NWN5aSLi5+uGC3QeWcKTLRiJZR9suFCsb0xF8pmyWbtw6u
         hb0nHXBbQ0zncX8vXehvtBR9jIHJRi0E2Z5woW+i/zer0USE3ZccQihkjPLQRk2JXd7v
         dD3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774856964; x=1775461764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GvYJ6ECT5bnsGVUpQ7Kcf/RMUFHIPygDIp49KCLMYss=;
        b=DL0Nb0z3XeAtgQumI2hOoNap1LtFy5ExhCHxbOaviPr/WUHwSvaVZ3st+Dcp9yNQnn
         jW+riIXH9iN0q8Ss08ySyBbNmwUmpCvtBPWLt+hX21UaSAaYqtn3hnd19LTDyT/nv/m7
         opNrxy7Jw0LQT5mEEeAbU3CMQKUpP8Zm2cXS3VnPZxjhj5pBz+R9Oge8Reo780fDtlmD
         TFqY1i3WGbu5kb6yuTzXyT0ze4A1tnKlkoUobyS3OPthSFTGvDH+WUdM2VbY0dTqmWhc
         9ef+WfiWnsvJjID9D0J54IkkIPFqhYprvniM6JHVopW1ZfXXG5619n7T3Hg20hofb7DC
         H/iQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeXKGud9Yy8IY+bbmmg6RNitSOe3inSnUde4BsZ/nmGo3hjo20CXGXgyiqy2aB/KYaXW+Mb00mfxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ4ftfajHvN0qkl5Qro8RkRey9VJFho3zR6cKY3bDneIsUNlKl
	+kddzNJ4Z/RRrthMK1WqYth7A6VIL4sLTsMSnGmXmoc67rvhQs/NIwel
X-Gm-Gg: ATEYQzwPdLNE5JTQPqpM/oUAfCNf0vEUdV65b8tdj8xGrNuIRS4IadW2jMurWhYMmuW
	gx9wLyZkPDCFSA+GrjShkT3UF5YHz3hGoPnEFTKFCGwDxA+fOANHVprwVTHpQF1Q6as+M7CQlHI
	6fYuWkyfz8EuG7bPkfCX0ES5UNch4kFPNZdsNTC18O8LlRj8wEcMnglmcabzXEBbcFcsOrH7Ws0
	JYbavyEF1jatBXqYHG7dNse+7wEk+JH8/TtpJDqmfmiXIzkU/BRCsSI8bxz44xbfQ839+Cc8oqq
	a+IJJNmXRmFOBoerxKF9m+2GRL0SInHLrQ2j0vyBVXiuUp6P1TVdonhx815mvo0ptvtESUkfo3O
	3RhdvL4XABHNvi9c0T8k9GEjk3/F+z9BDjOrhOsq6TAZHjX9IWCCVIK28W/rYBvAZmE9MemxBKU
	JWtlS9x1rVRKdX7OlAo9EQ91rbkMLqWaHB24BnmQ==
X-Received: by 2002:a17:902:ce03:b0:2b2:4d08:9e02 with SMTP id d9443c01a7336-2b24d08a6a9mr43053645ad.21.1774856964498;
        Mon, 30 Mar 2026 00:49:24 -0700 (PDT)
Received: from Mahmudul.. ([2400:c600:5467:3468:e24:16d:2342:ee26])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24279a428sm88127555ad.66.2026.03.30.00.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:49:24 -0700 (PDT)
From: "Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Md. Mahmudul Hasan Mabud" <mdmahmudulhasan1511@gmail.com>
Subject: [PATCH] staging: iio: adc: ad7816: use sysfs_streq() instead of strcmp()
Date: Mon, 30 Mar 2026 13:48:50 +0600
Message-Id: <20260330074850.12638-1-mdmahmudulhasan1511@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use sysfs_streq() to compare the input buffer with the mode strings.
This is more robust as it ignores trailing newlines, making it safer
for sysfs store functions.

Signed-off-by: Md. Mahmudul Hasan Mabud <mdmahmudulhasan1511@gmail.com>
---
 drivers/staging/iio/adc/ad7816.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 172acf135..c2544415e 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -136,7 +136,7 @@ static ssize_t ad7816_store_mode(struct device *dev,
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad7816_chip_info *chip = iio_priv(indio_dev);
 
-	if (strcmp(buf, "full") == 0) {
+	if (sysfs_streq(buf, "full")) {
 		gpiod_set_value(chip->rdwr_pin, 1);
 		chip->mode = AD7816_FULL;
 	} else {
-- 
2.34.1

