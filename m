Received: from mail-oo2-f38.google.com (mail-oo2-f38.google.com [74.125.231.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D9135203E
	for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 17:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790617930; cv=none; b=KvE8IOxxlM1dlBD5Y5u31Cr3UNsj2B5VVe4Wr4itb3JbDEZ3nYMufefMmQ1P1MHzuIXcEIE6S0pJ7Zsd97rUmVXu+YxNlLtoi2To4G9rM02lWMlxpNBI8KjveamVnX6XqqmwT9FrM1ifoR4+dBPg/dZzPDeSHBLH0dyw49Qfzy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790617930; c=relaxed/simple;
	bh=Q+vmfJG//p2Rey1KhKL5FmZQroywJtuh3/k2Uqp58iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dn0MLKk/+NK1OOTfCqC2R1TSRPIbDvj1jNm81S3N6KNo+GSCCFJTwZ5m6njM8xEAf7uztrkImiYQ0szcsiUcsOiUDZUhBF1ynp/pBIZwQB9VGrAxuoHTFaJrekJ2PZNwS7jss827c5U9K8uObCpb6X8tkjQJqns/3LQxatGgHPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUkKTHqQ; arc=none smtp.client-ip=74.125.231.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUkKTHqQ"
Received: by mail-oo2-f38.google.com with SMTP id 46e09a7af769-805cc8b4231so2343332a34.2
        for <linux-iio@vger.kernel.org>; Mon, 28 Sep 2026 10:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790617927; x=1791222727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pJn16IjQM6K4l/OhzyI9FQr95uDpWojn7sleNnAiD6g=;
        b=XUkKTHqQ/AcGibmiiXcgy9LqNdXQ9UeE0WJxB0lmXtEGhQazcuQdR3yPqj6oTvnz9c
         F+rj/TNotvWGjPYT1nKeq01SK1D6+pV7zKZ1PaFxUpwPQqg6eQNp18xTrt+tMfTZ2Xir
         GZFlTHZkbF/oRRFX+StfWf43bhHXXmkOTIQH1b2jrtzCElpvQCXsPkOLR8ZRCG4kNem4
         MDQZd22vL3NobahCTl1Req5iNJUJKGjmkaW9m/Wp904fCaJifVkbDRVAOrvL4ay+vx+q
         CR3Kk8xZrr70lpc8dUUn4DSZRpZOpgdZoK7Q9g5wr5g+rWMGLr00PK+fyz4VamLp7uig
         QO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790617927; x=1791222727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pJn16IjQM6K4l/OhzyI9FQr95uDpWojn7sleNnAiD6g=;
        b=ATZs6WXNYSoIfWP4nTm3ZitfmD74hux+kULoYr7HNQZvgP1JBzInGZsAnyn5a7BtbL
         lKO1lQ43fbZVdMJL0kUwfkw87g/cWe/BvzUXjD9wvhNMzD3Vv5xpFd8zM7wCjozg4rPN
         UJpWKfk19JlQ9E4yLtbzXCsfAMyYBa+u/c/tCq7DUhuQyGQz2cgnYAFBPE9ZV0d5Qvq4
         tnx6gI6AfodxRh690EBBDgRtRXvbfVl0qL8vLlBUhl2KJP9A2lgDve0bGdzcO990gYpU
         XM4No7PcCEhLwCeerLjbzOUxyFDADAmMWwnbS5Jg7euxC+InhCszsq74GsnhCnDIgk+j
         GIcA==
X-Forwarded-Encrypted: i=1; AKwUvBz+Qxe5pyUkFBnuTLxbME5E9EMpSc1/2Iu/QOWWEEOIOl76ZuNZExcSnSlhYmgKOFzU3hKSNb4dZA4=@vger.kernel.org
X-Gm-Message-State: AFuF++nTC7IUoi7JVLg6ZcRW7YkL//SThK+jItMxG+oEnW4PXNoFq5Hh
	KyryA2WrwITmPoHTcYJ0SaUJVqjuFeAKs67qBlDvOC8cQDO1MVUbn7v2W/RNpZpS
X-Gm-Gg: AYBFou3LVLI9J4kwQOjtsOqtNO5vwDNBKRTuF5VMj5XFfcwaJ0D/g2aUrFCtEzN/Rro
	LMbJ9lQTdIA50L96z3nwjlqbNgHmMcVKhNuvYiz7Z/mm8fCIHCGexF1LRpZTMjBPvDKwlTdQqSN
	bOXwhpy3g3LlSG8LSVsVcyLsGiIQrh6gmhz6KPVcHktjIjTONifam/t7LFzoC97N++wGIux5jJv
	jjhWfsHGQ6hm1nAJoGFlBBQx0iJCRx2+WGnCiybUspYK4YbKQxIkz4B4eSWCGGWJVMVtd4wl5lS
	tSDqV14lEtG2cNLk1dkfzfvKIEuQGx3UQwxTUsMRoOkmywD+aGVNWAy4Z2ygSCQOcPtY+/NXRHo
	FB4AfXcE8fIPj38W71N7AWxoPjgHzruV9Y2/9LEpkil8Igw5PETFQNiyIyvzQc/VVzI6JRyFIcK
	Seu71GEdU7SeVVyxb5V3Lyh/guItiA8T+RKy439XU9/00zEuSnduWyvMywcU0Olx4SwfjlNO3S1
	p+7I8W3q3M9Z2rl5hPeMhY=
X-Received: by 2002:a05:6820:1f11:b0:6cd:3fec:de75 with SMTP id 006d021491bc7-6d441c7cac0mr12797774eaf.75.1790617927580;
        Mon, 28 Sep 2026 10:52:07 -0700 (PDT)
Received: from cachyos-SlimIce.lan ([2607:fb90:9a26:9349::e71])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d8822199cbsm5971644eaf.5.2026.09.28.10.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 10:52:06 -0700 (PDT)
From: Jared Wuerzburger <jwuerz@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Samuel Dionne-Riel <samuel@dionne-riel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] iio: imu: st_lsm6dsx: Add ACPI ID SMOCF05 (Minisforum V3 / V3 SE)
Date: Mon, 28 Sep 2026 12:50:47 -0500
Message-ID: <20260928175049.86941-1-jwuerz@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This adds the SMOCF05 ACPI ID used by the Minisforum V3 and V3 SE
tablets for their LSM6DS3TR-C, picking up Samuel's series [1][2].
Without it the accelerometer and gyroscope are missing unless the user
carries a DSDT override [3].

Changes since v3 [4]:
 - 1/2: convert the ACPI match table to C99 initializers instead of
   only dropping the trailing commas (Andy).
 - 2/2: explain in the changelog why the firmware's SLA0 matrix is not
   used and the orientation comes from hwdb (Andy); drop the pointer
   to the cover letter (Andy); Link: -> Closes: (Andy).
 - Assisted-by: LLM (Andy).

A correction to the v3 cover letter: SLA0 applied via hwdb gives correct
rotation but inverted tilt (it follows the Windows convention, see 2/2).
The correct matrix is -1 0 0; 0 -1 0; 0 0 1. The systemd hwdb entry [5]
was merged with SLA0 and has since been fixed [6].

The full STS device from the V3 BIOS (1.06), identical on the V3 SE:

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

Thanks to Samuel for the original series and to Andy for the reviews.

[1] v1: https://lore.kernel.org/linux-iio/20251223025351.3099978-2-samuel@dionne-riel.com/
[2] v2: https://lore.kernel.org/linux-iio/20260201225450.1649001-2-samuel@dionne-riel.com/
[3] https://github.com/mudkipme/awesome-minisforum-v3/issues/2
[4] v3: https://lore.kernel.org/linux-iio/20260927220559.24169-1-jwuerz@gmail.com/
[5] https://github.com/systemd/systemd/pull/43935
[6] https://github.com/systemd/systemd/pull/43941

Jared Wuerzburger (1):
  iio: imu: st_lsm6dsx: Use C99 initializers in ACPI match table

Samuel Dionne-Riel (1):
  iio: imu: st_lsm6dsx: Add ACPI ID SMOCF05 for LSM6DS3TR-C

 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)


base-commit: a3b3580713f3ac5a32dc2874ee546828977a1d68
-- 
2.55.0

