Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546593D9048
	for <linux-iio@vger.kernel.org>; Mon,  9 Mar 2026 15:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070473; cv=none; b=hOFbLyGacXJ9smxoZ26agrxRdT2RF+bnz7tqrUG9n0RZ9L0Nfc9v0f9+ats6eRj8B1WJKMHjMbQEUD5hvPlNM6OQejFW0ER/gLv7NbKCic/L8icFDhb18Hw22+EZTYRrb8gQnopk3ujCvbNoHtfL/G1kJ1N08xdlV3iYsCvf5Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070473; c=relaxed/simple;
	bh=lHULfwj07UOv2NA0gHURCKRUObTQPEK1J5+hzqK1pEg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XD3CEl4bz/FW6YW4WPVUk8SppLn8W5E8J2gUVZDoc/6goSZcdCBIdsoE2qFWFyooQnfci31jzj0LuGqxZsQnO5xiI+BmYYu/5mjeRRkUFhms0R+r1Pv4oHYBQ+tQ3IuCh0RNrBwCdwToiPwM+dFzxZ8WB9Bz+ux2U/fgEKpKiHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=USDtFv6R; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="USDtFv6R"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so4029317a12.0
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2026 08:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773070472; x=1773675272; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aLjJduYJbPlqUspb+EI2OVQECqL3eoqkLEqyJPZKF3M=;
        b=USDtFv6RXU41W8p6Idl0AACHxywIGTgDxSGwcYLIb1U3+/OeBPNExAB8JcA7FXUTz5
         4wzEFtWNMVOr8ERgMjx6ZbKnBlOiooSoKb07GqgkC2Z0xNkPHpwIcCP705ofBPJ8wfC6
         iX2JODW0EyVwg7qXTFs8J/FDyeePDn6ccESzQuY9aWMri2QZUAKwsJknChtmT71w+pTb
         L4+9vHGYfr47onIvjY0CMJZPxh8r/UkDzwFa5kBDlwKqJuzt72UyDUSg2uO3YGInj6hp
         sK/xbQ95FTnjdsxYyGK2/soBnbwrqSn3dersHfOidUC47vAw9GajcsR5/JSrxV1tC3jM
         FgZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070472; x=1773675272;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLjJduYJbPlqUspb+EI2OVQECqL3eoqkLEqyJPZKF3M=;
        b=EXXvdmcHtRTCmXrT5KgJmQpZY05qH4tB2QeYRWf/pHpP4j9pJmP4M4nIAEtSFpeCGz
         pGfQ00ntjR45GiMsg/j7XNqggTepwwc/98lqfq2yndK0oCNA4OTnyScoD/x0qkoadVSr
         LO8JzbQJ+jK7hjPKA5/M1waRlxQbDaAS/8G1rsQK+PL0jOhTMbMqOFjn0QN28Cmt+GQx
         vQ8TdzsEG7tA32QKWpBiV0ZC9DlbLu1OHm8VuGN2wUCumOxJuJuf/A63LjTzC006sVAz
         opd+pyGz6UNKXUvymHLsGXrQITKb5sSUAa9VYDIFhxV+N2rt17bhUvP8EWcrCX7rxSkp
         59gA==
X-Gm-Message-State: AOJu0YycFsOg60p/0laf+9AN3Af3qoB2eZWPaGktzaujufBsGW1y2vQl
	+SVP+MED6xMpeExazyC789SDk5X3p2Cyonug2vbCHfgDpwFwM5YuImn5
X-Gm-Gg: ATEYQzxQZDnltPdcLmEZZ0VYg8Esphvi2QW8LFBsqgW9CoATAZ5s0uJZVkbwtg45FX1
	+cI0uFkydnw883gEDABATsdn18eJbBR6mBpyKQNJKVil5nZS9D+arHlkRpFjcIYU/11W+M8NUyo
	YyBOObqe6YPuaHKLgN2Dxi/Q1IBOXW+fHZvpy4UXy1vSwT2NrELWJWFU2mwvmC1W0OPse6MoNU7
	g+mSgC9yekPkTFF95a49+lKWWqXiwVqsarFBjzOXLnZ7xALEveQ5zewY8fN3uov0/X7CrSgFFHN
	9dzOwKK6IKfRDgDKe8FrhvkOy25U64cDyAHDzCSqckwBrJ3+bMqv3HS7t2/R+/g7LW1CfVdUkRz
	1DUjaDohyuSbUHib4mqA+Z7f2Cm1/QQS57RaSOxAsD2ftad5pp6l2Z7CjvkEqNZByX/Ij2/LgZx
	8NZWL5M2vxbB2bQcNYhjbv28xfLCuptbCVSgU9+yf/dHFkc1uADNKMyqz0Xdiy/VSRdQZPs+Ufq
	hx69HeuqpKj9Vj6bvIZRuOeEzU=
X-Received: by 2002:a05:6a21:1fc4:b0:398:ab46:3289 with SMTP id adf61e73a8af0-398ab46354fmr5140637.60.1773070471507;
        Mon, 09 Mar 2026 08:34:31 -0700 (PDT)
Received: from fedora ([2401:4900:1c80:20f6:77bf:3a75:33cb:748c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739e16cebbsm9316563a12.16.2026.03.09.08.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:34:31 -0700 (PDT)
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
Subject: [PATCH v2 0/4] iio: accel: convert to guard(mutex)
Date: Mon,  9 Mar 2026 21:04:04 +0530
Message-ID: <20260309153408.71512-1-rajveer.chaudhari.linux@gmail.com>
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

Alphabetically Header alignment dropped in v2.

Link to v1: https://lore.kernel.org/all/20260309142352.57407-1-
rajveer.chaudhari.linux@gmail.com/

Rajveer Chaudhari (4):
  iio: accel: bmc150: convert to guard(mutex)
  iio: accel: mma8452: convert to guard(mutex)
  iio: accel: mma9551: convert to guard(mutex)
  iio: accel: sca3000: convert to guard(mutex)

 drivers/iio/accel/bmc150-accel-core.c | 17 ++---
 drivers/iio/accel/mma8452.c           | 21 +++---
 drivers/iio/accel/mma9551.c           | 10 ++-
 drivers/iio/accel/sca3000.c           | 97 ++++++++++++---------------
 4 files changed, 60 insertions(+), 85 deletions(-)

-- 
2.53.0

