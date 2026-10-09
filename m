Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DDE31E844
	for <linux-iio@vger.kernel.org>; Fri,  9 Oct 2026 22:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584731; cv=none; b=rW4jK5p+7cEMwBNN1ts6lJWINAbGdsY4p4D7TtCcv+HwLWQHTl7cdrwzKnrcVoy2Z+fE0SvVrADcVClOwiLW8f+9HZwDFv2qEZd4Rq1+pjb/wVlj3AH/zh/O+gRLfVwl5KzwlTPp4p6McUJuXWdpU2k3Q2NgS04mwztmhqV3z6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584731; c=relaxed/simple;
	bh=ZfxBmz6GPShtLwiEphjvFKPdKTZLhI6jZuqqelBJVec=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aEOY95opVbkpyyH3yF/ETJ/kjq6FT7kdAoe+ryMLkERXET8pHGsjIjq+fH07oCHTtPaGPmiuMMCrcMKWq9NjUqYRsjqYcRn1gQSWdUKjTPn+qFc2GwquW2/IaoYzVqawFaI+h5rUjNUdK06/8KySpYGJeE7ZDz5vEcJwOmNxL5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=nI/c6FN6; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="nI/c6FN6"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7bec5112765so105594137.1
        for <linux-iio@vger.kernel.org>; Fri, 09 Oct 2026 15:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791584726; x=1792189526; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=w9mGT3pmDM0+79/8mcyzR1bRGnhrCDI9ZzCxuUr12cU=;
        b=nI/c6FN6s35gOxY+ZlDUkGDDgsq3JskR/4CgbuUU/q9ec29nrg280HOl3sJyu3573W
         tKskev6BDhmoktaLvPGqrmgwh1frAbjM5cnz46WnZsnTDaS3RDQOcWU+o12F0lCQiP6Z
         /eFt/VPkoLqOTyO4BjsjtTGn/fJ2Ukyqw/e1GNNUEtKTa2SRyOPz8E9ToDGCB7hqq2Fc
         LAASIxIEeZIghk6Gl7emS7bK/dZC9Lj3rp0wJAzGEH9RFCZLU8bN7+1Ytf+nXEJ368EC
         NeZPlxiBPmZmpoApOmNVnjSJGCQgQvVz+TMIXDhguJA0/QhovN5z9yBEKb43v4QuYsgW
         WBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791584726; x=1792189526;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w9mGT3pmDM0+79/8mcyzR1bRGnhrCDI9ZzCxuUr12cU=;
        b=Ad5w2HrxvIZeV19tKD09WhU4Ayh11aFFDv1N/vEkB9PvMLWHBCoVcMEBX+qAclspMK
         zB4Tm1kTWA2B6Bt/vC8WAxCjplPrTZZFCa8WIsNCAiXZcRFSbLsZwdFmoJ6CFtgBHin+
         4ECm6PfnCz4F8w5gfs0EeZc4i41tder7YncH5LP127ViJYuvi+KVsWsjS8/DRsxBZg2Q
         J34rD7Jgk5uDH1IQf26Oz7onoCXiTtdLbsm5YsF6qKP9bscHiv5LIKMCwJriUfXsaxiv
         Iu9jZYuosv94B0D2KQjARlggLZ46KQlLmUp2+7rJktp5Ra1lDgW6CAiE2L4y6AllzAeb
         m1eQ==
X-Forwarded-Encrypted: i=1; AKwUvBycbK//obrX/QElKd94ZIKSQKK7UlJPGoIJEnpn9HJsboFVhwBL81rSU0RkQX/kcngRtC4GCe4pXm8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzN2A24nEIXaywpVoe1KmycgcbeZ797sbYkMpDOlqbFdTNm5nD
	YW4yNACwD/hy5IW6PG55TWhYD4v1KPk2J5Bajw4TohQ1QzH/DgqucWunVDHkEF5Jlqc=
X-Gm-Gg: AYBFou3Oer9WrRS2VC3zc13wfRvWHY7gtLaKtNUHrQ/048RY7YD/LmzlFyvPK+VZk9d
	kh+1N9RHwurIQIDb8S33EYvZ1nlobdi0AUlx7AIk159QPTRS+aafFXFA8s/IqL+IL5piUKmewVu
	RhAyqbNj00O5KwuepOy8rHt7rIYLGGG4Fcy91u3m4dA8Xt77TYTvd6yGcTe7Ewb9OP1s0oQQIhp
	cEB30RMEpSx91feMjb68chJ5JNd+1RGALG9WqavRdDniaAhAx1iwBrhLZ9aXMveU+9uj3nyI7ZD
	n98I/OSv4esmeEfkhVDqXlViWfIidCSOFNZAV+rlA/jQH7Zj30tv15bSkGlZEbi325PbqhkM2rZ
	rCpvWNGFtSIGtTdwFUC7xZvcBWqevPqQfqm3YzUwTi6LvfzIDFpPHGhusl7HPNi33Lx+dBnrhms
	RpGUvw3lJyCAnCi3rjhE02xyb1h5Q1Irh+7DcUsI3hzpZwi9BAp24KDM30YkXn1Mk7bx1dw8Ufh
	JK53XT4gzxcKA==
X-Received: by 2002:a05:6102:4490:b0:7a8:10eb:96ce with SMTP id ada2fe7eead31-7cb3668a4c7mr1182570137.4.1791584726151;
        Fri, 09 Oct 2026 15:25:26 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:29bd:56f6:5ae7:35d2])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99007c130efsm2125418241.12.2026.10.09.15.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 15:25:24 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Subject: [PATCH v2 0/2] iio: adc: ti-ads112c14: minor fixes
Date: Fri, 09 Oct 2026 17:24:56 -0500
Message-Id: <20261009-iio-adc-ti-ads112c14-fix-settlingtime-sign-v2-0-6b54a7378101@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/52OQQ6CMBBFr2K6dgwtRcCV9zAsSjvAGGhNW4mEc
 HcL3sDV5CUv/83KAnrCwG6nlXmcKZCzCcT5xPSgbI9AJjETmbhmtSiAyIEyGiKlEzgXmkvo6AM
 BYxzJ9pEmhEC9BVVhLru6lEZIlgZfHpN4xB7Nj8O7faKOe2E3BgrR+eX4Zua791d45pAB70yRY
 ymkwOreqmWk1uNFu4k127Z9AR5D6g75AAAA
X-Change-ID: 20260925-iio-adc-ti-ads112c14-fix-settlingtime-sign-a8e34f974d24
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "David Lechner (TI)" <dlechner@baylibre.com>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=949; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=ZfxBmz6GPShtLwiEphjvFKPdKTZLhI6jZuqqelBJVec=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqyWm99QeVV/EUkfMU1QaXv7JSB+Q8cXpb4e61g
 seaqLS3O9WJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaslpvQAKCRDCzCAB/wGP
 wE5yB/wJim4CHHUM26w5lPqU6G07LKauaMswnKs7Elrepp0Tew+B4LS8sxiZ6tovULqV23lUcd8
 EvhJ9ek8xPFgFJIyqlpiRpROBcFy7BvAW5sO2d1AGIN9TTTVAjjVTS418tfT5heGCqO+FlJHWyl
 xPzPZQaSFEtllTFl/VmusAr9n311cOt3/FaEFy2FEtCY/tUMe9arAlf3u/CNl5HOwS8JMi/6nCE
 OANDrMxK9nYQ+4kkCdfwpdt5fA3QBpOurJh3x3nWPtMtrnOLz77zTDvsiSKPYeywqkTFUgjfzWB
 kCWY72DCnBgycCuVX+IqBggyBv9AY2mqFz3diTQW2HqfO7VD
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Jonathan picked up the filter series for TI ADS112C14 already, but there
were a few minor things Sashiko found that seemed worth fixing.

https://lore.kernel.org/linux-iio/20260913211128.25734544@jic23-hlaptop/

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
Changes in v2:
- Change settling_time_us to u64.
- Link to v1: https://patch.msgid.link/20260925-iio-adc-ti-ads112c14-fix-settlingtime-sign-v1-0-1fd53e7242e8@baylibre.com

---
David Lechner (TI) (2):
      iio: adc: ti-ads112c14: fix negative settlingtime check
      iio: adc: ti-ads112c14: fix settlingtime creep on write back

 drivers/iio/adc/ti-ads112c14.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)
---
base-commit: d8c0f48f0b1583308a98401c0c7b1a65d1d43a6c
change-id: 20260925-iio-adc-ti-ads112c14-fix-settlingtime-sign-a8e34f974d24

Best regards,
--  
David Lechner (TI) <dlechner@baylibre.com>

