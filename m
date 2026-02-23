Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219C23793CE
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 21:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771883837; cv=none; b=pYGuhxk0qVgISNyO6ssx8zq3TFaBahfARlskAxvtH9vksMxcAAINbuC8EatEyduZaqLrIWH6KRzLDdaDcQrwIuZSRjX65ROZJhh4wIdZGWj/jzT5Hs8CO8enjiCPvCiKluH5IZYG3a8n075bfX8wwE3WjznYJoCK4BH4t+E4OO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771883837; c=relaxed/simple;
	bh=E92lXIRr60SHMg2fArc47BQNbTfjxQG/SOtt2nLRB3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4ixJKPbiSwZlfPHPdYVWH1mZbQYE0sR1jMf4SmTU84kuGtFHCcrDd7C1lCShe4Akwjt2tK7qUJiNYcCgiqnfnRyF2NK4MdpRFnXU0pAXP12i1yW4BnG6HZjMEzDbMeuX4zKvCQin0UupkTKN2KNRqPVZaIicJEmtzjdgYEsag4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7iBs5jA; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7iBs5jA"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c70378ddaafso2847452a12.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 13:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771883835; x=1772488635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQTr7mgIilChf/JeESIDYXvGnp4mBQvya6Be0H5NIwM=;
        b=Q7iBs5jA4ZkGHyjPCDWIne4dRD4AbPC8Bk2OU9oDin1l7AW9zpXyNJ/lCncbPWN/1n
         QE5TL455craZ1baYHR8sZ/0MoolX0tthbzMu8Gx6PBtaa5FW+0yHcNST+JwDEhtw/7Bv
         dcSf1cEvVeLEmXo9YolRpKggsHmyBp8XCLWRBbrKOXmYyxSXnvKJY6DjPioFm4BXnqlQ
         ZLjtkbgqMecxnW3kzC3PqyKB/njcHQCnlzfufgLZ7pcFvhiwJtEEemnzA5k3dOpgZ/aA
         8++x8Rixh9bucORypwujWkqRI0HcP1NqEhQ59gKN3pdcQYfI9V3OGiTYF4GYBzdcivKi
         vikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771883835; x=1772488635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lQTr7mgIilChf/JeESIDYXvGnp4mBQvya6Be0H5NIwM=;
        b=KsE2k9eL4HQUxpBR+ArII6OW2Y1Zx99b/BujfD7EhwqzIXfg06f6cDplmPzK+lp6fs
         001xGGRJ59dQqwP/YbcqkqMw5YnZKhEF9LFiKVkXbDWHCqC/znTsuGibz1IgKz9lAj1T
         FTuK0DuD8+1O+45tfw1caBI7ifKrS48PsIECgssEKQ7fabIvNiDPRS0lqrCJeSaV8dQ0
         ZMv9E5QZRSz0wKoV6oZe4Hy0jbt+hKlETARgUDCRLDdytzrYfClCAIk2EmycdE9JrPBj
         o57mMd45EJ2YXUCtE8erW8lrfOoYWuL4e28DSYhoCe4x9r2uk2wOLN8MnCXVQ1kzn1mS
         N2/A==
X-Forwarded-Encrypted: i=1; AJvYcCWASej3TUTLdIZX/AudrPmQ25NwEjuRAvNO3lNJeukMLWiar/1J38Dffov30kSOqGPlIjnO71oxZCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoDomXu9xYOWpbm6ooBs5Yu1q7jp7aGEjZ48LewDTAOX6E66k9
	oEJ+e3UgEkgjXyFYeaNCwligrYCZCp3UFJ6NRZPdkptHIMQ0fr0M3rG3
X-Gm-Gg: ATEYQzwR+lqtFcKhmeM2ecwQ30BAlFhaDb0dTLIOgd76gdeQEq6Gvxu3smcZV31b6Yt
	aAhvfW4Bnn9Y6yNMHegpEB4LhSjHpvQ2WidOV2ytpyFl/5xdBk5l0gkStSuLaJiajp5WQAcZd1D
	yfMxIWSyRQ/DwoD7gZk9VbAErt7VayVjPNTids0vuWCwMNpH+IQWMYfsSkCNpFLcS+NIvOhg2Mu
	JnY5zEB7AlezqqzrkokaGmSqTsxP9I52ayIY81qwwLVHM+adeL//Ob8KFyv7TjxrZz467RvsHQM
	2UaMBVgimmJ4nUDFAAJ1X/Q2YtZR+JaGOLqhf5J0pxyK2SKtay1gWrM3gHXbAhp2tQU1gznhqYq
	SFTqSxiIkZN/84ebcoX+tCnOMozXo+Jk0ePJ+iyiyZ+4HQPsWgI/EaY9xPmbnUWGtrhW03p8zo1
	hBna6v1tDR53GKYyeZebAVCg==
X-Received: by 2002:a17:90b:5410:b0:340:ca7d:936a with SMTP id 98e67ed59e1d1-358ae8a87e3mr9532992a91.18.1771883835258;
        Mon, 23 Feb 2026 13:57:15 -0800 (PST)
Received: from arch ([2409:40c2:5428:afe:6feb:bc4:5ef7:1700])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358dc0092d1sm352772a91.5.2026.02.23.13.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 13:57:15 -0800 (PST)
From: Bhargav Joshi <rougueprince47@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rougueprince47@gmail.com
Subject: [PATCH v4 1/3] iio: frequency: ad9523: fix implicit variable usage in macros
Date: Tue, 24 Feb 2026 03:26:34 +0530
Message-ID: <20260223215636.18606-2-rougueprince47@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223215636.18606-1-rougueprince47@gmail.com>
References: <20260223215636.18606-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

macros AD9523_CLK_DIST_DIV_PHASE_REV(x) and
AD9523_CLK_DIST_DIV_REV(x) implicitly relied on variable
named 'ret' instead of using passed argument '(x)'.

Update the macros to explicitly
use the argument '(x)' for their operations.

This also resolves the following checkpatch.pl warning:
WARNING: Argument '(x)' is not used in function-like macro

Signed-off-by: Bhargav Joshi <rougueprince47@gmail.com>
---
 drivers/iio/frequency/ad9523.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/ad9523.c b/drivers/iio/frequency/ad9523.c
index 63c485e9e44c..5725ab62e0fd 100644
--- a/drivers/iio/frequency/ad9523.c
+++ b/drivers/iio/frequency/ad9523.c
@@ -167,9 +167,9 @@
 
 /* AD9523_CHANNEL_CLOCK_DIST */
 #define AD9523_CLK_DIST_DIV_PHASE(x)		(((x) & 0x3F) << 18)
-#define AD9523_CLK_DIST_DIV_PHASE_REV(x)	((ret >> 18) & 0x3F)
+#define AD9523_CLK_DIST_DIV_PHASE_REV(x)	(((x) >> 18) & 0x3F)
 #define AD9523_CLK_DIST_DIV(x)			((((x) - 1) & 0x3FF) << 8)
-#define AD9523_CLK_DIST_DIV_REV(x)		(((ret >> 8) & 0x3FF) + 1)
+#define AD9523_CLK_DIST_DIV_REV(x)		((((x) >> 8) & 0x3FF) + 1)
 #define AD9523_CLK_DIST_INV_DIV_OUTPUT_EN	(1 << 7)
 #define AD9523_CLK_DIST_IGNORE_SYNC_EN		(1 << 6)
 #define AD9523_CLK_DIST_PWR_DOWN_EN		(1 << 5)
-- 
2.53.0

