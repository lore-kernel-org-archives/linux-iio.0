Received: from sonic.asd.mail.yahoo.com (sonic-asso1-0020.asd.mail.yahoo.com [34.2.90.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC8D2E7373
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 22:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.2.90.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857580; cv=none; b=RvtHnE+n/ML70d9HXxn3cHqT9e/mTipnYUkhe65tH8M4Qhdyth984rxoTkFN7rzS6uMHf04LjYtioGqHlvUD88bBk7ZboKM8FRMqqwSDflbAUFQtRa7Wa1k6jROWlq2FsKnk4URl7yHDYVakGGjocge/zHIOtBNmX4qE2pluBTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857580; c=relaxed/simple;
	bh=aGEqPSMKq9Ug9q9GtOUHDLnF14Sv0G6I6VV/2Q1PsDs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=GbmA6qjfuDMHHoUidOvbCQqpmCIAt0aLSfCKbF9knxR2M/DV0UdvwjRde55HasXOpPleaNU3J/QFb2gCLq4t0lHca2kwxHXjmfxLCMOVqzlJNNz4td2V9RyJTh5jB0iIFr6ekVVn0jj1yQt1wNPSA7A83XNKlR5yNA4KfLO3Dhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=mE0brt0+; arc=none smtp.client-ip=34.2.90.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mE0brt0+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1789857573; bh=wG5swQbFXOftM7oGzmmIuu3TPfByChBW7CwVYmmmeA8=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=mE0brt0+ry0+JlfOTsI0P311Z1IK+KIvT2/wTQpazAEy8nH4NWVxR5/Cx9eHqWJda7fWSF87lXM1qfsAJuhIDVVpRNFuplfyKJioG7owH57xuBy3WjGNQYSKQqP67HJEu5yLE9YHPFdS+9cmpI8KKOf5iiZIgQDtKxA4EdCD7wz/lKYWpmdxqw8CR4++kdvZSW7gGeGVyHxEdc9Ssh3AVLtQ+DKGtlzt/wozFE9lujwqGybDhd2Cb4hsOJhcyXMPza0mHlfnjQJl/JqWq4GQ/OX0VhwlirGe+f2tgd+7oggXkNOy7dg+YcEkHzESv46VzZRwuL58I4Y6pFS1JZCYrw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1789857573; bh=TVgyjgweDKsCS9rHPvimi6WUBMJQGrhiQHcFVxQIq7U=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=gS+QOgtiTJqplyz4zvxRwxtZePGBsrOd+Cuv6XniSSxDN+XynavOxhU5+soqyIBkmdTm1ezU0fMDyHuzVsE94Q/5e2a4lZxGxBE8Cm7AGu8jMcPo6fx+IOx4TWnt/QfgkD4EvbfiEpcKXzSKVgRkeVs785cIeamnSY+mEAMshn9f0lMJr0RmOnhSFejr1qfQMnk3QP4IK5HayJyb/kFPIjcvDVpGwBepIgR0mI3ppZ6zgg0yNLr/6wo4bEpdnDcOXw+Hk2s5C91D3E/bkKNAP6MNwNCLBosKafwZQx/ZbHA7DaskEGw4H7LzPmsVE6af0LYy0F6Y/jbzNh/S341N1g==
X-YMail-OSG: TUYuVe4VM1kqzbZ3okIy5GipMvX.WFRo9Jw9ij9MwFEEX1RwNIR1IAacCqLF.ot
 e2S79cU3nv_bYLOBSBhYpdnzY6rvgUmQ6JzX6Mcj_YMxDca3Ep8w1dGDREjju2Sthqh3KYDJNhhP
 DbBdDJGKcXvIeZwGWzw8NdhhRo2RxjWv_DuOYCgZxLv3UwQk1DplQDR0jejBVVv3HNbu0fTRBpfY
 JM_0rXQGu6o.vr_NxAvbZQR0nAcOyF2fO4vaXgZ83gaVWD1JAM2sHkrGEABjzgkMCBAZmMWaUHxx
 .w2XYBdKxHDBGBn22.YDBK2ChkJ.jg_fRAOLf9FBzTdtPTVYftGfO7c8OSSr2JaU4WIErhcBFQ9K
 K3OhpfY5RdYqYh8DI5yq.AzUbW1tPTlQNobDB13ZL2bDRsI8vEySdswsh6ZfWS2ki57Gp97.4XaU
 xVQopgxLNa77YCCvjIP3T70TrVpoTwGReq8owoQrO9jrBRA_LhuRbEYZQhWXCvVohXFYTY2B9p4d
 nphlzTtWOOaA_RObwBzZIhAYEGBDiJpSIn2InNli7OOgWgqeSsPw8cSRZ1Cvdio.Eg3zOKWZr5eM
 PSDoT0ckYpVDJNZYOmRJpq_0FV0kv_ueRy6P6dvunR3TihkUo83LsV85x09FQhjyGbuJ_phLU_4h
 lIVQ70.eiuAxBDeGyPrrjajQZjL__F66EfKlPpsDcKufjWSFxK4LweCBuMyxWRIfLiMxEBI5cL.T
 lYCr6S9FMTOsUcTiZkYI40nYjHDg7ZHPGLOgj1MbplwwqR8wsnY1iFw7bnKG.GmkJmowoEgzVY9Q
 1ZlA389RMmxwRidF9Uxvaw7ZNDsEJ7KR5S5c3MhGsZ0HcDicFOBJS.ZT7tEz3HxWUc11V_gkU46z
 OWGLklel2dgh8GOVGA7aIFctLFM1ymdgR_NlHI4Ao6oEh_FxpO.LKiZRusRCOQcIXV3Dk9EXG0zl
 kR7OV.5MWHa8pyxE4XdlMlam_QRpWzwREGBdvyOZfyMWmeEjfRBJ28IoBLHh7WNAFslMerHB6_Mb
 r3kd1h.APulBvyEJBJ4CbLNeIIHoix2JjCScrbLdlItOluDnHWwV192A8WYFmX8pgTAfE8dNBT.A
 ziKJGWR5q9CA7c7SdOYV.Zj9wHICCxyBl8peElYVTf56CRrWUQrcHxUuHYNH7DJnvmosJg4hxw.s
 Vs0_63MP5CeeqLx07Mm5L63I.yhf8WCixAqc9ESUyRx8BLgCY3nNTcvDeA3s.XAN35.wj3OC9Gv2
 f5CDE3FIJ7odfHIm9wS.oEkHi8A8Bas0ZiGwB80bD3KFijeISTSbQp_gIOhehzwKROe3WiJpAOXE
 x46LZAKTp4mSHn1Frmva65YdSNc7QgcJ2wlEl80NtxPKZ41Rli8KF9F8xuL7c4_9JMsGYpVFRdJP
 PyZT6lzmsqDFeGhEZTtEgR421Dpi5RONvyBtdaYWUoby5u.KASFy2qGgko45H6eeOq2HSWg1mNQ.
 z7CSJ8KDCh6Ckr9LJqFCi0YQfRmiVSU6OKJn2PJytht.Zy62tdPlfOYyu.FUxZXnq2xCRfbL3Wrc
 cBD3KXyFckXFfmDWW456FNmSj6aCpxym6Z8DeQodZqM9kFybmYsr4SANstfFYbipl6E010YJ0c72
 ek7dVYX9LAubr9yCucCmmbwi.Jvf0Tt_AimCOEc7s.xRwFpfWvVdFoOCAYjaKstwNuvGJG4Xh4w2
 lgjwWa1iQyxA7LOfgdwLx6_zWKpG0Oh_.UvhxjJX4sCCNSddUmeOJQsrYwr6QXyYmgQ_Xiv13a8C
 V3KcO1UIDx7fY4tY8p9PG_I3yn0zmOc2sy91GKd85l0.DnoYDT5ADjPlLExo4xQTXUA63yogG1gZ
 CNJmmDVhPtXKHeGDMOVYvJW7XXuUya511q_12uwjSvT7JMK81tv1fl7yynJCgkbOCAA1Ayb4Kr4Z
 QeTwVMRXamcYOpyEQu1fhFkVBERxNbFGhydg4MVGRwvftgP0wPsbtLMSAwHrmPgbpAK5.BvlGigo
 H.IcmizWS78X1h1KQXPetGlWIIrVmMlUBCbQmL8MM_hj0OMd3PyMrvg--
X-Sonic-MF: <m.abubakar365@yahoo.com>
X-Sonic-ID: 5ba691ae-ecac-417a-b622-9f35f7fe833a
Received: from sonic.gate.mail.ne1.yahoo.com by mail-asdoutdeli-p-cin-asso1-prod-sonicconsumer-svc-101 with HTTP; Sat, 19 Sep 2026 22:39:33 +0000
Received: from dip84.lsn.bf1.yahoo.com ([67.195.177.93])
          by hello (SMTP) with SMTP ID be03fa672c94bb6c952363286c379f38;
          Sat, 19 Sep 2026 22:39:27 +0000 (UTC)
From: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Subject: [PATCH 0/2] iio: pressure: add Sensirion SDP31 driver
Date: Sun, 20 Sep 2026 03:38:52 +0500
Message-ID: <20260919223854.13437-1-m.abubakar365@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260919223854.13437-1-m.abubakar365.ref@yahoo.com>

This series adds support for the Sensirion SDP31 differential pressure
sensor, an I2C device that also reports temperature.

Patch 1 adds the device tree binding.
Patch 2 adds the IIO driver, which exposes differential pressure and
temperature channels and validates each measurement using the sensor's
CRC-8 checksum.

The driver was developed and tested on an SDP31 wired to the I2C bus of
a Raspberry Pi 4.

Muhammad Abu Bakar (2):
  dt-bindings: iio: pressure: add Sensirion SDP31
  iio: pressure: add Sensirion SDP31 driver

 .../iio/pressure/sensirion,sdp31.yaml         |  40 ++++
 MAINTAINERS                                   |   6 +
 drivers/iio/pressure/Kconfig                  |  11 +
 drivers/iio/pressure/Makefile                 |   1 +
 drivers/iio/pressure/sdp31.c                  | 194 ++++++++++++++++++
 5 files changed, 252 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
 create mode 100644 drivers/iio/pressure/sdp31.c

-- 
2.43.0

