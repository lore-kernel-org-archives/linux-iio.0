Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CC53FFFB9
	for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 08:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784019243; cv=none; b=FqSVI13xRo3YjvroRmO5BoM1beKaIhExVTa+A3F+W0oof4T2MmtsOwb6ZkHISuvu/FNn54tGYtmHDHzMBL/2TniiGzcDNK6YZJyWOtY1tPjpJhxJpB8jpPzNq+QFpvu2JY0PUI5aXd3xd9ytTFCFvKMZmcu8C+JOd/1QzzgASWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784019243; c=relaxed/simple;
	bh=Ls762+nAcAVDOYe/ETAhtif9vkax21EL6tHiK3Msxec=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P6IdbhY0v8tCCo1CB+7k2PSlQAxgOcEXZmv619PW8ownV+a2vq0vbIdcR8SFGXc9N7cU6023P3ixNu0Q+8HurYwOqexXsiv+nRG6bhL5nXC6G7Dj5VI77l2yQbMjeOecU7zlhQWce2Imc+Vkov5G/5igQZn5zyuXOkJ9HM+Wck0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMs3pkp4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMs3pkp4"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c15ba3a2b4bso472109066b.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Jul 2026 01:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784019239; x=1784624039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IloFAxB4P354MyLVrL9b3phaMa87Mw8VkBQn4mh2aH4=;
        b=cMs3pkp4rUU8zI6Gpj5GYT4I+4WHOAywLq/M7VMXzKX1WLk3eghF6BdeURQ8/S8b5W
         b6A6+Wkk73TN3vr9rwlQp5ehbx5MnKZn3cpeq3/A7yJRs+qhU7XF8N5lUNwMbZ5pk949
         /4FHurP1glAQksZKCoFRe85iXGYvvXAhJaK/960AEBGHwwVLthMgEovQN8qGgugNV4bq
         Bi3m5jgfy5tyhjVqORr6yGW1Vd4XpJlUEaXNf0c7UZnyB4Ue4GfEp/0O5B49lbAUyFAa
         hRAGbn+UNIMyY308rCD+dBKqv1IyCpcA54USVU0T5344gcEGOsKHuxMmcjwY46grWGDc
         3Ysg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784019239; x=1784624039;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IloFAxB4P354MyLVrL9b3phaMa87Mw8VkBQn4mh2aH4=;
        b=P8QfTmszFzBzARE29KHpM86HYHlqZMpqV/cwoR6IMFWNyqX24oT8Sc8LDv667guCFT
         DytzRC2Ln6pNKoVGmy4ep56GaBu9+Q58ix7gUKvYonN6xpApYNRnrcCCXYm83AskJS7T
         Qo0iXGjmYTSDndjsy5uKQxlQgGaydqoQDysaHGMriGiduzJVSUIvIU5h8OvnMQDPxIn/
         dUxh/MYykLFKBgdUlgcgI9vvuY2FwtbehzHZ5pAHzVsGCTzVvkJ2oAiDiRsZdhmENm61
         dQ6+tBmQ2nQWYh+i08Zr39xilMRZMrRDNnrDjtCIF21bq074zkuhdG7JEUF7dEMeL7kc
         7ofA==
X-Gm-Message-State: AOJu0YwX2iZRd59nkI9QkNxTbXcUAX5NX37D6j3SB+CJ6JYKrm54abg4
	/8EVJbhF0DjotX7WWYXYeAbLO6jviTiyQ9i/fMITMYTg2/ch4U3MGlQ/
X-Gm-Gg: AfdE7ckJHtV3aLwVeU/+BtEc5m7eTzyRWthBntp184X997pThBpCzczIw9dvRbQSthF
	q8EPAXa4msDa/ws4t8UXhnMgUCtt4hWOUsS/PIdWGcTThmcNdp2AynlpWkVofx6CJDB/OcZyQeC
	hLgh/s3xY9SUq/6FLZsl3zsKYL4G6zJYtikMhrB9MEMGy5dKqyRp/UN23qVfTxVSfe6pocegAM6
	63cax0aPUfm0FgWdbLdcrPW7yebMLFZECqF/xV+G9j2Ko7VqENefzEmCtFb0WVyXC078MYtNqww
	1ghOhHMC3Gmt1fGMPDpCOWvhOE2gHdn+WuubyeffQZF3ORqHlJJf/GdRCsDN5IrfQk9vKJ0g+8Q
	wLLP65h95zM9HEe8lUHXW6RCRH+llBMDZHpGmdMFwsF1YrrTjx6BbOwEFQFgpp7/aBt3d9iEQo3
	+Q6Ry75GJ/30K4B39D0O/n/1uRuwFVYO9vkiQ=
X-Received: by 2002:a17:907:94d4:b0:c12:764e:324 with SMTP id a640c23a62f3a-c166161cd2bmr108616766b.7.1784019238995;
        Tue, 14 Jul 2026 01:53:58 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ad82279csm1143689366b.13.2026.07.14.01.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:53:58 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <maxwell@maxwelld.cc>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Subject: [PATCH v5 0/4] iio: flow: Sensirion SLF3S liquid flow sensor
Date: Tue, 14 Jul 2026 10:53:54 +0200
Message-ID: <20260714085358.20842-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

this series adds a driver for the Sensirion SLF3S family of I2C liquid
flow sensors (SLF3S-0600F / -1300F / -4000B) and a new IIO_VOLUMEFLOW
channel type.

The series is now based on iio.git testing, which already contains
Rodrigo Alencar's IIO_VAL_DECIMAL64_* core formatting work, so the
external dependency listed in v4 is gone.  Patch 3/4 adds the
IIO_VAL_DECIMAL64_FEMTO format type on top of it.

The compatible/fallback layout of the dt-binding is intentionally
unchanged from v4 while the discussion on the v4 thread about the
preferred fallback scheme is still open:

  https://lore.kernel.org/linux-iio/20260621145117.70b2d50e@jic23-huawei/

Changes since v4
----------------
  * rebased onto iio.git testing; trivial conflict with the new
    IIO_COVERAGE entries in the channel-type lists resolved (1/4)
  * driver: include err.h for PTR_ERR() and math.h for struct
    s32_fract, per Andy
  * driver: fold the per-variant scale_num/scale_den pair into a
    struct s32_fract, per Andy
  * driver: add enum slf3s_variant_id and use it for the variant
    table and the I2C/OF match tables instead of bare indices, per
    Andy
  * driver: slf3s_send_cmd(): drop the "at_least 2" parameter
    annotation, decouple the ret assignment from its declaration and
    check errors first, per Andy
  * driver: use sizeof() instead of ARRAY_SIZE() for the measurement
    byte buffer, per Andy
  * driver: parenthesise the (FEMTO / MILLI) factor so it folds into
    a single constant multiplication, per Andy
  * driver: derive the temperature scale from MILLIDEGREE_PER_DEGREE
    instead of a bare 1000, per Andy
  * driver: checked the struct slf3s_data layout (re Andy's pahole
    question): the non-pointer members total 260 bytes, so one 4-byte
    hole remains for any member order; left as is
  * driver: drop the inline comment on the mutex that duplicated the
    kernel-doc, per Jonathan
  * driver: fix the duplicated argument in the DT/sensor variant
    mismatch dev_info(), per Jonathan
  * driver: reformat the i2c_device_id/of_device_id tables to one
    member per line, per Jonathan
  * MAINTAINERS: updated Maxwells address in the R: entry to
    maxwell@maxwelld.cc, as he requested on the v4 thread

The signaling-flags word (air-in-line / high-flow / smoothing status) in
each measurement frame is intentionally not read; exposing it can be a
later follow-up.

Thanks,
Wadim

Wadim Mueller (4):
  iio: types: add IIO_VOLUMEFLOW channel type
  dt-bindings: iio: flow: add Sensirion SLF3S liquid flow sensor
  iio: core: add IIO_VAL_DECIMAL64_FEMTO format type
  iio: flow: add Sensirion SLF3S liquid flow sensor driver

 Documentation/ABI/testing/sysfs-bus-iio       |  11 +
 Documentation/ABI/testing/sysfs-bus-iio-flow  |  21 +
 .../bindings/iio/flow/sensirion,slf3s.yaml    |  58 ++
 MAINTAINERS                                   |   8 +
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/flow/Kconfig                      |  22 +
 drivers/iio/flow/Makefile                     |   7 +
 drivers/iio/flow/slf3s.c                      | 541 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |   3 +
 include/linux/iio/types.h                     |   1 +
 include/uapi/linux/iio/types.h                |   1 +
 tools/iio/iio_event_monitor.c                 |   2 +
 13 files changed, 677 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-flow
 create mode 100644 Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
 create mode 100644 drivers/iio/flow/Kconfig
 create mode 100644 drivers/iio/flow/Makefile
 create mode 100644 drivers/iio/flow/slf3s.c


base-commit: a50909aa46dec46de3c73235fc15a7d6f763d996
-- 
2.43.0

