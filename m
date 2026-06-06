Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD09C305057
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 04:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721895; cv=none; b=Mgjtsq6fQKsj8TDfDLD7YmzKJc9IY7tk3geK012VYJdWF0MbATQKelLov6HKAKsJ+3j9/vKhNRqzqTWlMNcMNkMuM0JXknKYXyAaWxx45m/WA9miEn2YqayGfqKWUQ/oFY5vSil3NyGzpi5TlrBZTOc7cbCGac3Cvx2Oirt2vwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721895; c=relaxed/simple;
	bh=TwTMH444TQxyNANvjbKliwqB2xUrF4F6rItPqPyQfQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nCo0hgv50olOfoqipQZAonSBSpkviZn+3juglI+MQgfP3GhPj4GPNfGG70r3ksIM8G9BnM3MADewn0ZdsqsF7ph0NbpV5Km0A8bKBlqcJLLmpzYPgVLYiyDl7ruEM/GxflLw8U2SYBK6tq4C55MLLUz6Bm2Vod+uaOUSwlSowz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJj9WjiX; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJj9WjiX"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68d232e119dso4217467a12.0
        for <linux-iio@vger.kernel.org>; Fri, 05 Jun 2026 21:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780721892; x=1781326692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIXOvbsU7+o0n1Qu63VvvDhjmq7U5oR0cXTC0wZz+Oo=;
        b=YJj9WjiXr43PEAcbIaLfkvdprJG+MiDLNcOh1yMpwgG2uNq7XJtBRhk08MJASekLay
         z58rrhW47XSdwDTuW5ifeoNXDeKkIWu9COyB9zIShjRTs/SOZqD59C1e8IMGs1GAidUI
         8d496OhP2+cvrDr3QhPgj9UnWD8meVa+KxP5Fdw4j4Vi2LVuZtjpG+eMYbjjJWH2cACY
         6aj4mDbQ7Uf06nPfxHRxguoy9kj01jtphW0nbyvfb2RVILzpcGFVCnjHoH+7aiVn1//W
         2cEfebvVPo5AQEFd1tVeTnVyGsLx54cTq6MDVKjkaz53PGiTEeX02wXPbe7CUxiCzgwf
         K/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780721892; x=1781326692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VIXOvbsU7+o0n1Qu63VvvDhjmq7U5oR0cXTC0wZz+Oo=;
        b=lprH/qxnKz73G1c4+0NSUdPspol1JQ9uFEOzz0q+hJiZT8EK/mdCaodh3Pz61y6WOJ
         B1DiusEaS3z9+q+TYzXua//Xt/NTq0VtK5wOmV25FcZlHHVmyLLRMC+6OP+Hc2MfX/pk
         jbu+Yhrf/nhUlqI8M+fZAY4xpl1QUuIgAh4iwlbXZuT6n//ok8FpCA+lLawslaSY/z+H
         lRNl4XFLGQwjznnrXbbHKebYY2y2WeFRE4ihkQpo6KFjYFInR5krJDVxoDQS3xSjEBne
         fRN+N/aQE/eKFTF/BfgFhUPzfcscJ4zxnc9DGYMdSj+KXtO17k31VmZ5froC327qQEaH
         1CZQ==
X-Forwarded-Encrypted: i=1; AFNElJ+e6CNEbSr/NIlq99Mm2vUknA4YFKZtsS3119KbCMUP6x4+dqv2TRBbQM0J4cAOEpjp7OjyTmAPEDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YynVr0JyO7wpxQmJp25ne6VZM4YbQ/pvkD/5FvhTgHHHCysvOOm
	4GooD4fz2Z1juF8H+KuFBLmMancs31bnRNcKB4sA533bOSioczvIbx3e1FBhtzUx
X-Gm-Gg: Acq92OG3zOwzPswsohCO8JVx5YqRb8lvhjE3sQBlbD3BppD1PmK5keNqNDeP7atxCp/
	yxjy+/0vNR08+KeKzCTnWTT6les32x4m9xSrKdajlRvq7m5w6wS6AEXjQOhbhKUkeJB2ApoqRQP
	x5tOPIXRDIgGMrHn+2t1G2s9Mt+avMfuYDZ7RCsmAVSVJLCIf8WEGdZOph/LNyHyAPjYJihvPPZ
	+ZRVjUaBntx3bbPP6lLymF8oH1fnfz8pwO6Z0d6m4TDdTTayjevKfHw/v3wadVkpyS7FBlYooUA
	TDhkTBVw9PCw4b76fIqwT36ekMKVBU7g+3oiWcnbNULeREjUAJbKR0NXhvOnecE2dn5ODIY6blo
	jRw1FC0ivYky5Bvf8q8TfHIQafaMFB02FIGfnuQwvnhf8IUgumTRvxBzpKkXx/Q+cpYWXpi+0HF
	++pYwlVC8j0Z+DYjloopozCUtf+/w5JV06eA==
X-Received: by 2002:a17:907:75c2:b0:bec:db41:e4ae with SMTP id a640c23a62f3a-bf3737ebea2mr248152866b.43.1780721892058;
        Fri, 05 Jun 2026 21:58:12 -0700 (PDT)
Received: from xeon ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 21:58:10 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v4 03/14] mfd: lm3533: Remove extern from shared functions in the header
Date: Sat,  6 Jun 2026 07:57:27 +0300
Message-ID: <20260606045738.21050-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606045738.21050-1-clamor95@gmail.com>
References: <20260606045738.21050-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using 'extern' is not required, drop them.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 include/linux/mfd/lm3533.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
index db0a5e5c9e39..aab8f08dfcb0 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -82,14 +82,13 @@ struct lm3533_platform_data {
 	int num_leds;
 };
 
-extern int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb);
-extern int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb);
-
-extern int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u8 val);
-extern int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u32 *val);
-extern int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb,
-								u16 imax);
-extern int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u8 val);
-extern int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *val);
+int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb);
+int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb);
+
+int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u8 val);
+int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u32 *val);
+int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb, u16 imax);
+int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u8 val);
+int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *val);
 
 #endif	/* __LINUX_MFD_LM3533_H */
-- 
2.53.0

