Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C716B307494
	for <linux-iio@vger.kernel.org>; Mon,  6 Apr 2026 04:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775450371; cv=none; b=WSC1xsvYOS77pdDb7zMPtL5X4pFoikHj5Crk4MqmgYbXvXybRccnW2UdDwXit5ArIO/S1TdYtJVqTKd7zb5lxWSoMfF23zBKwq05LPgccalB7Y6mHe2FtswcsKEAVclEalOjdkv7LKntgqvfUBdVHtvI+f3iLhCrLB6iRF/6/As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775450371; c=relaxed/simple;
	bh=RzEbZjcRmdidkNJkUegPmAYcXuIFqLW3QK+aimG4ZBo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=o7g9cr4YfXf+NI6Le0F/h+hqs0bJC1kKjWNBUty1qY9xgyhNxmeMyA2ADGXOG08GqIfWnVozSdEObf3jmJMy0KeTzviSXk8C6nJFly/IMooJI+K4jKZnNhFOdUsO0oZleYlpiIcX/Li1Zm29SqhUWfQydxKIhyzJ3t1Ri+oMLpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfpIxvmc; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfpIxvmc"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c15849aa2cso4275254eec.0
        for <linux-iio@vger.kernel.org>; Sun, 05 Apr 2026 21:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775450369; x=1776055169; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=94bs8yeSDdB1bxNykO0LbTpY30fHjkiSTFrt3pHkIKs=;
        b=XfpIxvmcRardypmqcJP/Eq/45nQ+nNbaLRhwNzkQaxyDnSqAJO1UHh25dKedy0HPa3
         VeX8w2NLy4CFhgLTpJwMtSQk9UL341ctSPZcqrdZiuQR66Xtk+ikehDY5g4F5brOjeNe
         LC81X2XsQkHm0ru9Iu9eNGq84hn/bLT/7Yc83JyCYcLZMACdPrNqqj0LavH9Fkp0FdtD
         hTkNC0/ihJ34bON2jMzSXAd2PJ3IC2UzW7Q3pEKp4Pb+ViTSdkmOcCs0LdEpPo5t3T3K
         AW0syZG/72SSK1DQNybip2uJHqxyFWyliE1tBfhFg+iKjd2VhbhwqoUx2+Fpiko7zIHX
         OhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775450369; x=1776055169;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=94bs8yeSDdB1bxNykO0LbTpY30fHjkiSTFrt3pHkIKs=;
        b=jYgpinSTiVMAAheB+/WjQxs1CCZMJvq1V1EQu37clAYdPRb9PTXfWREm/cBy00PvNk
         ZcdlYh1d9M1UdDrjIfxRWsTvywQGAd+A+Fa25u+mJk8tDiPG2dGgPbwMeqId76vku3VN
         Ep48t40Oxi3TS2yKq9BZJvdXfIr8YeyxZF8ckaPFdCy/i6nrkocn/A6axB6ZenQZhwl2
         4GCeNOAKrHPZ8dYsyhNU4TiHJUKIInMb3t1zuNoZQTqaj1onYROETsB4w4x27kDOjig5
         udGnCs2hNLcUITIAd1K1pi9RHhrp1UFErr9UxJVOBoLrRPYBtSJRQU4VDx8Q0x3X09K0
         qpBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIH3l9zCfMB5/MZjcylZs3egkobBENn6Hpu/jGiPN44DvVDu/8Hgiw1/SmErBxx5Wh0QJeHOtvlyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwymLb4CAhSUnRvNUt35PrB0l5bA98CacdSOtE4xWdbFS5dqCuZ
	MX5V6DZNJ36/O7KuReivQga8SFfsMUqNF3la1aKfpWpX5GzKcgowfU9i
X-Gm-Gg: AeBDieuHhWTFYuai3FJ5qCA3B/7esXqYHjgtMs0xQ9rdLDmRnVCR132vjpGYw+YBhPE
	Ly5bmgY3gJLt0h8Ry3PWOiRi3BYf9apcTc2NHbbfGUkL41NXhOEyGVN4XpvnfLzo8oXE4IdD0+s
	lqmYxwEirjtGWt3FYIzS/qIbpNsMJkZaAcOSRNsmiUpWEFYDZJbZK9J3AaLAjm9dy3mlPPZqAwl
	KmxeMiAia+sKoSzswQmZJvhzGcMj+OXSNVSKF2uYDWfEyQMdFrLpnBu3XQV9KTMv4UlUVDcivCf
	Q0dhAbxWmsXWn0w7GIwIN7mjeYtQfWjYXsoC6nZlhLUewGn/soFgCOhauIpRUKkDAokLn7Ac5QU
	74AV0l5wtbBlzIuwVz9GeIzwyugkdyY0hziOSBJhr7y4j/au6UjLVHHtax8rSCNtVJFWrCsb1H+
	0LpBN+9ikHQK6OaDMbQSTLT6YsFdvsP5k+QfuT2FmNv8cjgKGMWJVDiInRipa3SETpKihEtA39o
	6LqJCHdBCwpy+A=
X-Received: by 2002:a05:7022:43a8:b0:119:e569:f609 with SMTP id a92af1059eb24-12bfb6ecd57mr4932000c88.2.1775450368753;
        Sun, 05 Apr 2026 21:39:28 -0700 (PDT)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:fe13:98b9:9e98:d1bb])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bed93f861sm15182005c88.0.2026.04.05.21.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 21:39:27 -0700 (PDT)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH v5 0/4] ti-ads7950: fix gpio handling and facelift
Date: Sun, 05 Apr 2026 21:39:22 -0700
Message-Id: <20260405-ti-ads7950-facelift-v5-0-1f980ed3cf9e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPo402kC/23Oza7CIBAF4FcxrJ1mCqWCK9/D3AWXHzvRigFCN
 Kbvfql304XLM5Pz5bxZ9ol8ZsfdmyVfKVO8tyD3O2Ync794INcy48hH5ByhEBiXD1oiBGP9jUJ
 pB/UrhUYzyoG15iP5QM+Pev5pOaQ4Q5mSNxur183TXHdCSoWqhx7cTCW9uhJTvE6xni6zoVtn4
 7yiE+X2eH2WVrHS/5BA+XVUFYBguAjO9QYP2m+4dVQdNgbX342hGVaOykpUdtBmayzL8gf4OJD
 WPwEAAA==
X-Change-ID: 20260220-ti-ads7950-facelift-ad8b5390a654
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 Bartosz Golaszewski <brgl@kernel.org>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-6911d

The original reason for this series is to make sure ti_ads7950_get()
returns result in range [0, 1] or a negative error code to comply with
gpiolib requirement.

During review David noticed the fact that the function also clobbers
gpio state. Fixing that lead to adding cleanups using guard() and devm.

---
Changes in v5:
- replace mutex_init() with devm_mutex_init() (Bartosz)
- Link to v4: https://patch.msgid.link/20260329-ti-ads7950-facelift-v4-0-c568c508c49a@gmail.com

Changes in v4:
- rebased on top of latest next
- dropped the 2 already applied patches
- restored inadvertently removed mutex_init() (Andy)
- stopped calling devm_regulator_get_enable_read_voltage() on ACPI
  systems as it is guaranteed to fail (David, Jonathan)
- removed call to spi_set_drvdata() since it is not needed anymore (David)
- Link to v3: https://patch.msgid.link/20260305-ti-ads7950-facelift-v3-0-a23fdd1a079e@gmail.com

Changes in v3:

- Added "Fixes" tags
- Picked up reviewed-by tags for #1 and #2
- Dropped the conversion to "error" variables
- Avoid using scoped_guard (per David)
- directly return results of function calls at the end of function (David)
- Split spi_sync() error handling into a new patxch (Andy)
- Switch to using devm_regulator_get_enable_read_voltage() (David)

Changes in v2:

- style fixes in #1 (per David)
- fix to not clobber state (#2, new)
- #3 and #4 (new)

---
Dmitry Torokhov (4):
      iio: adc: ti-ads7950: switch to using guard() notation
      iio: adc: ti-ads7950: simplify check for spi_setup() failures
      iio: adc: ti-ads7950: switch to using devm_regulator_get_enable_read_voltage()
      iio: adc: ti-ads7950: complete conversion to using managed resources

 drivers/iio/adc/ti-ads7950.c | 197 ++++++++++++++-----------------------------
 1 file changed, 64 insertions(+), 133 deletions(-)
---
base-commit: 2febe6e6ee6e34c7754eff3c4d81aa7b0dcb7979
change-id: 20260220-ti-ads7950-facelift-ad8b5390a654

Thanks.

-- 
Dmitry

