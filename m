Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6112E81AA8
	for <linux-iio@vger.kernel.org>; Sun,  8 Feb 2026 01:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770513434; cv=none; b=QRSJrtOikXQlncwpqnHdLxXe5CbdHNCrV+3XP2kNhD7nDzdCKognk3iVMDqmVUHokqCsqmSgUUjhybrnmiBO8xZzrAlag6he8FAudwEmfd0gTsv2BkHi0iJ8H4ixBLXYyNMeBnxyNeF/6xXEAU6fCoQnz+tvQsPYR6EGlUmcUC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770513434; c=relaxed/simple;
	bh=hNbcW979ihJHJrFNsYCGWRpk6VOuCWOtihFqgwBwBmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lapRRHjgAsRkQOXkmLZmTU5cB5bE8yRNZEdasEr8PMG0Xs8wCpikn/UcKLnNiItLC+gmI0TRdEelDRfdAQOOf/LwdXb0L06iM8sn2HFiA6acMbOmKjhyjOEyx1MYbjouVVTu7SIk6GCaLEH+h1IoEZ6l5sxZhi/ilmB2Htn8vZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAMdeLFJ; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAMdeLFJ"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8ca3807494eso211976485a.2
        for <linux-iio@vger.kernel.org>; Sat, 07 Feb 2026 17:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770513433; x=1771118233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U5R5FCkRpkHOWC9qpnp9FIHeczKhdG5CqcavMu4NqD4=;
        b=TAMdeLFJznAW6AQVUOrXhrGiHz/G+z0fu3RsIHqHQv835cl8kVRWNlO8UlU0u9xDG/
         y8wCQCAk/iqyBV/pWmjh8hs12/GcrKsmBMPf05o1oaLIBs1LQXjwpb8JB0lS457f9q4n
         il0XtkzQph58vdCXv3F7HBfep7KwXYDRTCYpC5EDy4WJWcrYxz1Rsooa8oLYRW+sgqK4
         vmeMwzSqKWPVPL0dnmGxBQr4E8sdOzRfCQyFdV4cJ3ouxqpIkr29ZjEaUjtUg52wr3+f
         UwaOpUDxFKRiLDzd8ZNpFB2MkJ3dM0FlAG1AYkOB/3lZaqpNlkW6srcrT4PVfqAd+xOC
         U3EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770513433; x=1771118233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5R5FCkRpkHOWC9qpnp9FIHeczKhdG5CqcavMu4NqD4=;
        b=hlZv4Tk4O69shbKcofeB2umSP92bbmMZncjaOIoB7MBfwClOQ5FcAAX8FkvNAWGued
         NgQ6L2l6tk5aaoswzcQgnHFRLkvvykHb5mhb7Wk7rdhnToTZKi/MMV50em3VpZ/iFIIk
         tc3K4z97aX5QQ0pLYeg+9OYN/XmfpygdcDc7YzpTaL23AVvTw+zrlDlTuOLbP2O3F9dW
         9JxRpGkLfLD9M5/42BuyQAI3ZmhNmKteAC/jtxo0cz4qkEp94y5E9tBLeA2JN+BcIBNc
         544SGbVRCVGAySgb3s3WsF7C1Zm6TeQ8dtGjrrandehLujnzSPu/lwE/df/ON6krLDYL
         OPqA==
X-Forwarded-Encrypted: i=1; AJvYcCWv8ydNQBFLHPeoc22u7TVBS/gHArp49ALRxzyrg9l0H4BsQZdFgz/+xlt51C0QNFwoXBLCf1ghGyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8mTmu3BdmRvTUczVAbB9f5lJD1ugeQxCvniY8iDhntYmnnMmT
	Fq1/gskJ/kdNYSNoETu57ERevksZh4FH9bFwPfaP9/8wvjomyU8x9k2r
X-Gm-Gg: AZuq6aLmaOV2vD3H5Km07pbmZaDhQRMMdLJ0U0XJ3WOQ10O3gqKW28zSx8vZJ4RfzNn
	vC7nDsKVcR00MMNhG7Q0TMPc0mhfx6qRMF/vc3r2jGyPmDwkQO9sK4mcQAWRH+YQvf79NLkDYsv
	ukMbhwxEugDBBZ1cGIDxPPW2HrSVvfQQiLKvjeZn6g+Qi21X/M+8+hVSZI2GLCyQOTmgbuo2mXV
	7u8QEuDYbRBYtIAekqRS/Lgbi66RpqnWN/UZxoelm3XqNRh4kclU0KpCvHyYV/3jAjI5+4lTEiy
	eWd2FkarsbSXgCq5bji67RDJg3qxohAed8gWgohBfPJ5PxTg6DsVMN/Mrqdq3Z7rYm4HcO6FVsS
	vISdK7sLhatlxb1PXDJn6X/Tel26TpI5jWmhYopg9tGFWcGEdsPszsXl/D2toILterNyVN4Q759
	Gof4PS8dBYEtK0foEQP4hSW71CukmtwQ==
X-Received: by 2002:a05:620a:bc5:b0:8c5:1fd2:e9ef with SMTP id af79cd13be357-8caef40974cmr993269185a.28.1770513433097;
        Sat, 07 Feb 2026 17:17:13 -0800 (PST)
Received: from localhost.localdomain ([50.21.71.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8caf4a97997sm481364385a.0.2026.02.07.17.17.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Feb 2026 17:17:12 -0800 (PST)
From: Neel Bullywon <neelb2403@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: [PATCH v5 0/2] iio: magnetometer: bmc150_magn: cleanup and formatting
Date: Sat,  7 Feb 2026 20:16:57 -0500
Message-ID: <20260208011659.53722-1-neelb2403@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This v5 series refactors the bmc150_magn driver to use automated cleanup
helpers for mutex operations and modernizes the delay function usage.

Changes in v5:
- Split into two patches as requested by maintainer:
  - Patch 1/2: All functional changes (guard/scoped_guard, fsleep)
  - Patch 2/2: Pure formatting/style cleanups
- Use scoped_guard() instead of { guard(); ... } for short scopes
- Left trigger_handler unchanged per maintainer feedback
- Use fsleep() instead of usleep_range() per maintainer feedback
- Dropped formatting changes that did not improve readability
- Added braces around guard() in case blocks for clear scope

Changes in v4:
- Replace scoped_guard() with guard() to avoid lexical scope issues with goto
  and return values which caused logic errors in previous versions.
- Replace msleep(5) with usleep_range(5000, 6000) to avoid checkpatch
  warning.
- Fix indentation and line wrapping to cleanliness.
- Extend guard() usage to all mutex_lock() instances in the driver.

Changes in v3:
- Add Reviewed-by tags.

Changes in v2:
- Use guard() for mutex protection in bmc150_magn_data_rdy_trigger_set_state.

[Patch 1/2] Converts manual mutex_lock/unlock patterns to guard() and
scoped_guard() helpers, and replaces msleep(5) with fsleep(5000).

[Patch 2/2] Adds spaces inside braces for initializer lists and fixes
scan_masks array indentation. No functional changes.

Neel Bullywon (2):
  iio: magnetometer: bmc150_magn: use automated cleanup for mutex
  iio: magnetometer: bmc150_magn: minor formatting cleanup

 drivers/iio/magnetometer/bmc150_magn.c | 161 +++++++++++--------------
 1 file changed, 69 insertions(+), 92 deletions(-)

-- 
2.44.0

