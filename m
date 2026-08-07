Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BE0446BE9
	for <linux-iio@vger.kernel.org>; Fri,  7 Aug 2026 06:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786082642; cv=none; b=Dl2v090LfZ7L/mVYbnIe503oobXWGdSNQXKb0F+0EeKs09MHbpY2wwMzV9nVkJLU5KfPP0jc3EAlFCg6tDG6g0UroadADRKVFyTLpSYO28PNMF6INx5Vej1r1xkrs40gZZOOdeu8C3NmCTMHcZ0dGDBDHoOytQ06XbklnoS05jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786082642; c=relaxed/simple;
	bh=8VqW8kvm6CDSv32ZJLRDHAY1XXBUAN1d4rtNyqZ213Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQ37vf7wfZCL88fXzV6tJgjBs4KlD5NxsRJkKRbxJ9shzWpEV7XzDFTdCp5Ctw5HwnSOFPJfMIxzLg0cgXX420INKncmjDY1+eG8K18fN9pEADFNO/vedQh1mpgKq21G/e1EOOcM7loyna9k1qRru7eqQOPFJZVPtawBIqYosHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci4q+NY5; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci4q+NY5"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca80d708489so1239359a12.1
        for <linux-iio@vger.kernel.org>; Thu, 06 Aug 2026 23:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786082639; x=1786687439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bi/ZTEuo08hf/a8t6fkw1rlM/UqizQDgz+QeGcjEPh0=;
        b=ci4q+NY5X9IteROG4EyGRrouCWQYb4ATyd/iVms7qKMCmoK1euwuOAOTRY867Ygt1e
         8F83rivmgCmNYQrLpYmGeYMU5+Xs8/pQnTHEQtfLq5xkvgQkol0S6El63L9TWQXh9kku
         jUj4f18hS0XG+knHsDgJ14cTbjAojRcIDogat4jhDEJa/qdiLED0/Wj6hEytH24/KiOt
         l9Q5bflxFZ1ygOsfN6T8z4OzOg4ybMdoR31idU7RX1u/bqkZO+Gy83jD7z0w3j1Xk54x
         Lh0xMh+Ha8yCJZcixa5SmE3QxjonCiTwP/QMCFdiZb8ClWkSo0YXOVn3Z3lAi3ptE6BE
         AAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786082639; x=1786687439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bi/ZTEuo08hf/a8t6fkw1rlM/UqizQDgz+QeGcjEPh0=;
        b=YgS3trTSF+syg+OAXbahr4ZInmce3izv7B6dHtQ07HiKniLZubI1Kw0qp+jhfYQCEp
         V1ufBH8gsWSrY/MEP8tUk7nG+6sppKIzVdUX6S+l57qh+paXpKuV8KJq02qJFQrw/Ftl
         rX8d1U8HGpk+iNWUrQH7wwh+jjws1rNHHuxk69c532XaLNQw2SAcNt+qfT5xMlvSDh99
         Svv42HkQsgsrbYVV7QSyXkyRL7llpyramPX/zONjaqFb2yzZwY0/TmUgLV6BawFRV5zF
         SWcPDxQUcU9PJ+5LZMpDN1X5kTi7x83NylsSJHd60CNX+tdDebMDBfvVGsf5Gd1g53E9
         uVhA==
X-Forwarded-Encrypted: i=1; AHgh+RquKafCGfpc7iidTu5dQMm3uU3aOJdI7MNGU6/fT4UR9RG5S6WH4si0pLZ4qrBQRSDEuWHPBSuHFJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxQBoQphoI6Ee5tW/AC3nmqyBkZTfgpOIKogi1gBJ4PrvpD7kT
	d+QTNJjVdo/cH8pi1q7KEC9OXg84PvW/eGSaT5GAkhZoI0VPoPStvBll
X-Gm-Gg: AR+sD12RO0ztEf4b8iaSUUGP8RHeJtlAph6M7WNXP2MwtZFTZNzA+P6psWmJuyvHTVH
	UomuejCTBQ+sytbQTHeHsdllcKK27Wxn2WIdRr8nu3CA0Lp7LxkfZD8cC3xglFwSwa2nZBdTK97
	KQA9H371vidAgqygtSokkebLAOAIq213lXk0BFSdXITQ2y+oa+cFs6dqiyncqRXpHMCrwD/PCI+
	FBuZNa9oyElZgP6XbiT7Emuf6jVM3N+SlkUtS6pAfWZRWfMqGwiGiKvWgTFS+03Ek4ELXgFxxf1
	q9+tcjl7fQQHNVI3/G2ZSXao+noYbDVwhlnaci2bdNtcahjIFo/+wUu3aiV2N6LW1i9NAF4hWMh
	qFHef0o1GOm7ovj5UH8Z6VD0IGtg8TFIhq8w6HvCbNUJGJw1385W6BN5aDGqBDj2Tqak/7GA25W
	pEu77U9GaOMdxu/KedxfTnAeoiQ4kMZBnm3/hhSD+y7hOBqzwo9LVsMLjkjyAv38PNv+U/zV6m1
	YX25w==
X-Received: by 2002:a05:6a20:12c7:b0:3c3:75c5:48d5 with SMTP id adf61e73a8af0-3cb9c071bfdmr12830008637.4.1786082639405;
        Thu, 06 Aug 2026 23:03:59 -0700 (PDT)
Received: from kernel ([45.251.35.98])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141019b4244sm3635471c88.4.2026.08.06.23.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 23:03:58 -0700 (PDT)
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
Subject: [PATCH v3] staging: iio: frequency: ad9832/ad9834: add comment explaining do_div usage
Date: Fri,  7 Aug 2026 11:33:48 +0530
Message-ID: <20260807060348.6477-1-raizudeen.kerneldev@gmail.com>
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
index 33dfd723923c..85f39ceb3c4c 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -103,6 +103,12 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
 
+	/*
+	 * mclk is an unsigned long, which triggers a Coccinelle false positive
+	 * warning about using a do_div() for 64-by-32 division. However, mclk
+	 * for this hardware will always fir within 32 bits, so do_div() is
+	 * safe to use here
+	 */
 	do_div(freqreg, mclk);
 	return freqreg;
 }
-- 
2.53.0

