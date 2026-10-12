Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779873A5456
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 05:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791781272; cv=none; b=m6VbgWH5ivTawnO30TA9FrybVmxDRbI4nhndxzN0th1Flbr7Okeu4mt+UvvXs349j9PMruhv+aYYbFkS8jkNhwuuzGURLeSIxqyBnIV//ok/8v3L1gI2h3QyqSNNaa+nBUGXKItbf59eElahRgMjLkxJ16bi3xuA68RKC1FWyLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791781272; c=relaxed/simple;
	bh=Dgrcx+5l3MbVk3DHwGskiEuwXmdQSekmNT7gHBvxlA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ark2wmAeIelbtO9ISLa1lxV2V2MbxFxsxv9dKI4HgqkUJM3mn9K3YSA9QX+CoqwwGrYT00WbGfzeTK4sSf3SJfUSvJjirvN/1zfAxIEoFe6+7HNZ1OLY5SIAhNnCJrrFSCwZefLTQNLG8Ruh+c0qsfv3ol3IgDvIa3Zni0byK+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABiRdiMF; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABiRdiMF"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-35aa0cf7c40so500142eec.1
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 22:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791781270; x=1792386070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eHYM8ew6E+IpcvsR/Lhzl7vHnRNSJSSkWtz2XyPlZeU=;
        b=ABiRdiMFnGCfWcAoChI5p3GeyEg4QH/S4pWXZ8jR7uEU52wSHXCIMpn7phMJsNIScc
         UpRTnWaiTUVTxqhuqBs7i0VEJwisfIXj7DQBr30HKA/dfFzHY/EIkUovm45kon9FVNxG
         BGVW6iAvEi/MYUn73cCMgt9Fs8kq5rxwoXMtap6DNMgFKhMFiBhS6n7sUdBUGR1abFSW
         kxDUyEPeYm/Nstpz8rLGktvMIxa9JEzG7zEomnz55RyT2GIiaWi6C3jZXT8Ri3n6gLP8
         Us1OObU93g8EjlX1xRwkQetPHytkMxShp8pPD4eaT9vc8nLd/QDcgG1aThefXVMvUkGC
         64Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791781270; x=1792386070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eHYM8ew6E+IpcvsR/Lhzl7vHnRNSJSSkWtz2XyPlZeU=;
        b=z/HOMgRhNbwJat7kQg2PDQ6VvsGzoqUUp8uqHxNJMh/abPimIIKwKGqiKMSd/pmAzr
         iLObUa1PcXz2JOfjwB9KahpPeIk8RopG4eQD3RJzNeBke4JmacMm8uLUyIb34/uJ2b0o
         5Gx/FBUjJqiJQ5YFnsm8mxvwPIkyI6OjhN40YtsSh0G2XXWMW2uhJFBJXYr9yR4obV9G
         QrUAIq3ySk1/Jc2TdO5BZK6HLwFi2NbCslM2l6j9WT9HccoKcdkSf283o8TpmiFljrMp
         PESLA6s8kscLd9SbhYt9oAHhPxlIrrpoCkPi6If7V9Jf1dhWoKFLZAgT2fDN1YTLdQM0
         C6kw==
X-Forwarded-Encrypted: i=1; AKwUvBxziPZAIL3v1yfZ6z1EuYVqftrodQf5cBYnOzO/Fi18ycJoE+ZKJNwowlCs3a5V2s6s5fUnQJL3xIM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhPwROVJI8KOMJhqs2uXc9D6PKtgSUm124v6ZtvkGEzbJSfUI4
	0/IgGe/GF6BqfvZPxzMDyN/QVEK9U3JlkSj9r/O5W4UjJglnrGYh3OMM
X-Gm-Gg: AYBFou0RF+dXej0hy5W4nCRlMCz7bQoS1GNonKzMLMCMeeXFatVFJunu9UAMQLuz5+9
	XD3gfSHN0nwskExtPrSUQ9TXWAMw5vm4gIYIcrqKtLhxd62sqC9vqcLblIy7oewJbzo40C5dvS/
	zoYR71PwACvbLOeNOX2tC/CnPeUB+/HsBTiYm8hvWP84R4ysavQ+9QmGRrRRn0oQvJen7KJ5tzS
	ZCNDBjqs8t1tms+vPXp6n96mhGbSjjqyxDmNsLR2uu1u/zYsdcM6UCWvnRLzOU/eo5kbYn2akrs
	1TqoTNB5fr5kWBdRQ/oI9dFChkcF5h00qornGka18ujcmKGbZnKLwAH2St0UshLAusr01hqYTxV
	ILoAPSMs0AzrrfJI+36qm1PO0E8M7PGwmltVGZ4IgNDR0bn/wSiOX+2xMsS5FVbdaBvy1FalItI
	oUo430cOTOzilbWRoTBde++TUOHSjhZwRILS4Rb6o36mDzWi93ii7t3pQ+rRPPEP1Efdl7RyjfE
	D54iFvm2VrRyOr9lR2rk8cSXDzumty9ShUlwBfGkEcVnoYEL0/rhFuXXW2YeyHCQTSlvFjQ/MZ0
	dhJiAtTsmEt47nvGjL57yjwtR3uYYZUwud7HJ7cguvhWobjo8oEsQB8QlthGMXZTIeoUP0uwq25
	IVGIYQG/0ir9iIRdZZ7e5cmzoj4arN1ZgOSD9rtWlt3hAgsUs6hPDM9M=
X-Received: by 2002:a05:7301:4882:b0:359:8fd8:a86d with SMTP id 5a478bee46e88-3598fd8a9c8mr5088785eec.31.1791781270317;
        Sun, 11 Oct 2026 22:01:10 -0700 (PDT)
Received: from FT6N242TWK ([223.181.119.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-353814b556esm31804877eec.18.2026.10.11.22.01.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 Oct 2026 22:01:09 -0700 (PDT)
From: Shashank Mohan Jain <jain.sm@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	bui duc phuc <phucduc.bui@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] iio: magnetometer: mmc5633: leave cache-only mode before the cache sync
Date: Mon, 12 Oct 2026 10:30:55 +0530
Message-ID: <20261012050055.48850-3-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261012050055.48850-1-jain.sm@gmail.com>
References: <20261012050055.48850-1-jain.sm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmc5633_resume() marks the register cache dirty and calls
regcache_sync_region() while the regmap is still in cache-only mode.
It calls regcache_cache_only(false) only after the sync. This
ordering has been wrong since the driver was added; it happened to work
until regmap started rejecting a sync in cache-only mode.

Since commit afc8e3ee8307 ("regcache: Validate cache_only state in
regcache_sync_region()") a sync in cache-only mode is refused with a
WARN and -EINVAL. Every resume now gives

  WARNING: drivers/base/regmap/regcache.c:536 at regcache_sync_region+0x1a4/0x1c0
  ...
   mmc5633_resume+0x2d/0x70
   dpm_run_callback+0x7d/0x1c0
   device_resume+0x175/0x270
  ...
  mmc5633_i2c 1-0030: Failed to restore control registers

and the control registers are not written. If the chip lost its state
during suspend, it runs with the reset value of CTRL1 while the cache,
and with it the sampling frequency attribute, still has the configured
value. Writing the same frequency again does not repair this, because
regmap_update_bits() finds no difference to the cache.

Leave cache-only mode first, then mark the cache dirty and sync it.

Reproduced in qemu with the I2C driver bound to an i2c-stub device: set
in_magn_sampling_frequency to 3.5 (CTRL1 = 0x02), clear CTRL0 and CTRL1
of the stub behind the driver's back to emulate the power loss, and run
a suspend/resume cycle with "devices" in /sys/power/pm_test. Without
this change CTRL1 is still 0x00 after resume and the warning is
printed. With it, and also with the regcache commit reverted, CTRL1 is
0x02 again and there is no warning. Not tested on real hardware.

Fixes: 6e5f6bf2e3f0 ("iio: magnetometer: Add mmc5633 sensor")
Assisted-by: LLM
Signed-off-by: Shashank Mohan Jain <jain.sm@gmail.com>
---
Prepared with Claude Code (Anthropic), model Claude Opus 5.5
(claude-opus-5-5).

 drivers/iio/magnetometer/mmc5633.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/mmc5633.c b/drivers/iio/magnetometer/mmc5633.c
index f4dae7ba13..b651f01e1b 100644
--- a/drivers/iio/magnetometer/mmc5633.c
+++ b/drivers/iio/magnetometer/mmc5633.c
@@ -499,13 +499,12 @@ static int mmc5633_resume(struct device *dev)
 	struct regmap *regmap = dev_get_regmap(dev, NULL);
 	int ret;
 
+	regcache_cache_only(regmap, false);
 	regcache_mark_dirty(regmap);
 	ret = regcache_sync_region(regmap, MMC5633_REG_CTRL0, MMC5633_REG_CTRL1);
 	if (ret)
 		dev_err(dev, "Failed to restore control registers\n");
 
-	regcache_cache_only(regmap, false);
-
 	return 0;
 }
 
-- 
2.43.0

