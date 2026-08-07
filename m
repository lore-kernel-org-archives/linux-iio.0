Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEC7352013
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 09:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096037; cv=none; b=asMU6CsPp8+5KQhlB7dFzGVPbVtInebCmvk4i72H7Im7WENwZq30q4BrCDU+YC73NfU6CX3sLexNUUZr8mgtygY4PK52zXml89pbFpHoRxK7e56KvhTztwRtiwx7O6IPdI4G2kTA/PzBXD9MBB3/RPXEGXwEFBrNqG1soXWS+74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096037; c=relaxed/simple;
	bh=HhxupGz1WHaq42O8GavvnZENK1sHfqrxEzKdKto82ec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jZsvzS9Ca0pZ6Vwn8MLmBuV/5x5ZEZ4f+2kBBAo87LX01Tj2o/5G2xoUoh5U1sWDOoFtznwVE1plPqEHS3lM/8H+Nkpb7v30CPL+fX7MZF9lGNEp/AOzaUP4TBpcQxq5l+NDDXM2iFWfmk8TUHzC+lNoMqawPCibNeOW0IVBaf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mJR6AAB/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJR6AAB/"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so3050331b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 07 Aug 2026 02:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786096035; x=1786700835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Ex4kLoFeCE7JpX1METI8NE7HW5gn3lcnhSZrjT8Evw=;
        b=mJR6AAB//Zpk8Mjgi5QgbG9G3nabPQnSTApkCgnjRzsNyK0Qcln/N7cyk5o3fkxidq
         krAzTwM/RrErQAoMdd8iyOxwxps0Y9o7SevOmjyp8WlARir1BYeMcqiGzG6JFkQcIasK
         voiiQNa+DadgC+EAPl1H5/BGK9M51zznee1+IuMhkycgj/8UXpueHT5DkO4fHhNLhIu/
         auY8fgl7FXGMR6YKJoXBmUCbhUhhXfuQ5Dw9H5UqbC2R48IW7T+y+Zi2frgWbqm4hMZu
         u07eETD+WkpX4KL9rRaR9anaxU9DZClS2dNqXl53CSd/7c9XocGgw5NEFy9gv6soZlrl
         AFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786096035; x=1786700835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Ex4kLoFeCE7JpX1METI8NE7HW5gn3lcnhSZrjT8Evw=;
        b=cHZQ/JRmdgAxBuUii9tUcJSoyobJVbsBTQGDsd9XlBSj7T+Vq3mVgyZPf5/J4TqZ0t
         yA9aDTqAQk1Sm99ZGQzVoEZAfIzVbDBHZsELnKxoD6J+tvTpvwXzOlDLbZ+Eofzvwt/u
         3q30ZbggAYX+DKvDh3aDCbFNTglD6Vgyrv5PNbFre7ZViv5X45Gif5KhMt4dF+Dbyoy+
         CtpyssCBX5yOiZkLNZeuSc+KCFvOTm0tTzbzpCaX1RwR9ENVNJAxu31V3KrtDcy4nbrX
         wLffW0bynJNL5dT663Nfr0V2UOACDziPpU23cPIh31UtbvgpglIj5/+7lCMiXVzarpmW
         y4PQ==
X-Forwarded-Encrypted: i=1; AHgh+RperXA/9OYoQMeA6aKGqI1qfsvqNPE5HWOzZ/cD1rNrXrwAzykXdECLHnc+soEnJNahxejvCD4b36U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNE30vDguhSPOGovGHlUc7MRYUvAVgszrndXaVqPg2pGxuMKEF
	XSxJ22pzmId8+IQW9n6xql/602VjTveho+runasn4PzreVr5J5AJmFYD
X-Gm-Gg: AR+sD10HwvnvbfqeAMyMWOLrT96UX84Ajzul2RSNBDt5HFC1mXMuLvsqfMtsxad2qsw
	ycb8O8FERGRxU4llJcpH97ChQeI74Maiq3rJaC+iiitXq2qmWCSzE+dxJEPW7UxuH8Tez27Fq9a
	t1H+dWwdOyq0bgHgPSvZzvwu3CERl5n/gLDzjWmHJexa9KBP/hs4TyhfXRh0Sqxj0OaX82ru7tJ
	of3pumg51lS5HDWW/v95FOycaeYWPvqtOew3MaGEMu2bLOtiwes6dRBISFy20c+2wwWwGsdoz4K
	yJKPrB7IPt2vx6yScVmEEHHxZxAqk2uV8Eh/L40WPgkq1IMejORi+ZD+uK249L2PpMKU0jUv8gg
	uot9KvynnNiaG0Szq6g2atORlg7NQJxvTLMFSUkYa2FxaPOd8oIFJkYLwzSZUFgWqSNYh7gBnZc
	XtPqU0ibjoSTLFgwZzPnx/BXyEVw0hjRMxyiaKsz3hk1aBvhh4HWkt4jchID4Xf6/9boW5uHoSc
	isfRA==
X-Received: by 2002:a05:6a21:3a86:b0:3c3:ad17:eded with SMTP id adf61e73a8af0-3cb8603af51mr25109132637.36.1786096034883;
        Fri, 07 Aug 2026 02:47:14 -0700 (PDT)
Received: from kernel ([45.251.35.98])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bec5aac2sm5832048eec.30.2026.08.07.02.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:47:14 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: andriy.shevchenko@intel.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com
Cc: gregkh@linuxfoundation.org,
	joshua.crofts1@gmail.com,
	skhan@linuxfoundation.org,
	me@brighamcampbell.com,
	jkoolstra@xs4all.nl,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
Subject: [PATCH v4] staging: iio: frequency: ad9832/ad9834: add comment explaining do_div usage
Date: Fri,  7 Aug 2026 15:17:03 +0530
Message-ID: <20260807094704.5371-1-raizudeen.kerneldev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Previous attempts to change do_div() to div64_ul were rejected because
mclk will always fit within 32 fits for this hardware, making do_div()
safe to use.

However, Coccinelle continues to flag this as a false positive. To
prevent future developers from submitting unnecessary fixes, add a
comment explaining why do_div() is intentionally kept.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
Changes in v4:
- Fixed typo in comment (fir -> fit) as pointed out by Joshua Crofts.

 drivers/staging/iio/frequency/ad9832.c | 6 ++++++
 drivers/staging/iio/frequency/ad9834.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index 60c33e10c46f..2e216c950c53 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -118,6 +118,12 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	u64 freqreg = (u64)fout << AD9832_FREQ_BITS;
 
+	/*
+	 * mclk is an unsigned long, which triggers a Coccinelle false positive
+	 * warning about using do_div() for 64-by-32 division. However, mclk
+	 * for this hardware will always fit within 32 bits, so do_div() is
+	 * safe to use here.
+	 */
 	do_div(freqreg, mclk);
 	return freqreg;
 }
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index 33dfd723923c..e089a94db97d 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -103,6 +103,12 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
 
+	/*
+	 * mclk is an unsigned long, which triggers a Coccinelle false positive
+	 * warning about using a do_div() for 64-by-32 division. However, mclk
+	 * for this hardware will always fit within 32 bits, so do_div() is
+	 * safe to use here.
+	 */
 	do_div(freqreg, mclk);
 	return freqreg;
 }
-- 
2.53.0

