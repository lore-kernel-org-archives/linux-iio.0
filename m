Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793995715;
	b=NsVfsFdV6FgyyLN/MPDNA3O57Q/8xSNBjYd/UujmugCISomXNm7Fe042loE81HZNe2zX
	 +clx38zYmNsdRCv29orGBMYNeI8SI0SvL6iYoMbmtoDKaSAz1e9EMocv7L1IW1nXgVZJt
	 AIK9OniH5eV6JC3kE2g3ilSvOmuVn+2tYBrfl8NgOODs5SgpWL75g5ZArd7hmYMJ0jMVb
	 3C4MG+UnHei1b6DCdmVd0Nrpmvu3YSDKao2meW4aq7BsQtETdhf8FHx1x6oV4P5JpgcGS
	 +lpdw3vEas0TmiFpJNaMnkSRB2hUe5tBgLrd2zdy+8xTyRSOxaOXd2M0oCqCTYxiGkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793995715;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/izIbDRAeUawScEMYwccdPIVGb9e13gPN2dhH/CsbGg=;
	b=vdJQR7qg7DQC+2TG1cPbKsPVV9Jfe2Jv4Ls5UVNfiZNgLD2OaOnrpp2dBsxYwELvX1jB
	 JLPmlmwF9bDurLpK7icaK9uHbNmqGMEsq7nLMtlfiClaxvIsS0bVrunAV7gd5gqV0Hlju
	 IlDwAatboTKpNL05jkQzb3Y51BFl499tCYD0RUGQwLfJ6ZS/APlCUKgWjUrpJUXlKm6lP
	 KiU3YHrA3nWoLPcMWvFLjzlrLz0j+BqIJ3ZiP9A6mU2ChfBH8naoyHKXDNoJKI5RRh4i1
	 AwXkuiLazilYPzno3WKHKR3TLvPzkzImitvd2qbQ15sY609zQshDFcWBDL14BayjZ0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ct7Rt5O5;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1318606A326
	for <linux-iio@vger.kernel.org>; Fri,  6 Nov 2026 20:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1318606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ct7Rt5O5
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so7713505e9.2
        for <linux-iio@vger.kernel.org>; Fri, 06 Nov 2026 12:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793995713; x=1794600513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/izIbDRAeUawScEMYwccdPIVGb9e13gPN2dhH/CsbGg=;
        b=Ct7Rt5O5hRSK1vIxG5RBjzXK+jQ42CkDB7+Xtjgm7fcG/f8A3HYJO7l1ns9blSk8iH
         FLPSMUKYRVgNA5+4GhjUWZA6iZ9SPG+aqDg10BVyTAPcHlHuSC6+1R6ynUc28tx4codn
         upK0LeYFC5z0XBXFmiK/yF9rvRXuyDFjL0nauJJgq5xfgIepfOSAPosT+HglCOWMOkSt
         xnXA9LkqeB2+joZ2iQQLAiAmpDx0eX3oaNkZYxGO+Buac7gnlPJPWpX35mvJrVaCoewp
         UYh4H4ElT4VPIyXFD6HKX0NR6+fhNcf+8SLIgeW/FIgYALTbh4PbRLZm8hRWosFJgZpf
         qd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793995713; x=1794600513;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/izIbDRAeUawScEMYwccdPIVGb9e13gPN2dhH/CsbGg=;
        b=wNV2uPbMukk/Txkepr/saGEPdL7Fe09dhxzoqWFjDCvJNrNVUi5rchQovhbFM3s+bS
         sXDwOuxYaD4x+dcpx+MnPztGP8fH9x3aeZnigtkNB2wdOOARdw3CvRes4LHClnb8Canf
         ARU3/MXh+h/k0MeCmPr4IfwBzhR4SeXR02SZeMsSoX0pzZdSjZtbzJ47O/q3166HeuON
         /SCeAd49YV2irurSy5VOzoqTaNvJDJyRvVL0rMxPfBe0Xr/UlLEYCBE++hVnGE8sd1P9
         tsPYnc0DAOjxi3h2216XcNTtCkKbDttHPZP7DV4mLDRaI62TtLblssjiiMvknubvYKI3
         Ad2g==
X-Forwarded-Encrypted: i=1; AKwUvBwjWtdFJ4imPwc/Kd70nkD7gXD8BdJkjUXr2wxcAGhFkcHkM0TBbXE2RZPUwezMWaBos8VrxhzhVTg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Q5b9Pm3e6anu8e6Q3Ac6p6XW8TOkIxTg5FSQp4yKkLh+DvU2h
	7b7+K1ct8it7D1/rlDPbD3TEJl6SAYyoetjcLoe9uSwQ/gJ6f6FnGog0
X-Gm-Gg: AYBFou18LgDyo6ppqRwVM8RIGZFw+WW+BeTgOS6xdMNEVLkaelTa0efiFw6qy648qVr
	TYcRZxBiBRzTzzI6t4v2qYQdX2iyJCV02f8BmgqIXOe6hP2oEnIKzcWwBytsXV0NzxKp7odbdgg
	dF6FelMaHcOkdoarZ5M8zzDlauHMaNQYt8+QkAX5/cEXKor4Lnc5/TvnvhWl8byxawOspmuX985
	FEyOTgMUu6p0gJgwmTkFy7zVo2QnLFJp+07oPu5e8ExDU+mcWEXQVefqXyKCkRdTy2+6gnZSWMi
	vlVld6bcD/oXf23nJAd1rWENotRAEPOe8zj5z43nuPT1Qh2SENAz4D1VOQeAP+D/6FASZDugRsU
	urcBkQrF+xEO/ewhRDhClzu3dHR3ScV1oUb/jhUEy39CAYAFZaRuyO9zDX5gw9smguKrL8U5hwi
	tVvvTdfA28eqsxFuB5wYnhSC8oSuiy7Lgu8FVQvpBLytIwBPbtsY8jwpxkVACmbwsgG2uBMs44f
	rS6pKAA6aFYf3dDYw2PgcuB3z4PzHVhJwPUOxQgOJH61k6dZuTsDt9hPL1+vVUms4EVO2CeIJZO
	/H7G1fsMWPSuiNIa30TcrLuYxKltTEk7RvK4iw==
X-Received: by 2002:a05:600c:1c23:b0:4af:c210:5b3f with SMTP id 5b1f17b1804b1-4b6df3fd28amr69391975e9.24.1793995713061;
        Fri, 06 Nov 2026 12:08:33 -0800 (PST)
Received: from fedora ([154.182.80.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b76cbdb9cdsm17132835e9.1.2026.11.06.12.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:08:32 -0800 (PST)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH] iio: adc: at91_adc: fix NULL pointer deref in trigger removal
Date: Fri,  6 Nov 2026 22:08:09 +0200
Message-ID: <20261106200809.53799-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If 'atmel,adc-use-external-triggers' is not set in the device tree,
at91_adc_trigger_init() leaves the external trigger slots in st->trig
as NULL. at91_adc_trigger_remove(), also used by the probe error path,
then calls iio_trigger_unregister() and iio_trigger_free() on them
unconditionally, causing a NULL pointer dereference.

Skip NULL triggers when unregistering and freeing.

Fixes: 0e589d5fb317 ("ARM: AT91: IIO: Add AT91 ADC driver.")
Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 0ac74ad92fca..c7fc06214c05 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -660,6 +660,8 @@ static int at91_adc_trigger_init(struct iio_dev *idev)
 
 error_trigger:
 	for (i--; i >= 0; i--) {
+		if (!st->trig[i])
+			continue;
 		iio_trigger_unregister(st->trig[i]);
 		iio_trigger_free(st->trig[i]);
 	}
@@ -673,6 +675,8 @@ static void at91_adc_trigger_remove(struct iio_dev *idev)
 	int i;
 
 	for (i = 0; i < st->caps->trigger_number; i++) {
+		if (!st->trig[i])
+			continue;
 		iio_trigger_unregister(st->trig[i]);
 		iio_trigger_free(st->trig[i]);
 	}
-- 
2.56.0

