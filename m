Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC1533AD85
	for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784708562; cv=none; b=LC2FkRvgeynTcsI3JrxYnasCN+xLsHh63wy9BsCbUaPKy9WYH3YXV+yKw8t9S0uv5CAq66TcPe3+rQtT465f8rphb6s0b+ACprAw9la7UkPPTARAjHkgQGObVB/tmN0lRN+0F+meDjje/FQc8kdshuzCEMiWq+np8sgSRPGS7n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784708562; c=relaxed/simple;
	bh=8sjnnDQnT7jKHqKJEZURpFQY6loTbMgd3W3ybquddG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MwrNiiixVOc16MMdTqp/wJtZlLUBr5EHQ2wBqLtydEBRj7hLHZl1CrrzlknlkunxxxmvlvlN/D+YcHVUhrWabSoMYl9sxVuvS0KZivd3eGO16ly4/EprUjFJnJ7ThEk4W0CHBJqtgYjEM6lmi3M0+FhkPfEaDmuYXb7pYa9S90c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ME6uZRvE; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME6uZRvE"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cb5b8572b70so3861093a12.2
        for <linux-iio@vger.kernel.org>; Wed, 22 Jul 2026 01:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784708560; x=1785313360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GwYJXRFCTwCHf9sWn/igVk2h1daNGsDuOKPemb7/q8I=;
        b=ME6uZRvEJyXkgCu0QCXd9EmI3WmbA7Hl3ePu2f9oMc4DYdwJHeCNKX17eeArdgt67m
         65msUzLmsbiwD6Lk7ioeX6vvhsDVpyoBNwHzqphfFgenDxLCX61JqXjlFo5PgqjIrXuJ
         7GCP4zcmPKv84SsBj9KESpkntJ1C9WafwwnKiIxWzeoU5R4dGR1Q10vqviEcDawGDxs3
         uhqQpxQFWNFeDhaQgiW9r4qiAjX2q6c4Ond6Sx+0VwhS6OOfirC3y/6e1d93L4783TmO
         6TDi9z1eez+p+bmUmeo+D0hgdgYJGDCQVnH2Flp2FKvvMVy/Io1RSufUlxtvbl5/o6NI
         1Kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784708560; x=1785313360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GwYJXRFCTwCHf9sWn/igVk2h1daNGsDuOKPemb7/q8I=;
        b=ooWUqPNFpnWAY/ROV8853Cb2q7CPSPPTbNdbVRXC395NxOPMRqI2JfvTCqCjIezyuE
         5rlCUmQsMWUcxWTfo4YE9ECJids42trmPVakzQA+YvAvVWFPOcc8PIjm8Aib00DsmpKx
         AYguLG0uyH5ZL5p2h3KE19rArN8Hhy9tOlCMQUMvv3W+CMCXz1v/upKRyx/ux41N0NKU
         Qth3pZLTgkuIm4Rr+ips1uPwnYe5zjEuMyrIsZw/zYe9VnU21kcBTM0IOOC84WVMJc8u
         XLSAzkyXBIwQ8NngkRZhoD+QDCPZmBKkcKP4tGTlzlF+xFbekq0af4aPwdpKyk9g0c4q
         1MRA==
X-Forwarded-Encrypted: i=1; AHgh+RpPhWzK+g4TT/ZorgusHKI+5M8NyFuPDM0PtVB9E9ToO6TOQUp+7i6UX5KZYgDtjcgIC3QC43+B7po=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDY1Rk7ZMUIdMeN67zQAN9efa60CvLPfH+n7dDY4F0tMkFMNH5
	ZzEuNOHuHFvtHSlxBBi3oeZtG+U0YFHFr0UftUWD5ngc0iB1Q9auRBZE
X-Gm-Gg: AR+sD11hXCP6rw5e4uL9h17/Tx3XTBa3pK2qQ0YL833g6mvAL+8zFeTFxpfl46Otix5
	zbhT/XUx4jV26dPu6cdEXdfKZPxeREsiRMZL5ZaSi1AGLCQc+Fbs4gd+P8FDaX7ntmvelKjrYYI
	U+CrbBK6Pff7+xhZFpQ7a+QBs5vLzFF55ezQfXR9jFNSrPxnkPOkPWY3kEsmEr78anDUkUsYxpi
	4Uj8atv1vXCYfMn+QE5xko7ZpgLnxoKh9PRHtY56ZPP8vac7bI52oXporqQ+Om/e5B+5aKB/TWr
	z7Hd0E4dKFrTFykl4w0zgJ9ND3L8lnn+WBQ/wD0M2Tw/BO4u9+umhyKNIHhUM46qBlpwD7od7Bb
	tzICvnVo/9rMT80dvGNCZ46fQ5i7IRPK1M31C2qdUHtz7iSYYYL1VcXRc9qPwPSwdBWkI96GIJS
	es4Qj9gwuD/pRCaNZoOlk=
X-Received: by 2002:a05:6a21:103:b0:3bf:77d7:667d with SMTP id adf61e73a8af0-3c3ad677d8amr23252278637.28.1784708559999;
        Wed, 22 Jul 2026 01:22:39 -0700 (PDT)
Received: from kernel ([45.251.35.89])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc193f8sm13343234eec.1.2026.07.22.01.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 01:22:39 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com
Cc: gregkh@linuxfoundation.org,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v2] staging: iio: frequency: ad9832/ad9834: add comment explaining do_div usage
Date: Wed, 22 Jul 2026 13:52:27 +0530
Message-ID: <20260722082227.18768-1-raizudeen.kerneldev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630032322.5805-1-raizudeen.kerneldev@gmail.com>
References: <20260630032322.5805-1-raizudeen.kerneldev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous attempts to change do_div() to div64_ul() were rejected because
mclk will always fit within 32 bits for this hardware, making do_div()
safe to use.

However, Coccinelle continues to flag this as a false positive. To
prevent future developers from submitting unnecessary fixes, add a
comment explaining why do_div() is intentionally kept.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
Changes in v2:
- Instead of changing do_div to div64_ul, added a comment explaining why
  do_div is kept, as requested by Andy Shevchenko and Joshua Crofts.

 drivers/staging/iio/frequency/ad9832.c | 7 +++++++
 drivers/staging/iio/frequency/ad9834.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 60c33e10c46f..6d046e9121e2 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -118,6 +118,13 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	u64 freqreg = (u64)fout << AD9832_FREQ_BITS;
 
+       /*
+	* mclk is an unsigned long, which triggers a Coccinelle false positive
+	* warning about using do_div() for 64-by-32 division. However, mclk
+	* for this hardware will always fit within 32 bits, so do_div() is
+	* safe to use here.
+	*/
+
 	do_div(freqreg, mclk);
 	return freqreg;
 }
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 33dfd723923c..8722f3a01cde 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -103,6 +103,13 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
 
+       /*
+	* mclk is an unsigned long, which triggers a Coccinelle false positive
+	* warning about using do_div() for 64-by-32 division. However, mclk
+	* for this hardware will always fit within 32 bits, so do_div() is
+	* safe to use here.
+	*/
+
 	do_div(freqreg, mclk);
 	return freqreg;
 }
-- 
2.53.0

