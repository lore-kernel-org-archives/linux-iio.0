Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C772381B01
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783895407; cv=none; b=HJ7pq9RlCFIv3UPuw1g0L9wuqID99P+T/h4AzmXi6xSQ6SkRRIsM9nn/yWitk38fPjvg2c9swqcjpSRw3lK5q/qCJb68YrtosemRlhE1f9Wi+/FLovuxEqMG4gQl5JmOEnWkntHumvytOm/AQOtXpUt00a6jNqW2rJLsVRj5dJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783895407; c=relaxed/simple;
	bh=h4Vryts5/HJkz1V5caojW1TWYW0a9IEe9ExT/gVUbuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WuYPFewvS4FKXL3qiuphZuF+ffe5YVccnheXGfiDVnfRGzCHxGH0HiWqYtqBM3S5wLmfghWV3fHdgNgG1wZ8N+KOgZ5VINnJp2jPKJvHbGLR6qogWZNiwqFk6OU3yZkuBf3J1K0AiNmOtIl8TFDuOpV9d5sTYtMIApSX5drul60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hq7g4VFl; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq7g4VFl"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cca24023edso29953795ad.1
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 15:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783895405; x=1784500205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6oxtH7JnenqWTHEDhaGlPkoYn8q2KAF+d8dgovCM58M=;
        b=Hq7g4VFlv6kY2QLfb/WtqbSl2qGMYWwd6/JqSVJjFGG9/gWPPw45zAqidrecIVhb8U
         uXy6UFftSgznRgjX8Z3kqlyCgKFA8yqbwxbxR/O7HWobWENtA8/q3Hfi/SKyAmlohGQa
         63SBMY7Ud639NsT22/eJl6/ynS0iAZqMo0beoijkoyca9k4gzoV8010kv3cH+7XiVWRZ
         jJpmOSVWi1VKKSdtsdgo6dqSFE6KXYxZxoauM9WHIg7PKokjrGuXH2ja9lWw31CiVBBW
         rfz0LsUI7gI9X6CMl1gK+j24GJqXKJfvqf4eoghkfzE4VG5U/CSOqAGD0b18izo0tXUS
         xS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783895405; x=1784500205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6oxtH7JnenqWTHEDhaGlPkoYn8q2KAF+d8dgovCM58M=;
        b=s42YO42L1B1SFcizLcHdsHKvxzBMl839KLF9vO9LofMVfH2CpoO+2JHv3u9h/syVz4
         g8ee4LdCDtn/5szywnrPRMsOfaanH+5K3PCajQYpO6nnE4X6gB08QVTm4sWX/r1TjOPO
         Q5eKmA4/yUP8in0cTHjiUbb8WQ0AweBCF3oW7RkSW0JoE33gaHzRCMnHzBvFhnplJphN
         ztoCunVo7Z8je2k2n6hJY8eCSHEGUZhd+jP7+DLM/DNuVtzvxerWVeFId20pWvStMJL1
         hJrYav0C6+bZaYDWka+8bxOBFzYCWsLiVkdm5NTA20TUBI5sc9QiWg6bTnpL+ffVnFgm
         CjCw==
X-Forwarded-Encrypted: i=1; AHgh+Rob72SUT8BX+I7TRT4FwAH29OJiBpHiv0qLrG9p5hX+5Y1VJGHod0TcBHAcD8Er2L4B/mjUKrNtMBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2r/RJkklfUIfGZo7qAtSazc22frnF7obaqmFEUnesz82YFKX5
	y7z7jgtawPAebVXHvwJCuZhSC1JMFwg+QZ1tvXhyGFj5A5DDU03FdPRN
X-Gm-Gg: AfdE7clEthrED8OxOOeMBtVgkce+kPzzbX/xxWhWMM1fpH8gH1O/To31oO9BaRJk04K
	twwHDO21vjMlj89O9A47tacQNssDUGK7DEr162lmr7QnTf4PY1S207QhOWRCbWivDIchYNQXsp2
	yDjiBli0m6jHAc90vIYdsVMN0oCIoCy1BKzt9PqDe2fmpvIedyaci9jbMyxtMRK+VftF3UF606d
	+bFL9qPZbbdmNinuB8mmJOiFOOKTqzj1V7c97W0G3vJh5uO9ZVf525aai5hemYZREWkbWJZgs4C
	JYnrFFE7s5AhxQPrdy/VnnlUMylzRv8nIq60a5tIFUJ8H9ljU1OgvXPY930EH5cL3WvG6yHFusp
	f9c/Xpmu87O6OXuN7VEgGkjNlnnBq0j96EDdjPL0inhieYcXtPDi1fg4AJhAcr8LcVBBfaVVltt
	oL37T4YAhAHsk5
X-Received: by 2002:a17:903:1a2b:b0:2c8:1f58:55dd with SMTP id d9443c01a7336-2ce9e79f35amr63957415ad.9.1783895405574;
        Sun, 12 Jul 2026 15:30:05 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d3bc1fsm89048375ad.55.2026.07.12.15.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 15:30:05 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH] staging: iio: frequency: remove incorrect kernel-doc markings in dds.h
Date: Sun, 12 Jul 2026 22:30:04 +0000
Message-ID: <20260712223004.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 13 comment blocks in dds.h noting which sysfs attribute each
convenience macro creates are opened with the kernel-doc /** marker,
but they are not kernel-doc: there is no identifier to document.
Running kernel-doc on the file emits 103 warnings:

  $ scripts/kernel-doc -none drivers/staging/iio/frequency/dds.h
  Warning: drivers/staging/iio/frequency/dds.h:10 Cannot find
  identifier on line:
   * /sys/bus/iio/devices/.../out_altvoltageX_frequencyY

The header is not scanned during normal builds (build-time kernel-doc
checks cover .c files), so the warnings only show up when kernel-doc
is invoked on the file directly.

The comments have carried the /** marker since the file was introduced
in commit 4851d97d87c8 ("Staging: IIO: dds.h convenience macros"). The
attributes themselves are already documented in
drivers/staging/iio/Documentation/sysfs-bus-iio-dds, so demote the
comments to plain /* style rather than converting them into kernel-doc
for the macros. No functional change.

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 drivers/staging/iio/frequency/dds.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/iio/frequency/dds.h b/drivers/staging/iio/frequency/dds.h
index b2ca8bb971e8..d5f0139b79f0 100644
--- a/drivers/staging/iio/frequency/dds.h
+++ b/drivers/staging/iio/frequency/dds.h
@@ -7,7 +7,7 @@
 #ifndef IIO_DDS_H_
 #define IIO_DDS_H_
 
-/**
+/*
  * /sys/bus/iio/devices/.../out_altvoltageX_frequencyY
  */
 
@@ -15,14 +15,14 @@
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_frequency##_num,	\
 			_mode, _show, _store, _addr)
 
-/**
+/*
  * /sys/bus/iio/devices/.../out_altvoltageX_frequencyY_scale
  */
 
 #define IIO_CONST_ATTR_FREQ_SCALE(_channel, _string)			\
 	IIO_CONST_ATTR(out_altvoltage##_channel##_frequency_scale, _string)
 
-/**
+/*
  * /sys/bus/iio/devices/.../out_altvoltageX_frequencysymbol
  */
 
@@ -30,7 +30,7 @@
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_frequencysymbol,	\
 			_mode, _show, _store, _addr)
 
-/**
+/*
  * /sys/bus/iio/devices/.../out_altvoltageX_phaseY
  */
 
@@ -38,14 +38,14 @@
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_phase##_num,		\
 			_mode, _show, _store, _addr)
 
-/**
+/*
  * /sys/bus/iio/devices/.../out_altvoltageX_phaseY_scale
  */
 
 #define IIO_CONST_ATTR_PHASE_SCALE(_channel, _string)			\
 	IIO_CONST_ATTR(out_altvoltage##_channel##_phase_scale, _string)
 
-/**
+/*
  * /sys/bus/iio/devices/.../out_altvoltageX_phasesymbol
  */
 
@@ -53,7 +53,7 @@
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_phasesymbol,		\
 			_mode, _show, _store, _addr)
 
-/**
+/*
  * /sys/bus/iio/devices/.../out_altvoltageX_pincontrol_en
  */
 
@@ -61,7 +61,7 @@
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_pincontrol_en,	\
 			_mode, _show, _store, _addr)
 
-/**
+/*
  * /sys/bus/iio/devices/.../out_altvoltageX_pincontrol_frequency_en
  */
 
@@ -69,7 +69,7 @@
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_pincontrol_frequency_en,\
 			_mode, _show, _store, _addr)
 
-/**
+/*
  * /sys/bus/iio/devices/.../out_altvoltageX_pincontrol_phase_en
  */
 
@@ -77,7 +77,7 @@
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_pincontrol_phase_en,	\
 			_mode, _show, _store, _addr)
 
-/**
+/*
  * /sys/bus/iio/devices/.../out_altvoltageX_out_enable
  */
 
@@ -85,7 +85,7 @@
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_out_enable,		\
 			_mode, _show, _store, _addr)
 
-/**
+/*
  * /sys/bus/iio/devices/.../out_altvoltageX_outY_enable
  */
 
@@ -94,7 +94,7 @@
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_out##_output##_enable,\
 			_mode, _show, _store, _addr)
 
-/**
+/*
  * /sys/bus/iio/devices/.../out_altvoltageX_outY_wavetype
  */
 
@@ -102,7 +102,7 @@
 	IIO_DEVICE_ATTR(out_altvoltage##_channel##_out##_output##_wavetype,\
 			_mode, NULL, _store, _addr)
 
-/**
+/*
  * /sys/bus/iio/devices/.../out_altvoltageX_outY_wavetype_available
  */
 

base-commit: 2e2f2de7532cbbc2269de8be20ec709606c6e79b
-- 
2.43.0

