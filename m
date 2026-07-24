Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB21E46AA86
	for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924027; cv=none; b=mYQgv+WCFfAk1AED3MxQvmiT3BVmXV6MM1Cxy02Z7v1tHLe+HEgwYO9FWeYVLsaDJlL1Tbj9yUe31ZfoqEJhz7VTmN9BE1hiItsux0eV9VS4WkTQag+SfB5BZr7bHNian5JcKo9zvQyiYulBtU8ubeUf+ThB2+dIZsoujTiBMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924027; c=relaxed/simple;
	bh=yRVmGTHlVjCqAMICdYZX/WJ2qye72HSFuevm87sKa9E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lbcvD162m8tgL2mRdiUP1CK1G6kt0EgI07p8P8OoSDV2Xt9/dcJVsn2W1LfyLSzho911AX9pdmhZB7bwQd5qS4lm0jvraBrGUodG7Kq9j0JdZLVMuBTm2oTzhOWHoPJO+oa6WAb6jTLUZRJIxKpYUcAXq+GIMlHVbsaUA/jcDYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Xn5LboaD; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Xn5LboaD"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-45133d2974fso518449fac.1
        for <linux-iio@vger.kernel.org>; Fri, 24 Jul 2026 13:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1784924016; x=1785528816; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hxwsKA/pBOcqaGT9IA2EJlmhRxzg1/JW4iMwxTMeU3g=;
        b=Xn5LboaDg6CdxGlV0AtAUiWAVJluoMgXOhdApbPo3df/+lKQWszhCRuo3yGc0/zjUo
         WVmBwyPPduommi+493UQjdNpDsqcPz8s+HgzdKD3pTNUikB0lZrx++pr4CJm6pxCr/tA
         wFEomCTJRi/m6Sog+sL/jgGDyuI8OPlQWorJu39qpSG7kQpMVqsiD3HMzCaFgLQMmqRk
         B8i9RATYVoOBSqNTdlBaC9NAPypOz17NOZ+Lpba8XvkWVthl11ddmM1Mo7nvVZ3Q1xue
         bMffhVhgy/7MPUzzgb0swjJuwx6LsFEYrkHZcetV8pIi42wuen8glk53Uo4g1SQcEya5
         Z2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784924016; x=1785528816;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hxwsKA/pBOcqaGT9IA2EJlmhRxzg1/JW4iMwxTMeU3g=;
        b=fck7j+1W8KhqDV/obJv6+uhqVAj5AVxUd/gpDXankE7plBVK49nI99X9HzxaXJaJmJ
         x8J+OR1oBJMLLZUsF/tupEH+XBCZir3zFB6FkwSVigsojTv2gIcFGnrg/uvEzgkPSSnV
         6qMkOQ/kqyULxSm1K4HIA8hvzjf6ANgPw+PCiM4GsYNEvyDLArZPTNOadfxdbIzad/nW
         HUBO37NAW9Kx7Wio4jlZz/tX39gB8PiVWlnoEmV6VMCyXNMqg9zjegd4wWrjFxVMqNnP
         NL5ngkuohTrkfSDwERdtGhSRAt0Iszx9Ihb8EJbfflbv8pqMK+Gi1AzPnWhVeujbLv5G
         VzKw==
X-Forwarded-Encrypted: i=1; AHgh+Ro9/37tRAaWfWTXSvVWx1sXEgiVZq0DOHq62JE3ePt4R7hDF25Adq/lEnHNooJxpQdleUSLrkzl7wQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTBp8TeEJF8po0VyL1ex4hsWSQn19n3w/cTBeSO4gAaR3FxZc5
	SIj1bcruU3rM9usnRmt5clSdpE7ZJBVn7pOfd6vbjoK9VY677vZJFL3ZPBXekSYoYZo=
X-Gm-Gg: AR+sD12RFlwtPiRNmzHl6QFM/qEJXqnvuL2Ax7S1fTNYbssS2lhS9Y8cLIUpljGH5WS
	Cb8LMJn+JVS9MtD6odr8vROgDn+0wFvzt6FGsHrl06GZUsuEyZ1qeSfrzusuqxMj2tI5WdV+kCj
	SL5w5NCb/GzQ/LlipnNsclcNGe1WO0pJpWWlliBAZBnZCaSNz7qUbbh+Dx6iGQ3bVW2PgzsZpPs
	VY9Ux0oksBUMA4u4n0CvEK+joU6AEFoYssYWgrkYJd4KOlY3JpcCtXI4/AHpUA5TIA6GoF9gijG
	trhz5MjvURlnBcLYnyiCHn8+634xWVbpdunKFxdfsNrYamcLAtRVt/uThgdkA7uWYe3JyDWkqXN
	JJRuOzQdaQEPydq5UpoFs6tZ0gnoqPdGKRVm50WhnpCYCN78MDJxYKow5dORJoavsqg6V/3G5ms
	lZDdjNA0G44+BNBSRH
X-Received: by 2002:a05:6870:63a8:b0:456:771a:f843 with SMTP id 586e51a60fabf-457a106f518mr5949618fac.29.1784924016034;
        Fri, 24 Jul 2026 13:13:36 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b635:d463:c98:cc75])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-457675260b4sm8309042fac.17.2026.07.24.13.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 13:13:35 -0700 (PDT)
From: "David Lechner (TI)" <dlechner@baylibre.com>
Subject: [PATCH 0/2] iio: adc: ti-ads112c14: continuous mode support
Date: Fri, 24 Jul 2026 15:13:09 -0500
Message-Id: <20260724-iio-adc-ti-ads112c14-continuous-mode-v1-0-9eb0b7a4f020@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WOywrCMBBFf6Vk7dAktj76K9JFmpnqCG00DxHEf
 3e0gitXlwsz59yHShSZkuqqh4p048RhlmJWlfInNx8JGKUrq+1Gb20DzAEcesgskYyx3jTgw5x
 5LqEkmAISIJp2p7dts9F7JahLpJHvH82hX3oqw5l8frO/F5GuRfx5Ofvpu2qRmz/yoYyjPCNEc
 giNoRaNdxr9urvZN3twiWTiNHHuKlmS6khTEE8tvFpSth9V/3y+AExWIbYOAQAA
X-Change-ID: 20260724-iio-adc-ti-ads112c14-continuous-mode-dd1580754609
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, "David Lechner (TI)" <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1691; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=yRVmGTHlVjCqAMICdYZX/WJ2qye72HSFuevm87sKa9E=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqY8da5EEplt2Wiri0pqeXHh282YyCOq6rJXNxC
 vkJBQqVPmuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCamPHWgAKCRDCzCAB/wGP
 wLlJB/0ai/+RctGy9TF5LWiQRrk4AJCMJlDc9kGB3/6BgBC+xIrSJEvUAXA/giTcw41mPLRe0CH
 ipRoqjFg+Tz+vu8kCQUXJQGVwzP/uvnvl82uGDmASovV9QZFmgjpLIDt7so+l0ubT9Ncj38Zfjo
 EYtxWKOWeq/SFPm7GHSkobBrgEkhQAPx8L5yPkz1iBW2a42lMkHAfNhIhrXMfb3KSpQPg3D4bHK
 0fOh3pWmvJHlGw4LlrO0xW9QcGQ95M5CjjQK3QShSsVdc5mUGBVfVic6QtI6Ra8DD6kcEFVaXxJ
 8aAjsDmZxs77k9IvJCpTElgQf0JWsTitYqk13EJsmZsMR/hE
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

The TI ADS112C14 ADC has a continuous mode where it can trigger
conversions using its own clock and signals that data is ready using
the /DRDY line. This allows capturing data at higher rates since it
avoids the settling time between conversions. But it is limited to only
being able to sample one channel at a time.

Users will be able to select between continuous and single-shot mode
for buffered reads by selecting the trigger. If the "own" trigger from
the /DRDY interrupt is selected, continuous mode will be used. Or if
some other (software) trigger is selected, single-shot mode will be used
as was already implemented before this series.

Supporting open-drain /DRDY is deferred for future work. In simple cases
we have just done a `drive-open-drain` DT property for this, but on this
chip there is more than one pin (GPIO, FAULT interrupt) that could also
need to be open-drain and not all at the same time.

Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
David Lechner (TI) (2):
      iio: adc: ti-ads112c14: add DRDY interrupt support
      iio: adc: ti-ads112c14: add continuous mode support

 drivers/iio/adc/ti-ads112c14.c | 278 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 251 insertions(+), 27 deletions(-)
---
base-commit: 0b5e142ced4bcf20532da051934bd694d1bbd470
change-id: 20260724-iio-adc-ti-ads112c14-continuous-mode-dd1580754609
prerequisite-change-id: 20260714-iio-adc-ti-ads112c14-buffered-read-41e5d1ca0dc3:v2
prerequisite-patch-id: 8723aa599dcf5b836fb81cf1efb6c9096bf60b7a
prerequisite-patch-id: 12754335ccf210bcdeaa8a5d60b2280618d50993

Best regards,
--  
David Lechner (TI) <dlechner@baylibre.com>

