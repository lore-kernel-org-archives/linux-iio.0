Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4B117DE36
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776623815; cv=none; b=J90v/2nOqUKn0u3M6KofZEHqGS4l3CXxMTBwwYC69h3Nu7nSshGs21P4gNrJsB6G7AMDnUuXbsvOdlc2yU76tYdVnBAUo1z2j2RQ2Sf0IpgifexkTiHYG5yRzmPj+QeSkSHY2EaM37w3Gn+l152aOItYomaNLvLkDbVUwpzuGCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776623815; c=relaxed/simple;
	bh=Ml7XosIrBBKLKpWQBPoaiYRJ3t1ahlKXAL6Z9dGB3+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=geTRjXbm5fJwgZyB0DUwHRhNJW11eLiq+FMScb6dc0W1mfE/nh+FOZ7Hd75/M1r1PzEMdg9IItCbjRbFqOMPec0gOmU9sOylECniF8M2tF8CYvcKzh1pIqNRCG8KeRS37L2l9M41U9q0rNC6ezfEVEkhj+ku2DuSjES3phZL/6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pkpol1f2; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pkpol1f2"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488ad135063so17735205e9.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 11:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776623812; x=1777228612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QvxSgscLgfqeVV9OXyq74ThO6l4kdBgNKvvMtYF6vPk=;
        b=pkpol1f2LeMhlS8TvpGfSIle5zo4c70TeZPWh0iM4yZ/SZZ8lkY0Rg1B7b3ncnc+rY
         sYxCcXPeqv2Bx5ETAHdhrUSOvCW4nanbeMh40c3zJxhOviPqUaJLrv568xnRxyJUltlH
         zRfaywSpc1o4PTl2UswnQInD5qZgmHXTe8O4PjjH6gy0qguLDDg6bM/ZjLdhNUJuwVW9
         XtQ9J8/NxY/eM0py1yPn4dPeH/J7yWHj0hz5MIQGHYbCxnTXjDprzV++4aB4Fdq67CVW
         yGf6qQH3LJubfDNTMwv3nk+hloZvmQP7RzM2w1gLtoer/42l82fZEXzmYe3wyCETKOaQ
         BLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776623812; x=1777228612;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QvxSgscLgfqeVV9OXyq74ThO6l4kdBgNKvvMtYF6vPk=;
        b=XWepw1a8YoRwzjlLSFhwGWYMIfcUyPGoMKNjpbvJr4kpbIN6OuxvWeHgxH+Glhhqxy
         kx6RtQgo+SnRM7+TeZvxuFg9DQDfsZjQ7N0JrKBpJr8wyeyLs/MpT3GJ+QFmXib6e1EY
         bnJNweSq0J9MZr7HdmgyMPnSl3Z9cNvkVMDaFpQ4bHLvw5bDu/d0EZXXuR7QlWVRD8d6
         O2wHCVCvJwjwa7tjoqk8BeK0v/AAuWnERxJpZ6u698flM/CuCxy2aohtqFnTQf3+KkRm
         JBKJN+m2zOYcjaiU3apWKvFB70Jv9t7nGYY0ZtlQcLqWYKRKvqT0U4Wv56IJWol/NWQs
         T/qQ==
X-Forwarded-Encrypted: i=1; AFNElJ8IKD6Nkx/t2D5IoQQERaUMPQylK+JMUi9yhDCL+Tfsq2RwwVI+S8gSDTR5bRQwU1bOW7OlLVhWgsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD9w2wUNL1KW6fJif0Uez2OFxj9yhvVlbOflGUJ7OlKZ5myV3I
	pbC9Ryar94Lt2KQS7F0cThcWG+B6HLLPmmPySsnF0IO317hxcqqyVc/r
X-Gm-Gg: AeBDiev94l3xj3vnModC6osfLc/RgxxKoPcK9qK6nACQOMhoNArVLuPmCzgwxd0J8Zg
	iIxcLpiQ1tkvb3u9stfjfLQvtwAUgli58zd611dx6mziGX8Uu3xxanpEPnQVu4WyYqs6ssipF9L
	+78YyNudCwhGz7Ny7ZdaBIMDkKy4hc65v3V23+DwhjZX0bK8vH8it8SxQf3JvbmnCnxXnSvc2+R
	AlxCo1YrhUpC3TOpoVqihkOItLH+XPc0u0SotJboclL7l6/ma5N/m1WNxxY9htK5Jx9CKTSePdg
	mv4xUAzxoNCYaLR5Hg9LC6yazFrZjCH1hcdgoYKtyGDq3qj1VLkM6o9mOvh1WQugZkGy3XyBCJR
	qB7TtEFZ6sCx9Ptt6suzhB4cn33bWx/pu8eGlD3JdqOCjnRjLrYcWhpZNSb8lrJ80cYks2xE4y4
	WSKKC0jP8jPvZXb2CPudPoa7IrObnO0pIcxGeEIjSsNwLXoxa7X3C3Te2xMzsBp/Ee/+JZA6zMc
	+GAV5+hKmmQKbqYuKkKXqpDI+N4vUFataFv77lwccKJWo8c/yJyli5S/X+l6gUMnmmJk+T0aXNs
	H7i7WyEJEfITBTHSFb0YVk7wNhm/+TilnTXC3CO//RXwsY8A9kk1crbj6L5EhwkwtpEerfsvb0B
	M17x1LaHJ/Q==
X-Received: by 2002:a05:600c:a40a:b0:489:1ba8:5bf0 with SMTP id 5b1f17b1804b1-4891ba85dc1mr17847125e9.21.1776623812086;
        Sun, 19 Apr 2026 11:36:52 -0700 (PDT)
Received: from localhost.localdomain (ip-86-49-249-181.bb.vodafone.cz. [86.49.249.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891bb3d121sm49407265e9.14.2026.04.19.11.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:36:51 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
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
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v7] iio: frequency: ad9832: simplify bitwise math
Date: Sun, 19 Apr 2026 20:36:23 +0200
Message-Id: <20260419183623.86587-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Refactor the ad9832_calc_freqreg by removing the redundant u64 casts
and 1L bitwise left shift and replacing the multiplication by a bit
shift, as multiplying integers by a power of two is identical to a
bitwise left shift.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
v7:
 - replaced multiplication with bitwise left shift

 drivers/staging/iio/frequency/ad9832.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index c0b7852f1c..659821a1e2 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -117,8 +117,8 @@ struct ad9832_state {
 
 static unsigned long ad9832_calc_freqreg(unsigned long mclk, unsigned long fout)
 {
-	unsigned long long freqreg = (u64)fout *
-				     (u64)((u64)1L << AD9832_FREQ_BITS);
+	u64 freqreg = (u64)fout << AD9832_FREQ_BITS;
+
 	do_div(freqreg, mclk);
 	return freqreg;
 }
-- 
2.34.1

