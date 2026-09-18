Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110B13F20EC
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 12:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734326; cv=none; b=Du1PFS6iFOzVn4IUSNF/iYxbeFXFJ/8ul5ObYSwD9mwusTKMV+an7RVL1rfk+JEhzENkdoOqImc0bLSsgQwGZqDVEby4WlhkYHlgvAGcKQTDn0sEqOtKjuSo7SDVUR3PgVh8RkFbUrruq8sGIBW7RTICBJ2vo1Kl6WpixztYlz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734326; c=relaxed/simple;
	bh=9ZSenL6dtsrp2oZX3sDl2ArZs7VcmFhK1VTxgTrS8gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0hhX6/usaeCSMemiPqOQjwUvuOMTgsUJnVl9BDIs9YTJVCW4iHP+9eZpje7hEwpAMCZJr+7RDYwpBV5nxzaCAyNinHJT8gH2c5j5JJ96MFie/H49zQV6NPiis+XSIsagDRQqOmiYCN9wsIer3+oC5fz608SBDaeQcZb+Ki8MDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GeSAMZ4+; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GeSAMZ4+"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f17452so557122e87.3
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 05:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789734320; x=1790339120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CMf/fmxNjFr5lz+nt/08I/rGej163DC0gAtINhbDhHI=;
        b=GeSAMZ4+viRqrtMAXU7pv+EBNtYUJxdYWLgPvaWfC7AlTwrRP/ci8xdwdH/TB+rEsp
         m+TYjLPoxSLfSwmn98GxukRg78bhJ3MN+LuRsR9mzEuvYSC9wTJIOSlLtIp2ic1WSH6p
         07bXf2aQ0LhzB5YGHpLw6Wh94c/zg9M1bHUdjvds2aL+65eJ5+07YfU2LKuf+USLLc92
         y5sc89zMAWiR7nGxuoJtwjC0bBdfq50fRtMyaG3wr2ydH6j2ZZZZjk0/BJ/zcSm47DZ/
         vyih9qwKiTOY4cHo0PSDG/VcTRm35Sc8+LyMNOtpQC0HVfWlRrsXJ2/2gh3Qme8uKiUe
         1Fxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789734320; x=1790339120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CMf/fmxNjFr5lz+nt/08I/rGej163DC0gAtINhbDhHI=;
        b=Dgffc/eD8U/QtFEOeA/AuTmMeftdBlEbtU+XzkJuOftdOo/ME4a+WcrnmNxb+v+F9P
         bqCnC8ITBFof+GH6cHI31Isv1TSG/U5apkvckcNTcTMk08B0NOvUi35n/2JjW+ehjJDQ
         UswWkaBUjqTC1sH+mZXki3avPEV2W/xGugcyuy2gY5QgO0RKUKYfNBOYD+enhs2qhJgW
         LpAxdKOnzQpJI/sIKT9symfpWhIPHc8tuxOlkkxVnQdTD0Z9W4VaDSEuqnveLc0pP9DJ
         Og8nDIA+3BlKKdpW+ePqCTCYrQm6VmIvxhu1pCWKjc4vd2jgCS+UhekU4/M8O7QDowUZ
         6FVg==
X-Gm-Message-State: AFuF++nO8KLKE3UvqlbpZtN/DX0i1PT/IwsW9fTTTLl5doGUfSkGiH+D
	8b24bYdJ/7PfTExE/MhZ+y6Hi+4kW9xWtV27kgzHLOSrMy2zI9TX0lO+
X-Gm-Gg: AYBFou0wMtsXBq4X/Yi16yqVK8OmNig8AklYG4cBzdr4zVoX9VJKlM1QplTe3sOdBd/
	BVtCRinjchLkx6ioagIRsRDvxK5qiQDKAEQ4XQDf/VtzMaDUQKTc0QVv13MBPz5wK39WalMLQdt
	FTz0M+/MWbK3p0rDpqd7rmHC5UfAsyavtVSC8Sixtv1Z3bf/2ZuDZj3SqZWrEfmuaBZ3k5OmyW5
	Vfl8CJcHhJjLAJE3EnwNqsXsFnXFjIcuDJ/NzR68wQJ2RZ7rmXkU8MgEMmGbr0WoKjM+hle5BXf
	G60wf54gnvEeFHFy9Hmn1gJ5NaPP5l1w21oMr5WoUQsJGO4L3+yYZneKY9VrDxQU17oElOlkQ5x
	aqqFkIwFt9YoTVMi/O2mgj+X+nqiAtayKN22mREEJlkIDQ66wJ99GVz57+/Y0X5nFdUK/yswbsl
	dAPKjGV8ocb/OxmTQ+5MiOE77E3CuJJ1lrZxlucoxSLDfWr7xQbI/u7dbW+NW5wqq9KHPaaSsc0
	q3PtAgC9lPt6DHVy0vogxZgOuoA7rRxeIjogPXVcmvaqwRJ46CDFbDkecP54B47E5rh/Q==
X-Received: by 2002:a05:6512:3c93:b0:5b8:9fa1:9c3b with SMTP id 2adb3069b0e04-5b8c1846e53mr784754e87.32.1789734319524;
        Fri, 18 Sep 2026 05:25:19 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8c270ea53sm398549e87.12.2026.09.18.05.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 05:25:18 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v7 00/10] iio: pressure: dps310: FIFO and triggered buffer support
Date: Fri, 18 Sep 2026 15:25:07 +0300
Message-ID: <20260918122517.377565-1-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v6 had FIFO support as one patch. Andy asked for a split, so ten here.

Buffered capture without a trigger, draining hardware FIFO on a timer.
Patch 6 adds an IIO core accessor Jonathan asked for; patch 7 uses it to
refuse timestamp channel, as FIFO entries carry none.

Pressure read before first temperature is held, not dropped.

Tested on a DPS310 on a BeagleBone Black, pressure 32 Hz, temperature 1 Hz,
watermark 1. v6 stalled on two of six buffer enables; this series on none
of twelve, at 90 to 98 scans per 3 s trial against 96 ideal.

Patch 10 opts into clang context analysis and comes last, so it can be
dropped alone. Built with clang 23 and CONFIG_WARN_CONTEXT_ANALYSIS, no
warnings.

Deferred to a cleanup series: min_t() to min(), 1000 to KILO,
30 * USEC_PER_MSEC, David's define sort, c00/c10 via get_unaligned_be24().

Rupesh Majhi (10):
  iio: pressure: dps310: fix CFG_REG bit definitions
  iio: pressure: dps310: use a local device pointer in probe
  iio: pressure: dps310: use get_unaligned_be24() for the 24-bit results
  iio: pressure: dps310: take the lock once per raw read
  iio: pressure: dps310: add triggered buffer support
  iio: core: add an accessor for scan_timestamp
  iio: pressure: dps310: read buffered samples from the hardware FIFO
  iio: pressure: dps310: derive the drain interval from the watermark
  iio: pressure: dps310: implement .hwfifo_flush_to_buffer()
  iio: pressure: dps310: check the lock markings with context analysis

 drivers/iio/pressure/Kconfig  |   2 +
 drivers/iio/pressure/Makefile |   2 +
 drivers/iio/pressure/dps310.c | 726 ++++++++++++++++++++++++++++++----
 include/linux/iio/iio.h       |   9 +
 4 files changed, 652 insertions(+), 87 deletions(-)


base-commit: 61718ed183599e5162496b5306c3377a925d21cd
-- 
2.43.0

