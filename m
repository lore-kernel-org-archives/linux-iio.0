Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA803264F5
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778440223; cv=none; b=Y95DOEUwsOmz0C11JdieCc1DjYQDsZlfH1tOdKokbUP+5NPhWofUpEVt6MlnxJFMafc098SyIbcoZeoWLKSFxDwNbNEaVBd7jEu3VlWJ18m/nMBEO1JVf/IAvm1jaDn+HAmtDvZn2YjrWor8I49/dZoPp/CKebzQ2t8zzAStM94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778440223; c=relaxed/simple;
	bh=4M89Z1PtLYhg7xWrkhOWRzVhNaUlFaflseDuSOzEK6w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BKYYUWlK3QtdCg9yfcFZ0D+mhe5AKJ4zzMiJ5WpYJK3jRDyQ/Y3w8A/AejriFKSv4dPwXFyawtzk96CqKAz6R+HFrnDD2NVFoqpA5oWvR/kMsOMON9te3OS+8DJwrdyaWt5K4Ui9te9GETTIdGTs+bUlHQ6mS39JcmQUai2cCTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s3WzgFUx; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s3WzgFUx"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2b788a98557so26465785ad.2
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 12:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778440221; x=1779045021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ob0ZbbyCxM8PinaaIzSEYPIxsXFv1SXQq5I/2s/H6uQ=;
        b=s3WzgFUxV0KXSGwP5oaQC2Na9uDpt7o/M4avHf2LW4n+iyKvQ90Y6w3YsIHqblPJJY
         +DM9IGmK+PUycQrQeVJ+A7R8nRty/wpgsP9dqbhH2bZ1pGlj5Ff9oPdQZzftbBnSTzR/
         2LZi6w3cVVkmjKT5cP4A212CTnT+RwXwcGz7dgvLmiCjDxI5WzCwHjtnIg2V46DogbzL
         FvQBCwA6Fk3AVukaptseidxuhi+w6hoJDr/p6ktvxEFzRUxSnBfjjfHiHZwANJFt+uO9
         nEQfedifsywO83HwOHPxopRJq2T5KdPgv/wvqQ9s0qKQY6zOjJb0VHrBRdjYN8zM7CXq
         qANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778440221; x=1779045021;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ob0ZbbyCxM8PinaaIzSEYPIxsXFv1SXQq5I/2s/H6uQ=;
        b=iU9tLJvG2DzDMMXKwhBsKvP+nhJP9BgPwTTGQirUEv0Sa3Agk6UB4y6S0h+7HzOT2V
         cgKVb+52Aac2PNV04o0ppPyWsXASIsSVQ+kLHBEBI8MkLcvK+CvuKdE8DxOBAs/4OhuB
         Y3jAa5WH+uk/oe6pZN4SokhdbjPXBK0hXhPNuhvmGYrc05AvRXvQA0Ex4idebkwBW0MO
         17K8DMGwV7yxg1TPkMF8yMUbzJ4fjGMhsxbxfQjTbuh+CzLLCxJQQwF3pTtJGl0GI7jD
         +wdKkkGXfpiJ72KmLkW4EWspEYCeHLxA7ZmaCI+hTmnELLKnZhOEU1LWAgGiT2pQuyoC
         OFJA==
X-Forwarded-Encrypted: i=1; AFNElJ/q/l6LRttldNaoewn6+jiCmrmAGAVD6aps3ZRBMlAZYb2j/XtnK3RwoNOweLETUNmVEWFwryi6ZNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKsB8xR9+GFM8kKzTBa8Aa6xYg7Hw3PAcBqyzIJhG48yXHodxI
	V/3gOaY4N3RNp6ApTDn+JXs9AUNILuc4AMOLogpNHzPTJDSSntApCzU=
X-Gm-Gg: Acq92OErnAuAkPUuOFt7u00s5AhWrmB2LhB9HTtH8prOGBAz9TIQ0wqI9xzkVdiQa3N
	Ve/XOX6XF+sfzqnVczT4BJYGi2l6MKXwjXBY/qd+TgY0EJXT9zgUEXSgBjnJQE9gAkljfgNfj1h
	wRnnGBIfaobLAfV9t+SYLLMvlei8Dw6QiNVtL8tR8OLJ/2guoJQ9FoXMqiK1I1V5tjeRtyEOP7A
	1iAg5vRRaWQI9xhGPxMqRO2qHfLRM0ncZR/tyzEmbg254oo9Z0nzOXi89SvUACtXM09bA23z2iD
	bmDkGn9RLpNsF7akCBXwyy7XprULX2k66nPvvgRwZgCDUCsTV021kVDzYF70gLzWflS6o0PFaUt
	3Bgo7ZG+9ZkR/pxObimSPpJLe5HIlVFKsmkbU37T4cncb/LaVbqjKFEd8qeg7dAVdysLocqXRyR
	MGM774A5qYRELstWE0oNBDcknA566o6cQuptGSO/mqOF2MJKgKhuB4epuvq7SeOhpr
X-Received: by 2002:a17:902:e314:b0:2b9:86ca:5bf2 with SMTP id d9443c01a7336-2baf0e04a83mr84516495ad.30.1778440220905;
        Sun, 10 May 2026 12:10:20 -0700 (PDT)
Received: from localhost.localdomain ([103.76.103.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1c5466bsm81817305ad.0.2026.05.10.12.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 12:10:19 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [RFC PATCH 0/2] iio: magnetometer: add support for Melexis MLX90393
Date: Mon, 11 May 2026 00:40:08 +0530
Message-Id: <20260510191010.155380-1-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series adds initial Industrial I/O subsystem support for the
Melexis MLX90393 3-axis magnetometer and temperature sensor.

The MLX90393 supports both I2C and SPI interfaces. This RFC
implements support for the I2C interface while keeping the driver
structure transport-independent to simplify future SPI support.

Currently supported features:

raw magnetic field measurements for X/Y/Z axes
raw temperature measurements
configurable gain/scale selection
configurable oversampling ratio
direct mode operation through the IIO subsystem
initially I2C support for this driver

The driver has been tested on Raspberry Pi 5 hardware using an
actual MLX90393 sensor connected over I2C. Raw magnetic field and
temperature values were verified through the IIO sysfs interface.

A custom transport abstraction was used instead of regmap due to
the MLX90393 command/response protocol semantics and repeated-start
transfer behavior. This approach was discussed previously on the
mailing list and seemed preferable for this device.
Link: https://lore.kernel.org/linux-iio/20260424114818.1290b029@jic23-huawei/

The implementation intentionally focuses on a minimal and reviewable
feature set for the initial RFC submission. Support for SPI,
buffered capture, triggers, interrupts and runtime PM can be added
incrementally in follow-up work.

The DT binding schema has been validated using dt_binding_check and
the driver has been checked using checkpatch.pl --strict.

Feedback on the overall driver structure, transport abstraction,
IIO ABI usage and DT binding would be appreciated.

Thanks,
Nikhil Gautam

Nikhil Gautam (2):
  dt-bindings: iio: magnetometer: add Melexis MLX90393
  iio: magnetometer: add support for Melexis MLX90393

 .../iio/magnetometer/melexis,mlx90393.yaml    |  39 +
 drivers/iio/magnetometer/Kconfig              |  10 +
 drivers/iio/magnetometer/Makefile             |   2 +
 drivers/iio/magnetometer/mlx90393.h           |  76 ++
 drivers/iio/magnetometer/mlx90393_core.c      | 724 ++++++++++++++++++
 drivers/iio/magnetometer/mlx90393_i2c.c       |  71 ++
 6 files changed, 922 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
 create mode 100644 drivers/iio/magnetometer/mlx90393.h
 create mode 100644 drivers/iio/magnetometer/mlx90393_core.c
 create mode 100644 drivers/iio/magnetometer/mlx90393_i2c.c

-- 
2.39.5

