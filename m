Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81F8231A21
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 20:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780174504; cv=none; b=Us0S/+GiXBgSCEY0m85edHLInnR8ptRGTWXN9lJ6CwvYosARlOz/mAi1QerspbJ0j+JMQ6D2WW0QCa3qSjwGbdphrkywnvC1ntO1zUUbCMzUQ7BRZlN/vHmAARzr+e0ERQ61PG1QDCzVnQn018xwcyahRYU0c/o0B068nodO1yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780174504; c=relaxed/simple;
	bh=UiqUdZNRF7eardJd3hONfjjKT3P6JjWYLeCZRDbyVpE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SwFkD9tntYq0uYOFia0yqoc7oW9yBK3O84l8uXwfv1o3+vwYnTxNPsuZ3zJRPE3dTQ7Z/Rzauer3bXJ9OLTOo/1ShBmwDQvjSbmcRg+b1M+DAxtw9NK2axHushEwTO+kmZntGwKR9p6ABAijBe7eMXuhqUnRwY+SjLtomlIO4WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZKZoFlc; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZKZoFlc"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so95312275e9.3
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 13:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780174501; x=1780779301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kyzq+icHZHQh6+UykHH+7FDE4tjYOIwMXwyjQtjbacI=;
        b=YZKZoFlcEnQZdIKP8a+fd2cS/s2XuRxAleD6rthrYUq6O7pI9ofeXNDVOPxDxR282N
         gUNam4BcRWG0neacbHhsd7QX+2YoAIxKy7RfUUNlpt+2Bcx+/+wURYXlUg8PGunr711A
         eqViPW0J753Jg1sFGsBifa0sSmy4iTJz0jEtfEOMH2g5++Z7FjIU24RvThu5nF04/VkL
         pDdml7B06MaBMD6J9JnSZt1nMfj175VP8jeoUEFAsfbFYpqopTPkPO4dNFGTywxXBUoH
         V50srfCzFLq3Q/+zKKldXMxfrV6v54ixvkEq8llubiBelA2zqOVUhTVr8AD+yGh62Faz
         99mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780174501; x=1780779301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kyzq+icHZHQh6+UykHH+7FDE4tjYOIwMXwyjQtjbacI=;
        b=ioMkdi67xBQMeRgieHdBCFVZINaaGjnalyq3RExhqgtgBkzO/iPOjVcN7ZR6mGp5bw
         vLaGP44U3KHGGZ8wqznkzbeNPoEKwo3CHDd7QIE5QwXqThCpQlje0H3Uwcm+C1+sm3Lm
         tFeyKVUEowaHPfbMq8B2RLI0ugP2uNK/mHoqSYQbBEsSi8VOyg5ERPtqZCoiv16ROxY7
         LEoeNXnd+BoKQb3ASf/ABQsFc59N8bJsTvKTih+oNoTTiohYyM5zJXmo/A5f4ovZWeD+
         dovti0Kx5VLU1PhBq33NLNrXXR0IRtdBmd683lECUCP2nDrtfibzLTIKw76M5Drdp1Ot
         arDQ==
X-Gm-Message-State: AOJu0Yy84I5a2qsN8D1h59CC6PGUQAkxN+fWRKupExX1IfLytjlWkWBx
	MXRCgNGuS7+Ph7nJ9U4jfXmiAfTzhry8jMUDlFfzi88RIDgmQcEJ6p5c
X-Gm-Gg: Acq92OF1G8gr4ei6O2Y6tiknOGIt5/+2KWjcJtU9OOKrX8VUhgwSYXMRHgbfEmISkXS
	bWJCqJ6N4T8hx1YMsVu1JnpBrdfeo/c1etvjUKwggCt9KAJ9S26hdzX3GVcY1bjSwma6toJA6Dh
	tHPiZfR9zkNFEnZPRti0yQfB1sosl1F+WqzVB1+v4nFTsdKRXwZ4hL+6lN0NL14SC78kOVVxj+2
	EjeG8BHml5hSvv7MQc8gg7Tpc/kMlejj+NdPaTdluvulNgCSZfosQl/xvXKQMVfxnOwzHM6NQAN
	8pVM7bEpWzJOEZxHp5/qawJ9fEe/o/WrgGfLS2kcapg+e+9SbEUzpy0b4/Pv1Ok5Sy6c0GGLkO+
	d3oKdv1XVu2MOtNNpLOL6ucfPBYOx0BB/BPuSqPQ92ylbyyyMg6YmhOUHioBZOw8+XNpu7rpYR8
	ZR0VPiC7fYfgo/R3k=
X-Received: by 2002:a05:600c:6008:b0:488:a882:c7 with SMTP id 5b1f17b1804b1-490a2963f07mr65009115e9.25.1780174501228;
        Sat, 30 May 2026 13:55:01 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909cab0e94sm132288225e9.12.2026.05.30.13.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 13:55:00 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] iio: flow: Sensirion SLF3S liquid flow sensor
Date: Sat, 30 May 2026 22:54:29 +0200
Message-ID: <20260530205435.37326-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

v3 addresses the per-patch review feedback from Jonathan (driver +
cover, https://lore.kernel.org/linux-iio/20260528124413.6c91e1bb@jic23-huawei/)
and Krzysztof (dt-binding,
https://lore.kernel.org/linux-iio/20260528-transparent-adventurous-python-af8f69@quoll/).
As requested this is sent as a fresh thread, not in-reply-to v2.

The IIO_VOLUMEFLOW patch (1/3) is unchanged from v2.

Changes since v2:

  * dt-bindings: drop the generic-only "sensirion,slf3s" compatible;
    the per-variant compatibles stay (-0600F, -1300F, -4000B)
  * dt-bindings: drop the optional interrupts property -- the driver
    is polled-only and the binding should not advertise something we
    do not consume
  * dt-bindings: drop the sensirion,medium property and move medium
    selection to the IIO sysfs in_volumeflow_medium ext_info enum;
    the sensor starts in water mode after probe and IPA is selected
    at runtime via that attribute
  * dt-bindings: MAINTAINERS no longer claims drivers/iio/flow/
  * driver: includes cleaned up per IWYU (drop property.h since no
    DT property is read any more, add array_size.h / dev_printk.h /
    device.h / errno.h / types.h / units.h)
  * driver: drop the SLF3S_MEAS_LEN define in favour of ARRAY_SIZE()
  * driver: inline SLF3S_TEMP_SCALE_MILLIC at the call site with a
    short comment that explains the 1000/200 ratio
  * driver: use 600 * MICRO / 30 * MICRO / 1920 * MILLI from
    linux/units.h for the per-variant scale denominators
  * driver: slf3s_send_cmd() takes cmd[at_least 2] (kernel idiom)
    rather than cmd[static 2]
  * driver: detection wins over the DT-supplied compatible; a
    mismatch is reported with dev_info and the sensor-reported
    variant is used
  * driver: SLF3S_MEAS_START_DELAY_US bumped to 60 ms (datasheet
    section 2.2, tw) and a 25 ms tPU power-up delay is observed
    between regulator enable and the first I2C command
  * driver: blank line before plain return statements; minor reflow
    to 80 columns
  * commit messages: drop the manual Cc trailers (get_maintainer.pl
    handles those) and move Signed-off-by to the end of the trailer
    block

Patches:

  1/3  iio: types: add IIO_VOLUMEFLOW channel type (unchanged)
  2/3  dt-bindings: iio: flow: add Sensirion SLF3S binding
  3/3  iio: flow: add Sensirion SLF3S liquid flow sensor driver

Tested with an SLF3S-0600F on a TI AM64x platform; W=1 build clean,
checkpatch --strict clean, dt_binding_check clean.

Thanks,
Wadim

Wadim Mueller (3):
  iio: types: add IIO_VOLUMEFLOW channel type
  dt-bindings: iio: flow: add Sensirion SLF3S liquid flow sensor
  iio: flow: add Sensirion SLF3S liquid flow sensor driver

 Documentation/ABI/testing/sysfs-bus-iio       |  11 +
 .../bindings/iio/flow/sensirion,slf3s.yaml    |  49 +++
 MAINTAINERS                                   |   8 +
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/flow/Kconfig                      |  27 ++
 drivers/iio/flow/Makefile                     |   7 +
 drivers/iio/flow/slf3s.c                      | 406 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |   1 +
 include/uapi/linux/iio/types.h                |   1 +
 tools/iio/iio_event_monitor.c                 |   2 +
 11 files changed, 514 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
 create mode 100644 drivers/iio/flow/Kconfig
 create mode 100644 drivers/iio/flow/Makefile
 create mode 100644 drivers/iio/flow/slf3s.c

-- 
2.52.0

