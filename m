Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D115B4749E8
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 21:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275389; cv=none; b=NFEW00wcJV1n3L7aW6313tRF9HldIpfu2TlikLJaHSXd5hzOrIo8gW3eJh5nqDV5mFId7FD4FoqpKGzpi2VU6a6h3BD8lASXyxJolFTcva08tOhMeDEnalvO7NvYXpYeh6jmkFcTAyaGmtnoBtqaokyXL8ju2QRgwucnwRN6pHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275389; c=relaxed/simple;
	bh=m9WTyRPX3CTtev1o3PhO9FQYiIljtJyc2OUPXlP9aws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fXdoG92TMIzGaskoCJ47FsX+nH6wLdAb1di6jrJ3B2Tk9B1vTGjStMKSHAUbsFAC8sa9exNEHNDIQIjQICM8bBSmn9EkmP+HtyRpyr5o/yKHnEaVGUr5yfCOhv/rGGzS8WkFp2sjulcY2iF44DYn8P+vA/jkutlCBwdlgDmjrkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mivd/mB3; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mivd/mB3"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso308855f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 14:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785275385; x=1785880185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3yJJxjA4jwLPit1RMUh+Ow88Dp8B6i7wdRDxZCyrLZ8=;
        b=mivd/mB3M05A/q2m7edWivA+7W2G+KzUP/7RKMMO0O9QHd6wzF669SOk6SF5Ri81jx
         kDdWmY6x2ZemZ74q0zT3ceS7Mcp8krmZeeMtvtf9vD5fDvFjkYG9MwL1yr8XMUwy/7vS
         +LONnfurBcYdKPaZ+DsMxNu0DGVSzMuB60iAQjUYS7JfcVgHldzBtJ7a7vACWrkj+GT0
         ucB01ZOYrRJ5cKmQq2nVvmXPHBSZKdac8mWqoYFM9Wj6mAGnWojypkDlCW3wo7pP8Qip
         PaiuaHgtJMeJt8UrZSm3ALWJ02roDuSubcV16Ivi4T3Pz06ftEfAU/vfuQorRMD6HzO3
         e63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785275385; x=1785880185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3yJJxjA4jwLPit1RMUh+Ow88Dp8B6i7wdRDxZCyrLZ8=;
        b=VaZK2RN35WSMQP8SwMiwnoLkeRzW15ogor3pnuB3xEQGYKHVFgZBqg6+XNJ72LDKCz
         QVCSItSGYw718el2b1CxjtJ4mPIwQR8zOnl0zMaEAuVoEnWMuzGROn8nYd1SnCjBxTiN
         2PjLY2L3/vBUtxtMrAHsrPO+VvT2zXMUZxSicXnLsvy45idHgKrCHt7pOAc7Mz+PBZvL
         xjpATFa4DfpSo+dwvTOPJdXI88HGyYQCCsWwah1gkOPoPcnYaVTd5PnuGndpQqgNbdTJ
         PJe4gJNdodSNkMUdTRKKTdp80Kig3Xg1Hmf+rCfJiM63JHyA3bkSdJyAg6CnJgjXDLhX
         B4EA==
X-Gm-Message-State: AOJu0Ywqrh3HDGd1fM4w/PR321za+urmK6GJKUmVfjf9fk5ZVCRWuR+0
	cKlZ5oczypt13jNlyjzw3el4dDyn2eE2Ya0R1fAYNSIpBmb7gIPfeEAO
X-Gm-Gg: AR+sD10Ndep71+iXdobgDEoASNHsb1xm442eQD41+Mve7t4zTJPBoYPdudTiQn18QBf
	QdsSQpMQiFNJJ3Wpy1lglBP7ga6L46TPwqavCtfJM8kN/Eg/y4LZQNKcSqq1sz+QLREz0ioPKPj
	9Mz0tPpSCAGUisSc8IN4zjLyyK4Ti6SKfv5huKSmqqCpih5QeGSvYMMYCXkoYil4foksnCMpEWh
	rBug5JKyzPL7AAgshVN+6T22bez13MmlZguJ2dPEHRKLe7klip1bqNCEuJ869hOzQ1NnOKI4GSQ
	JFZVioDy1+8b4GvrkkdGiLlJQhy4TXnqQBeIOvGMlkGHoUqC/vvA153GnOvbiXvDpl9db5FFwwQ
	fzX0WmgiIhzD9Oz1xwQdaCRZt1fFMOuw5j4+JPov2sMhduNtfRk+LjRRWR60=
X-Received: by 2002:a05:6000:2685:b0:47f:8810:cc64 with SMTP id ffacd0b85a97d-47fb1e6cea4mr5113712f8f.19.1785275385017;
        Tue, 28 Jul 2026 14:49:45 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6b0ef25sm2353042f8f.24.2026.07.28.14.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:49:44 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: jonathan.cameron@oss.qualcomm.com,
	krzk+dt@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	maxwell@maxwelld.cc
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt1@gmail.com,
	455.rodrigo.alencar@gmail.com
Subject: [PATCH v6 0/4] iio: flow: Sensirion SLF3S liquid flow sensor
Date: Tue, 28 Jul 2026 23:49:39 +0200
Message-ID: <20260728214943.29820-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
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

First of all: sorry for the noise.  Patch 4/4 of v5 never made it to the
list or to patchwork - it got lost on the way out from the machine I sent
v5 from, as Jonathan noticed:

  https://lore.kernel.org/linux-iio/20260720032927.14fc4f9f@jic23-huawei/

So this v6 is mostly a resend of v5 with the driver patch actually
included, plus the binding change we converged on in the meantime.  The
driver changes that were listed in the v5 changelog are repeated below,
since nobody got to see them.

The series is based on iio.git testing, which already contains Rodrigo
Alencar's IIO_VAL_DECIMAL64_* core formatting work; patch 3/4 adds the
IIO_VAL_DECIMAL64_FEMTO format type on top of it.

Changes since v5
----------------
  * 4/4 is included this time - v5 only had 1-3 on the list
  * dt-bindings: dropped the fallback compatible entirely; each variant
    now has its own compatible, per the conclusion of the v4 discussion
    between Krzysztof and Jonathan.  Since the driver has to look at the
    product-information register anyway, a fallback buys nothing, while
    separate compatibles let a future drop-in part claim a known
    compatible and work on older kernels
  * dt-bindings: dropped Krzysztof's Reviewed-by, since the compatible
    schema changed
  * dt-bindings: commit message and example updated accordingly
  * driver: reworded the slf3s_detect_variant() comment and the commit
    message, which referred to the now-gone fallback compatible.  The
    behaviour is unchanged: an unknown sub-type still falls back to the
    variant named in the device tree / I2C table
  * rebased onto current iio.git testing

Changes since v4 (from the v5 posting, repeated because 4/4 was lost)
---------------------------------------------------------------------
  * driver: include err.h for PTR_ERR() and math.h for struct s32_fract,
    per Andy
  * driver: fold the per-variant scale_num/scale_den pair into a
    struct s32_fract, per Andy
  * driver: add enum slf3s_variant_id and use it for the variant table
    and the I2C/OF match tables instead of bare indices, per Andy
  * driver: slf3s_send_cmd(): drop the "at_least 2" parameter
    annotation, decouple the ret assignment from its declaration and
    check errors first, per Andy
  * driver: use sizeof() instead of ARRAY_SIZE() for the measurement
    byte buffer, per Andy
  * driver: parenthesise the (FEMTO / MILLI) factor so it folds into a
    single constant multiplication, per Andy
  * driver: derive the temperature scale from MILLIDEGREE_PER_DEGREE
    instead of a bare 1000, per Andy
  * driver: checked the struct slf3s_data layout (re Andy's pahole
    question): the non-pointer members total 260 bytes, so one 4-byte
    hole remains for any member order; left as is
  * driver: drop the inline comment on the mutex that duplicated the
    kernel-doc, per Jonathan (checkpatch still moans about it)
  * driver: fix the duplicated argument in the DT/sensor variant
    mismatch dev_info(), per Jonathan
  * driver: reformat the i2c_device_id/of_device_id tables to one
    member per line, per Jonathan
  * MAINTAINERS: updated Maxwell's address in the R: entry to
    maxwell@maxwelld.cc, as he requested on the v4 thread

The signaling-flags word (air-in-line / high-flow / smoothing status) in
each measurement frame is intentionally not read; exposing it can be a
later follow-up.

v5: https://lore.kernel.org/linux-iio/20260714085358.20842-1-wafgo01@gmail.com/
v4: https://lore.kernel.org/linux-iio/20260611132700.671322-1-wafgo01@gmail.com/

Thanks,
Wadim

Wadim Mueller (4):
  iio: types: add IIO_VOLUMEFLOW channel type
  dt-bindings: iio: flow: add Sensirion SLF3S liquid flow sensor
  iio: core: add IIO_VAL_DECIMAL64_FEMTO format type
  iio: flow: add Sensirion SLF3S liquid flow sensor driver

 Documentation/ABI/testing/sysfs-bus-iio       |  11 +
 Documentation/ABI/testing/sysfs-bus-iio-flow  |  21 +
 .../bindings/iio/flow/sensirion,slf3s.yaml    |  55 ++
 MAINTAINERS                                   |   8 +
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/Makefile                          |   1 +
 drivers/iio/flow/Kconfig                      |  22 +
 drivers/iio/flow/Makefile                     |   7 +
 drivers/iio/flow/slf3s.c                      | 543 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |   3 +
 include/linux/iio/types.h                     |   1 +
 include/uapi/linux/iio/types.h                |   1 +
 tools/iio/iio_event_monitor.c                 |   2 +
 13 files changed, 676 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-flow
 create mode 100644 Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
 create mode 100644 drivers/iio/flow/Kconfig
 create mode 100644 drivers/iio/flow/Makefile
 create mode 100644 drivers/iio/flow/slf3s.c


base-commit: e0484d62e8e1cff75b210938be835ea6221bda59
-- 
2.52.0

