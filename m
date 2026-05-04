Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCCF204C36
	for <linux-iio@vger.kernel.org>; Mon,  4 May 2026 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777886478; cv=none; b=o/re7f5Msgjg+GfJpsymP3JZr1ASNPqeeVA8fqNDttelBQUNPF8d8e3J5EQPYbES95J6W+rVc1XKCeRczUlFQIeXbsKffikVHovlwSCf8mOMpBHEuobwqaNBzqh1uiLw554aNORO9+BlkIeCnMlG7CoWHgq5AVqTfudpY2nLNDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777886478; c=relaxed/simple;
	bh=uCtvUv4bxEywi3tg4tIQ/iZN1R/dih7qyJa/FT2wfkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YKwUVRDp7AvhfZBQpflbfgAvaUJweMFiUf28TEXUjlFZXkv4lGpYdrGj9ZEizC/am661sNFw5iOt42QhLq2reuxEyovvVH3WqbRqnp2MXTjSY3XJ0t1zkUlBrnNT4/InNTfTCjOdjU7QdGRxySWJeNRSPfiWM+bbx4kwpWvYaPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAsynOgt; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAsynOgt"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c80167f56cdso449804a12.3
        for <linux-iio@vger.kernel.org>; Mon, 04 May 2026 02:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777886477; x=1778491277; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZcAeOLR7xmJOHuEzHLeDXQ/7X479DK/0Yz3LFZ7fIeo=;
        b=ZAsynOgtQffqsBe1VkvB7a3rLEGrT8oet5hGGzUMJxLsTZRJAe1L5M7Cmn9QmLMoUN
         q3vgvmFp7c4YyuJR6enD6f5N/QJC7VjvuU7AODcUR+gdKikCF8qMVaDGoGiffN04qSwA
         2tTFYr6uVZ6rc9lQIv1LI77Hcu2r57A6SzadIMP1S7+pdTE1QI71zeABlU4LZ8xXYD10
         BMc2rIylybyrEUsEsn5nWDbSUw9RlUiMl0BuhQiOvRjtuoM2+J5QWYWzwKxU65PGqzfg
         fBd3eR1uvN7zHc4rlD+Zc46rBfamzy2qw3fLWYJ4jm7u/M+KjVUASaoZWUkHeJVSdyM+
         AIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777886477; x=1778491277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZcAeOLR7xmJOHuEzHLeDXQ/7X479DK/0Yz3LFZ7fIeo=;
        b=nRTuT3toMFu09W2Z+XXAdIVqgkBWBt+QMlUr1/El4p8IBYtcRwK71eNEZuriHx5kNG
         8dz5fOoxK4DA1bTPk3J4vWp/Y8FRnUEpclCuCZtBfqTcS5OJ4Am8Iosp27ER1xOtgS5j
         zsX9USyJ7PmKRM97wBexfsJscVrByziXYOyb/xWcsqW5jqP1Ei+/Ij/0zpBq9YZxh2o+
         VMOmlvSVCwX35mJQ1NzoffFj8dzJ2K8YJE6gdwX0o/U7LhirflJKvDUZlMFK3B3tUjpS
         GqLXIufJGzQKT26shYsUQNCQ00Y5lFfOMcLp1GvylMFVOz1pRJ/1rn0Zln0UzSzY3Y1Y
         mpFQ==
X-Gm-Message-State: AOJu0Yy5Z5mm/+bM9AZktbUV+H65LRMrTwc43WNxuOM9EHFLfN6x/4fN
	V25lUFA7QZdxri/5ZzfR5OLCXiwqB+M0svXOSg40rwDh2zJq25kjToGMhK226f2pSvE=
X-Gm-Gg: AeBDieuAwZ90/qQ9h2SJHK/CUuW/N3bxQvgRzgbm127txZtlKX3J0ErrVp/DujomqaX
	02y2O826qe6Ffa6p6zGslgrMoSkvienu43137bP01LojNMipw03HRCbD+OkafvdjfltkuiND2be
	1wZDhR419IoaVzlBmbWtyeGmvKEf44HkrB29EFFSEAfhFA8cfgJGJw6V+C/WF+yIJZK6uQ4diwo
	8hE2uvDAoJrhEMyhIwllqdGSn65HnhJ5ZvyurjcV55TnRXQOBniL/jsf3ixbLJLhaCRQlLHHisT
	lRLSBEtBjO67OkztA4Cp1+xZH0BC4/pjS/ldK6On4i+g+t24IGSvbWZXh5N98SULLxyRaeqS5ag
	BH9a0KACKtyr/A5RBoxqwkcqYUsA1brZj4xKZOQSRFax5yUwn467itMxn0PSwKbiI3BTsqYEk5Q
	j5opu9lHqCKFtKKEiYMYUyFCHjOlIbBg==
X-Received: by 2002:a05:6a20:3949:b0:3a0:aee6:acc3 with SMTP id adf61e73a8af0-3a7f1c24df4mr9623065637.38.1777886476890;
        Mon, 04 May 2026 02:21:16 -0700 (PDT)
Received: from scootaloo ([101.179.98.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c802545908esm4163923a12.27.2026.05.04.02.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 02:21:16 -0700 (PDT)
From: Angus Gardner <angusg778@gmail.com>
To: linux-iio@vger.kernel.org
Cc: linux-staging@lists.linux.dev,
	gregkh@linuxfoundation.org,
	jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Subject: [PATCH 3/3] staging: iio: ad9834: fix chip name typo in comments
Date: Mon,  4 May 2026 19:20:59 +1000
Message-ID: <20260504092059.1536094-4-angusg778@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260504092059.1536094-1-angusg778@gmail.com>
References: <20260504092059.1536094-1-angusg778@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two comments incorrectly refer to 'AD9843' instead of 'AD9834'.
Fix the copy-paste typo.

Signed-off-by: Angus Gardner <angusg778@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 0e4727fb8cde..a27c03387526 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -164,7 +164,7 @@ static ssize_t ad9834_write(struct device *dev,
 		break;
 	case AD9834_OPBITEN:
 		if (st->control & AD9834_MODE) {
-			ret = -EINVAL;  /* AD9843 reserved mode */
+			ret = -EINVAL;  /* AD9834 reserved mode */
 			break;
 		}
 
@@ -239,7 +239,7 @@ static ssize_t ad9834_store_wavetype(struct device *dev,
 				st->control &= ~AD9834_OPBITEN;
 				st->control |= AD9834_MODE;
 			} else if (st->control & AD9834_OPBITEN) {
-				ret = -EINVAL;	/* AD9843 reserved mode */
+				ret = -EINVAL;	/* AD9834 reserved mode */
 			} else {
 				st->control |= AD9834_MODE;
 			}
-- 
2.51.0

