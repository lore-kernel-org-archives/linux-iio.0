Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791D84E3251
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 15:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792165711; cv=none; b=G6pMxL7eJ+arh0yDou0PuNmn6sY6uENwyzfJKNsWGpSkaTBS4305J4RMToV/S3TI6aDpdy6/IxJ4oB/WQwnUfmeFMADdvP0O2Ru691qIfa1+Wd9nsP/Kl9FBIwJnRLTZB/1vuG+0h++Ysq5M8ANnP92TrL7hTP9QlRdcn884Dsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792165711; c=relaxed/simple;
	bh=V1jRKmCQFL7EqhgtKwrUFCiu8eMFT9qwVk/G17OwXZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Go1LRI0d69Vao2m3BPvYL+0iYK6tpVRohaPKS3WBEDPL+EeFIIjVxFVl7zaMflEmS9gjPt18YUZWgI0QaHMfdFBzHpzyoaSbB4DRxhtcj4xmjMlqq12WOzKL+iUMmUHfk4091pYnw+ofodyHvNPG4QfVTMDRuADpruagoHpCnO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTAQnOHg; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTAQnOHg"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8726acc5eadso671327b3.0
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 08:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792165708; x=1792770508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8Ear117DJjn2hMVG10i+yEJqY+WZsqWtPeHsEomSMN0=;
        b=FTAQnOHg8eLnJByhEyrjDiEcwDlm6nNvNCL8gdewgO9cIiTOEYRb8us2E28u1EiDWm
         tKBXafitMx/dHnXFPB262I+sZZo+YaxkwUaaHCDlUYjALYrujT5QDdqLMXsbcvxNzGMp
         5Tp4VbZGrhAv6DS7PlCMCEKobopHQvpJnAFB1+yNt19KNGWdeWhJlHGDIdzr44rI6f5U
         Xi02du8UQDyh/sAy3x6b9xgX+ucwJRyz4bphcdkc+pBkFD6or7uB++IYhn/s1ez8YXxd
         ahfABQsFv4ZrhsauGzvCynP8KfrGKkRxJS+JivmlDevSDfN8rIRSJqhWKFCl/fR6ctFb
         /PBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792165708; x=1792770508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Ear117DJjn2hMVG10i+yEJqY+WZsqWtPeHsEomSMN0=;
        b=Mp/6u+Nwb9N4NVjs73fYb8BxxOcsq6zNCgpA/EgD+etVmwkWk3ugtvL5YOOYzv29ZT
         TN5oxCZIJkYxPdrceCJA0WWeYVXre7cJCn+xS7sG7LVgumP4ss0erNWRGM3MexJlac/j
         QgXgbIO2ssXVGykF2K4Z8UAVtooYnzM4jWYKOqzYLGJ5nbtuWgIG84KiLgT+vW3zpajN
         EQZMWFq2NOZpz5K/mq5wkCvCfmrNutckKXz2BUZ4vDLOo2arYUEbyoa2/O3y6z0dHrEC
         2yqsSrq8Jah1tLaaUmWEqSg5gfr1EOy4dnPrUHeXrpn2zW6LhuWE53Qk8k3DXmCWcxv7
         bADg==
X-Forwarded-Encrypted: i=1; AKwUvBwgxIoYgg5Yn+qz0dW+RBKYUaiETZoB5eRsg19mAUY5DNR8MZ3Lr2RU7Ig8iLLVhn2o42hZXmCq1lY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLkwjYAPYBTQdEX7+c/sglTRMg+9vtMmMneAbYRHMBAFAiCp0lF
	9sfoH/fhxotrZIbsyPgczKwOYGedbr0v5k6W+p5cj/TKJ6RPoAtcF0hu
X-Gm-Gg: AYBFou2rnJc3zJEaf1aeTo+JEFjWKizpjYqy/GgJvNqQiuiYqJu9WyQziGNPAIQWyIe
	yP9FCXrf6XwOGMJtZmiwVspiAFDtLwmcdQHIlbQCuhxZI4cWoRLVRlYsyjwNY+Njd0lhcQfxBSB
	JzN2uxuSUneM4izViQDH+TcyO7K+VOJn7k2QcPQ4DyeA/ijOOl3bSp76qPAE17AgHihp96pi9Br
	euobyX3CxkcvTbfRNiermwDGvrXFQxF+UCWFkP8yn6g9MVM+3SbUu7xs66wQ4n1uGp/p/ehxgYc
	21j8ZX43V91IZwo9cZNQ8cB+BIzEObpPN5z8YK+BWBzV6NuOUm9/nsl7jlyFJDOfP8cWnBhmGf0
	qXjvfyhsZlU9aHjWdRkdyjm1EFs1A/FbHZtF6/vo0Zdet4CGW1CQglLmoMGhTqXTxtHgi+hHUr9
	XkmUl9mqna70SEijpwH4d5qfDe8E4Aq9SKyLjHOhG3PfLn4l3nRORNXyug0s8T/SLD3/lHbd8rG
	iY/38bpWefyOv7V5ArOo9YxmmY6RQPDey3pTbY=
X-Received: by 2002:a05:690c:581:b0:8b0:ab62:c636 with SMTP id 00721157ae682-8b0f21e9dc9mr1812167b3.45.1792165708302;
        Fri, 16 Oct 2026 08:48:28 -0700 (PDT)
Received: from localhost.localdomain ([180.243.241.21])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0e593c65bsm10882167b3.38.2026.10.16.08.48.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 16 Oct 2026 08:48:27 -0700 (PDT)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Igor Korotin <igor.korotin@linux.dev>,
	Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Mark Brown <broonie@kernel.org>,
	Brandon StJohn <branstj@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v6 0/4] iio: position: add Rust driver for ams AS5600
Date: Fri, 16 Oct 2026 22:48:15 +0700
Message-ID: <20261016154819.17936-1-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a Rust driver for the ams AS5600 12-bit magnetic rotary position
sensor.

The series adds generic fallible I/O support, SMBus access, a minimal
read-only Rust IIO abstraction, and the AS5600 driver. The driver exposes
raw angle and scale through IIO sysfs.

Reviews of the lifetime, concurrency, and teardown contracts in the Rust
I2C and IIO abstractions would be especially helpful. Danilo and Igor, if
you have time, I would appreciate your help reviewing those parts.

The Region-based view models byte-addressed registers and is not a
general model for command-indexed 16-bit registers. The standalone
word-read helpers accept any SMBus command byte.

The current interface is intentionally limited while a Rust regmap
abstraction is unavailable. Feedback on whether this is an appropriate
interim approach, or whether the work should wait for regmap, would be
appreciated.

This series is based on commit 3fadfb9362cf
("rust: firmware: avoid UB in example by passing parameter"), which
contains Gary Guo's io_projection-v6 infrastructure. It also depends on
rust-next commit b93fb6e76ec1
("rust: error: add remaining error codes") for ENODATA; that commit is
not included in this series.

Previous version:

  https://lore.kernel.org/linux-iio/20260822062725.60519-1-muchamadcoirulanwar@gmail.com/

Changes since RFC v5:

- Split FallibleIoCapable and the generic fallible try_* routing into a
  prerequisite patch.
- Require CONFIG_I2C=y because kernel::i2c is currently exported only
  when I2C is built in.
- Keep a bound parent borrow in the unregistered IIO builder and transfer
  registration ownership to parent devres.
- Derive the bound I2C client from the parent during read_raw instead of
  storing an ARef<I2cClient<Bound>> in the driver.
- Make IioDriver unsafe and document the validity requirements for raw
  channel specifications and the unsupported channel features.
- Reject operating modes other than INDIO_DIRECT_MODE.
- Use the external error-code dependency for ENODATA instead of adding
  the error code in this series.
- Clarify the writable-storage contract for read_raw output pointers.
- Replace the stale datasheet URL with the stable document identifier.

---

Testing:

Built for ARM with Rust enabled, I2C built in, and AS5600 built as a
module. Tested on a BeagleBone Black with an AS5600 on i2c-2 at 0x36,
running kernel 7.2.0-rc1-as5600-debug+.

Raw angle and scale reads passed with the magnet detected. With the
magnet-detected bit clear, 10 consecutive reads returned ENODATA. I2C
transport errors were propagated during a physical bus disconnect, and
reads recovered after reconnection.

Concurrency testing used 10 parallel readers and repeated reads during
20 bind/unbind cycles. Lifecycle testing covered 50 bind/unbind cycles,
50 module load/unload cycles, module removal during active reads, module
removal with an open sysfs file descriptor, and module removal while the
I2C bus was in an error state.

KFENCE, UBSAN, lockdep, and kmemleak reported no issues. KASAN was not
enabled because 32-bit ARM currently selects HAVE_RUST only when KASAN
is disabled.

Muchamad Coirul Anwar (4):
  rust: io: add FallibleIoCapable
  i2c: rust: implement SMBus access via IoBackend
  rust: add minimal IIO subsystem abstractions
  iio: position: add Rust driver for ams AS5600

 drivers/iio/position/Kconfig    |  11 +
 drivers/iio/position/Makefile   |   1 +
 drivers/iio/position/as5600.rs  | 177 ++++++++++++
 include/linux/iio/iio.h         |   6 +-
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/bits.rs             |  29 ++
 rust/kernel/i2c.rs              | 248 +++++++++++++++++
 rust/kernel/iio.rs              | 480 ++++++++++++++++++++++++++++++++
 rust/kernel/io.rs               |  66 +++--
 rust/kernel/lib.rs              |   2 +
 10 files changed, 1000 insertions(+), 22 deletions(-)
 create mode 100644 drivers/iio/position/as5600.rs
 create mode 100644 rust/kernel/iio.rs

-- 
2.50.0
