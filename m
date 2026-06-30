Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB1E331EBA
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 03:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789813; cv=none; b=cFKhFFhEZ2kyAPapwcOltUBM5hY+3tkzppOu6mPC/b8lYYDy8BgK1rIU5vCcKJ2+xjdBKGX9GfnpJGRM9EBMNe+9VddZy9N1tVeSlFMZfhj2ZJo7pigktc3sHokLBvn96DWWEOFhI3r/RfK3eu1riTOBkCR4L/qYT3OkMJo2HE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789813; c=relaxed/simple;
	bh=GEWQmwoNCJmCwgrNxAvDHtsa+YfvsbHxx8LGeyKpryU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=myHyR8yevueiOnPA/gLoN/lxGAXp+Xom1CM+Q1xVUP4mDNjTzarL9QsqZdO7pGymjxxJgZ3X2nagQ3GT98UZNnLnZ7T599fzOmc0UO1cxvDjALpeWRg3ynZdpesURprTfYRJLvVsEJkKBExC+OTewnC9L8ZKj32MKm+RQMsln2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OVmNhgxc; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OVmNhgxc"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-137335bc3caso8270345c88.0
        for <linux-iio@vger.kernel.org>; Mon, 29 Jun 2026 20:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782789811; x=1783394611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1N2TEaibcJ7GIyHQYkU2Fx6MeyHpeL+NE+JylwXxFFM=;
        b=OVmNhgxcu7YW3GVPLv3VsnEDcYXAhusuiEE3OBaqVQ3gBMZSKF2qQmYXsz03Qtwqrt
         mzGO0zfaCRt7K6V8dsJegLHb3j/HPCBrbHoUtjvK8a61XTMiiWvdVfu2v5bbsKwN+bwT
         RMYi3kLORfyHfUlCTknPixTLZdMp5htS2ZY/OyzuFDNZ0nFd/nKCcrap5jhvP5+i/HVr
         h6sVlsVvCr1J6ySpF5lw9GuuT2kfyCGDgwxwesfmfc842jlhlxetNGMrRrKw2DVonu4Z
         Y0HCY6RWo1Khb4eVn20oUtLhjOYGLLT3pR0InvAirPMGTL3De/zKvnm0vywQwLVK7tpX
         UZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782789811; x=1783394611;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1N2TEaibcJ7GIyHQYkU2Fx6MeyHpeL+NE+JylwXxFFM=;
        b=SqCswsAjiyf7BYqpqKklggTXQoJdQLFeerjZBTKLDUcI6JIPDNKufU6hzBkNHgBBll
         9k8xfa0ndnXsR5UouT6L/kjglc+IXMCc3WOK5O23bs5HmOB5p7MSkqDxSTtAOHXTYKln
         RLJ4Sdk/wYQY554r5za4PhKxSzD1lha0fwkEjsZVgJ671lC/ayD5E8UHNklISjJkKQCQ
         HAuM34qlLffEzx58i7d2pC82YbfXMLs/nk54j0MLLE+PIEqyP/n/QZiXlLLsNxpFxYeW
         GWkLZM5upc9fka7AISjt6W+1J7E+1y8vvbQe+jFCOhm85v1bAv6BJz/D7OOY4b3LoZ1X
         kB1g==
X-Forwarded-Encrypted: i=1; AHgh+RpzZxD8FgR6c0yD6D6aw7L9zhm2hjnChzo0M3KLNC6CWV5rfbL/8YPVFUxleLfFbgUvALolPnQBys4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkf7XhwABuduxEh/GPBy5IMeZL4W6T4iq9C5ror+YjY/qByH1r
	3zV/dUu4DCdN2rioRR5hSh3VZb7GybxU9umcU+wR1FPnpEiz1xzZnNed
X-Gm-Gg: AfdE7ckq8f5mfNtU4Smp15MJqeMnT2kxa6eg6V2s2POrLfu1TAVBQmS694Hyi+rr8U/
	/mKmURwVn9qCq+NwXrHBLbo4IR12SE0KgudK3KZ6WF55kTz0T3yR2yFXRox7wDifjfHQ+lKPCzp
	ivJBC7VMitgqkAQTGwiT+TFM38w1DrstmNPtioTyGBiuby5gSUQjmgYTtq5NijpT1Eadwf46uV7
	p/ULD1LKqSl9jx4Utgr1vEiWMxawSbxKISwAI84nl3XPyVR4PV+cicqYIb83QC4yJRheYbuEqQZ
	erXbf7X8trG1EnaokOSseVGjAnq6tW6RWRg3g7Zz2NarM2Rtb/sTX8o/spdTXp8aw5UYKoe3bPA
	nJHawkBy+9v2EYH4ga/UUJHpXXqMS7hko11ObmMAazNUovX8B1mO+6uY4meW1aGo2CI6zq9bkeC
	VI3mfXI4FXTYYkZSA/JBEqNQOwOz+NStxr2yc4ng==
X-Received: by 2002:a05:7300:a994:b0:30c:ab4f:9ba0 with SMTP id 5a478bee46e88-30ee14a4556mr1290207eec.40.1782789810939;
        Mon, 29 Jun 2026 20:23:30 -0700 (PDT)
Received: from raiz ([45.251.35.28])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2f5ed29sm2992571eec.1.2026.06.29.20.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 20:23:30 -0700 (PDT)
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>,
	gregkh@linuxfoundation.org,
	skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: iio: frequency: ad9832/ad9834: use div64_ul instead of do_div
Date: Tue, 30 Jun 2026 08:53:22 +0530
Message-ID: <20260630032322.5805-1-raizudeen.kerneldev@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Coccinelle warns that do_div() should not be used when the divisor is an unsigned long, because do_div() expects a 32-bit divisor.

In this case, the 'mclk' divisor is an 'unsigned long', which can be 64-bit on certain architectures. The correct function to use here is div64_ul().

Because do_div() modifies the dividend in place, while div64_ul() returns the result, the code was updated to directly return the result of div64_ul. This keeps the math exactly the same but fixes the warning and makes the code safer.

Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
---
 drivers/staging/iio/frequency/ad9832.c | 3 +--
 drivers/staging/iio/frequency/ad9834.c | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index b87ea1781b27..91df7ee65bfc 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -115,8 +115,7 @@ static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	unsigned long long freqreg = (u64)fout *
 				     (u64)((u64)1L << AD9832_FREQ_BITS);
-	do_div(freqreg, mclk);
-	return freqreg;
+	return div64_ul(freqreg, mclk);
 }
 
 static int ad9832_write_frequency(struct ad9832_state *st,
diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index bdb2580e29bf..70b310488237 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -101,8 +101,7 @@ static unsigned int ad9834_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
 	unsigned long long freqreg = (u64)fout * (u64)BIT(AD9834_FREQ_BITS);
 
-	do_div(freqreg, mclk);
-	return freqreg;
+	return div64_ul(freqreg, mclk);
 }
 
 static int ad9834_write_frequency(struct ad9834_state *st,
-- 
2.53.0

