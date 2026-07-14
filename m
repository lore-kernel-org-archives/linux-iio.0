Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D8E379C40
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784028705; cv=none; b=TaP7sgF/MfGYZrfInT3YSPgclQBxJAFe5+6xYwi8dAvoPbeDPpA+/bH71baZnr/asFCB19X7KElmn6RKGPiPaciHeK99W9Q4dhj6r4WBY6uLpybN3P9gwG/e5EGKFioA8pP6fweR7BGjrx+yw8WHGjYzEmlNyIfsbaiMV8TWnxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784028705; c=relaxed/simple;
	bh=PcZYP0s/LLbxYZ1l/StzN0wsFguTXZWmYdbg1dHBg1g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=acyb3a0JXJCQ4kfXKz05wlsucZrP0l2Vgqj4quSrcMlPPV1UxyoTCrs2Opw4kzVL/RlHeEOavs2771pZI86OecO2d+T/0a8QhFpnlrVEAKGoFxNDm5O7226IBk7WJx2HyM28095/0YSBzN6lZJ8qHnv+AcJjWyIup9Ed8FuwVlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j9n4om7T; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9n4om7T"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so738922a12.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784028703; x=1784633503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WmXULsheCa3K8LRrfmjt/jRlfBRLh2F63wTT6/Iom50=;
        b=j9n4om7TARJln/MsILhP2HOYSN1xv1voQ6RKymcfzyHhl0ku/oSIe75KHlE0Yx5WsF
         Oo4+PiE39bYlE0sKPNQxwybCNM3oZeUYNu3ID7V4LhGl5TaID5EpcCvgWMX/TgOLfjPr
         se7zLWZXZw4A/7mnYSbmZXGgyl1mUpObBIu8liF91VZUUWqAI8wSDmkMz5ucdKkwLPu/
         SGyo7popsWXyLYB9dWZS4qC/35K2oNoVk8z4fiZDM2TUgkraZe/bnyFd8blVOzjSPDx9
         fXf3l4AsjDAE5/pFzSW7B0cwQUuYM7LMFgiGOjrkX9cs7AhYPeokfvpJggxx8cfpt4HO
         XeRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784028703; x=1784633503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WmXULsheCa3K8LRrfmjt/jRlfBRLh2F63wTT6/Iom50=;
        b=PCRe672cgC/GoWO4WshGFBPdFU6Mly1Fdz93eUpoiTX49SCSYr+DD5CZ8uxkW9+/ri
         IRBi8tCfN5i0Jy+8Qs1j5Vu++ElRQFQsbAnffLPE6+6HRRD5CoNll1Fe0RGzYYLvkGfM
         BsSYKHCzx0ONy5+V9kHohXu5BG9nRzDsm0ri/SzsayZik3qY6FyXZxZJbsleL0LZ/dsL
         gW2FN92FYcU5rLmgwBaAAuOV7qwtLdyWs6+Mi8ZXoTti78xcGUt9YlfoMl4yqJ9YW/3J
         qNlSoEL3ZmX1mlSa9RgfzRrkzaKipS+M9xaeyto5q4rDf3K0ptRBS7brZR32Kth+7JOI
         OnOw==
X-Forwarded-Encrypted: i=1; AHgh+Roy+tPOcYGOQq6E5KQg20sloJtJFff/62tWoQnneADMDuZOpaKzbKmY7IBjCKti4lyyxHOBlYzf4W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVCzdx5N1IUuBjs0vx2jGP5srUwT5YN4xg2mhXRWteEKoPkWWp
	HrwG7k2AhniFF1Uu/mOZIXuFfic+pluA3abUFe1adhqPrjmgPaSg068=
X-Gm-Gg: AfdE7cn+dFT4+/27Dns5d/JubC24f92JPGekeU1hYz3BWQgsQnzDd/pVWCR2mcoSrZt
	puLApaqLaTspzVYmH9hthOSXWGphEG3edZg/wOljJx0elWOlc8afjIwslp3efdYNfPvKgVV+YA0
	d9svt+pCYr9xcDJmaa38Q0Nse367xmKQF1NgwvSG1U4R/IxY8ltXGfepXlw82vFOPdZ9KqAcqPy
	Mc07ZbwtaatdoD10Opa24EItjOkz0a6CpPn2c7jqs4dKZSotbOJM4iilA8/veIw0B1J5GINMYve
	+G38XIKvNMXLLR08SvYU0loTwcQ6UwFxCclP5VOIWcq9KAUz9z2ooxBDMIS9M0CcYrswiv+hGQJ
	q+rTNmn6KLo4iwls0pbHd1Dp6lIiAyaQhK196Neuq1aVTQpyPq3IbcmUCxy0hT+eR+BLx8JkiLC
	csKzCczWXDADw0FXpRaMEpAVpYpKeB+b+sZmc4Ct2cj934PlgbPKlZ
X-Received: by 2002:a05:6a21:3995:b0:3bf:6c08:2840 with SMTP id adf61e73a8af0-3c11077478fmr14168126637.47.1784028702844;
        Tue, 14 Jul 2026 04:31:42 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.168])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f72a6sm95357368eec.1.2026.07.14.04.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:31:42 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v3 0/4] iio: light: opt4001: Fixes from code review
Date: Tue, 14 Jul 2026 17:01:30 +0530
Message-Id: <20260714113134.3445-1-nikhilgtr@gmail.com>
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
sensor").

Patch 1 fixes the power down path, which read the device ID register
instead of the control register in a read-modify-write, corrupting the
CTRL configuration on the way to power down.

Patch 2 fixes an incompatible pointer type passed as the remainder
argument to div_u64_rem(). No functional impact.

Patch 3 makes opt4001_write_raw() reject integration time writes with
a non-zero integer (seconds) part, which were previously accepted
silently based on the microseconds part alone.

Patch 4 fixes reversed GENMASK() arguments in the (currently unused)
fault count mask definition and adds the _MASK suffix for consistency.

Changes in v3:
- Patch 4: replaced tabs by spaces as suggested by Andy

Changes in v2:
- Add Fixes: tags to all patches
- Patch 1: use regmap_clear_bits() directly in the opt4001_chip_off_action
  and drop opt4001_power_down() (Jonathan)
- Patch 2: document that there is no functional impact (Jonathan)
- Patch 3: add blank line after the early return (Jonathan)
- Patch 4: fix whitespace alignment of the new define

Regards,
Nikhil

Nikhil Gautam (4):
  iio: light: opt4001: Fix power down clearing bits of the wrong
    register
  iio: light: opt4001: Fix incompatible pointer type passed to
    div_u64_rem()
  iio: light: opt4001: Reject integration times with a non-zero seconds
    part
  iio: light: opt4001: Fix reversed GENMASK() arguments in fault count
    mask

 drivers/iio/light/opt4001.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

-- 
2.39.5

