Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82FC3E275C
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 12:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170243; cv=none; b=Y5NZPlpBrO8Vzavf7duHZeZi1RB7tTCcao0kIspZgoi7vZ/jd8jKCsnA6Qbh/IG8jL3iJrlIvel0hFq2qeK8KatRNlQTXg9vg9cSLfkfEthkS7+k/PkT0kryp4whjbNaS48mRLB97e1L/H59g+rjEDAcpNsHK/GPlEhHJSlp95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170243; c=relaxed/simple;
	bh=cVNgNU7t0muGb6JpBJuNu2XwbT1PAhNRy5+RS/sq3ZM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=avj7owkEQLNwe90Y+FnpKuLVuXDryn8MfNMYt2VSB+zLWAAgvXwUlwX9cXnqToDLu+0hC6sw0GLbf6eY21W6vhBfCj4mqHlbEBaiGb7iLr1NdMhWhS98KAgaWM3ha984yAfU/VG2avo1nIK8BZSculMep0zmSGOmGlJbXrdThME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sujxgTBq; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sujxgTBq"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d7605ec91so2009153f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 05:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776170240; x=1776775040; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V3SCJ0zYtXoX/kwFz6GU6hKKTZxupHZ6sfNhgJ3dKFc=;
        b=sujxgTBqoiUV851C5k/ksc/Q0IyOhnEfa+Fst/G1AmSHEhZNvlUTowssy6V2uylNCw
         +LaOvMlRB+TcGNd8T5BG3vv3WP5g17U67sRe8U/9fD4DX+Uk8VhEFNqCyVzUvFVMSR/I
         YWp3ir1yQLuHLtCAnsbGed32Q4kDVOia66fOzKWF68ztqklprtUbssgQr52p8J4Abx+l
         kGmmVTa84XSrpXNb0UfwZjOxJ3Ko88opilAnK8I9p0/qFpT2KfzQ83k0Dfy+iGzy6/pt
         RSu2eviQxPk7U/S9Dvr9mRdY81bHyDkinp4BcFvUWwIoELSBsIzoSL7g4xFYrhMkaaCg
         bsXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776170240; x=1776775040;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V3SCJ0zYtXoX/kwFz6GU6hKKTZxupHZ6sfNhgJ3dKFc=;
        b=LL4R2ZYYiM8qUQeLhx9cKu8y0png0qk8ziAY7151GY8GHEm37/SkqbauYWs1mp0sMx
         6FTviHmZDOUwnm8bAASn7YTN+A9y9CLnJlrlwHIDFUF5jRl7HGOkNpeQcD6oG0PS5M+/
         gYvlCbL2N69/Nzwk2Cb874DDp2APVskIrCtimXXJsZG9V2l2tJ9TVrlGdkW+hWTSeg7G
         pWd7MKJK0l/l/OfamnVugo/d27UpSQOU3px54R5gWduBoq2jqicpevrB3RnK1DxLtPPa
         NjkhLWab7ub+fP0yJv9E32z0vExLYoAs0XJhEhBM9sBIrra3hXZNWMrNckYXPKkNjZwt
         9nbA==
X-Gm-Message-State: AOJu0Yx77NThU1fkNMEb/cD8KVYi6umcK7nmr74MkvwxS22mB9ibcfIW
	tWJGSIr7BCdnrCJJgXNhNARJOO6F1OZYrPjAaPn08jAAVbd5Fqf3nfB01mTMuw==
X-Gm-Gg: AeBDieulw2zwO4ISHWIzKpPujXyQ6+ztIvceZeJICJcg6XS197mpWB2a7l0QZynfw4s
	4byE734bhbbvgtdiMnDcF8uVUKM6kmRaUeuhGATRtQ9K44c7fO04QXTt/EBjHPyLYNcXNLWI0OC
	O4lOIT9qmtC3s1WN9nVZIoj1n7jO+Bd5laXljZLP2u2izaBEMBvtvZgjmslqla+6pHW1UU7aCrS
	5WktBfEmRvKeKQVddaHuycbCefBXSbpwnqAgCki5zrOmFwtKNPPg8/9GEPnw/W+YV+MOlExW0Eh
	csup9RJwGD1TWM9Eyxs9zLHK786iwB6v+I2nZ8jr7WZ4beqFFYUAxgQUzGEPViixlsDOoLQNtAq
	YcAEOZDVXMThf7FNe9iapk2VRZR7PwAZr1bcKjUwlJ0U+ZVtBmaOOyLn8JXQqI5HJcKAM9ip8L2
	xze2zad8+rqh7VaZduE2XzU4SHKW9Rbg==
X-Received: by 2002:a05:6000:26c8:b0:43d:773d:7908 with SMTP id ffacd0b85a97d-43d773d7b36mr13594655f8f.32.1776170239668;
        Tue, 14 Apr 2026 05:37:19 -0700 (PDT)
Received: from [192.168.8.79] ([2a00:f502:260:5bd3:9217:8960:5f33:aaab])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e46a85sm41552729f8f.24.2026.04.14.05.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 05:37:19 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Subject: [PATCH v4 0/6] iio: light: vcnl4000: drop enum ID table and use
 device-managed register
Date: Tue, 14 Apr 2026 15:37:16 +0300
Message-Id: <20260414-vcnl4000-drop-enum-v4-0-59fde2932a0f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTQqDMBCG4atI1k2ZxKhpV71H6UInGQ34R2xDi
 3j3RldSpMv3g3lmZpP1zk7smszM2+AmN/Qx1Clh2JR9bbkzsZkEmYMCwQP2rQIAbvwwctu/Og4
 y1ZALQiLN4uHoLbn3ht4fsRs3PQf/2X4Esa5/uSA4cCIjQRCgVvpWd6Vrzzh0bOWC3BPZISEjU
 aA2eNGYXgr1S6Q7QsAhkUZC2lJWmFNmqNoTy7J8AdT4UjI6AQAA
X-Change-ID: 20260401-vcnl4000-drop-enum-0238061fcff8
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Erikas Bitovtas <xerikasxx@gmail.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2

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
Changes in v4:
- Removed trailing comma from device tree entries.
- Link to v3: https://patch.msgid.link/20260410-vcnl4000-drop-enum-v3-0-2ea2bc6f5dfb@gmail.com

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

To: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
To: Nuno Sá <nuno.sa@analog.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

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
base-commit: b82346a4da00ed70466d8e02e9ab384db6d1f83a
change-id: 20260401-vcnl4000-drop-enum-0238061fcff8

Best regards,
--  
Erikas Bitovtas <xerikasxx@gmail.com>

