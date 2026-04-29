Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A1F330D22
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 05:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777441589; cv=none; b=rcPDROG+pUuJZe6YtzehZfg8K4nuAPDpCf1oFguvxR1CjOxl4y6MIIYXWNj9TXhPLoZ2Va+LVFOLmSXVMmbAte42IRsBhPp0l6BJm0h3+xxq96FVdopQ4bzkh60Um6N9zZrAl2r57Z50UO7KZ+YIZrLnurNrLkQfVCrZkHzMj/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777441589; c=relaxed/simple;
	bh=8jcauZUpKBKt1Y2SRePdT2j5+qzSTeLWSFY+PfQPmXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SQ4PPUwbZt2cYG/Cz6+O6Xe0NdD23KzGMfnEzLz45pprlNLway8dKgweqlb2eCyaVwzKm5pJz+ZTQxBUZ1a5d5sNgRMDgB6PLj7GUfc2Xe7pDMEOUkENwoi2Q4FmF6//PGIY6muoM41s1ksBmvy3SvzxPrX0YednkZuMinuigoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g17JNizT; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g17JNizT"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b4583f0a1aso76980465ad.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 22:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777441588; x=1778046388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z9GS+fDU8N+RMGg3TIx8An5pT4tHPP5/YiqsDlbIWGo=;
        b=g17JNizTchzVAnSbb3u+gEZiiVPDHhOKO4BnQ3ATthBgEF5hjMOiMOiF73SwwwXb62
         djZpvj04prQbTLANsVCv/lyFUCTZ64TrCJ1IX5k2evLhJif5EXs1IIC+DAp8xe4DYvGd
         Rq3lN4MC9GEneoFHQGtThEsdkSSz15MJK3MPBAJkA4h7Zo3jhar6LUGj9KppqbgmihLn
         n81cDBYLUIz1U1qvSgPja7hmnK38c40eeBkfKL41S5EdxXxGxSXYej9Q5H6SCrp77DLn
         kdpJoMhK+TzQ3LAKtOwvCY4VGyVG1RUgkHMM6FuUN1jx1btmfEK3kYkLFyjorbngtRqf
         Tifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777441588; x=1778046388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z9GS+fDU8N+RMGg3TIx8An5pT4tHPP5/YiqsDlbIWGo=;
        b=VrB6iSeL1I+jY+W6Kfjqj1etwuCzpLurT6tEAvi4jgwwv1/aCfpsXXIAM5fbxz/5dw
         ItSc/pcwxpIP4suB3GKKHMQBIDSh69Wi6+7nubOXKAW3qPHjKwakrzDLuOvvLooW+X88
         HCg3l31MaYqK/C+Ws79AlehyALv/YFhREBXCq8dVRyZPGehrfo39kNrFU8smCQ3a1STF
         1N/Z/s6sdK0ZIQ24jNpziN6U78HQk+C+P33vmwaO3aY1I36/PNE/ikR3lUnSCkh3Frht
         2PhIo7qraPb9AKxax21UHwmQHrNVJKbsAq6CvrGWV7oT1ayCRV9p7O1MdEOV8MKpOVSA
         UyXw==
X-Forwarded-Encrypted: i=1; AFNElJ/0RiCyBEIPv6HtANe2/ZgB0PeyNBQ7JSEX3/ME7SNv5BV1lW4alKYs1Cjqo6YFZ4yA4I/R3P0JcXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq2kNpQBpu9NjwloIOFy4AtLqOWunDUGrz/dlJGgwPyxPSgidp
	ncBquGuMIdZoLJwKWLVBP/f4/1WLencfnlRPSlpgHQxw3IXQLtGhf8jN
X-Gm-Gg: AeBDiev2+wN739hIHXhcUOjlxdq00smw3wnhGgLHqxjYw1z75jQc6Ucoo/kw0Q94rLZ
	dSUHUqds/640rsuU15HaYv8wBjy6g9kEtdYW7EvCwSuFzWPvrgAfxftWtBKnELmsbkgoR1ZsrpD
	BAHFJO0Y2PnLBLpmIeVGA7+b6kMqevJ2J4FenQHvSzsBu9XjBl5N9LhzEbGbHTainVl+k556AKi
	UGifyzZ+snQc+s1ohFRV8H8NuTqGVOSspFnVE1hE3E9PMf1scNKS/y9p+NZPz39ssZvJkxbnMJx
	aJSse5ysnwVCLfAbVkyfeyWet2KdxQGM01C1J/njJFAD6InHrTAqmiWQ9IQxyuEEx4M/9f5+7Ll
	ulUWpJ0DP1sue4j6aeI+G4E+9yQihw4PTOTsGxrh8jZuJ/glGpu4A7i2iCgz6rNr2GgcxaefqeS
	p3twxN1fR8MRpNT/0tBEJGztnW7lrNBtZfU6OfOdUF0HfNv081Qs4kpNOYuQzI1MsXEyRhKNNfZ
	YJPbgbfkYn8bL08/yzktpWTtRVDcu7G9azYK8Yiahh8XdMRvQ==
X-Received: by 2002:a17:903:985:b0:2b4:5986:cd80 with SMTP id d9443c01a7336-2b97c47b524mr63574105ad.26.1777441587586;
        Tue, 28 Apr 2026 22:46:27 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:5fb:20b2:c2f6:85bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98879656dsm9346365ad.25.2026.04.28.22.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 22:46:27 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/11] iio: adc: hx711: localize loop iterators in hx711_read
Date: Wed, 29 Apr 2026 11:15:41 +0530
Message-ID: <20260429054544.123862-9-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429054544.123862-1-piyushpatle228@gmail.com>
References: <20260429054544.123862-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tighten the scope of the loop variables in hx711_read() now that the
trailing-pulse refactor is in place.

No functional change.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
Changes in v5:
- New patch split out of the trailing-pulse refactor during review.
- Use unsigned scoped loop iterators in hx711_read().
Changes in v4:
- The scoped loop-variable cleanup was previously bundled with the
  trailing-pulse patch.
---
drivers/iio/adc/hx711.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
index d85ff2f4a3dd..15b9f78b6a25 100644
--- a/drivers/iio/adc/hx711.c
+++ b/drivers/iio/adc/hx711.c
@@ -157,7 +157,7 @@ static int hx711_cycle(struct hx711_data *hx711_data)
 
 static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 {
-	int i, ret;
+	int ret;
 	int value = 0;
 	int val = gpiod_get_value(hx711_data->gpiod_dout);
 
@@ -165,7 +165,7 @@ static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 	if (val)
 		return -EIO;
 
-	for (i = 0; i < 24; i++) {
+	for (unsigned int i = 0; i < 24; i++) {
 		value <<= 1;
 		ret = hx711_cycle(hx711_data);
 		if (ret)
@@ -174,7 +174,7 @@ static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
 
 	value ^= 0x800000;
 
-	for (i = 0; i < trailing_pulses; i++)
+	for (unsigned int i = 0; i < trailing_pulses; i++)
 		hx711_cycle(hx711_data);
 
 	return value;
-- 
2.43.0
