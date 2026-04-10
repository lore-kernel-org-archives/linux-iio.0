Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C644135DD1C
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837582; cv=none; b=AjA83YhNfeRj6tI50bJT2QowJU9SCxy7AsZAjx2dIz6kjwjVRjnBou1d40MwlhWJmHeywzN5HCFbytrIxdttMIcddFG74Sh8hyZXlJMmVo5VOdfpWs+OGczHiLEpNBR8nPNzcif8jVBZemPfd/9scNQzXudmos2B1q0yC3anO3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837582; c=relaxed/simple;
	bh=iHOrEOPukBDw2OMmEmWqNyYObEXpDlsGXACdw/giA24=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=M9TPS6AWBPeU5+pvlo9EEslyLAWvJX3Q0ORRgWnT7+zkjZM57t05vabzeA9NAc0UUMLFowMgIvyrx9byhHA1UUMA70AiNOkRYCnP+vCamsrmdGluZc16QxWcFwdXSzBhVXSoNPXeyoVaB3O4ZqW9hhgyN3F4otGcThlhpkDXlh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnX/jd5q; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnX/jd5q"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7927261a3acso22464807b3.0
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 09:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775837580; x=1776442380; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GdpRnrT8EdM9Ad4fwPo90RwHr69ZTTQZqjwzgeAcqUM=;
        b=HnX/jd5qqbRu+qJG5J8XSsDaZcLjiidBjJKNd5MWtivVi7ImRpltPxbAH1N/WTekRK
         Qe1qoL9TSYDu2pOFOsB0w7ZA2QSOU3LY/m51BglQXEIIR5MU0Hn/0P7d1NS1oQikTcXc
         VGu6ifY5Lzo0A8UNWuojsgPqmWszXBoL8dTxbIFgGzofF5ZANzaOKEVr0jUH5UtJsEk6
         xf/HNOlGfjCgi5n4z4qJ8hYhGL7GQh+LWLArJilRuKsCn0Th0yg5adX7HdfS0uF1ipyx
         0C8E1tLYthFx95K2c6zkcoz7Tao6p3yQOhwUb8y/chjGzz69rfIeFhSAtO2dqiFbRvsG
         GEpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775837580; x=1776442380;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdpRnrT8EdM9Ad4fwPo90RwHr69ZTTQZqjwzgeAcqUM=;
        b=Hh4J+CEXkllkxbJNCDNQ7C/kieAskJ0o4tfOTcJqILIENhn0Hc7BKeuFHeV2gFn2Aw
         s2DklCnq9K4jdEOpZyAhyQpLk/BofJWZHSGhV5a5dLj1DBarshe9ydBTSJaeZ5vMSeJd
         VsnB4ewVgzAwsSEko3BSX9WqvRw5WdxLzLWmJeU+5oMKbj6mqGw4sEUWr9uiIabVPbHT
         2Vs1JjqrJRM+faapy8abkAxTGh2jCB9iL0EBnTJgyaKS69p2Yx3xANLQDOdDdlksMY4w
         k+zuPKhM1fthLBfWxFVZPxsQCboCCA/wBCbAUQ5Fo6qo8CnkfZFrCu70C734j8iMTMRc
         lg8A==
X-Gm-Message-State: AOJu0YzW9HgzCY/ay2kG6E5/1cjQTlkNGV1wBJaAr7ctuEZM3A3axxrG
	QZfodhoe1GYyLzDnJCDDbQVqOEMhu4XnQubNcqPrQenkYXBMexkmDODR
X-Gm-Gg: AeBDiev/lewN0691rBp57sLUQsu6X5gk9yg1EQvDPUJBgLgy7WF99xQuVGy7IB2uLrV
	xffmj2Trl7lovSE5rgeL3CuVMuZFcPYaNGxp+mJTdmMaaH1E1tupQVNaOd947wlLaKyJmUnxGBV
	LWnePCwxzUcEh769bki6kywtk6vgKbFMU6iaZgVefkoRz98B+VRzLIirMmiYO5BUg9jDCWmlXjY
	8vsUukN2IqGWlB2IcGM7drdkIAclx57/87YzIxeoTxf37D2acCPYH3fk/UtnMTvIrfVaf4xq7wd
	Gvvr5ZlYkcMWsBV9qRfP+WjiiNW9zq/DVZrj2tlR8TTvh9Et7OtRrsUfHGhfRIak7aMv+ruZUpK
	wu2pNqjMruC1mW7apgZlYH0Dj7LQX4O1cuBVn7mTp/wUGxfZAQP188qbro512MeHEZk3Jx+0y0o
	4VA4Jn0it00XvVPKXrMWlsBe7jug==
X-Received: by 2002:a05:690c:9d:b0:79b:cced:2349 with SMTP id 00721157ae682-7af71a57a49mr42863057b3.37.1775837579765;
        Fri, 10 Apr 2026 09:12:59 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7af3fa05b48sm15408337b3.33.2026.04.10.09.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:12:59 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Subject: [PATCH v3 0/6] iio: light: vcnl4000: drop enum ID table and use
 device-managed register
Date: Fri, 10 Apr 2026 19:11:16 +0300
Message-Id: <20260410-vcnl4000-drop-enum-v3-0-2ea2bc6f5dfb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTQ6CMBCG4auQrq2Z/gjFlfcwLsi0hSbQklYbD
 eHuFlYsjMv3S+aZhSQTnUnkWi0kmuySC76EOFUEh873hjpdmnDgNUhgNKMfJQBQHcNMjX9NFLh
 QUDOL1ipSDudorHvv6P1RenDpGeJn/5HZtv7lMqNArdUcmAVUUt36qXPjGcNENi7zI3H5SfBCN
 Kg0tgpF28gjsa7rF5d+W0z3AAAA
X-Change-ID: 20260401-vcnl4000-drop-enum-0238061fcff8
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.1

This patch series drops the enum ID table for device enumeration and
instead adds pointers to chip ID structs directly. Necessary
information about the device is then taken from i2c_get_match_data()
call. This removes the association between enum ID table and struct
table and allows for easier addition and removal of new devices.

Along with that, an iio_device_register() call is replaced with its
device-managed counterpart, to ensure that device is unregistered
automatically.

No functional changes are intended.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
Changes in v3:
- Reordered the commit for moving device tree entries into one line
  after the commit dropping enum table.
- After a failed iio_device_register(), added
  pm_runtime_set_suspended().
- Reordered device-managed IIO device register to come before setting
  autosuspend, as it was before this patch series.
- Link to v2: https://patch.msgid.link/20260405-vcnl4000-drop-enum-v2-0-7c8dc98c3974@gmail.com

Changes in v2:
- Moved device tree table entries into one line.
- Moved power state function in probe into a device-managed action.
- Replaced call to pm_runtime_set_active() and pm_runtime_enable() with
  its device-managed counterpart.
- Removed vcnl4000_remove function(), as all the clean up is done by
  device-managed functions.
- Link to v1: https://lore.kernel.org/r/20260401-vcnl4000-drop-enum-v1-0-ffd201f0c848@gmail.com

---
Erikas Bitovtas (6):
      iio: light: vcnl4000: validate device by prod ID instead of table ID
      iio: light: vcnl4000: drop enum id table in favor of chip structs
      iio: light: vcnl4000: move device tree entries into one line
      iio: light: vcnl4000: move power state function into device-managed action
      iio: light: vcnl4000: make pm_runtime_enable() device-managed
      iio: light: vcnl4000: register an IIO device with a device-managed function

 drivers/iio/light/vcnl4000.c | 276 +++++++++++++++++++------------------------
 1 file changed, 123 insertions(+), 153 deletions(-)
---
base-commit: 64450c940b89dd8fdc74178fba2f31718afd8c71
change-id: 20260401-vcnl4000-drop-enum-0238061fcff8

Best regards,
--  
Erikas Bitovtas <xerikasxx@gmail.com>

