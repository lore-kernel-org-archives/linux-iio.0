Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EA62D949B
	for <linux-iio@vger.kernel.org>; Wed,  4 Mar 2026 08:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772611525; cv=none; b=n1evYAJSdprhjs8vix+FRVwGXEoHV8LGewIYRT0CpUgQ0r48tIQKcrUap3cJNz6lsS+JU7GmE9u7PWehZbyhcS+5fizX4FW2yeRWMe6YOZbZnFql5kiLtZqpFxbcnTI4wz0PIRx9kKuMFWq7jN0gFTF4c6aRc/0jatH33hBsjWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772611525; c=relaxed/simple;
	bh=jbvdwCO67VQhNtH/x9Y8g+kaY2YwPyaOvP1eTER+PmQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Y5Ijp7wpIH0j+jPQw9bfDWU1mhg3YhCCaH8iFwj6XsvmaQkbBUIv1mOMfbmixXlb95JbJqcCKhGXlYebFhyYdYsTIiVStXYC7rLieyJn0seySdsJ6UYonUW9KOTQ4t1GbOXGKosYsR42QhcZ03/Z1upjl0SkYutOFoPxrhKArig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dcY/MHz+; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dcY/MHz+"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48371119eacso79430285e9.2
        for <linux-iio@vger.kernel.org>; Wed, 04 Mar 2026 00:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772611521; x=1773216321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=d3DrrqBha7wqPGDbeVlwqOXZPaqgpO9jCysSLq6DJ3M=;
        b=dcY/MHz+j2U9dWSLnxm+W87344cWV6KcZFiJRUeWvm7ei/+YnZOmb2b0H9dSvdgrt4
         ouoFgbk2dtJ7ArWF+zshAb0Lad6f6IhJXRyKUZoYN50g/q2H5SWb3iHKJ0GlsyapTIxx
         iPFRGVV+ocnKYP/Jg/ZKImlqI5kQ1TYo07/01B3aNeyEgwZW0sdEAvUJXfbav3KkPQNP
         tfb3u+KXig1lrIEk02y6i4nii8Jta5JW2fa+ov9ZyhZeW5u9enzn84IdtcuMzYtVxJdk
         Qv84vUJORitvjUuLKTaAz4C2rkL9qSctSeAbFMWjOmXJVAVDQWe1SZvlDWIEgEIBgaxs
         opGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772611521; x=1773216321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3DrrqBha7wqPGDbeVlwqOXZPaqgpO9jCysSLq6DJ3M=;
        b=iVco5ljyrhCKMqLD4ticFs10SW+HNv8/0tjCsDD7//aVfMtrXALW1FXaaN1uetVo/R
         aazANRDAAIUVVm7vR3VUXsLcsMPX//Ta93izG0REDzkBXrE+AGBqasWtZOUlAIIe3pTX
         5AdZ2Kz/TRaTfh+gmi14KKhmjalDG4Lp6qzFiJUQuDFZmZLrCSCI5FqZhnhrOJ4QJUn0
         fwx9eSdEp7EO/qjmfqSr/F7T2uiXoUyY16hW34Gs/jXEvk/S9U/PMfb8OtGLNmkJ3DfT
         QTbfsloUb9W9kyKEUBoUBGgMUc4JIcLqMWlsPbXl3IvTGbwVw0ORBE7YIDwta1AXefB8
         seWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ8gBAe9q1ndTaPOU/P8Nesn8gpIye2vVBBdmhswq7VWL4TPDxhfMlQfPbf9S9d7kM/en8iQA6RbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9J4ZSwGXl3nLTTcbdxBrUW2KHlc4IN9Ypl/iQW6ZE//cVEhFk
	AAOphzsydL1Zx1gxi2Cdxx0nbcdsCOZwnT4HFKjk4fqKzNxe1ZZjn1OcN0mfSwwFxtI=
X-Gm-Gg: ATEYQzyfnzKGW8KFUKYaFwfbMX9z952F+NwoDsA9peOnyBHzNui9YNK5QU7ATYIVUCX
	1ZzH1BQskI3kn08YnHbGFBWXrAm96iwRGXDqsZx/LFb5TP9meK801xjKMHEIoX+4iVGokLyccQJ
	DmhvuOUY7DHSk2o439yfQPsU8TglDruzLQyxcK2vTKqsT8ikqBB8UzqOAFKY2JFQ4hhshFYpeq1
	O5+mT+JVWaAKrnCAmqxe9hAC0TJgR6L17cuLEHFXoQ5pnpbx+o0SMVa5UTedMBJk8nY1d/S0MXM
	mrb2Zqk0MLOkN2jCQs6S/tg0CnjrTVcEPXH1RzbYnMBs+coOlGufV9kzGCHpZdxZWVOjNj6Addc
	4afKjR2dnbJI7kjqKQSqd0P0FbkkDQUjuLBiPSxWKgJXIqDQKcqxSV3pArymuJ+u7U+Zo
X-Received: by 2002:a05:600c:45c6:b0:483:badb:6191 with SMTP id 5b1f17b1804b1-48519848c97mr14311475e9.8.1772611521196;
        Wed, 04 Mar 2026 00:05:21 -0800 (PST)
Received: from localhost ([151.19.177.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439c2f8c0e7sm8290307f8f.29.2026.03.04.00.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 00:05:20 -0800 (PST)
From: Francesco Lavra <flavra@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/6] imu: st_lsm6dsx: Add support for rotation sensor
Date: Wed,  4 Mar 2026 09:05:19 +0100
Message-Id: <20260304080519.2844101-1-flavra@baylibre.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5064; i=flavra@baylibre.com; h=from:subject; bh=jbvdwCO67VQhNtH/x9Y8g+kaY2YwPyaOvP1eTER+PmQ=; b=owEB7QES/pANAwAKAe3xO3POlDZfAcsmYgBpp+dCVCyMxiqoUYwbHAmaC8ervlrN+2TIaDavM 0vUnrzPqg2JAbMEAAEKAB0WIQSGV4VPlTvcox7DFObt8TtzzpQ2XwUCaafnQgAKCRDt8TtzzpQ2 X6MIC/0Xhyvs6mV/L1G9aPGERnKepHEFwFg5GkAZXwkTMcy09CZo08Vb7RCBtjwLMNCs5dvYwg2 Oq+WlYPxAJwdqqyRnE5iIPggjM2wR18Fmmf9UnG1GnYPMrx+MkMuDtUrRIOdJK63vGW24xYJoPq ySgzjIAEJGKstWxcfB05HXu1VbIcgRZ0Czh7MrddCkxj/8OfwCn92Za8SRPOtxklTb7zyBgRY/S oIaq8ijaWyZTIBRjnMY9qkvzK2oAaVhI5g4mAjncqdApN6JWk8xKopi1oRU91yxvszztZDUG76q QdH+vWoLKSyQK8A2NJizDfMMWLPy4Od8OYgIrn54HIh5gy09q1ue3Zo21jB9tBDMrC6pgTfMNBz PkAiq5BUmUW2tpyn+6HVer8fbMOM0+IH7DuWKWWIyHS1W33whkTpeC0fzGepD9VMsNTfqS8/LNM ch6FinORscV0lRqzgX1xtm6N8ZuW8a/rwrNTxnwUK3WKr68A8qpll7VJFswSYaOJFYXaM=
X-Developer-Key: i=flavra@baylibre.com; a=openpgp; fpr=8657854F953BDCA31EC314E6EDF13B73CE94365F
Content-Transfer-Encoding: 8bit

This series adds support for the rotation sensor functionality present in
some chips from the ST LSM6DSX IMU family.
The IIO ABI has been amended to allow the use of floating-point data and
a "partial quaternion" channel modifier in IIO buffers.
Tested on LSM6DSV16X.

Changes from v6 [6]:
- dropped patches 1 and 2 (already picked up by Jonathan)
- added floating-point support to iio-tools (Andy)
- replaced `sign` field in struct iio_scan_type with union instead of
  `format` field (David, Jonathan)
- changed [s|u|f] to [f|s|u] in ABI and driver documentation files (Andy)
- removed IIO_CUSTOM channel type in favor of IIO_MOD_PARTIAL_QUATERNION
  modifier (David, Andy)
- replaced "sf" with "fusion" in type, variable and function names (David)
- added copyright statement in st_lsm6dsx_fusion.c (David)
- added `ret` variable in st_lsm6dsx_fusion_probe() for better readability
  (Andy)
- modified data structure holding the list of available frequencies in
  order to replace device attribute with .read_avail callback (David)

Changes from v5 [5]:
- cleaned up FIFO data representation in st_lsm6dsx_read_tagged_fifo() to
  avoid casting (Andy, Jonathan)
- renamed 'sign' field to `format` in struct iio_scan_type
- added support for IEEE 754 floating-point format in buffer scan elements
- added custom data type in the ABI (IIO_CUSTOM in enum iio_chan_type)
  (Jonathan)
- added driver document in Documentation/iio/ (Jonathan)

Changes from v4 [4]:
- changed data parameter in st_lsm6dsx_push_tagged_data() to __le16 *
  (Andy)

Changes from v3 [3]:
- added patch 3 (Andy)
- removed unneeded checks for negative return values in st_lsm6dsx_fusion.c
  (Andy)
- replaced st_lsm6dsx_sf_set_page function with
  st_lsm6dsx_sf_page_enable/disable (Andy)
- used reversed xmas tree ordering for local variables (Andy)
- added parentheses to MILLI / MICRO in st_lsm6dsx_sf_write_raw (Andy)
- added check for string truncation in st_lsm6dsx_sf_probe (Andy)

Changes from v2 [2]:
- amended description of patch 2 to point out that there are no supported
  gyro events (Jonathan)
- removed superfluous parentheses in st_lsm6dsx_fifo_setup (Lorenzo)
- added Lorenzo's acked-by tag to patch 3
- added missing checks of st_lsm6dsx_sf_set_page() return value (Jonathan)
- added comment in st_lsm6dsx_sf_write_raw (Jonathan)

Changes from v1 [1]:
- swapped patches 1 and 2 (Jonathan)
- miscellaneous stylistic changes (Andy)
- fixed usage of MICRO and MILLI constants in st_lsm6dsx_sf_read_raw and
  st_lsm6dsx_sf_write_raw (Andy)
- replaced scnprintf() with sysfs_emit_at() in
  st_lsm6dsx_sf_sampling_freq_avail (Andy)
- replaced scnprintf() with snprintf() in st_lsm6dsx_sf_probe (Andy)
- clarified in a comment in st_lsm6dsx_set_fifo_odr() that only internal
  sensors have a FIFO ODR configuration register (Jonathan)
- modified patch 3 description to explain justification for the extra IIO
  device (Jonathan)
- moved page lock from st_lsm6dsx_sf_set_page() to the callers (Jonathan)
- s/magnetometer/gyroscope/ in patch 2 description

[1] https://lore.kernel.org/linux-iio/20260109181528.154127-1-flavra@baylibre.com/T/
[2] https://lore.kernel.org/linux-iio/20260115122431.1014630-1-flavra@baylibre.com/T/
[3] https://lore.kernel.org/linux-iio/20260119100449.1559624-1-flavra@baylibre.com/T/
[4] https://lore.kernel.org/linux-iio/20260121112758.1831077-1-flavra@baylibre.com/T/
[5] https://lore.kernel.org/linux-iio/20260122162335.2020006-1-flavra@baylibre.com/T/
[6] https://lore.kernel.org/linux-iio/20260225100421.2366864-1-flavra@baylibre.com/T/

Francesco Lavra (6):
  iio: imu: st_lsm6dsx: Fix check for invalid samples from FIFO
  iio: Replace 'sign' field with union in struct iio_scan_type
  iio: tools: Add support for floating-point numbers in buffer scan
    elements
  iio: ABI: Add support for floating-point numbers in buffer scan
    elements
  iio: ABI: Add partial quaternion modifier
  iio: imu: st_lsm6dsx: Add support for rotation sensor

 Documentation/ABI/testing/sysfs-bus-iio       |  46 ++--
 Documentation/driver-api/iio/buffers.rst      |   7 +-
 Documentation/iio/iio_devbuf.rst              |   3 +-
 drivers/iio/imu/st_lsm6dsx/Makefile           |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       |  28 ++-
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    |  32 ++-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  |  58 +++++
 .../iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c    | 234 ++++++++++++++++++
 drivers/iio/industrialio-core.c               |   1 +
 include/linux/iio/iio.h                       |   7 +-
 include/uapi/linux/iio/types.h                |   1 +
 tools/iio/iio_event_monitor.c                 |   1 +
 tools/iio/iio_generic_buffer.c                |  56 ++++-
 tools/iio/iio_utils.c                         |   8 +-
 tools/iio/iio_utils.h                         |   4 +-
 15 files changed, 438 insertions(+), 50 deletions(-)
 create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c

-- 
2.39.5

