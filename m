Received: from mail-qk2-f38.google.com (mail-qk2-f38.google.com [74.125.230.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0CB3CB8FC
	for <linux-iio@vger.kernel.org>; Sun, 27 Sep 2026 22:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790546797; cv=none; b=LKexoOiwDrx7L/AENZqPC23QlntqAP8H+1vw4gpACC72ENo24KKyWHuB81nEGxPlr2F7FPX5DaZTInK9pR5U3PBXuDWUVarbo4icZG1GUFNztVb6h6E1lmPergkhqNMG03UZTSvi3lmAZj/gjzDkadOqyYz6B0Dk9ek6WpZZEL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790546797; c=relaxed/simple;
	bh=Ds8BwIspgUUCE1XSNxUZNlyPtU6a/MkzXnSYH6x+Kl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pN21fgtyY5jw0BLEA7XmL++AGku6ApfbteQ0ME7qdHFR8xSSozlsV+c/spqo7Z+DVCGmE2wZVkripQUTSaP6gjIk/4qhiRkN0nEV3lmgs6ov4JQKEdLorNm12TYiZyChl4hujom7OejJ1433GaFDi8eFrodsZySsWarlLtTUClA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ku+236OX; arc=none smtp.client-ip=74.125.230.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ku+236OX"
Received: by mail-qk2-f38.google.com with SMTP id af79cd13be357-93c7519e76bso33394485a.0
        for <linux-iio@vger.kernel.org>; Sun, 27 Sep 2026 15:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790546793; x=1791151593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gGNTbiyBO3Whl7vzsynX3Y5WRTEml94o2XJTrHP18qk=;
        b=Ku+236OXViSm1DWlIExuAMK4OBfOwufiCVtfhLhJqL+tYHlR90eRoSp5vQTtc29O1o
         bqrYEzfKRtv0PRweZ4Kt8ziGg4S/I6aneNHC3L4Bu0ac2ugnfmGVh4+o4P/Fdb6egQck
         bXouQ/M5ArKwM5a0KNRgzHcPsdgORdKzDT9g1uHKvotV27TEpefShTWZHSV/LKaibFqm
         +VGmzrs/vW88TSLiQlyb4fvWebvFwIi+Vu+7aD5CE07rSb1VZ2M1sz6ivC24i5jgpSlX
         DuunYzQXukZjvwAnEQPqZzsd7E+tYH2zmc3c5JDztPQGokl9iJ7XzPYeeM/KdUWlDKtf
         7kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790546793; x=1791151593;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gGNTbiyBO3Whl7vzsynX3Y5WRTEml94o2XJTrHP18qk=;
        b=XI0uasTNdua9JcynYNsrtlBnjcyO1gxzc/E+WFpe8Bh5OrWC4xxjgk2hvmt7Xgln2X
         qXBs8fQEDshp2gb/bBmAQ1qB6Bsvz/gFquyxAx0T6629s240dd5wZaB49T98VY4nRLLi
         knqvZtf+xTdkvV1axF46r+cE/OLZFtNpZ4Bnu/CnElDoLw0s3cYb0QSi6IDOozUUVnNb
         SanYVEFLWr7UbDaKF0nuWNaYNjXYhYylk5YBeARoWUhk1YhMa/sgIYJeP9nrgq6PEj3y
         yPPtlmRgd5Got0Q1FBv74gB/1j2J5O+M0kKx14FXbSXKXcP/BMQVcAAfGu8NhWv3XOgz
         rQow==
X-Forwarded-Encrypted: i=1; AKwUvBz4626JWfHHdjuVZIajTxKPTc1/nhhXEZ4bHEFNi2nsCooK8g4Fmlr0t9a3dnFyQLjeH0QqUX61pjs=@vger.kernel.org
X-Gm-Message-State: AFuF++lc29qnEotYlyjNYHKC5+vtqGQZEr/ovqAHDvvbDXxTReLrypNj
	ytKRZEJ+smAG63866tW2qvjWP1pfSkWje4q+3KhqVT5ZoyUOPZgZ40/GPi5ZrKuW
X-Gm-Gg: AYBFou3KybgvM25VARii0nmNBJWUhgphXRtm5fs2tT/ew6IoF7YO+F4z6DUMxyYM8Fg
	qCTDH1XItfRnW4nx4mN4ZYgBf24k5BvqYoafUafojCQogOC0oG6nnbby3eolBQLr4/XCyf9PCFB
	O2WUoKVBwiRytWNcPI7MUzNjIoZGkoUqLkyV8gaDCPntLkI2NRsc8jDD/tw0HRSQTyqZX7L+HOP
	oeUKToKYNLe1em7V+ZXD6S2tpnCkGSa60XJ7YFtVRD6N9paN3ddYLhsSAmvowmAjjrI4aIMAPbH
	m6AFUQqi2vXLBfIu6Z9G0CnQ2oC4DdgKK9tyTtUplVv/YmqLi59F2L/LdE8Yo2+6jstoYtoBnVk
	ZF7A3Ud+HUpWwupeM49GdBX/AMYU0jvgNBp6ynVn7onbFy7v08m/tKnTCfNoH18T1R+kOT7NbjM
	n412uafEsPN+2gEO9A1u0cgJv4g31bA3WSr5D8CSvl9fdJyIIbTkIgqLjEqsQE+JmXaPMvh+ZnG
	PA35qgD4TBl08+zMVsMjeiEZdchGaMjip7wN76LlX+nr7CXukVfNQUG5vlQBnF+ZhZ9UFFFoaun
	8Dt1gVA=
X-Received: by 2002:a05:620a:4495:b0:939:c898:ce3f with SMTP id af79cd13be357-93c43b861ecmr1708540985a.14.1790546793340;
        Sun, 27 Sep 2026 15:06:33 -0700 (PDT)
Received: from cachyos-SlimIce.lan (1841343-static.dvnpiaaa.metronetinc.net. [195.252.229.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93c44972febsm708092385a.39.2026.09.27.15.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 15:06:32 -0700 (PDT)
From: Jared Wuerzburger <jwuerz@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samuel Dionne-Riel <samuel@dionne-riel.com>,
	Jared Wuerzburger <jwuerz@gmail.com>
Subject: [PATCH v3 0/2] iio: imu: st_lsm6dsx: Add ACPI ID SMOCF05 (Minisforum V3 / V3 SE)
Date: Sun, 27 Sep 2026 17:05:57 -0500
Message-ID: <20260927220559.24169-1-jwuerz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This picks up Samuel's series adding the SMOCF05 ACPI ID for the
LSM6DS3TR-C [1][2], which stalled after the v2 review. The Minisforum V3
and V3 SE tablets both use this ID; without a DSDT override their
accelerometer and gyroscope are missing, and owners currently carry one
just to get screen rotation [3].

I own a V3 and would like to see this merged, so I followed the path
the SMOCF00 patch took [4]:

 - Patch 2/2 only adds the ID; the SLA0/SLG0 mount matrix patch is
   dropped. Orientation is handled in userspace via hwdb, and I will
   send the systemd hwdb entry separately. That also addresses the
   patch-order concern from the v2 review.
 - The DSDT excerpt and the tested machines are now in the changelog
   (full excerpt below), as Andy asked.
 - Patch 1/2 is the trailing-comma cleanup Andy suggested, split out
   and applied to the existing entries too.

Samuel stays the author of 2/2; my edits are noted in the tags.

Changes since v2:
 - Dropped "Add alternative ACPI mount matrix retrieval".
 - Split the trailing-comma cleanup into its own patch, covering SMOCF00
   as well.
 - Changelog of the ID patch: DSDT excerpt, machines, test results.

The V3 BIOS (1.06) declares the device exactly like the V3 SE's:

      Device (STS)
      {
          Name (_HID, EisaId ("SMOCF05"))
          Name (_CID, EisaId ("SMOCF05"))
          Name (_UID, Zero)
          Method (_STA, 0, NotSerialized)
          {
              Return (0x0F)
          }

          Method (_CRS, 0, NotSerialized)
          {
              Name (RBUF, ResourceTemplate ()
              {
                  I2cSerialBusV2 (0x006A, ControllerInitiated, 0x00061A80,
                      AddressingMode7Bit, "\\_SB.I2CD",
                      0x00, ResourceConsumer, , Exclusive,
                      RawDataBuffer (0x04)
                      {
                          0x53, 0x4C, 0x41, 0x30
                      })
                  I2cSerialBusV2 (0x006A, ControllerInitiated, 0x00061A80,
                      AddressingMode7Bit, "\\_SB.I2CD",
                      0x00, ResourceConsumer, , Exclusive,
                      RawDataBuffer (0x04)
                      {
                          0x53, 0x4C, 0x47, 0x30
                      })
                  GpioInt (Edge, ActiveHigh, Exclusive, PullNone, 0x0000,
                      "\\_SB.GPIO", 0x00, ResourceConsumer, ,
                      RawDataBuffer (0x04)
                      {
                          0x53, 0x4C, 0x41, 0x30
                      })
                      {
                          0x0009
                      }
              })
              Return (RBUF) /* \_SB_.I2CD.STS_._CRS.RBUF */
          }

          Method (SLA0, 0, NotSerialized)
          {
              Name (RBUF, Package (0x03)
              {
                  "-1 0 0", 
                  "0 -1 0", 
                  "0 0 -1"
              })
              Return (RBUF) /* \_SB_.I2CD.STS_.SLA0.RBUF */
          }

          Method (SLG0, 0, NotSerialized)
          {
              Name (RBUF, Package (0x03)
              {
                  "1 0 0", 
                  "0 1 0", 
                  "0 0 1"
              })
              Return (RBUF) /* \_SB_.I2CD.STS_.SLG0.RBUF */
          }
      }

On the V3 with this series and the stock firmware tables, the driver
binds to i2c-SMOCF05:00, WHO_AM_I reads 0x6a, and both
lsm6ds3tr-c_accel and lsm6ds3tr-c_gyro are registered. Screen
auto-rotation works through iio-sensor-proxy with the mount matrix
-1 0 0; 0 -1 0; 0 0 -1 (the firmware's SLA0), applied via hwdb.

Thanks to Samuel for the original series and to the v2 reviewers for
the feedback. The patches and changelogs were prepared with the help of
an AI coding assistant; I reviewed them and tested the result on my V3.

[1] v1: https://lore.kernel.org/linux-iio/20251223025351.3099978-2-samuel@dionne-riel.com/
[2] v2: https://lore.kernel.org/linux-iio/20260201225450.1649001-2-samuel@dionne-riel.com/
[3] https://github.com/mudkipme/awesome-minisforum-v3/issues/2
[4] https://lore.kernel.org/linux-iio/20260324193626.77231-1-twoexem@gmail.com/

Samuel Dionne-Riel (1):
  iio: imu: st_lsm6dsx: Add ACPI ID SMOCF05 for LSM6DS3TR-C

Jared Wuerzburger (1):
  iio: imu: st_lsm6dsx: Drop trailing comma in ACPI match table entries

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: d8c0f48f0b1583308a98401c0c7b1a65d1d43a6c
-- 
2.55.0

