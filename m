Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB9E257459
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 04:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791694589; cv=none; b=I5t4lF6aGO8cSvzuuvc2u/2V2OnZijLlr/4YhU1KO8sadGSgNWpb1xOQly8/7Fygu5TOl3cgCza/R7xVZfH91MrqG7l/9Mx0k2byoWV22vG3qd/QmMd4wqJOcWKYP349uK4+pp8YCQIZBPofo/oBPjjG3J4lVarCxaKYFVlMDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791694589; c=relaxed/simple;
	bh=O7ul0WmTP+iMseIN0P2Bp/XfuNbs/+G4cJMcENk65x8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZZXYWyPus3qYyGjOyNJSacvMY6GXzduikqefDU3gSCv51EGL9UaD0tdADuuk9jl1pV9A7G5j6g+rWs9NmxcruvqsPiWzAh5RtoK9zvM1Z0yTdRkUYEygWQphM0J0k3aZsqAx0OkAePlyxG6OVTpvgUrxXyaSZXrhEr8bPTa9Yas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qX3RYAbP; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qX3RYAbP"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-170135e43c7so359116c88.0
        for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 21:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791694587; x=1792299387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NyBqrn/uBzxgl92CYCl9BYbWFbHQuF77V5STTyBOvYs=;
        b=qX3RYAbPPKhDzD6EMyorW5wbejzwJRnYsZ7eFKeptM/Gp8D4ZAuXOz5Ybbny4/h7uo
         /C08HOL5sriJh0PYZviaStHY1ZVFsLn/I7wAZj3QVPxU2Z+Ke5FxjtJAMvkpFdAs+7uo
         fmfXvUwyuYaXNGgL8wtJXB4OqDW9xplJENKQTT/QXdkKMvhxpWoBbTzZzQXEXUC3ncPC
         3s0GEUFaa980QgrV/bVf0QvBca7xw3122kV9IRQaQmZ409DtXnjWz6itM8KI5gwb9GHw
         TQshMx3xh4JQmczdTwqietwQDc4ftJug9BWLh2uOe4AiKkjbA3VrTPF3nJrGiJEtibvu
         eu2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791694587; x=1792299387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NyBqrn/uBzxgl92CYCl9BYbWFbHQuF77V5STTyBOvYs=;
        b=v8fX0JZbl5Bh0gtfoNRyu5Q7OoOFVPYtcbUPzmtZVUoJNeXOf3XxPq3sisXBGhBcxV
         gClYVF60CegjKZ5ytURVyweCeXWKMRGJ8587AaE0RV7V2Wa+RV0FAVjGvlzF5o/eYhHU
         CnJ8rxaH/SdwtvWszEQWHgtYdyS082pr02Tq3Boi4tO3wWuW/7VB9AOqIgMo8cy1udRU
         QlnT56kzBcrE5nq/8XkMtHogNdL+2M2CcO+qhW9e1tg7yh/gVBBrnA/qDuBEMChhATAu
         NcX2N31TtqmuhUpLPMmr1ycnsUw/MYChVsCwqyQ43aiuu7FF/ILewqOqo1jd9821Klsv
         gjrw==
X-Forwarded-Encrypted: i=1; AKwUvBxbHP0AwK4I3TKuvx55I+JrTyyhzmKr4rgeeFIZ0KBM3nr4rUMsOrajTupF0BZ4jp9pgEFSZ2ooAQ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyfEf0lR74BcqWNpZTQP5fqN7T4ZfT//JJh618oO/HT8ARUu2X
	DRzsi+UX1aDHCLc9kwIZnbNeZLJwjp9VfBP9ORyqQRmgAh8QZzzht7ts
X-Gm-Gg: AYBFou1ILrDt+Mwh2tRmMpbm1ZK9pKXF3/C1XuQrkVi8n3HToI+Xfxao8mkwu4KBhqa
	xMyPDjjyY8/wXovK4Y6E2LplJen3C1DDKZVv/svkr2TfP6mXK7kkkAiUYSGZVe5iEqdlQMjZb3A
	GxymKazITj6IvgzCBj+tucMRWsfaCSaAfgDDBkj5fGdCxYM1uydi/IUK522hkdK+30f4JbRe1vi
	qmboriXqFlUZm5RcsNocfCuE88kaXzFR8eIijs5fb8EVjcjFozvLo39COPEmb8DiC5rWNBnxCWI
	AL0ZCJwkLjthBklMiMzykKK7SWdbrVNB/bHxBUQY/8pVOmWROjQWlFAlwUvuZ+f0pXudp8QBDvS
	XwZ08A54XiIlC9KSxNTyjgX038WYBSKR9lNAh6qf2tT5twSqm46AMqw6cIlu6OeJ+7nHfYhtjJE
	KxKxsgZ/yS74q7Y/L1EsTQO+doWJNPZXTR1OBDhvSAIouEz8/nRquAi4yLbRPy59Q/6tzb2PoB1
	qDKEn+3NvPNr/rgeoSLkKyQdNULaUwYkOziWRF+4BXCHk3aXh/cG6MUbF/JI20Z2UolJg7mt2TF
	dTcTeApQEPtETZD3CuT7kCXCjROvxA==
X-Received: by 2002:a05:701b:2309:b0:158:7ea9:4a76 with SMTP id a92af1059eb24-16a6187f08amr10122967c88.16.1791694587274;
        Sat, 10 Oct 2026 21:56:27 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.212])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a567bd18sm18518278c88.21.2026.10.10.21.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 21:56:26 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH] iio: imu: inv_mpu6050: fix magnetometer scale of Y and Z axes
Date: Sun, 11 Oct 2026 10:26:17 +0530
Message-ID: <20261011045619.357261-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inv_mpu_magn_get_scale() returns st->magn_raw_to_gauss[chan->address],
where magn_raw_to_gauss[] holds one coefficient per axis, computed in
inv_magn_init() from the per-axis factory sensitivity adjustment values
(ASAX, ASAY, ASAZ) of the AK8975/AK8963 magnetometer.

However INV_MPU9X50_MAGN_CHAN() never sets .address, so it is 0 for all
three magnetometer channels. As a result the Y and Z channels report the
scale computed from the X axis adjustment value, and userspace scales
the Y and Z readings with the wrong per-axis calibration.

Set .address to the axis index (0 for X, 1 for Y, 2 for Z) in the
channel macro, matching the order used to fill magn_raw_to_gauss[].

Fixes: b1392de06184 ("iio: imu: inv_mpu6050: add MPU925x magnetometer support")
Assisted-by: LLM
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Compile-tested only (W=1); I don't have MPU9150/MPU925x hardware. I
checked the built object: before this patch the X, Y and Z magnetometer
channels all have .address == 0, after it they have 0, 1 and 2.

 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 38c3f3b398d4..1614f49be66c 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1576,6 +1576,8 @@ static const unsigned long inv_mpu_scan_masks[] = {
 		.type = IIO_MAGN,					\
 		.modified = 1,						\
 		.channel2 = _chan2,					\
+		/* index of the axis in magn_raw_to_gauss[] */		\
+		.address = (_chan2) - IIO_MOD_X,			\
 		.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |	\
 				      BIT(IIO_CHAN_INFO_RAW),		\
 		.scan_index = _index,					\
-- 
2.53.0

