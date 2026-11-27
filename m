Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795782800;
	b=a5EyaezPN4R0dCwueM2ndO4aeD7PXnJkXaSy6p6TfVJk1tn+rI3x0r1TZ8f/lBozCnVd
	 ctxXT0B5eq7yAPxS4wz42JIdENBryokSSyLqYz6Y/zVxiiO01dAMTN/Q0xJ+fC5hyPlJV
	 XM25rf+7Sju8lDHxGYhdX8JwwyJ4jsI38qLSexbX/SJTPJaJzt9SXBikamJgvNPbbxkxV
	 Lw/tBBHrmuwSeeadzw09S/Bw1O10kyGHICrvZWw0hDzZ8mKPKIZOld7l6GlFY7cFSFX+7
	 i0X+n6/ulZBTHv2cMqmjXkvR8fTtcp6xb+F7ROqBdRcyixvBVV+PbbIvQEZ4soMLHDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795782800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PMxsfU1o3NhAxu7Ye8pNPHcg1ClzXw9Cf5wvYHFfgpw=;
	b=HBDyG3QSrY8J+dCj9nOwfZduBlJXdDPd2Q+j7zgHB8zoNjfGttcQ7xRogoDAnZ9zCN+/
	 nFrFol10XskRhK+CzGHyCBFu9udN+WFY6YxBy2yRK4cbJrTX7r3sNaDbDNTJxJrZirWmt
	 9uZrehisL8GpsFGbZ0mcVF3KBZkNumiM2Q7yDjLCDfLUuvYrvb6ZmPrrOPF/wJ08saj4D
	 ef5+n80AKCEwplIsj5+C7l/rBwetO+GaSS8SgXvEOV1QkGZSiUVzArNagxJy7ENmRL2+d
	 rYUrGaxRaFsKOZA7EASmWM6QX/v/BBiJCVjEyaQW+xz/DIjoCfdfkMy+nfTV8SMqpYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CiI8vkqb;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CBD606A31E
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 12:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36CBD606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CiI8vkqb
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8d2d4cdb478so271468b3a.1
        for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 04:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795782799; x=1796387599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PMxsfU1o3NhAxu7Ye8pNPHcg1ClzXw9Cf5wvYHFfgpw=;
        b=CiI8vkqboT3TMonY5QV2ElBF34ePhX16qL59l3wBDkVX6fIIdSuBdDKaM7YejNAq5D
         f9gFRIKN6doMjnP+oCyJAbJCNQ3i8fCgxPAXq7CK8FTR3mPmAg8CScTg6f7ZdrVuxgF8
         +3He1YDl/kEcfTLXEpmruajIH0NUuJcfq1v0ODsMMEhBIu7nO4S+/yi2gr5qOeY/2bhL
         eRM+oCk1hwYAxP3AotWhUG7fozgK4bIpiNixXMgypu9k45Y3mPR4DeO4jYdbUQQm4YFd
         C9g9E+1HHeR/42axB1ZbJ+RpH+BB3XE6sT3e9kd9aORXg0N8CO5Lm2sr7QzDLvxza3R3
         Phgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795782799; x=1796387599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PMxsfU1o3NhAxu7Ye8pNPHcg1ClzXw9Cf5wvYHFfgpw=;
        b=tUUCd/MfF/FmU0Rsj9oNAYN7Bf2KTztgQpTSdBNp2d3rb61V5RYIyOMRi8yCW2zr1+
         sUFWS4sSWdIAcldanVizNFr86DgzeO0b0CLcYdZXJROIhqjRBkW5FVa2SJZgBVCuolo7
         15t25MTCLCVR8TrkvIu/Kn5H21KUEwG9bRapvLkButTediPGzuMbK//EB7ZiqSm4Z2mj
         fv0U51CI5oqfGL1RfE73fB858POFaVb8RXV87q7il/hz3ZXI2o1+99ITI68nl1lTosoR
         pfWgry+YJ6ks/bDAu2xyKy0uu8D9vL5szkzBYS/YFB+RtVMDSZxadFrsfHJ0yD9rjgc/
         bHpA==
X-Forwarded-Encrypted: i=1; AL+hErFbBvBBOmjO6tMg+4OfltbvL3mC2wEX1tlQ6qYtQmPSWzpywLrpK/6LjizA4/WjEPvJUkNvUVG12pI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+tbvWMfgkJZaMCPlvzMVlQa7Jpq2DPZ0ytsS2KHVv7QYAB4c9
	HwtkFlGeHfP1kQfFv1nhmSeJOlNE+HvMU9Wbqtbp7G2qT93bkpEqVEsk
X-Gm-Gg: AZFdTZeKFZicYYhoBfM79mu81/AT2tXAiYP8+34Gpiqs1snNM6G8+0FPPXqfvPeYudG
	BAjTGt3gm35adB78e+OfLTBYoNHL1PMOKxfWeJ8/+IdRredIRH3k13SbR+O2JeUS3Z5kirZXukk
	8DEeWyYTGrirCDX3OXy3IQsm30TIJj94Z6g/tIBarF7vTaGdflJ0ATnLfJwYPraRHtNYPeUeJpx
	dieGrjpJq8qLuPphv65orNTHD2A511X740loxh+FRBwbLV3kx7Y0Jq7jgQqfBdoTz//XsqFneJk
	A80HGoOOXfFh54SmAKTZUrUXGkBoncCcto6MszVAJrd4Xop2ldC21o8kz5rt1cFb9gSr+liH5Il
	ctNMJ7WvQBjXOn27zrMmwnT5ufNrSdBVx0nsqRZYPtbJ+UvAJkssGLl2eiKx9VVWvcO5UlQOJet
	DlZ4SskSye597y3Vc3dVu4sFcutXL/l+8/B+m1u/NMUY7XZGBs9WrYHUGf7XDD2datwdPp0Bo5m
	h/PRNKWE5LqH3Cr8WvxVzIUW41QaOIzfJu2gtHCJklCpmNMlqrmQuoFEzLax2zLJNTo/8rDRG9y
	QljDN5CmIuuzdVyfr85tFNGEu4phQiMpugP946cDzGz0+MiIM82vUnt+DgN0e+Ca948NMJdO
X-Received: by 2002:a05:6a00:4fcf:b0:8a0:5d6f:8a5b with SMTP id d2e1a72fcca58-8c87d70b055mr23096959b3a.50.1795782799462;
        Fri, 27 Nov 2026 04:33:19 -0800 (PST)
Received: from localhost ([2401:4900:1c2a:12da:3176:e694:92eb:c932])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077944bsm12568899b3a.2.2026.11.27.04.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 04:33:19 -0800 (PST)
From: Punnay Sharma <punnaysharma805@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux@analog.com,
	Punnay Sharma <punnaysharma805@gmail.com>
Subject: [PATCH 0/4] staging: iio: impedance-analyzer: ad5933: buffer and sysfs fixes
Date: Fri, 27 Nov 2026 18:02:59 +0530
Message-ID: <20261127123303.144052-1-punnaysharma805@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Four bug fixes for ad5933.

Patch 1 fixes buffer data when only one of the real and imag channels
is enabled. The driver reads the wrong register, so you get the other
value and no error. This has been broken since 2011, so patch 1 is
tagged for stable.

Patches 2 to 4 fix sysfs attributes that don't match the chip. Patch 2
rejects frequencies that overflow the 24-bit frequency registers. That
only happens with an external MCLK of 3.2 MHz or less. Patch 3 makes
out_altvoltage0_settling_cycles report the count the chip uses. Patch 4
keeps the old value when a write to the chip fails. These change what
userspace sees, so they are not tagged for stable.

I don't have AD5933 hardware. I tested in a virtme-ng VM with i2c-stub,
KASAN and lockdep. The stub can't run a real sweep or give real ADC
data, so the tests cover register values and the sysfs and buffer
paths. Each patch shows its test results after the --- line.

Every patch builds with W=1 and no new warnings on x86_64 (gcc and
clang) and on i386. sparse, smatch, coccicheck and checkpatch --strict
are clean.

I used Opus 5.5 assistant to help find these bugs and write the
fixes, and I reviewed every patch before sending.

Punnay Sharma (4):
  staging: iio: impedance-analyzer: ad5933: fix swapped real and imag
    data
  staging: iio: impedance-analyzer: ad5933: reject frequency code
    overflow
  staging: iio: impedance-analyzer: ad5933: fix settling cycles readback
  staging: iio: impedance-analyzer: ad5933: keep old values on failed
    writes

 .../staging/iio/impedance-analyzer/ad5933.c   | 35 ++++++++++++++++---
 1 file changed, 30 insertions(+), 5 deletions(-)


base-commit: 39508411b82d4dc29dd245bb471ec9ecc1111c9d
-- 
2.56.0

