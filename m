Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729045;
	b=HXFGSUKzRz5ERO6CdzXodR0LfA28qjuCEZ8r7tQBtWcxpl/g53z1bqP4p/hp89B4WQPr
	 iWLSq1BKudecqQGyLKjmUf8OHoD1YFHNR6wx68grwjfNHIMiyDNOFObaDSiT9XPOkxbP1
	 xexGulrQIhyDg/U3fz+7vXL+TPKRKiQGzsDa1Svu501tbiA0Vl1b7y+hHIO2LhqCj2qON
	 mQRyQ3cyjt4E5WeVcuyzffy7xl+3cmjBnwEIldCsCR7OeA216tE09b3vslxFeYo1OElcw
	 wQbi8PG9yPuskYT7Q+2biC+n/o3FmF2ocdwUmZQx3sqyngZisfwhQSlObooeViwEmpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=uP/6kVUXbVbhrAYhjj9kXY0YqJ9cNzkJI0NxOXhod74=;
	b=woMTCA50l7c3Zxu6m/SQzc/PRpOgWkL+rpxV7R0w229yMzRn9bkbQmb0LIEDdNpaXxm0
	 GF1D86IllozHPD2d4bQ7OvBOCXV5xciXtLNJnrGcIOalbHNCFi6rPDkt8n5YZ4MsbvmkJ
	 JVpKT5fO7NJk3brV4vgnbjEIJiUyf28GPXHcM9erNklkIm/P3W08U6zIzLSZTcuiL8N0m
	 Q6FuFwF/eq9pKMFrOAfNJotKk3OCPE1CSD+1X6UB3aZY9Fbl6woKGZKZ5cSRIItcGgRG5
	 /+qWZkWEfiR7E8wh8FXOlD+syUNhPmAwTyQ/LwGotqQKzl8Hg1Ov3EumDMDHDevLiWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bzvRbgNw;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275DC606A31E
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 21:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 275DC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bzvRbgNw
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cde7e8abf9cso2734873a12.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 13:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795729044; x=1796333844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uP/6kVUXbVbhrAYhjj9kXY0YqJ9cNzkJI0NxOXhod74=;
        b=bzvRbgNwjn251XThpHXsW5t0unYcm3gX8Be+ckcmbKuwdN9mJZI5U0edI5NQJAK7z9
         zS8VDCyiZCsceZh9tNGFJ+OBhXqubZbNQocHOCMiUOhf9VayirpezZ1+cSea0NKLqFGT
         gw/ricZkunTKMcx1zRT6jUwow5WRaaeBEHRfQlxBnR9jCNeJgrgszzJCjxlqna5QVC0r
         7GeBpbWlTmGsWHtuMHp1Bx8cM/8s+odqW2Lx1DqkaQJ7HZdd3oqmDuQ7Wt+ZX675MR7c
         vbZNsg1OF3rY1FCKs/gRvkuSUhQ+6HbLQhF6SiZNyv51i9uwj67qHdqWygGBJEDXOc1d
         87bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729044; x=1796333844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uP/6kVUXbVbhrAYhjj9kXY0YqJ9cNzkJI0NxOXhod74=;
        b=QFxgDKDRjXsesDRsYbbeY6Hosbba4SmalhleWg03I1nTtQqWIXkJaOXYp4XDwbo0oO
         /UXwgJMGT2KOx0ZLFjNegnsvkjHjpQlu2lthqcAPCq5Zo3D3kHz7+uyVDpbosgH0kePw
         mzXv5hHqXiFCEwHLvtl83T9R7H1l0Ri6c2UCkVWf+DLA9H8pJ3ooaX5oL2G+ErZ6Wo4R
         NaHerOtiL89nCvG/lIufDQve3RR/DRGeJ26Lhws5E+pOOm3EY4FbjKqtO7O+QQU1IqFL
         ql2xapzlTk0uYOxfvaXBK2Ir6JRQ6TFhRYpApz4lsJtpEayO7B+mcNxjRroBoT3N/y2U
         r8ew==
X-Forwarded-Encrypted: i=1; AL+hErENj+PkdTHxuUGgHZa86r1xs4IkQC9kVHaxBXeO1yu/IuhxWIsokBqmbXSbSYggLc+6owQDaQdcvBE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9hKDm8V537KMmHSpSnuipiV6Jlum2OgWNQX5whXlrHo/Woa4VF
	pHnhOtaBmliyfmzruGlITgZlj+3vi1KDLuQJkdPe/tGYS4o54u77OBKn
X-Gm-Gg: AZFdTZcvZXUzaeKNwpkQJtV7sAOgTQa0ekbGiPqW7ipP+Z+p/gSn4ZL98uDSomTMuPM
	O9SqrfeoivLPN2KBiVJpo8SZKmnZIWzDZWXYzsYsJxlj5LFcZ/kj547B4Gbl+UYswC5TypmwVds
	hDfLQRU+7sKBjNqfLurM9O7Oh19wL+EenoCQ/Mx+edgUbea2O0+CB329Ce2B7Sipd6ahKl6rDCT
	JFrfZZpdhDuLw0LLB/VoA+ulVmXLd74UTsa9L5NDErYpqiBXLqEQerH8dkd8fi+iX1xsOoPZbiB
	TT9wlyG7hHDtdY32pm1SAtR9z/vcc7kzqueQB3mNgniUiX33FgYx5RUUsxcQBlgtvsVoY0L6HLc
	iJEzvrqoxNcyGRWs0M+Od6lpEh5u+HJFSZwJKv3j3S0TSzPc3EeOiBtlK8hgZ9E1YXvmBC206WB
	+x3gx6JMxZ6csOpE/R1jAnSyLJeG3tUj1dEjaJNEAvrG8KwgsOZlhmJnvr60bvRK7c8J1FdFMUc
	jPQJRRsvtwHsDOyXmcLPzJhaZfScS7NKGhr7A5I9dpRWydCJrpEI3e+eb9VuFRuHxNPSsfOxzrL
	FLZx+Xs9dBiA79e2WKrgW5TfpoI4ujCuvKQ3wPKH2Gpa82F1fxfujYD4hdU5n/EgA0N1I+HGpVc
	syFZ647MfZKhqbOv3n6jCOKEOXsx7SpVvmyECCvuerhpTZmLpHEzWRmHaYVPlbj7tT68jfJdcTn
	TLHO1X4GzyQtMySH/6wFc58w==
X-Received: by 2002:a05:6a21:9d95:b0:3f9:f95a:7415 with SMTP id adf61e73a8af0-4014e45d163mr21654924637.63.1795729044324;
        Thu, 26 Nov 2026 13:37:24 -0800 (PST)
Received: from kapoor ([149.40.62.9])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cea7c38sm11703905a12.2.2026.11.26.13.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 13:37:22 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH v2 0/6] iio: proximity: hx9023s: fix sampling frequency, resume and event value handling
Date: Fri, 27 Nov 2026 03:06:45 +0530
Message-ID: <20261126213710.1047676-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Five fixes for the HX9023S capacitive proximity driver, and one cleanup.

1: writing 67108864 (or any value for which val * 10^6 + val2 is a
   multiple of 2^32) to sampling_frequency divides by zero: div_u64()
   takes a u32 divisor. The check added in a318cfc08537 only catches 0.
2: reading sampling_frequency indexes the 32-entry period table with
   the PRF_CFG register value unchecked; the configuration file loaded
   by hx9023s_bin_load() can put any 8-bit value there.
3: resume re-enables the chip interrupts only when the trigger is
   enabled, so threshold events stop after the first suspend.
4: out-of-range threshold values are masked into the 10-bit field
   instead of being rejected (-32 becomes the largest threshold).
5: same for the 4-bit debounce fields (16 becomes 0).
6: cleanup, no functional change: get_samp_freq() doesn't need a
   64-bit division either.

Changes in v2:
- 1: use val == 0 && val2 == 0 for consistency (Andy)
- 1: reject 1 kHz and above (a period below the smallest table entry)
  and use a plain 32-bit division instead of div64_u64() (Andy)
- 4: check val >= BIT(15), keep the threshold with & ~GENMASK(4, 0)
  and add a comment on why the low bits are dropped (Andy)
- 6: new, drop the div_u64() in get_samp_freq() as well (Andy, on v1
  2/5); last in the series as it isn't a fix
- Rebase on the current fixes-togreg

v1: https://lore.kernel.org/all/20261123165255.239490-1-kapoorarnav43@gmail.com/

Patch 2 assumes the whole PRF_CFG register is the period index, as the
driver already does; I don't have the datasheet to check whether it has
other fields.

Applies to both fixes-togreg and testing.
Compile-tested only (W=1 for every patch, checkpatch --strict clean); I
don't have HX9023S hardware. The checks in 1 and 4 were tested with a
userspace copy on 32-bit and 64-bit: all 32 table periods are still
accepted, and the threshold check matches the v1 one for every value.

Arnav Kapoor (6):
  iio: proximity: hx9023s: fix division by zero in set_samp_freq
  iio: proximity: hx9023s: check the sampling frequency index
  iio: proximity: hx9023s: re-enable interrupts on resume for events
  iio: proximity: hx9023s: reject out-of-range threshold values
  iio: proximity: hx9023s: reject out-of-range debounce values
  iio: proximity: hx9023s: use plain division in get_samp_freq

 drivers/iio/proximity/hx9023s.c | 47 +++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 11 deletions(-)


base-commit: 69bf7489f01ffa3c3269d09eb8a0668b1bdfa053
-- 
2.53.0

