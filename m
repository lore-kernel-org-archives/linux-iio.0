Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E011438D3F0
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 20:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602359; cv=none; b=SJ5vJFsp9eBtgtmT/cl9Bv4JKBSTsp7YaY3ujewJPukDZeuehnyGD8vlSTzDVLxZgu7TbNt2IMaCyz9HrFAYsaW1pdTWuhM1acWmIGEhsiofMaYtixeDrhkEaQS8Sy5JGvPNEzw9kCKoBgMZP9T3JpjhLVtYBz46Jvx4bOkBNVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602359; c=relaxed/simple;
	bh=Vv3QUAx6lbwrzeWj5c/NSZu3wDm6a1Gd35SAKG4rXXw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V4kKVK63qAXFysOzYIkf+TB0D+n/rprEMlyYSaq3z0PfrVW1Tzj+HHD3siozpX6knFdWPD9cFpoGNxe5VqhKC18bVBNeVDR9jvsQS5GgWvLOYFEhHvlDoiWcq0EpuVHFxc6WM18jYfV/7s6ebost/rerwyDwayjji+iSWY8sLck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LfZ6ZPYq; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LfZ6ZPYq"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b021916bd3so1001118e87.3
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 13:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787602355; x=1788207155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gg/nMr7TMApsjClnTTTaAGhH3lootDojyA2UMKFL1nw=;
        b=LfZ6ZPYqK6lmXbQWUvuj6kOz+bR+wLa/SrTrrLlDosReEx/3pPjeUrd5iOZB8b4L3y
         8NKbNe6EdNjIwZyysHrdjQBnnj2dJ5ob4M5iImUVDKkBQ+ANh/D2qZppOLe5JnszAzRx
         SX2wcQSLTBUWtMbq1OgVADaf6EVoXov5Y6S7Po1B0F2nkj4n4wG+12Ac5m7oQrF2k1W6
         1iyJo81P0bWO1rtdkKXTZCpl8PxJVKpSwGTKyoXcKzvi4ToCI/hZLRY2WjIFIOZIl/CE
         HriZU/TNrZrGUPgPwJV6fdUjQgZsikAsrsvEKsjIOQtxt7GNI2qPq/pg87y0uBQqo9xV
         ElPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602355; x=1788207155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gg/nMr7TMApsjClnTTTaAGhH3lootDojyA2UMKFL1nw=;
        b=fRjKhI+6TrUAq6nH82HiCH51KimDYeWaLdJiHTL6bSru0r3PfIjCWeBIiU81eTJWlH
         ySt+y8W8QhBsNWK4O4HKKyJkn8FSDFWV7g3mCUOrfgpBcNOqmwe9D3hQRmiKXSSQFbbe
         tQgKi7Kan14ThRPRMx2vkQWd7fQFPmdHDHKYe0JYoMVPrl0dJwp7H/7O6AVezsvbRlXJ
         uc8NMK50+MIfOF9cPnD+w9j77Le8NvGTqc0TI/CCQ2081Efa+Y7XIcqm0c6UBC6Byuwz
         dVGV7ed5tCtwaTv3z4SVt3+u1uYOpiHP4eYKMYUpQ0eAvIrOqTjhSes1qeEALcg362Y/
         Nhxg==
X-Gm-Message-State: AFuF++m/8CwmdvOAfRlx8k6fzxkj7GeUUiZSQFA9HAfgQdh+bepjsMYS
	Up7YhFKcF3mzVhdLR84W1tN2YuJZNevvtq2EpLwfaE6+0vLYDMDs7uti
X-Gm-Gg: AR+sD12KpyV4mcTVvSrTx4wD1PXDptPlrwoUdm01HMXgFwmtnPmfcUWCtd1MXCK7oZQ
	U+qzNcg7PdeGlH11mVnojIWjgHLIiYUq11y7GiJAtH6wRnUXsDb7sOHh1FycRhB+V/DbKc7KpoQ
	YNeEhQUqFfDrYhlnjyxP7O5SNEFstuNg+6hgiDqnFR2SmqDn9Q0docOhpTc1iJwvmoCFP1lfseK
	d4smileLh1KGEDxTEcnI0I1Ao9fPmkhZAN61RVDySWXdxkekBEM40tdU+SJXVXyJIRWuENC4hTL
	rCuY33RPQ/66D5JXjVlqkRIQzcWYsQbBLyxgWfyOo4xRcu6VD2JlcpfI1kOUW4HcFKoLWlgY/tk
	r6V88guYXKXThlod5uDPnsrmEKjrfcAb0DN9WMJvXWQx7N0QIV9BcLXP7V70IWSH0VAjmFjCbWW
	GFCKfV8kqiC7J9zfO0HAjGUy5Iqbj3uazmHe9wc4Em0rZlnMT7AxXJsBIhLW0/bP9irPlwKZSVn
	FTF9nIOY3DNoxDrttyEw8lyv41fPXicxzGLUZbLMrORf111O1xW75eH2SLhdDsaxmvLOn4OGGTJ
	wBMdLQ==
X-Received: by 2002:a05:6512:15a5:b0:5b0:1551:d85c with SMTP id 2adb3069b0e04-5b48b89e7edmr5887419e87.20.1787602354578;
        Mon, 24 Aug 2026 13:12:34 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48ce0cd9csm1923620e87.71.2026.08.24.13.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:12:33 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v6 0/6] iio: pressure: dps310: FIFO and triggered buffer support
Date: Mon, 24 Aug 2026 23:11:57 +0300
Message-ID: <20260824201203.396651-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dps310 has no buffer support today. This series adds it, hardware FIFO
when no external trigger is attached, FIFO left disabled in favor of the
trigger when one is.

Patch 1 fixes CFG_REG bit definitions. It replaces the standalone fix I
sent 27 July, which Jonathan asked to fold in here instead:

  Link: https://lore.kernel.org/linux-iio/20260728223009.0cb86996@jic23-huawei/

FIFO_EN is needed by patch 5.

Patches 2 and 3 are precursors Jonathan asked for on v5, so the buffer
patches carry only buffer work. Patch 4 adds the triggered buffer, patch
5 the FIFO and selection between the two. Patch 6 turns on clang context
analysis for this driver, so the lock markings are checked and not just
documented. It is last, drop it if IIO would rather not opt in yet.

Tested on an Infineon DPS310 wired to a BeagleBone Black. Lock markings
clean under clang 23.1.0.

Changes since v5:
- split probe device pointer and read path rework into their own patches
- __must_hold() markings instead of comments saying a lock is held, plus
  a last patch opting the driver into the analysis that checks them
- get_unaligned_be24() for the 24 bit results
- scan is a structure now, not a byte buffer with memcpys
- timestamp taken in the trigger handler, not iio_pollfunc_store_time,
  which works with nested triggers too
- plain mutex_lock() where the guard hurt readability
- clamp() instead of clamp_t()
- commit messages cut down, Assisted-by tags added

Rupesh Majhi (6):
  iio: pressure: dps310: fix CFG_REG bit definitions
  iio: pressure: dps310: use a local device pointer in probe
  iio: pressure: dps310: rework the raw read paths
  iio: pressure: dps310: add triggered buffer support
  iio: pressure: dps310: add hardware FIFO support
  iio: pressure: dps310: check the lock markings with context analysis

 drivers/iio/pressure/Kconfig  |   2 +
 drivers/iio/pressure/Makefile |   2 +
 drivers/iio/pressure/dps310.c | 738 ++++++++++++++++++++++++++++++----
 3 files changed, 654 insertions(+), 88 deletions(-)

-- 
2.43.0

