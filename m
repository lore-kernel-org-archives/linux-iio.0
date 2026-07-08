Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012E23A1696
	for <linux-iio@vger.kernel.org>; Wed,  8 Jul 2026 19:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783540249; cv=none; b=feCpMslWtKBv0FD13cqUbe9t0/fy5AIIXDm+ApShWw2tHIdwsJKs8Ymy2ExGBunLX5FunPjPiB+FS59pYMvnSIlp/CbnGhr2UeE1TaudbzwciWTHk5anQxGczV9x4zg2lSRbRKR76JkYmBXtfQ1pVEUyFU35CQiSctvgMGZkbB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783540249; c=relaxed/simple;
	bh=Lc7AigMLzJ+GDiMKGnyj4NPSsZLrfG4Qg/0juEpaIXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sZoms4CuuMXMN3SeEwe7BEluqV5kdkXvVmftSfYv4g+jpsO4IrJeOBSG6gyoa6yBVwFHjIhN0LCCeJQa/DoC/7OvV1Gx2194UnWlD8e71TL541s7Rs4Um6hZKVypA7Zo4gWKEsUH4CB3vbUk43iPfIQwyCDl4P0CaoOdOiqyy5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jSKnER3t; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jSKnER3t"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493ba701891so7663145e9.3
        for <linux-iio@vger.kernel.org>; Wed, 08 Jul 2026 12:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783540246; x=1784145046; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Al60uRNUXMv/ywON/0E162wkL/xU9g7jEbMyVO+DyM4=;
        b=jSKnER3tMpge/fMcKPyDh4MMrke+lCJHokeVRXUzjOPSswUH+F3o67wQ7jm7TWW5yJ
         FvkxIyllBXL4A7tu52llrRif3mafYLJHjhMHAhsejlC2fqoIW6J63Zt2HVhszA9H4dGR
         M5q2LuG7xaNRKlov+c7ruNqhjmBp0Fi3ITqOaJGAAmZpvq9hs7hw8GaLxBGdg5wxgkoL
         o4wHPcASssNnaIQZPNegXRaIanCa4MaMuH23c9U18gBfqWWE4JA0Ly5xr0oJu9bVk8XO
         ArdTCXXJ5Wab5zCWfWU/F+qx1RyGIHd8P1LQBYd4Rgg4SBcfqzkCIqRfiSFqWFT93EJn
         Za8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783540246; x=1784145046;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Al60uRNUXMv/ywON/0E162wkL/xU9g7jEbMyVO+DyM4=;
        b=FkK59QHKqUVsSH6ttMOEIzJTBSAEp6EsNVih7fUXnvFGXM2PZf/GYc1FePI/7jKmXK
         ACa6PvCbprm8Sxn34W0RsEGDWd4txdX1AtiFxMPfQmn6BNWCI7lRkIznZ+yOLfHRMbQR
         j4ggl7n7HiQ693hYUIzvLy58xrLrJzfMWeVPyLDHxEaUUoSetcoBBXQrkJeC7ZT9LeGL
         0dSLHhPy59P+V4KhgN01WiqkdsfmdS23M6cQ2s+v3/UJjzG0q0k3F7zoBGH2KHxIPkHS
         QmYBTZdYgDePA8u9kHnDmK9eqiPKfUe0qhkHAGkS1965D/aixd2oES7sBycyo+W4umTM
         DQ5A==
X-Gm-Message-State: AOJu0YyankGsr6qa6Bk/8OXtIDZrHzdks6X8M+XzEgeeyyd65wWOBste
	EeZ5Zom+OOHDKa54tZj5x2Jd2etR+KD2vRBTGGR+B27XvFC3P3bTVdi0
X-Gm-Gg: AfdE7cmBrhrDiSmvnGeJVN4go4vhzutW1SbVq69jL0DNdFzqabIxZ+bkG002i415vxW
	xLCizQi3rDDigOYkgR4Y3+BqOtUBzEk9d3L9Lz5kaKMI5wcAM0KLy5eWZVhBWdg13lf4xBqCG+b
	9agzmdja/Usirfdywx8tgBNfPcZJpuUMlMVm83Ra0EDzVZqyGOUluuxcHa5t3uU677jTttF+hVi
	yEzBbq0GRtljb0OyePQoWSGnv1x55lPAfb4WKWsUZ2XxEt+S3FDx2y+c1nhGsgCrVSLrXzF8pQN
	h1wkbrXrrWWyLHGn7zfTDyFkcH4L+KI0HN20ektcsa65RwR8bK2kLi1oQRsJvyMXWZSKbCcsChi
	fo6qVRFVtkku8GrVT6yqFMViAqazlr8BZDDVktRO891iSuhpvILzgO2vCFCzuleDrt79xd+z/pj
	4GejTaPVx+eI5ZJCvV4vzYv2ugGvBix52Iwt+lFfwud1DykZLCIbA3DJK90F1w+hqYlRy1McoHN
	ZMAtijKHx4oqmNCsXO/Ue2SDF1iR59I0wlpsr1bTvSjSHsHZFCnWzIQ0absy5cEqxVcRLO86t8x
	Rvoe0GjJNWel35lglJK5OJsS+RAH9IYSP3CbRnzSdTIarpiXZ9lmig==
X-Received: by 2002:a05:600c:e557:20b0:493:c062:a533 with SMTP id 5b1f17b1804b1-493e689c2b9mr30826825e9.17.1783540246255;
        Wed, 08 Jul 2026 12:50:46 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493eb742d0esm1701215e9.13.2026.07.08.12.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 12:50:45 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Wed, 08 Jul 2026 21:50:28 +0200
Subject: [PATCH] iio: dac: mcp47feb02: add missing 'select REGMAP_I2C' to
 Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260708-add-missing-regmap-dac-v1-1-e5925fb1fe23@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgPVoYpXEYfYpjWDtTQggvTuF
 sc3/P+CchFWWLoXCt+icqWGoe/AHZQio/hmGM1ozWRmJO/xFFVJEQvHkzJ6cki7C7O1RG4I0OJ
 cOMjzj9et1g/qh1rvaAAAAA==
X-Change-ID: 20260708-add-missing-regmap-dac-abcf866aac1f
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Ariana Lazar <ariana.lazar@microchip.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jonathan Cameron <jic23@kernel.org>, stable@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783540245; l=1982;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=Lc7AigMLzJ+GDiMKGnyj4NPSsZLrfG4Qg/0juEpaIXU=;
 b=IrVLz+r2gt9zR/udm4f+S6b/20+1ZVpnrfiXPcMIQBmNqhZzAe6DlC/DPKGzkNJw0QXfMuq3A
 WEKhKHBY4g5B87DAP7GRA0m4RbToL9Q/Ai9oR3sDHY22L8u6ADzmEDL
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The Kconfig entry for the MCP47FEB02 is missing a 'select REGMAP_I2C',
causing build failures.

Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
Cc: stable@vger.kernel.org
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
This patch adds a missing 'select REGMAP_I2C' to the MCP47FEB02 Kconfig
entry. Without this, some builds may result in a failure.

Steps to reproduce build failure:
1. Run `make allnoconfig`.
2. Run `make menuconfig` and select I2C, IIO and the MCP47FEB02 driver.
3. Run `make .` and make will end with regmap-related errors.

An excerpt of the errors produced during the above build:
drivers/iio/dac/mcp47feb02.c: In function ‘mcp47feb02_probe’:
drivers/iio/dac/mcp47feb02.c:1114:32: error: implicit declaration of function ‘devm_regmap_init_i2c’ [-Wimplicit-function-declaration]
 1114 |                 data->regmap = devm_regmap_init_i2c(client, &mcp47feb02_regmap_config);
      |                                ^~~~~~~~~~~~~~~~~~~~
drivers/iio/dac/mcp47feb02.c:1114:30: error: assignment to ‘struct regmap *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
 1114 |                 data->regmap = devm_regmap_init_i2c(client, &mcp47feb02_regmap_config);
      |                              ^
---
 drivers/iio/dac/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 657c68e75542..14a246729d2b 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -552,6 +552,7 @@ config MCP4728
 config MCP47FEB02
 	tristate "MCP47F(E/V)B01/02/04/08/11/12/14/18/21/22/24/28 DAC driver"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  Say yes here if you want to build the driver for the Microchip:
 	  - 8-bit DAC:

---
base-commit: fef4337eb2888c758c7058e1723903204f012a26
change-id: 20260708-add-missing-regmap-dac-abcf866aac1f

Best regards,
-- 
Kind regards

CJD

