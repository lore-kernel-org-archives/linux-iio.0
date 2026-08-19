Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7808357D0D
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135873; cv=none; b=urJi1uHSjlDS6JUemNYnDf2IJxaZ1osbe+RBQ3XFgnWm2xLBynEdJrQbt7kLPumK03tll4TAs4St8COwf2eyBZ2pE3cwN5dpXLo76h9gu2nnJf7lPaH+elyQd/Ug2BsE0TtkGFgO4a16cQvPCJKHfDLRIjjKxNoI5uGA/eON7GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135873; c=relaxed/simple;
	bh=U7GA9q0rvihmr1wCUwUA2tc36Vq5++GKoRi440Dr+N4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S5DAHXtV4/0Wjka7OqnxnpAaECIVxNStTtSHoO1QzpCOlUQBzhmd35Ro9Ctzt6x3YS4tDC0d3L7MlytI45kzxVljC+iAZT9kLRrG5Clym8AagB8EF0gm83rSmI5nLi8EH/rvrusgv7/BPNLml0aEDpCXyXOK9PYuhJ4tqSCHRNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5YGkXgC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5YGkXgC"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so8184645e9.2
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 03:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787135870; x=1787740670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QW6KRwupdg55mo+OcaBJiMe/Biu9HWOoBuExG26k1D4=;
        b=p5YGkXgCmogwFWBXJBnmefP2dqg7biq/n0+IjlFDN6M1G9iGvWbmLEkHx4x3xCDAOy
         mgEvfYboq1zVACnkbS1UQxkRzP3yDdGtWeYj0m6Lac7hg64YgXStp2/YSJ4cbKdhtims
         a6FfWv/uMuS4sOZ8MsW8QHaLH2nJ4ZkidldK7aSr9B50k/sg805Qma93UZPTKvVY3gFV
         cz+AWt+n3qzN71EBmxS8PIusmqSc6QD6P8Q4WVT8uommTrRoWW50ZOEr1L94VeDbZlML
         E9J4ivwlUJp1LqsqQ5KRI+OEYFn/FNyU8xeDymbUSV5v8Pxg/AoLn/44VXWQQi4aTvoU
         vtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787135870; x=1787740670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QW6KRwupdg55mo+OcaBJiMe/Biu9HWOoBuExG26k1D4=;
        b=R6+nlT7BSyMO53Zk6xkWCLd9oghHn3Gy+7GQtwmOPly7Ps/Fy/D+T+DI6i2dzhoi1g
         McSPWPGVo7tBNXTqGI164kkLBwCgNAC8+6/wsa/WbEQsGD0FkLXDUkT2s+81RSp88jLN
         9oq/C09v4NU1QKfNhL5IFUAgNoQK1fAAb3rDOWdyZmzmmlIfZar/T/UnhC74cHyPoFE7
         z6dG9ixsTQ1WheMiLF57vjPM0ZFhwJ2Srb2W8j3ekPpzZRTTuEjkYE6+u4VJkn927wNA
         MHCI7i47MtFTsEVnZyDys69kY72zvGZ7Jah8kcwJsjDdGgSjH8WnXvu5Cr/l/9a5BA/K
         CNEw==
X-Forwarded-Encrypted: i=1; AHgh+RomrULxnEF5fgIh+CsLC5ply7axhfgYoRwbnMJozrazIQdfIVUIqVzC0QhDAFYS5LfFtLpjUUCphV8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh0esxl1HxpHtA5tG6jxN0HK0skoDEHXS9fqgpL8gNm5rKP99J
	M6zbJdtjjIvRaFnFkBcLyJMmOylrlCygDJK0SDEAKXyxRb2RjhhWyUjl
X-Gm-Gg: AR+sD12nh2hbLTgQxjdHgWFWsL1ti/ZMaICpJSpYA7RWQ9Iup6wauzHuyscnF5GN5fu
	Rd91kaDl253GRRP0rNzJ9DbegJNj+UHGLqGlZxdkmw7AcBSZa14OQAG2kSwQwYpi2Pp7dIZy/Lv
	X+CRtMaaazOUn7E5iA5QGsIiidYYbogfZ8sS7oOxrvLTo/ZbBRs5pdctbD2rEcmjgcxY3FeV3/O
	LB0HbBI0JpmYjO9RaTCGWhuSpo1VVbrKjh58bp64biyLFfQkJfhDtndPj/8bLqjZg5OyB3MSJQK
	238NOG6JnN2+WEeSgTi8kNDjex1JIbEnDP//4VBATBppFCK3MIiLgvOhYs0vZm1UPThH+pMFhlk
	ybACwrNotvjJoVJjImO3EEBdxSYsq81u/CHnV3p4PKx99oL45XGAnUoV4iM3xd1FvTVVBEt2FYB
	utW5FJowJVlO9F3qGMblucchdoY5GVanQa6MUb3d5BYbPiyltAGbWtVt5jWiQt0XXjuTDv+TeAW
	hqqZfwcpqXhTmBVVEbZxzaQT79telABUV1Tj/s=
X-Received: by 2002:a05:600c:4f87:b0:499:7219:122f with SMTP id 5b1f17b1804b1-499aa199590mr52206965e9.4.1787135869941;
        Wed, 19 Aug 2026 03:37:49 -0700 (PDT)
Received: from MacBookPro ([2001:8a0:6c97:6700:51db:1c3:6be8:694c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499aa11f832sm50175655e9.7.2026.08.19.03.37.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Aug 2026 03:37:49 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] iio: accel: kionix-kx022a: unify staging buffer and convert to iio_push_to_buffers_with_ts()
Date: Wed, 19 Aug 2026 11:37:44 +0100
Message-ID: <20260819103747.31722-1-grondon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the kx022a staging-buffer unification plus the deprecated-API
conversion. Patch 1 drops the redundant buffer and routes the one-shot
read and the triggered handler through scan; patch 2 does the
iio_push_to_buffers_with_ts() conversion.

Changes in v3:
- get_axis(): use a local __le16 *buf and le16_to_cpup() (Andy)
- Add Suggested-by: Jonathan Cameron to patch 1
- Trim patch 2 changelog

v2: https://lore.kernel.org/linux-iio/20260818215122.52715-1-grondon@gmail.com/

Gabriel Rondon (2):
  iio: accel: kionix-kx022a: use scan struct for one-shot and trigger
    reads
  iio: accel: kionix-kx022a: use iio_push_to_buffers_with_ts()

 drivers/iio/accel/kionix-kx022a.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

-- 
2.50.1 (Apple Git-155)

