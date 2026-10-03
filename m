Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D431E106
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 05:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791006831; cv=none; b=ptgCF7jNdEUNCNvAeL6BZPbcuRxC19JZJ78suOAuraog7zh1yYh0nb297d5Ux6nMeE+tnOy7QRmz97Wo4ATjO9fbhfKe/s7VR1+JvasGqnzZqLsskuW5DiSzRNfrtmBK7pRoIZWsWQGnt4ROfHcHed0pmZqygcs4PIDyjvcAbtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791006831; c=relaxed/simple;
	bh=bgkVWI9xXLd0nO8KTFTzylCKcdnG7XdCgRt6hDnHG68=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nenDdnkVuPEWI8T2Hb45j9smtMiSy0Qa2Y1xs1Ta1jGHDS6MpPFjAjIkOg8gtyBD4ZK/aGBPTVEw/nWrRVr3hvhiE47XI6vhBb65iNxjBgCXF0nSv+24bnw7sxgLtz3PtMopWnhy3SvV0dgYqExQ9nSwtFYDNMUSLQ80JhWnD6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LGRlZfNB; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LGRlZfNB"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1460bcc512eso25700c88.1
        for <linux-iio@vger.kernel.org>; Fri, 02 Oct 2026 22:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791006829; x=1791611629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bbzqWeCGv8CWYCDqlKs6MMVA3wQh3Tzas61qMifSYnA=;
        b=LGRlZfNBWvNkacOCQmfUbuPFLkcur7i0Zr1KAxTgeI/ucdAZ/dmJBVD3Ay7AlUBUDn
         ODlGqi4s2IebXQOefn61KpldW++iNd9COl5RVztnYeAYf8F6CL2WudIUumvCwL9raVAw
         ZvwpU9yZW/CNRCrqERYR/uhw52NNrnbY3egpYU/ekw3laqCnOad5Jc3iyFlRAv4kpiTi
         gcgw1A2VRYOCsRkyob/IazpU6BHOOxdSea79VaweNvQE2QoOmyvzETgPmjtrKQyLzwxt
         ZnnvBb9Ef4IB9+XcbVSp5K0AqpH/9xbWWBvcS5ozVJHUW0pk2fb6tAK/kIOxN2J+onRL
         5FZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791006829; x=1791611629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bbzqWeCGv8CWYCDqlKs6MMVA3wQh3Tzas61qMifSYnA=;
        b=0C9sM2trmjBZC+emUwn4bqjCcYl19UF6uYqg6O8cXPYiT1BFa90YhtpyV0YFwbJhhl
         fY4Kj3u9rLRvug1Mcxib50l0zQKO0F33MI+PRz4/zU1j1myg+5kJvr0l6ckHooRXFSVE
         sLnf10BaG7a8jPoyyjA0KJhjLY7Rcz/DsXytuc6TClzylcRQba1Q7TXZb/31xG2ke/cn
         m8bThOmETjRPivQKMkN5cbHwNCTRh15rQ6tK6Ho+7L8rBoc7WGjONGxGnMxPj8ue7CoB
         G3V4FXZohwmg8APXY1dvhPRQJzf3vEXplyxh1ahKmdHwkI+edPzWd7YWgP7t3cLx06ir
         RUhQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQURk6oNIz9HxNQ/fYB820lLeWavMCvvv7lM+dPebpiU5+kCcgLpsTv/lQcLdIqMHrF3e14WCmPwo=@vger.kernel.org
X-Gm-Message-State: AFuF++kekaYKcSi+FP/H52ZA8eXEXOvH0jPQjA0dTSiwE2WnNnfkZ3C/
	urqmNHuByHE99uus+jLbDu4kaIf/tv95zFQZRIL8oByiMCuuBhy1LKo2
X-Gm-Gg: AYBFou3eyf5iYNkUAlrrboEH26ooDpR8tfR62+/2G00HmLvMMPlBrpAYuCrYFEDOe5e
	tZJJ8FPguEBUsAeTFgt0yPIjDEpE5AJARKm0RNyAi+yOGnVNGGEe6Yjwp97ELRLMFyrCHMl+84n
	q/FwOLMgnyzLDJknPhs9zCdl4cWKPEy6xQXuL4qtbvQwGBzcO4+hZqmffi6yQeeQpf3nPncQ+WI
	IGX82jAEDzbKM0JNfbRn/Vf7/MX4anCInHhI1UpcRsZ5Yt5fzNSFxjtXYyRhkvPbx7Y7qEFLbhW
	7PWVHICeqddl9RSOFvXBqcrULiwanQ6qRN/JK+6ftHRz5GWYXsQlXN9AQAubINAr9QFOEOM9gRE
	CpCTkwEeNDOpBZ20iobgk269BsuzyMtHsDlp/q21J1AXBsj50tFb3vYmfyj7Om0l34nPmCuCK2r
	qFREnXkPzUnykqBSEvl9qF2YIYNgvNIYwopKd9RLGbHCZLR4/vAar58vd9l6OkymhoE479x0kOH
	JtVVze5vr6etCazrstXdsvk8WPf8X5IIvsxoxNrvVZ94nbwnwjoK5HUYONBrWFEkgImjwyn6oLF
	o3ZhD8erGLLUsTMl
X-Received: by 2002:a05:701b:4586:20b0:138:4e43:6399 with SMTP id a92af1059eb24-14f5bc00817mr5463175c88.11.1791006828933;
        Fri, 02 Oct 2026 22:53:48 -0700 (PDT)
Received: from kapoor ([117.235.138.222])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fc39a6cbsm2720364c88.5.2026.10.02.22.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 22:53:48 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Nyekjaer <sean@geanix.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH] iio: imu: inv_icm42600: drop stale vdd_supply kernel-doc
Date: Sat,  3 Oct 2026 11:23:36 +0530
Message-ID: <20261003055339.143977-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vdd_supply member was removed from struct inv_icm42600_state when
the driver switched to devm_regulator_get_enable() for the VDD
regulator, but its kernel-doc entry was left behind. This triggers a
W=1 warning:

  Warning: drivers/iio/imu/inv_icm42600/inv_icm42600.h:186 Excess struct
  member 'vdd_supply' description in 'inv_icm42600_state'

Drop the stale line.

Fixes: 9fd569aa3d70 ("iio: imu: inv_icm42600: Use devm_regulator_get_enable() for vdd regulator")
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Comment-only change, checked with scripts/kernel-doc -Wall.

 drivers/iio/imu/inv_icm42600/inv_icm42600.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index e56943931b6a..3737e79dbcc1 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -151,7 +151,6 @@ struct inv_icm42600_apex {
  *  @chip:		chip identifier.
  *  @name:		chip name.
  *  @map:		regmap pointer.
- *  @vdd_supply:	VDD voltage regulator for the chip.
  *  @vddio_supply:	I/O voltage regulator for the chip.
  *  @irq:		chip irq, required to enable/disable and set wakeup
  *  @orientation:	sensor chip orientation relative to main hardware.
-- 
2.53.0

