Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724A63F2101
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 13:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468966; cv=none; b=c8TUxs0zs+pSbODZFesGJw1Vt2R8iAulMflq6ZoX3Fw5pfDArm3BIaZSbLzzdVEkb9cnKg0URLEYeuAy0uQ9N40XPPkJcRyrpwNfrSCJlXRNGeQ4k7EKOBOJw0xMyVIOIRUQxf/NBTPzOnnUdDjpvRJfY+RPgp5mR+5WNKB7D7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468966; c=relaxed/simple;
	bh=QntNCRxsqRUOS0ylI7Pz/qxqd7q8WopawYe4imAZ9cM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s2MWz+1QnyytVq2d9mYHhICmCEoaVoGYIjmp79E0lygJJ3eAT7GhuNXAtUdd9TuWvdqpl7zcF+h5nyy0g4VXNxJtDNtul1lqAAv6O4MaJpSvroaOupO8XjIzowqpOTUM7ItFeqoyGUV1PY6zD3k2sL0FVrouO6VLxN1/6Squfwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+og0c+k; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+og0c+k"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82418b0178cso7594024b3a.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 06:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777468965; x=1778073765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GHDw5P/WKuWdQLGr63cox/hFUSLBxTNMcAldluDTWOk=;
        b=a+og0c+kQ+B8MfH1G9mvqqOKRs14SiqfH9j7JV23DE0DZYMvYXQXwCn32fHimOap6J
         YHLRsvH7Be3Vzo0FzKAXPyJmjwbuu1wW2etthAkVW9BKciXEIBZ7xT3Wx4CRNFGkNFjg
         fpc6wlPwL7UX3evvJVJDqXGM6xfv0DrZOGo1P+l+0fSP516/XrM+I89uL+xCZryepvfa
         9EyZ3FS/HMls2vEjFtX+oqfZnfDw1HDG64RnqGRWxOEriI6+73JiBv9lxe/ClIZMxLaa
         GBnHKD0DrQp13HttYuRSNBn5WDg4QkXhN4rDVL9m+Bu1zM5CC6iifnbiwRNK3tgK/L7R
         8QNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468965; x=1778073765;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHDw5P/WKuWdQLGr63cox/hFUSLBxTNMcAldluDTWOk=;
        b=QkidYfjxy3EZGb4JXD6VAw+d7KCtqD6E/aMKR3eA9nDLCK2GOrLsHLKTt9uBIGQGqi
         NwD5XWjhGaD4PMJmYjS/GwyV/CCohFNmcJjY7R0vzWcKEihwOt+URUMUqIFKdeAE17eu
         WSUGODJgapjxmx6WY/ksfS0wyU/WfTRG+RRHKbp+JrE55N2xNvI7Jq1ictnVboVQ9P41
         G+UQ6p53bN7VGu4H55tapABTU9A5Zvj1g0m+gYVAMvL5tKvj9k6VndFqNYweRa1gfWqC
         Tm5LwY5HLjiWuVAWf3OgIMANrU+goftXSfXkvdIEtNX7fDX2Aoe9sS3CKBT4QaZ4kCJi
         0RSA==
X-Forwarded-Encrypted: i=1; AFNElJ/EdZq3tVZCkdVaoF9Jhpw+XT9Zg/xiHXhsVUkzF0mLVopeK1hRpywvS/YiJRtTePP2w9A/l/LdYt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ASCmKNmG2pKCw+A7pDT+2WNWGC+mNX/lMdjFhQQ8zCa+chZo
	d+fEGzGif1S6Ps48HFCYKBASccLrsoGlVhethBf2vtSTos1WR4ZQzNK9
X-Gm-Gg: AeBDiesZdVMWb6JA+sZ1DnfRnc5eJmQQXs2HWIoRr76iob/OKOh4ScPaxR/HwTfeJBq
	QXHL9m68GjAypbR0g6UGn5gphKnOk+5/YxQJCejXdFNR5XyyUFPupbBw1NLlV12QZ8AeV+lSY1Y
	ypFKR9Ons3rPQQlGW7UDRuxI/gP0NWxnDcCqDCdQ82MjBUD0UWTdCGEeecscYB22J2fvdHVyRYc
	ytQgfu3QeV33zi5efwzvTg3T1msO2AmuLSn/S8ZVTQawhDfUDc5afrf/0NptWZnkZ1xXS1GLXUP
	4kWj5qyj34w1wY9C5kNROB6ywisUyEBxot7lHJr1XCpuM4h4aMOLt6VPsCGgoOi4W6/t6/peziH
	qizR1V6mSZSXD8yNeNaytFNLF7xQuPaVN/6uQ1J0bOZWn7/aBPjQOZl3baTvBXuziq7k6po77Q0
	6YlY47uFWl0y7c/k6VX8Qw3KQLPsAr8auZpIAMUHa7DzFHMTwtKJVYCQN4Yr45q+5ftzmKeyf0U
	/SwL5gup2Mp9Lw=
X-Received: by 2002:a05:6a00:950d:b0:82c:212a:a9b5 with SMTP id d2e1a72fcca58-834ea663abdmr3633488b3a.36.1777468964920;
        Wed, 29 Apr 2026 06:22:44 -0700 (PDT)
Received: from localhost.localdomain ([2001:448a:2002:4381:3859:fd0d:505e:362c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed5cd407sm2091372b3a.13.2026.04.29.06.22.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Apr 2026 06:22:44 -0700 (PDT)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: branstj@gmail.com,
	lars@metafoo.de,
	ojeda@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	igor.korotin.linux@gmail.com,
	linux-kernel@vger.kernel.org,
	Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Subject: [RFC PATCH v2 0/4] iio: position: add Rust driver for ams AS5600
Date: Wed, 29 Apr 2026 20:22:26 +0700
Message-ID: <20260429132234.30514-1-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the Rust driver for the ams AS5600 12-bit magnetic rotary
position sensor. v1 was a probe-only stub; this version adds minimal
Rust IIO abstractions and exposes in_angl_raw and in_angl_scale via
sysfs.

Link: https://lore.kernel.org/linux-iio/20260419151327.26306-1-muchamadcoirulanwar@gmail.com/

Changes since RFC v1:
  - Moved magnet validation from probe() to read_raw() per Jonathan's
    feedback. probe() now only verifies I2C communication.
  - Added minimal Rust IIO abstractions (rust/kernel/iio.rs) wrapping
    iio_device_alloc, iio_device_register, and the read_raw callback.
  - Added OF device table for devicetree matching (ams,as5600).
  - Replaced hex bit masks with kernel::bits::bit_u8() per Miguel's
    pointer.
  - Replaced magic numbers with bindings constants
    (iio_chan_info_enum_*, INDIO_DIRECT_MODE).
  - Downgraded log messages to dev_dbg!(), removed unbind noise.
  - Added devicetree binding documentation.
  - iio_info vtable is now a compile-time const.
  - Uses iio_device_alloc with PinnedDrop instead of devm_* to avoid
    lifetime conflicts with Rust's ownership model.

The IIO abstraction design was informed by earlier unpublished work
from Brandon Saint-John.

The IIO abstraction is intentionally minimal: it supports read_raw
with IIO_VAL_INT, IIO_VAL_INT_PLUS_NANO, IIO_VAL_INT_PLUS_MICRO,
and IIO_VAL_FRACTIONAL. write_raw and buffer support are left for
future work.

Muchamad Coirul Anwar (4):
  i2c: rust: add smbus_read_byte_data and smbus_read_word_data
  rust: add minimal IIO subsystem abstractions
  dt-bindings: iio: position: add ams,as5600
  iio: position: add Rust driver for ams AS5600

Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
Tested on BeagleBone Black (AM335x), kernel v7.0.0-rc3,
AS5600 on i2c-2 (0x36) at 3.3V, diametric neodymium magnet.

  $ cat /sys/bus/iio/devices/iio:device0/in_angl_raw
  3296
  $ cat /sys/bus/iio/devices/iio:device0/in_angl_raw
  1675
  $ cat /sys/bus/iio/devices/iio:device0/in_angl_raw
  468

  $ cat /sys/bus/iio/devices/iio:device0/in_angl_scale
  0.001533981

Magnet removed:

  $ cat /sys/bus/iio/devices/iio:device0/in_angl_raw
  cat: '/sys/bus/iio/devices/iio:device0/in_angl_raw': No data available

Muchamad Coirul Anwar (4):
  i2c: rust: add smbus_read_byte_data and smbus_read_word_data
  rust: add minimal IIO subsystem abstractions
  dt-bindings: iio: position: add ams,as5600
  iio: position: add Rust driver for ams AS5600

 .../bindings/iio/position/ams,as5600.yaml     |  40 ++++
 drivers/iio/position/Kconfig                  |  14 ++
 drivers/iio/position/Makefile                 |   1 +
 drivers/iio/position/as5600.rs                | 129 +++++
 rust/bindings/bindings_helper.h               |   2 +
 rust/kernel/i2c.rs                            |  24 +
 rust/kernel/iio.rs                            | 224 ++++++++++
 rust/kernel/lib.rs                            |   2 +
 8 files changed, 436 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/position/ams,as5600.yaml
 create mode 100644 drivers/iio/position/as5600.rs
 create mode 100644 rust/kernel/iio.rs

-- 
2.50.0

