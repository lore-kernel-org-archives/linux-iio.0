Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA39B3B6BFA
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 05:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791695983; cv=none; b=r0ZkebKzsiue0U9Cnw23JZRa07pZBrJNAR8nJ5Q+Kf4jL8Q9PzSX6PtNtXDGFkBPikSx+0zVGFWpOCQqMPboyDeCN/8ekrPCkHoPZtnYurdfzytLH/7Iv80pam2V1Fwhwvo1jRG3iaJMH0vYMZSqMGKtb23ZPLCi3ynq3DrGrKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791695983; c=relaxed/simple;
	bh=JgqaW0jRrSkb2cf4CqN4cZZHyxYEsI74UmVchmzGqeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4V4gMM5BxjHizauc/hOg4Vx+oFH8wl1WwLfpTr/tSws1DQ4hzdJQLEC0P5yiBloCYO60v6iR6BdOUJjVrM5bRagcF7P+7KFldHh7M1QCECdIZ4CDiakeeen/oAdVRzkQD/yhiaFcYxsLAyFQVjg3yfnic8alfCDOuZXI64D6lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beQWH39d; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beQWH39d"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3535a54bed9so1227288eec.1
        for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 22:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791695981; x=1792300781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AIrsR4VcVIMlceI9suSog5J4mni4f91foAYKdF7IqtY=;
        b=beQWH39d07G6/vqzaWi4Tt47kjum7A5w0OIE4senfCY4g1xY2GzzKS/w0EIYm5eaB+
         MxhYied6GgPPBF1X5IrhpDmfCQKgCeNshh1IEaPgLYqVlv9btgzLkCpDE8kabioZM3IG
         3co/RNSF3Sk01dgk+igYX47SxVV1SyLQEBZZdTzJCcRIwzccTjyuRVzJB7xXMt80RgcL
         qB4KSdaHf5wYZlQ8kGPaNwfHrmxgjUIML5aoVjDe6CGb1XhiCJAdS8371s/rVSGnTrsZ
         lR2dltiIc5YsPzTthwmFskvamC0m5VHlmQKwMiHqLfuV/h7dOqcoaqvb7J1cMoMb8LTa
         H4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791695981; x=1792300781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AIrsR4VcVIMlceI9suSog5J4mni4f91foAYKdF7IqtY=;
        b=VS+dPX+3wQDZzdgnK82uQHZHU1lGGlRgsWFdy2m127qQcSjrWNXfBa1UOkNOJb3evV
         P7/0P0IhUzM/AeNYIuCZA8hdvvvqY3Q/K2Dqo34YkHaLdqmn1Kz5rY+GlrVTapnpKnT1
         iLljumwgnFwUnNTIDStrB1LcAkaP98J0ItL0oNGwVC7U1NSIHjjzLx/foOoXSqolHC01
         J3pAzjbv3nnwiwL1qvUV+zEva7OxJGHV5BZ7QrYUL4jDvp58kiEm9sWMrKSStdhbfxyJ
         ZAOjmAGCEC0kSIjGgc3KnnC1DYVufV1lpMz9fO0fEEsgJnOhkO0r3Pk6D9pHOZeUUGxe
         ZKRQ==
X-Forwarded-Encrypted: i=1; AKwUvBzMZ4R7EOj2nMmr+hi817p2XQKECtWeyCz7had/5MDTtL/gb7CBZeGubC+7YxripI8FvDNcGtuDgMo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLize7ctiWILKP3oSNe42RU5tdUHd7vlN3BIvQrCuRRKKnmx5Ed
	oJKnIpx04oqA0epO9KrCj/faRLxa4zJARo4ku7fVtB2glvmZBHKARecF
X-Gm-Gg: AYBFou0u+h0e1aDeF2jwKJ6YdmZvmlebNhL3dPQ7OAgp5Jt/tkcxTV35XQtfot1T3/Z
	vGiDTOYC2G6Q07WqhbOfhY35zy0dQ3zYWpXpuABLr6g5nowgKBGhqyqO0dQmdPvbPmXeikXz+PF
	y751KaeKeWsNG41J346VvKeZsUZ0OPqsITY5kn6uuaq0zSFkYRqpcnXDFvEGcZfZ1DgI2LjFc4r
	1OGPbfKglECDc7i/cyinKWvBZx9ZI6Mqn2FWd6zpEwdshKzc2JaSzp1cVIX1WUVes4GWaUPwT7B
	KV7l/e1tPWkCWrtdBkuoQ5+WRBX0nY2PKLqEX+yvX3iOp60MIPMhyZWAPUbUYF0XRbtNzo69+I6
	U+fUqbfkvM0IE5ay69IiU0b9pS9ddwHMgZCrj1lZ/IUnpf2eOH/Q0m47YyANG9/ABuE2TGAaybM
	gDko1cIDrWHK1WOMg32UiR9GS3OpHa0iOaqR0JDlUYki3N6QI+pAbCOzqggobrZKYn4l4LEfv3I
	La0hJsEOHijI83Qc0o38m19oAj2+53Hesm1NYvpsa17WPZ3D9shvjO6lPxSH4OGyhqcKZ+BffcH
	sVa4Pjs2HbuelUnwgz93Q+c+9kP/MJm+xWO8v4RgnKr61RmK/5Q41ELzFSESYgzdX+zOJo3TTSD
	9DqWixHYP86j2ttsChOgxesiliQti29s0ZusU4g7zWjRkf8Yiju1ISDs=
X-Received: by 2002:a05:7300:fe88:b0:359:f6b6:4ee9 with SMTP id 5a478bee46e88-359f6b65afbmr412179eec.28.1791695980339;
        Sat, 10 Oct 2026 22:19:40 -0700 (PDT)
Received: from FT6N242TWK ([223.181.119.248])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-358ee8a3387sm8502491eec.15.2026.10.10.22.19.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 22:19:39 -0700 (PDT)
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
Subject: [PATCH 2/2] iio: magnetometer: mmc5633: leave cache-only mode before the cache sync
Date: Sun, 11 Oct 2026 10:49:24 +0530
Message-ID: <20261011051924.60456-3-jain.sm@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261011051924.60456-1-jain.sm@gmail.com>
References: <20261011051924.60456-1-jain.sm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmc5633_resume() marks the register cache dirty and calls
regcache_sync_region() while the regmap is still in cache-only mode.
It calls regcache_cache_only(false) only after the sync.

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

Fixes: afc8e3ee8307 ("regcache: Validate cache_only state in regcache_sync_region()")
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

