Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9934D345757
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773066269; cv=none; b=RYFkgQEfeJ2C3abkmvpL+YMhme32EWZlw3xlPkzLNpcITW8AIZLC1ATKwPfaJMW3JcK8u3haR4VNIuym7Ncil7K5OHarqLXyhV196YIyglB0v98w59OCh9cfK47BuveudI0iAnS9ppiK+aFhDLnula/LhvNFxJTDP4eyb8HC3Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773066269; c=relaxed/simple;
	bh=9uJRT3FKb6EexXWrwSqKSpTNQpf3aTkdg4yqa026Uj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gVvO9Cd0axeiDJZlbe8ITNshy36j4901tzmOb4R5rUKl3OD6vl/5WRN4C506Pmmq4v0GKjmoZkBiSI29aw+UoBfrcuax1z3oMUBD7778QJ0RGep/Z81U0TLs8nw561oOTp9GlYILlSYzkyRbclWapnXyMyhFOB7Uei0hhuTQEac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hc2Ay3ZZ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hc2Ay3ZZ"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3597fea200dso6291824a91.3
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 07:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773066268; x=1773671068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AER5ZefJVDvStBcox3FLdZxVBXZmffk2UdbV+Z5G4qw=;
        b=hc2Ay3ZZ6OEZshYoJ22khUo6Hh1VGY5R4QUsHVh5gnZnGGTqN+Rz08BRJ9V7TUckck
         xRxJbJHLeXKVp3KMGoicF+Ch+U0KW6YyeB6JkeJrDKcBYZU4mXTD8E6oU9xpSra/gY/u
         kuoiHtQHQUC58iqJ7iZowgiR23YSr1+3rlmhFbCSMIqIDP4hUHr2wnGv9yE5ihhikjzg
         A1x0LBreGd2omj4cM8MKftvPIK7bZKDvO/BZqS1RtckmQdvyXKdQh6QCvji0/h8KKu3B
         JDpDFgIufBYV98ZVZJLXkDAndr6qvvdMtRiUkeY62lyq5fP94JFZyXKJqwQlo4IFrEYd
         3sCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773066268; x=1773671068;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AER5ZefJVDvStBcox3FLdZxVBXZmffk2UdbV+Z5G4qw=;
        b=iDqEWLsUcjfhIigrzT8xNk0gHk5aRVyDHAueXk5obHE06rGlUsNDFyfAuLkDxgdyx+
         bP/MLl8IZaoMDcBjrMnYTrqq0rvhXJy0hnodBT+BvWwTLEVk5Ki19LIviAdtYuJhocsA
         3i2Og4YXno36OFi3EF/4bVqGvQ7hEGQ2aEUEdrQMK2HGfMc8lHWnliBolNd7SYEN1zNB
         lUk2kc6/2Cm8wafrfzQzrNOpqVcl3iGYgRxUzSUXq2nKlc5TiINRScKywSsDdSGbNRCM
         k7bQC+JmFqZqgRjGX/x3LDbKbMsncnfbtIJ5sCgRGFveDt/i8sSZCg79rtdlmbRaxhca
         Rgbg==
X-Gm-Message-State: AOJu0YzSWRbvVTaGQmPGkdUfuMZNYPIqsmkkf0rEq8zuuD18O3cN1JXz
	cstxC2A9P7EHBaGstZ4CbGej9J3uveKb/WF07Uj1JNRHxH7i20NrzGQd
X-Gm-Gg: ATEYQzwv+RqdiyCzD5drxY8AXh2llyaVYfaRlwaMoFeLPHRxoNCYTVERBGZqwRLWnKM
	+76FTe3TARpS6ep/MTYp46vaavkMRn+IDRRCJyjFH7g4uUnrrszUdm18f5M8zyI5PGOhJcIJ4o4
	6y4i8+KK/6oAWOU5Eo1TmdD56HW4bKh/tsCt30p+0oppGVIillB8XMgPJC5Idvzg4jAC4QQUDu8
	Sq3ceaK9m0XglHB0PNJj2SnRwdUPriT1moOU1bus1Kff9a7VYKhB9fLSnsfebBdYeKVXVliQ2de
	o8ek+r2ST7XqaYSjFRAce7XANsy65CiG9zs4u8dVm1cD69ProP7IZyraRawqCqWBJYckWWHKG82
	FE8NMOXHHh0iJz2ZEHbRUX9plqWRJlOR5AlPCCXZR2r+BPmPE19/UZ1EvvpGM1fKrb8iOiDUCLd
	Ncn4+RBRy3+2xSAF2iX5qntQJxCZXqF9t9BO6Q12HpniFwvPu7a0KfptCGF9E3GwNNLcrqG9JTb
	mQQiU8m9QH0TtXvAKH2mNm01RU=
X-Received: by 2002:a17:90b:5587:b0:354:a546:5edd with SMTP id 98e67ed59e1d1-359be24b125mr11455177a91.11.1773066267736;
        Mon, 09 Mar 2026 07:24:27 -0700 (PDT)
Received: from fedora ([2401:4900:1c80:20f6:77bf:3a75:33cb:748c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359b2e0e1aasm18985311a91.15.2026.03.09.07.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 07:24:27 -0700 (PDT)
From: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	waqar.hameed@axis.com,
	linusw@kernel.org,
	sakari.ailus@linux.intel.com,
	harshit.m.mogalapalli@oracle.com,
	antoniu.miclaus@analog.com,
	andrew.ijano@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Subject: [PATCH 0/4] iio: accel: convert to guard(mutex)
Date: Mon,  9 Mar 2026 19:53:48 +0530
Message-ID: <20260309142352.57407-1-rajveer.chaudhari.linux@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts manual mutex_lock/mutex_unlock pairs to
guard(mutex) in two ADXL accelerometer drivers. Each conversion
also simplifies error handling by removing goto labels and
returning directly on error paths.

Also aligned headers alphabetically.

Rajveer Chaudhari (4):
  iio: accel: bmc150: convert to guard(mutex)
  iio: accel: mma8452: convert to guard(mutex)
  iio: accel: mma9551: convert to guard(mutex)
  iio: accel: sca3000: convert to guard(mutex)

 drivers/iio/accel/bmc150-accel-core.c |  26 +++---
 drivers/iio/accel/mma8452.c           |  35 ++++----
 drivers/iio/accel/mma9551.c           |  19 +++--
 drivers/iio/accel/sca3000.c           | 115 ++++++++++++--------------
 4 files changed, 91 insertions(+), 104 deletions(-)

-- 
2.53.0

