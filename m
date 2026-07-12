Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B9B35F5E0
	for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 20:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783887902; cv=none; b=reXu4qZY3kqQv3z7pZT8gEx3E4oAm0ujwmLvn/K8YTaTyzu4hX3zG5wnuamjameya4RpVsmR1JTJGbhkdegi1stAbt90M5s7FO6EvmqaBYtTGSHubfQDu4bpcDEZHLSRohPV2YjQKkmqKqui5ilC2aj4u1SF2ilWxF3N2OSf8ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783887902; c=relaxed/simple;
	bh=azXbfzTVmf5t/PthoB5eAnFnQztXSJqN2A7j8+7fovk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XtSJRdBKb17+R3sujZzRESdXGkVu/TwNympX0mYDTmo9vmhXVfSqVEZkfZ+63bT8ectkY+cEC9YrHpc6FbceDddTEIMkHBCFiJeH32/hmm3N7DQRrrAuKbyHLAtiNzQp5eazOd2pp/4pw19nTWHAnh41xGw1VWV3Xuh2j296gDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hsz2m+ql; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hsz2m+ql"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso1371585a12.2
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 13:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783887900; x=1784492700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XAJU2Ed0nDLZnCeUNFdR+RiOc3fXZSZtj+0nChoJKD4=;
        b=Hsz2m+qlM4zUYDkhf0Bu6wHXm5FUYp47ePmV0yB3fuksQJs/xOSym5zz6FSU8wk2pZ
         oOvz8aUtGNMwpUrVTAESyDrqieqj+qlDDF08uJblY9cpqZo8HHwgXCfiKfmbTTax1lvV
         m/d6Qy4J5L+ztaAvSbT8NkrKJ7rSFYQNKgdw8keYFUn/63reUkznzrnwjdevfqiM/YG4
         JuhOSRF+aIYIreKCMPv1N543zk+wUESy4hlfD0hJZ8NW6vJuwqvp5uoevg8Fj/4Tad75
         I43O5L2aKfl0RHoGZ8BJN7sk51F2jd94Q4/o6pYl/Djl4b1aVnxqxqqVIpWkklUw67Ot
         o4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783887900; x=1784492700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XAJU2Ed0nDLZnCeUNFdR+RiOc3fXZSZtj+0nChoJKD4=;
        b=SxSkhdAgB2k363aOR7acvlzVdpBRjqD2bKrMIUHfoHjMz+C7GNPFmlTP8uI2Fed7qx
         nY/y4oARCDb9O4IXaw96TP6gWvSlfxE9MG6asW/irhbjb58mXFaGQeH6w9eRHUWoNqov
         GKUO4sf3RllogC2cYQNrZPy9X3Bk72LAeBKpQq3MymvQjQpqOPz9jPwZD7gujjsXNDc+
         uqTsK5mpnZtdY+8v9M6r6Uy4UDl58stS9iqb+mFwVKNLJgg6sAvjHoVUmZBxKN56TSk0
         7XAYmYtTKMvEDshmdWDh4nkvLSPmktxsm1+KT4NemQ12qFsVmmXc2buyyQvJ/2pBJeoP
         wSaw==
X-Forwarded-Encrypted: i=1; AHgh+RqsXU9OOQGIfUCczSjeTYdSxJ+/GDF/32sZ841wxKHFfpdIXtN3kzzJa7LuZJe0lp6+uTJQmYS67dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtnSP08iRbauIKIXqKzVgo6/JTCZsvZNYoZHPYjEmPRPAK7ss3
	bvz67U2eu+idFDHtTv7nuPAr+8IWWu1tDrENmJXMmXpF/6686XLoPGk=
X-Gm-Gg: AfdE7cmCXix0Pm7ExlCXh5DlA1qtCCteS7dRy/O5KIf+LMyCSTN52aL9Rw+zDkAqioX
	VMzqHkD6PNkW2b19cM/2qaKgMFAOziwgeZhkd0rA3MmfqJ6BRyUQ/X9i0vhaJGmoeGvDOLddxp7
	Ig6nIL+OlZeBOe/39dMk1FJCMnE+UUSpLZlOSjp4EtHCnf74LonAZvj9/sGw+e3hFsPrr1DSU6R
	T1PnviJ+8bAx5kq777W4ZC//brX4M56ralLqCjekXWLDZ3cN5F2DAmtfFOgz0e+z1YSgw2eQasK
	pMrt6VMhA+IC/+/ULZ8tgG9LTuAc4r6xhN690dbTz9KWRoSaz2FE4kpVR94UB9NvkU0u2EwHa2t
	6XhEhGM+d8ctDPOBzVLbNRZ6aJBw+Wt2o39FEYj/uGfVHgZSQ5k9vBAVz8vfE6OleZ5CQHF7gwA
	RXbI4O/GwhgpN34ZGdQ5rrxx1a/FEuwUqCsiWH+rjwLiBUs6QtKMEQ
X-Received: by 2002:a05:6a20:c98b:b0:39b:d937:8020 with SMTP id adf61e73a8af0-3c110ad2d68mr7085610637.42.1783887900305;
        Sun, 12 Jul 2026 13:25:00 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm58833648eec.4.2026.07.12.13.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 13:24:59 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH 0/4] iio: light: opt4001: Fixes from code review
Date: Mon, 13 Jul 2026 01:54:47 +0530
Message-Id: <20260712202451.20822-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series fixes a number of issues found while reviewing the opt4001
driver. All of them date back to the initial submission of the driver
in commit 9a9608418292 ("iio: light: Add support for TI OPT4001 light
sensor"). I have not added Fixes: tags; happy to resend with them if
preferred.

Patch 1 fixes a read-modify-write in opt4001_power_down() that reads
the device ID register instead of the control register, corrupting the
CTRL configuration on the way to power down.

Patch 2 fixes an incompatible pointer type passed as the remainder
argument to div_u64_rem(), which takes a u32 * rather than an int *.

Patch 3 makes opt4001_write_raw() reject integration time writes with
a non-zero integer (seconds) part, which were previously accepted
silently based on the microseconds part alone.

Patch 4 fixes reversed GENMASK() arguments in the (currently unused)
fault count mask definition and adds the _MASK suffix for consistency
with the neighbouring defines.

Datasheet: https://www.ti.com/lit/ds/symlink/opt4001.pdf

Thanks,
Nikhil Gautam

Nikhil Gautam (4):
  iio: light: opt4001: Fix read-modify-write of wrong register in power
    down
  iio: light: opt4001: Fix incompatible pointer type passed to
    div_u64_rem()
  iio: light: opt4001: Reject integration times with a non-zero seconds
    part
  iio: light: opt4001: Fix reversed GENMASK() arguments in fault count
    mask

 drivers/iio/light/opt4001.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

-- 
2.39.5

