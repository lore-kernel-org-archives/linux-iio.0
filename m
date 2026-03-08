Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F1A22FE11
	for <linux-iio@vger.kernel.org>; Sun,  8 Mar 2026 01:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772934301; cv=none; b=JR6iFZMOMBpNi0VYqPeouRFJQI6zPpXsnNj954geU78oMnLgLbbAWZxNLBiP4Yt1e4FLsvtTyuIQdEHnhEuDm2vS1uF4oztdx3pi+QXF1p9is0dMpeiDQpVfYEpHb9wo4WmzfMtayzj90hNhqQaw3AJnSnMA900+0DxvuiW+YaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772934301; c=relaxed/simple;
	bh=qh9EnAIlafMpSV0kwNGBfJup8j+0TfCOjR2kqo71D+4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Pn1PFef16Vsj9c7BEL6JRTJMfSV9tXkdvHf2HghhrXRhBGdHQD2vX+j1VgFy37REhTCj7yE+1Zi6naCSoXjnL6OKGa9yA/A35d/XkiwXOA5TO/rRbkT7B8qwipj8pusYPyeSeXVt5nAtRb3XeC96Llx6HKHSqOrcCuBXwEvlsiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3aujLe1/; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3aujLe1/"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40429b1d8baso2209463fac.0
        for <linux-iio@vger.kernel.org>; Sat, 07 Mar 2026 17:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772934297; x=1773539097; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kln3hSL51Q9yieQxEgh7uAQOpUixLbpor52Ava0k0rA=;
        b=3aujLe1/lQwy1SMIVx3SFlchjA1S57Tq/Y6HkcB67CD0DeniLGenKi5pAz0ex4cvfO
         ClS1O8i9R0nG3Ss4zfRjED0Oa6++lzkUzcd1FubZKOkd1alghcIIgdOmbXlpY8WTj3Zf
         k+xRj5mvsILEIl9D/6Y6AYCR+qKB03+1cZqNfogoKGhUf0+rLYphSZBg+MnFA/PBpvFu
         WmuQrB4Sx2dXXAz6TlVKXyHoRbrbHV+4+boddBi/0JBReswTVyiLuI3+miqR025MrCEE
         u7JGcyi8mZbI9TqLmEWNpM08SWjnokZ2p1B9iwyTMMp6j8riStAywy8gWoK9RvhcMAlI
         QQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772934297; x=1773539097;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kln3hSL51Q9yieQxEgh7uAQOpUixLbpor52Ava0k0rA=;
        b=nr5wF6AIIv9V3J9lT8R0I4orNgx/RduKE1U9dYKF9jRTJ1dxs5DR9eOLGENXOeX635
         DVMKopczXgsO71CSvXoEsWw9P47D7c1zrYkeeGA5HBsAVpgsKdJ+f80RtRkWw6Knmr1l
         Lc6dm2znHQG3IBso/LP94qLgP4U1JcccLClw0OCdWeTeUEihCjFioFPFgt2uQKBRCepL
         S1JGP76JTUJUAZUY9Osq39MgUOvSpIygoLFpKkaQXh7rVc/9vt/SrXuou6RaFOXDYvGZ
         9TocciWUEm7oS93FJdeMuhWzIyLY1t1zmvfyig5GXp7SArqT6/HbnYV5ktfF39oZDmrD
         zGLw==
X-Forwarded-Encrypted: i=1; AJvYcCVTcInIzQEXU8SGkC4iPgWw4jNRrSc2A2/99rk5CwfcwvnBunI7YjltWvkENFwMycKYxIDiyB8rit8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymL/jFTt2iLs4Vz6t227IvRvvatpSbXGXBhdSz6OiiKwkgjrGG
	qc/gQvLZIuLVE/RtTzA4Z7B1qlW4qzfDOXKl8uyrJ3vL0QlszFRA6gijfas15BaDFUm5Oe2l4nE
	IqKlv
X-Gm-Gg: ATEYQzzIc8/rVME0k3VO5iG87H+gu1UpPWbm/CpmHKN4fSmtOdrG6dzTxeoywDlaKh6
	ww4DxbS9As5e4PvQtZ9URYrfjktZxOymErGU8Ut+0QJGnXJOYvbGtuT6WFHsKz0apOur/TV+1oG
	RPLtRQKexY/x9bnBQTLD71iChc66aNW6l9cKncqhl3FDjZIDGfj8DwljQQnghmxNaE+5gJXe4/M
	pl8raQ/NJq9uAPjqGiDhGBtmPA9G6ibUVOFefN40y7+QawZNIBT3UPnjaDNCDeJ3cRrD5I4B79f
	2q7K+0hysTRGILj7Y5EOqROEcuTzkdzqACqUdzGd6FLteI4SGW9i/4hbY+eJgOTf5VwI6BinD4g
	sJF1dmBYVu1IFmWJCzAtNnGAqJraputF/D+OImFmN0uZaJNIYFPkCNPlLSn3t92CT5x0LLuKBFF
	hH4P83u4ORHqF7jVTSJEreRCwwPzehhQqSO8zhuJs=
X-Received: by 2002:a05:6808:2227:b0:44f:eb07:5042 with SMTP id 5614622812f47-466dcb488c8mr3385810b6e.44.1772934297214;
        Sat, 07 Mar 2026 17:44:57 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a7b4:e550:6d81:e067])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-466dfa96903sm3244357b6e.13.2026.03.07.17.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 17:44:55 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/5] iio: buffer: fix timestamp alignment (in rare case)
Date: Sat, 07 Mar 2026 19:44:08 -0600
Message-Id: <20260307-iio-fix-timestamp-alignment-v2-0-d1d48fbadbbf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32PQWrDMBBFr2K07tSSkhTblNJ7lCxG8dgZiCRXU
 k1CyN07sTcJha7EF8N7/19VpsSUVVddVaKZM8cgwb5U6nDEMBJwL1lZbd+0tQ0wRxj4DIU95YJ
 +AjzxGDyFAk2LPRkctrvGKSFMieR0oX/tJR85l5gui2w299+Vu9HmX+5sQIPB3bZttBtcqz8dX
 k7sEr0eolf72+pK9P0jA8oqVMLJuAzoqvc//RNNhOVRYkXSS/MB0bZW90+Sj/seh5lAgufSVbI
 t14l8FF8t1FrewmGUOrdf+J5NNlcBAAA=
X-Change-ID: 20260228-iio-fix-timestamp-alignment-89ade1af458b
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 =?utf-8?q?Lars_M=C3=B6llendorf?= <lars.moellendorf@plating.de>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Lixu Zhang <lixu.zhang@intel.com>, Francesco Lavra <flavra@baylibre.com>, 
 linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2424; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=qh9EnAIlafMpSV0kwNGBfJup8j+0TfCOjR2kqo71D+4=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBprNRuIXVzb60XcT+S1XqdGxGPrA97SM7fL0kQS
 9P37d+u9ymJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaazUbgAKCRDCzCAB/wGP
 wMUsB/464ZVjv26zy2PcDdddyutV5pnIdbxC3rPI696jWsYvJlkR8HnngTun3E7nP5qUqmhUDXS
 CH1GD6cvub0nZPlJ3xRN72ao5H4W50U0jFPbCgaKc/iSzN+LoAgcPXgPturmTaoBw7pBnajHZyl
 zBcbRp39AoQ6k6vEP/u6Mx++pBJVg67wcV5Xap4Z+ICHOw8aAo7J/bC1ftH7OjnBMg2MzAbpuMF
 b+2G+nFmQ/MNcrUl7fpkERoclMFdb4DNnh3HLFtKUXokbUb6TaBgwJof4rqzUYZ0iSLJjnwm2pi
 1efm5za7lFU5cgUDS2I6gI3dK5purp4yCDQU1Q6Uzbp2PqK4
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

In [1], it was pointed out that the iio_push_to_buffers_with_timestamp()
function is not putting the timestamp at the correct offset in the scan
buffer in rare cases where the largest scan element size is larger than
sizeof(int64_t).

[1]: https://lore.kernel.org/linux-iio/20260215162351.79f40b32@jic23-huawei/

This only affected one driver, namely hid-sensor-rotation since it is
the only driver that meets the condition. To fix things up, first we
fix the hid-sensor-rotation driver in a way that preserves compatibility
with the broken timestamp alignment. Then we are free to fix the core
IIO code without affecting any users.

The first patch depends on [2] which is now in iio/fixes-togreg. It
should be OK to apply the first patch there and let the rest of the
patches go through iio/togreg (the later patches are just preventing
future bugs).

[2]: https://lore.kernel.org/linux-iio/20260228-iio-fix-repeat-alignment-v2-0-d58bfaa2920d@baylibre.com/

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Don't say "HACK" in comments.
- Cache timestamp offset instead of largest scan element size.
- New patch to ensure size/alignment is always power of 2 bytes.
- Link to v1: https://lore.kernel.org/r/20260301-iio-fix-timestamp-alignment-v1-0-1a54980bfb90@baylibre.com

---
David Lechner (5):
      iio: orientation: hid-sensor-rotation: add timestamp hack to not break userspace
      iio: buffer: check return value of iio_compute_scan_bytes()
      iio: buffer: cache timestamp offset in scan buffer
      iio: buffer: ensure repeat alignment is a power of two
      iio: buffer: fix timestamp alignment when quaternion in scan

 drivers/iio/industrialio-buffer.c             | 46 ++++++++++++++++++++-------
 drivers/iio/orientation/hid-sensor-rotation.c | 22 +++++++++++--
 include/linux/iio/buffer.h                    | 12 +++++--
 include/linux/iio/iio.h                       |  3 ++
 4 files changed, 66 insertions(+), 17 deletions(-)
---
base-commit: 6f25a6105c41a7d6b12986dbe80ded396a5667f8
change-id: 20260228-iio-fix-timestamp-alignment-89ade1af458b
prerequisite-message-id: <20260228-iio-fix-repeat-alignment-v2-0-d58bfaa2920d@baylibre.com>
prerequisite-patch-id: e155a526d57c5759a2fcfbfca7f544cb419addfd
prerequisite-patch-id: 6c69eaad0dd2ae69bd2745e7d387f739fc1a9ba0

Best regards,
--  
David Lechner <dlechner@baylibre.com>

