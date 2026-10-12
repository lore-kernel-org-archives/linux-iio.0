Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066923392D
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 05:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791781265; cv=none; b=Ev6YgSZvMrD867y588P+nGGHyAX3devCm/bYXQnMOH5FG95tR4jZF6QJUPjKnHgBLMoUkHI69RhZgfK0IL36vL4LtDvTtO7rzGuxoiFB7dVLj028y7lFHLkckJ982W2nb0Uc/tZ8/tNzsLSK3RieB6YtRuy7QjC4F4f1uQbNsMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791781265; c=relaxed/simple;
	bh=YSPqAppYIDiXgXhCpT7joAM6e8KmwPlOW/NJw44Sujg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZJQ0wgPQbuBxBIowjkfwxAaqfUCMQqB7Mg7YhlY8ak077T0E67GVdPfVZkGGisxM3xk5XOrgQFdSI4U0gkK8LBINHgT84BaudmLYUgZ3XlxWK+rxhDbPSich7fy+7boISg+zKeYuTNRol0FRpDWsKDeyi+OXOnUSP+eTfR54JfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1DScy+v; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1DScy+v"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-359d729379fso777172eec.0
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 22:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791781262; x=1792386062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sh12r1iPHZpHQ+j2VdLQ1JnDQGI9QrQoo85Y6cAkElk=;
        b=R1DScy+vk2oTJOu5T6UDU51IGBE/NrMiLGxqfpqxOIYx3ZSusrtpaNZByUUo+m7nHH
         9qYvxj5MGE8RgOOO+9qKpvCuhZ9Rg2K1NLQ0fo4i8YSeWpq/gFtXNtQz4BQqt5JIaIl6
         m/STNEUo64bsXYVCM13ICz8FSbm4CDyFUP0aGCX3UCT4dnKYRJKlwofVNwXv18zNc4S2
         Zz8IgYV+KJ09nFkXP34/UghRzsWe8ZNVtVcZfRbVjEEDty0YwAo5WWbbndhNNCT8MyqG
         sxuSz1T835+X6dhLJGvkBqCtWhBHlqkrt+6t0KURsAnZAm6vmo2Yc0/l9hj8j/u1Dlpb
         4pYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791781262; x=1792386062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sh12r1iPHZpHQ+j2VdLQ1JnDQGI9QrQoo85Y6cAkElk=;
        b=e4sHYSR8TIKnuoU2ejYrCybf4vIyaCWNfr23Qv1dFOstel5TYxWnM2JKlJ9Rm0DP5A
         XZGZBEFTDusCO7w4m0LolPVZHkul7VToNp7ggNVO6zKj8FMB//tSje4cCamMDEAfKbe6
         UCuXqp5P2CVyzGTZgopnaZ1FtR9pVZqnIqB5Cynv+HHtwGsBmHbJglxk3c24Rcv0xqkd
         ngqARjYLSmVrBhclzZJtkyB3mPaG/VLSisOZeClcSEs+b2rEwkcPcD0AZew4Z+5FQsRH
         VRMVWZXD3cll5S4gDG9/3HdQm6nPSV+GJkUIg+6O6qCv6JmqK3PUOL58UrRbp0k/p3CA
         Djrw==
X-Forwarded-Encrypted: i=1; AKwUvBwLoF/SPVG81cTBt9EMmTsXUUSzyQQLTOfWrpr0W2a0F4yggaRYbQsUfD413ixlXrSMJrmqzkzGFKY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKni0JcyNiArV17NbU1vt1DXSIENqJB1iESkU9LhQEH5hMOGwwN
	PgZRv/uia7IMBr9H/2ahPufhaCyOWB8FQhVPtED8fZJyNy5ww7aYqPMSEq3x2uJO
X-Gm-Gg: AYBFou31klyr+JuXupldBNwHylEjxImZNWgoOv+P8420V7L9h7pQQFqnviRAkn4leLd
	L+xc3d6d+8p2XVk8PPDZrrRXXXnnUdi2o+O0YaPcf+VNjT39UBorvzzFSl9jPNx4Ui1QBY3PCVT
	i0KopMQHy81Zby6UuZUMh/oGVQ9IUQ/ZSr29a0YVMsdXBoCQlboV416ojfEA8Lla39xgCBSfZh5
	ysdonX9A+/LxopOkKOBuTQ2JHk/Z9ZNFNUCV+ljrKLnIWGFRhRFD79o/L8j9VDC4G+NKrP+l+D8
	uO92xMMuqvaYi77sFPNlGkVAkgFTXXF92DV+w/0TcZtQyaJAD7jtD0TnSLoNRZqE35Al4jpMpkM
	OckwpizJJi8nqHi+mR6aMucHD7J5UDfnmHErnBLMyBrklZXxcZTmsfVhwlGirMJwXbvIHJbBMpr
	qD3+Jc1D8rorRLPHmYVCw3nMCyHKr7u8+Ok7soz2qEeRhzX5kjJMStIf0/M19t3vChE1bfzxsWB
	CYZzG/eKntSD6BNQ2IMgQL9oDF59qFfMyuF5fitvYP8cxqQq/HpgAg4EEJKQDB0ny3jfNQGo3Ud
	/97u0DCr+0l5HQ0LUar40pfl8W3pZ+e7KXHiaXvQUfy2/lylHkAmMSzkeIbPG0IYJ/hJ5vtQaOq
	XaQiR12jVNonQ164u/iBxVMMvsls0Vm1X1M7B89oOVP5fwbGB9L5bOYU=
X-Received: by 2002:a05:7300:e9d6:10b0:354:1db3:674e with SMTP id 5a478bee46e88-3541db367f0mr12293844eec.6.1791781262172;
        Sun, 11 Oct 2026 22:01:02 -0700 (PDT)
Received: from FT6N242TWK ([223.181.119.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-353814b556esm31804877eec.18.2026.10.11.22.00.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Oct 2026 22:01:01 -0700 (PDT)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] iio: magnetometer: fix the register restore on resume in mmc35240 and mmc5633
Date: Mon, 12 Oct 2026 10:30:53 +0530
Message-ID: <20261012050055.48850-1-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The resume callbacks of mmc35240 and mmc5633 call
regcache_sync_region() before they take the regmap out of cache-only
mode. Since v7.3-rc1 regmap refuses a sync in cache-only mode with a
WARN and -EINVAL (86fc3483a4d6 and afc8e3ee8307), so both drivers now
warn on every resume and no longer restore their control registers.

The kernel-doc added by 86fc3483a4d6 says that the caller has to
disable cache-only mode before the sync, so the two patches change the
order in the drivers.

The Fixes tags name the commit that added each resume callback
(553a776b7908 for mmc35240, 6e5f6bf2e3f0 for mmc5633), as suggested by
Bui Duc Phuc in review of v1: the wrong order predates the regcache
change (86fc3483a4d6 / afc8e3ee8307), which only turned it into a WARN
and a failed restore.

I have no hardware for either chip. The patches were tested in qemu
with the drivers bound to an i2c-stub device and a suspend/resume
cycle through /sys/power/pm_test; the details are in the changelogs.
A scan of drivers/ and sound/ for other resume paths which sync before
leaving cache-only mode in the same function found only these two.

Based on mainline (a5ebb76233b7, v7.3-rc6+); the patches also apply
to next-20261009.

Changes since v1:
 - repoint the Fixes tags to the commits that added the resume
   callbacks (553a776b7908, 6e5f6bf2e3f0), per Bui Duc Phuc's review;
   the code change is unchanged.
 - note in each changelog that the ordering predates the regcache
   change that exposed it.

Shashank Mohan Jain (2):
  iio: magnetometer: mmc35240: leave cache-only mode before the cache
    sync
  iio: magnetometer: mmc5633: leave cache-only mode before the cache
    sync

 drivers/iio/magnetometer/mmc35240.c | 3 +--
 drivers/iio/magnetometer/mmc5633.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)


base-commit: a5ebb76233b79db01e82e061173cb73c6d2b5c6b
-- 
2.43.0

