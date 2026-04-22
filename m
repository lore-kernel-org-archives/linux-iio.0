Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65BD3BFE4D
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 11:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776856934; cv=none; b=kfNuoF7ch1+TO7DccfYLai3h7lNvMaXRzDMEr8EoqLbuPl0DM2YmeOi8SHTur4lb4z2EjB4+P+77TlqpvKcn+4vhqbUqDuYVUdxczWRotCdS+Mh0k8YKDRpy3ApFNv+Mky9rLFdO1HZjiY01+wBfklwDQhDT9Fb0zJxm+u7LT/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776856934; c=relaxed/simple;
	bh=G8jsdvtp87OlJ8uJd3pwmkg1IzyqeVHJhgdLUXFfu+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nMHxFwuFaOgus3knHyiZ6+5zmo5U59o7haEbBmnCqiZ9W7HdmA3hOhzgqP7hNdv+uqLnImggf+UvXTBwHtLTrfTsslieDFdV6BqNoAYEZclGjUFPeY/RwRziTdTK+ci4Kq6ePa+4dMioSvszmnOUmKT9rF4iwlCWz5CN3r2dscg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbqeAEtB; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbqeAEtB"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9c603ec2dfso706266866b.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 04:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776856931; x=1777461731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j0Fj033YEDjAZz3YbFYJoJOXRn+iWTo/zlcLxqFJWzY=;
        b=GbqeAEtBszC/M53c+7mzNB0ElJSzN4Bk4p83FcSOjmuA3RxtTVxhyaXwrSI3RIcR9K
         a0VZjwyLjDeMtzruq0yAV4VBStOId+ZfloL8r7bQM9tCM57t+lqylH4snI63JCwOLfsK
         LqAK87deamzxXzAjqOG8aY7lV+8ol7zBSoKCd03eNQnbBeLg7CfE5rudwDfxi9XbCiGO
         1A45j/Spq0gBrnNItanMzv+RFESr9E9ULMEnoncxcYIwYzelWd/xWQQ8xwW2hnbjW65j
         HWGBr2YfgNgwLtSyz3LOKCFRTXmkV9I/v9wjrSU46IDWs9vHb07zXhsKQt4oeDsiB6sr
         +gFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776856931; x=1777461731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0Fj033YEDjAZz3YbFYJoJOXRn+iWTo/zlcLxqFJWzY=;
        b=nzu2xrItP0GYvxBDh+vSn4cJnXUGmF+POPrnhiLBSMalg9p3wxkqwbRxN+Cv9x5g3k
         wNvWNRqkDBTQxxwXivQsWXv2bmebBM4qevK3n6GSrGZlVBe+jd0bYCrktX1Lq/4Y2NEX
         e9tMqdAaPfx0361NuelsYfe0FpSfYIr3AV9WoVuRevTM0LQOWqvxgXxVbkbcEspNlFaf
         3IwzVFJZxrG8B7KqqraA+2cU150XShPDuOK5OpgnqLk1P5RxnWFUY3Bhn03ecx/9g6qd
         s7M8jQ1AovuHzUe6k2/TPupSZzenlWxhcCzmLcZ5N5ATY08j52GvByOG1M0kQ8v+/4AK
         xz+w==
X-Forwarded-Encrypted: i=1; AFNElJ+mbn6DYdkcRJRLTHnzuLeoVeYGtVlVbaZX/TWg2GdWJK6WzWDusZOgTPB4VRvy7LN8V47mJQ6mt54=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFX33bQQhKd2hnXjf+EGBo3HeH+T+BYU3Pc3Cwg5L6+aLE+sCK
	nmTZN+llhRrkH4GJkuCcvJZ3A3VF+L2InoVsEDUaeyhA58qQdweZVVOoTSJh9sGjC8rb3Q==
X-Gm-Gg: AeBDiet2ZZyxN/8YbMK+uJ81J2zOCag7MjYTMdMxtXfz76ncAG18rTdNQ2bWkEDDgkR
	RKKrz7GLT4tXki/29onvsaeAMNrIsYBTTn2oWo3AEJeqFQPrGFSf7E1md+h7hy65lp8ccJDKtqD
	6hiolDCmB2jwy/TNr92jJg1cfvROveXJ4lM976hkoX54pGQx5zxlXIKoJ47DMhVZQ8hXCH/QfIw
	MfpDpHMGx0/khG1Jyrdmc9VyjGVx/0VZ76B/8jAqJ+AVclkyWtnp9nk4j2Ggzo7A72Ot7chnLRQ
	PfnyKi2jNi1hKFS6ldxzYzP5ey1arr6Zfk56Q/LaNlkKMuI6WlmvGazy3OMju+opXJDLdU6wsUJ
	WXKO4UEd86jcsIKDIVpew48/RkL5x6Ieky7Bp2h5Gz9iC3eHyqLrAHa6lCbQA7qtgawXCI60/FS
	qOu406ZbITAsc36uCjAro7gaDZ0iiKwX4i1WB0yLlHLjNTJdj1oFbaihskoDc1LPfnVdGULA9g3
	1nN/ikuZttbIrbj/bmhh8gdbNKgKXy/phJCnNxxZ5/nKNmGMoQXMdLx4q+HygitN/0j9hFJVzVY
	f+EyBn1jHmu+QJRid91zdsboJVpO7gdwcVGkHCuYlH1GKJLRNRqkYYt/iF/JaDgv0BeGBsLElC+
	tsABkGldUdO86YdAIN49LCurPFuAU2wharXYzq0YSek/ASRVul8h2luGijWz0caclaSfVlBify5
	IToDiMfuM=
X-Received: by 2002:a17:907:78c:b0:baa:3b6a:629e with SMTP id a640c23a62f3a-baa3b6a6998mr275816966b.41.1776856930549;
        Wed, 22 Apr 2026 04:22:10 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.od237066db22328bb-tp.internal (25.236.141.34.bc.googleusercontent.com. [34.141.236.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba6366452c6sm395156866b.11.2026.04.22.04.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 04:22:10 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] iio: magnetometer: ak8975: modernize and cleanup driver
Date: Wed, 22 Apr 2026 11:22:01 +0000
Message-ID: <20260422112207.1313-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series modernizes and cleans up the ak8975 driver, migrating to
more modern kernel APIs and cleaning up legacy code.

Changes include:
 - replacing usleep_range() with fsleep() for optimization
 - migrating to iopoll macros for better device polling
 - removing unused headers and adding new ones
 - checkpatch.pl fixes

v2:
 - PATCH 1: reverted alphabetical header ordering per logical change
   separation
 - PATCH 2: added newline between fsleep() and return
 - PATCH 3: fixed open parenthesis formatting
 - PATCH 4: fixed whitespace issues, added <linux/time.h> for
   USEC_PER_MSEC macro
v3:
 - PATCH 1 & 2: split alphabetical ordering and header removal into two
   separate patches
 - PATCH 4: commit message fix
 - PATCH 5 & 6: split error handling and polling loop replacement into
   two separate patches

Joshua Crofts (6):
  iio: magnetometer: ak8975: sort headers alphabetically
  iio: magnetometer: ak8975: remove unused headers
  iio: magnetometer: ak8975: replace usleep_range() with fsleep()
  iio: magnetometer: ak8975: change 'u8*' to 'u8 *' in cast
  iio: magnetometer: ak8975: fix wrong errno on return
  iio: magnetometer: ak8975: modernize polling loops with iopoll()
    macros

 drivers/iio/magnetometer/ak8975.c | 92 +++++++++++++++----------------
 1 file changed, 45 insertions(+), 47 deletions(-)


base-commit: c65f27cae0deda3316ed49899df4492a3896e38c
-- 
2.47.3

