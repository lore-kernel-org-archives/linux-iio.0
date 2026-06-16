Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69A5329E55
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616334; cv=none; b=S+jV4MisK6rM7rO63q8FiZT9QF4dcA8Vqls2ZJZe4sym6B/4TRzv9k5c8RrTGaEUZ9ooD7PnIbsUpPoCRJ2+T7ketI6AoDK+cufOe5mvwuxf15cjxlZo9byosSUTZsEMu60v7pPo+GowT4mTkhOxNsb4RGoAEq39ylCMLzqlPwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616334; c=relaxed/simple;
	bh=/DhHLMxtax0q61L7+CS/qIAzA9d13fjEx2Ew5GW+K4g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j8Cqdp/B3M5UoOx5VkxOxg4SALB31/2iqie67bAxzJk4UuTuhYt9NvoOgC5IxEaO8y++jeoitQZIDEo/O1OAGxhTBhMaGbeZevAzMW2DSA5e73CGHI/100Aljazw24x+iOwap9sx3k1pX4CJRNd1NCBhyyqe1EKezs/W3gg7BSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNqs00+n; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNqs00+n"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8423f1d8902so2121062b3a.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 06:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781616332; x=1782221132; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TpRajPh6PjOiqYjGPArNVmTipWmAREJJTLFKHMT2x0g=;
        b=kNqs00+nXc7u4etMTuLiSu8UgmUz7klvaHAVEz9i54WViThAtAQnuCKWRDsK82fV1E
         uiGa8BNWKEDI8FlVnAl4FwNmrdJnkGHkhDKKnk14roo6niZ1esqhEdg1AdEliutOiGMI
         x6nNVdElgc1J19W5kKPCXrdlnw2/1ViTsu4ALv5ljIMbeEc6JvYC4+7dHw4kDRN5BroM
         yckvCUOL2F+0H5kTlvSmlMKiyqWPv4GZVUnsA11E6GBu6kUMviCax7MV7Qdj4V53t/W7
         VHlLyWIAppQOvxwSu/f273Qe5KG6Jvr0bVdllVbT64LcL/j/wYOKE0/IPSE1+BdYsWmV
         6dFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616332; x=1782221132;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TpRajPh6PjOiqYjGPArNVmTipWmAREJJTLFKHMT2x0g=;
        b=CtzQMWW36faKbaQ9D40xQ8XvBouJ6Bx64UlssppbcDjruP0ONoPD03ytwkKSd4PFWr
         vm9xe/pEWSsIgMhFhcRe0CXzksQjvK0EtLPmOEIEPQerrfP+SwH9mCRy9obEamVwI9M5
         Owl8WZAsYllsMPP7szR5QZgtWgfcRyrllzn5uogu65tOzPuU+YTbKbLg4Zcb6MegL3SS
         MPEcmpoYHbQPE0TCqnoI2Ki89c414RlR1E3cZvjAhJWfD/d7v97EScdhp3sXS9rSj8hC
         NwbS3z7DLyiMx6oyp9x3Su/jst/u8185aaN4m0mbfK+oForUiq8CHDV1F0bqGl1AxAKO
         dTWA==
X-Forwarded-Encrypted: i=1; AFNElJ8jAcKTAzWFiom5pM6PUWtypiEH1AIJvqysPKdaGtudvKY4gd0KFHXyR9KyJrXibdI/M7FNAQ4IupY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaV70twJNnVO0uyUIA1RI39E7jWb9zJWmWSy81q14BeVCRdgJq
	bKR3eu7t6PvbUeNx9KMC58m9xYCuflQ0RWKMiyLIPZMZ4F2cg8Hqfqpk
X-Gm-Gg: Acq92OH1ll62HKLaiO/GkcVsYoIUsKkcx0QFHcZkM76STSiJPi8Yb2XJIllt7U9w91K
	XPu9iJNI16We68rw18eIc/zXNm7m6JeYLK5dEEMPahvdWu+DvgYhJZHzr0wr/ovMRe/5Cu0OvxN
	uUeeZQwtNbtsw36gY8MxXaRgNYGmrXLY+NHM79AlJLIqY4TKB8+gJcSfBZ3cFaNrtJYJERmDmZv
	D4LTATUmIxO4Y/cf+E5E3pCyozCDykMMaBW1/w0rfcNx4tyfr1Dpkj/PvRiItH5NKWUYReySFBh
	FkLIjcxqfbIorppAQGrPSoPsGhfbzhCYWg/BM3RXRw04pbqNBPWwcLCxFOgZ6wJSgXsVwOpk3XQ
	M/0svZc7nbxl+iC1T1ZY9mfukxiYTCCH5bEH82qiWoSPDTn0n7LUa5KElrcbZmD1OknhCZ5lhf6
	UKelV7yIXYkxJpZCd1Q+h3cp0R18xWOHL9uF8S+T2J0SiFCLlR
X-Received: by 2002:a05:6a00:a903:b0:842:5712:c2c2 with SMTP id d2e1a72fcca58-844e1aa26d5mr17296039b3a.41.1781616331963;
        Tue, 16 Jun 2026 06:25:31 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b046911sm13105079b3a.53.2026.06.16.06.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:25:31 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Subject: [PATCH 0/3] HID: iio: callback API signature match for usage_id
Date: Tue, 16 Jun 2026 18:55:19 +0530
Message-Id: <20260616-16-jun-hid-iio-u32-api-type-v1-0-952c74195f46@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL9OMWoC/yXMQQqDMBBG4avIrDuQREilVyldaBzr7yKGxIgi3
 r2pwtt8m3dQkghJ9KoOirIiYfYF+lGRG1v/FUZfTEYZq6y2XJqy5xE9AzPn2nAbwMsehHWjpBl
 UZ1z9pHIIUQZs1/39uZ1yN4lb/ks6zx8FkVEhfwAAAA==
X-Change-ID: 20260616-16-jun-hid-iio-u32-api-type-180e8f0b2c37
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

Hi all,

Most of HID IIO driver has correct 'u32' type of usage_id with
https://lore.kernel.org/all/20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com/
series which is applied on iio/testing branch.

On top of the same, this series updates remaining HID IIO drivers
to use 'u32' for the usage_id parameter.

Pending list of HID IIO drivers are extracted with command line:
find drivers/iio/ -type f -name "*hid*" | xargs grep -A 5 static | \
    grep -E -A 5 "_proc_event\(|_capture_sample\(|_parse_report\(" --color | \
    grep usage_id

This matches expected callback API type as HID usage IDs are
defined as 32-bit values.

No functional changes are introduced.

Testing:
  - Compiled with W=1 for each patch in the series

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Sanjay Chitroda (3):
      iio: hid-sensor-temperature: use u32 instead of unsigned int
      iio: hid-sensor-humidity: use u32 instead of unsigned int
      iio: hid-sensor-custom-intel-hinge: use u32 instead of unsigned int

 drivers/iio/humidity/hid-sensor-humidity.c           | 6 +++---
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 6 +++---
 drivers/iio/temperature/hid-sensor-temperature.c     | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)
---
base-commit: a50909aa46dec46de3c73235fc15a7d6f763d996
change-id: 20260616-16-jun-hid-iio-u32-api-type-180e8f0b2c37

Best regards,
--  
Sanjay Chitroda <sanjayembeddedse@gmail.com>

