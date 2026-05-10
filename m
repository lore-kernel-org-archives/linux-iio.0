Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6A8196C7C
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 19:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778442721; cv=none; b=tu4016W9lFtbff3JM8XbmukjoOBtUxdm9zrToMCHSsSs2mYJOYmdvFIsmbLgL+SenPhmAtUWWl+9uEJuBRocc+HmGBS3Impjm8o2HaLcicB48TFUDuXQqc+KOIX06DeSu6AcunFBZCQ0Xfs0s4YwTJ9f4WcdcIRb/dWnzWw/y/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778442721; c=relaxed/simple;
	bh=SJ2BW98p81Na7BI7ENpdz1Wo6C3u+mKqcgpg9bZolXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nem2XMWshlsBibwSfw89hNZkoxBfI8S7k9gKRIhwt3HlqQnurZysK9t+0b0JP3//mAn8acfJ/IDOXCeywEIwApGnW7JJKqlHEKxSTlyJHzHMcLE6h4IlzuAlAt2jDPEkzqXpuxZ8YR6Px+BP2Mv8jIhtKBMzylo5KhF+g70D5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkUTzfs+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkUTzfs+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b458ca2296so23344675ad.0
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778442720; x=1779047520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wePw3fvqh14IAiFXg0oU3SyxE97VnhTicxkSYMPbBQU=;
        b=NkUTzfs+pt2T8R5zOHwnHUJhS6sX5w+g0Oq7lLHAfNnQf9QKdCA9C+eaOMZo274WtR
         15JigBDoCvyRLnQWtnm+jDcWDzkn/4xtSA2NqM0MacHxDR03f7BhSbSHq625k4fpoDDZ
         tcQTeCZWzw6XuIGPw4+18xJuYayuluNOqNGLSzxLNfLAqGGmk4L+P+O5LsqdWg+UPqjE
         krz+19wokh+XVs4Dt7G1I6gHAvbfdjOSbvHrtLVsIt0SV2FgcqDsN8T+hn8OlszJaZHV
         FxPMAM1Uke9ckNGXL1oh18rPMbRvyl69+ZvD9uZfAEyjzim+MX0HGeyooqMiHG0ddtKc
         TEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778442720; x=1779047520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wePw3fvqh14IAiFXg0oU3SyxE97VnhTicxkSYMPbBQU=;
        b=j7P4XPdz0eDlx0US0IABbPTTsfplbYfWskfhwg7o0e9DRmmn0EPT5/BIx0vdsLEGsZ
         4FXiZkqF7sur7IEcXr7Inl1YoeNq7uFM1q3jSfYf2rAQemRlmYjkYmlaaP/50oNgZn2h
         eIa3Ku223JSofGzdYdl5Xjxrxdmu89ziPB54aNdbj44KgGeVDTRh1EcNQ7KrS8wCTeLC
         6+z07nrgJF89P3/tRk8FaGGUGaHYM13c0dE1f3rw4bME8PHjCLqRYYcVbKYfYSYimtys
         HBermxYTTdoddZqjWW9kdTwAd+qDINVan12dfczxgD4AGUgNN4j5k59FBvT71KGRDey4
         uuGA==
X-Forwarded-Encrypted: i=1; AFNElJ+e2tXFRjGx6EBB7XxSlgoLGAXtVQOQ7eB5NNvY6MxFZ9cKLSlZo1UyhNn56njA2iyx2noXwZjL/n8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3q0tXoxf5pQBCwUT/H90cXDeXrhqo4y+VtRi+PxpvjsCDcl8a
	qP6jHx7eRQHHhnhqoc3tb1hwc9ElzaswoIcaz40TGi70QQ5Okmqs9HpN
X-Gm-Gg: Acq92OHIIKPb9fZ+8mlVv+qAkEo1f6eI5cvYQdwQ2Cnnee0wPaixsiBh1rJGvP+lr4j
	yX5VY7oAY4zh0ICc0vXNHut09ngDpVUYDwGMSAsh+dFBRK9Ss7ltjTzqh2PtUfxAiHZhkMnSk/q
	9CRT7ZolQoXyx12Yl1it1Dd1hh5QSO8f+u5MPDr6BBfoqESPPWwWs2R2mF9zwdVkYi/H6mCyk4F
	MP+RoUUJfYHWKrpSWn39FeCcBXNWSxVgb4iJBo2I+goC3DgmbP4kiNvW3+amiLqt6WjkQy2kdGJ
	e4znJOXUDfATSf8TEcbTMDZ/MsnYF2y1rOBybYqJgaHsFySrYUAoCEe3lfkRAegly5rygLlFqU9
	RHe4O0LZhLRpLiB9F3HAZZD1ZbmXxKURaWWxXVdR+T7Zm+5PHMI13R74uE5saw84cTsEposFOkD
	vKjTo809mAUV/CMeMBUjlFDwRgn0hDz59zXHKgRkAE+6v4dyIK1nxmk+4hzeGQS9WrxxaZEGQD4
	O69TuWeD2AQqH9KGq4/pI8LxretZWXB0uq09q26cyQnZmzA+Gvg+7X8d21Zhdfc6hVRQQJ189AI
	Jo4Wgw==
X-Received: by 2002:a17:902:f70b:b0:2ba:5e44:ce8f with SMTP id d9443c01a7336-2baf0bd5421mr116260325ad.0.1778442720061;
        Sun, 10 May 2026 12:52:00 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e358b2sm77065095ad.54.2026.05.10.12.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 12:51:59 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 08/11] iio: adc: hx711: split variable assignments in hx711_read and hx711_reset
Date: Mon, 11 May 2026 01:19:30 +0530
Message-ID: <20260510194947.31997-9-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260510194947.31997-1-piyushpatle228@gmail.com>
References: <20260510194947.31997-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate the initial value assignments from the declarations in
hx711_read() and hx711_reset().

This is a small preparatory cleanup before the later loop-iterator and
variant-specific changes adjust the local variable layout in these
functions.

No functional change.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/iio/adc/hx711.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index 24be690c371b..8da39d2801cd 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -159,9 +159,10 @@ static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 {
 	int i, ret;
 	int value = 0;
-	int val = gpiod_get_value(hx711_data->gpiod_dout);
+	int val;
 
 	/* we double check if it's really down */
+	val = gpiod_get_value(hx711_data->gpiod_dout);
 	if (val)
 		return -EIO;
 
@@ -204,7 +205,8 @@ static int hx711_wait_for_ready(struct hx711_data *hx711_data)
 
 static int hx711_reset(struct hx711_data *hx711_data)
 {
-	int val = hx711_wait_for_ready(hx711_data);
+	int val;
+	val = hx711_wait_for_ready(hx711_data);
 
 	if (val) {
 		/*
-- 
2.43.0

