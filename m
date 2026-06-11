Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7A13E7BC2
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 15:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192471; cv=none; b=QW3NsiCKqFbaNC+77KnofiOeBBXT6c0q4C0GuX/GWt5jenueiPd4qJMDkBs49m+gyIq7ZZRIFjgJxCSKD+zmWOJwYUZNc0QaZfTttIT+iLvBG1ovrEYOg+F/Pm1YQ4nLw8vIOrUiMNOWYJUBroc+AixemXiVgv+dWwjogB1rThA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192471; c=relaxed/simple;
	bh=h6MWLCfUd85/1dSrfNYdTXKwJSaieCPmgnUikAdWiDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ucnn5tC0xIimMmh+B2+OagMAvR92KWibj5aCUNx48gBpN6ZAyXg1fk5qysXjULVfvmLWEmbR0rJHBpEDCvEfJxIMMbeLqn4njevRSZzxMsEm07V+lLjfnB80yeHUAV6UhQArygliEMivfysc3S7ddc/eHoDJV94BbaHA02RidEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6MPRow3; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6MPRow3"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3965d76090bso711fa.2
        for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 08:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781192468; x=1781797268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=APKUOIAbDv6xgvZxBxqpunnnVlUhklDqkLiJkSm1Xgo=;
        b=M6MPRow3UzQLWSYpG65PHzm9p2vZhwDufZ+URknbcmtJjusH6wlZj3Fgr1YcWaQSa+
         Xx1jY4l3I8RYmrJbFEtZljyWNcPUO2P7pgFNa0iOJpwpNsdWEYAGwRABuuPzFdzw7OML
         OBvXgamPO+71yIFYPPHZLhIRpG4NEt6CD2hK6fW7b1TxI+a3zJAoN2Lnosexm9KMQCZe
         ZFoCyhh0CpHpyRN0r7OmLPI10WRfVInLtJ5HHbDDbArKPP1mfL9+XfQF/ttZnagnaoEk
         I+bE/INOc59Td34hVYGUETEXUD5Oyrpqw0N5Ls4dBwsQcFL/9/11VJ6IvMyYNTwbc76W
         zYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781192468; x=1781797268;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=APKUOIAbDv6xgvZxBxqpunnnVlUhklDqkLiJkSm1Xgo=;
        b=HNfoIJFgSOTm4t6/0fMofUKoRh86PwzQl/1lcnSsCOxWLJJ+wiSryR7GWF4PdieaS7
         JiMHKOMFryF1woWlQhsXv4VKSnowJzKfQU8O9nRJlctpOmUXVYdcl+52Cf/AR+fy4+Yg
         hbaYiY2S0gwrBo61tzcgzOQ8ld3agmUabgKdr20UWeDmVGgSATzFihGnbZ1a5sA/7v/6
         FTs7XHjtlxLB/QVGB3NYe0frvnNj0aL84eS0p8RGCB4/g2aWHit/dzlmlwQKZD7Tts9n
         v/iSS0sXwkqMbAZvFkKZP9jdKaLjlX7EuuqTBS4c38g0ND4dywoGUI/mnl+e+eRBdByT
         rtgA==
X-Gm-Message-State: AOJu0YwSWtm25x682iI+vsP/AcyTMTaYHULmnOsBLoua9B9sSLR5waUt
	8tjJPajB2ecZeSGJsPsAoY5bkpQ1sFp6a+7Q+v3eyd+LGAN3pFWnwaVHt5mKhZH8Cmk=
X-Gm-Gg: Acq92OH0+L+WCWxjnwnjcJOzzMzcHAG+udLZ0+Spcyb3+FEV0sNAmtSKx6ekQNUHLbp
	EopL8x5Llm/QnCKlJgAJxYQo1ypkpOnylOVdu7ezruJ9/o5bhW3NtDpMEfvioJgmBf5lPoltVdS
	qOddHay7mQZsdIY6zPJ6WMnNJjTUoPFBXU6crVkuqs4//PzpCU14g7ZOufcCyOwnKrwdw8r/7Vo
	8xzsugZLpew6b7bEmhiWQXhrxTKtNNeUcjyAJdZSoOXbOEc7e4pjDkp/NhH8f/CFJxjcEt7EPrW
	stAFpIdJnaVwnmQ35jAWNYBsogsPmM2V7uYcgHzwj8PMFaOSPz7Ocjhl5t+c82Yl2h54K2dfwa9
	zvKC6c0PHB2T0qbrqm9loq+1TcwRXs4xNhLjsU6AeVJeEvRtDwTp84rb6QZFPuEWgt7mIz82ltg
	VPGehEW59Knv5nW0EF+/7WRH0AWpJFEhzbxoLXEsIitIdwmFsOHm1mvxwTEr75H3Ae+7cq2aI3Y
	UHwug==
X-Received: by 2002:a2e:bc84:0:b0:396:66c8:1070 with SMTP id 38308e7fff4ca-3991a19e3f6mr10922481fa.21.1781192468187;
        Thu, 11 Jun 2026 08:41:08 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3991ac81488sm5994641fa.1.2026.06.11.08.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 08:41:07 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v2 1/3] misc: lis3lv02d: set default click detection thresholds
Date: Thu, 11 Jun 2026 18:41:03 +0300
Message-ID: <20260611154105.3727-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260611154105.3727-1-shofiqtest@gmail.com>
References: <20260611154105.3727-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several upstream board DTS files use st,click-thresh-x/y/z (the name
documented in the old lis302.txt binding), but the driver reads
st,click-threshold-x/y/z. As a result those boards have had click
detection silently broken since the DT properties were added.

Set a default threshold of 10 for all three axes immediately after
the platform data allocation so those boards get working click
detection without requiring a DT change.

The DT reads for st,click-threshold-x/y/z are unchanged so boards
using the correct name can still override the default.

Fixes: 6a7740c7f5b2 ("lis3lv02d: add device-tree support")

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/misc/lis3lv02d/lis3lv02d.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d.c b/drivers/misc/lis3lv02d/lis3lv02d.c
index 21e8ad0a7444..6a028c1bf866 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d.c
@@ -956,6 +956,14 @@ int lis3lv02d_init_dt(struct lis3lv02d *lis3)
 	if (!pdata)
 		return -ENOMEM;
 
+	/* Set sensible click threshold defaults. Several upstream board DTS
+	 * files use the misspelled property "st,click-thresh-*" which the
+	 * driver never reads, leaving these at zero. Default to 10 so those
+	 * boards get working click detection without a DT change. */
+	pdata->click_thresh_x = 10;
+	pdata->click_thresh_y = 10;
+	pdata->click_thresh_z = 10;
+
 	if (of_property_read_bool(np, "st,click-single-x"))
 		pdata->click_flags |= LIS3_CLICK_SINGLE_X;
 	if (of_property_read_bool(np, "st,click-double-x"))
-- 
2.51.1

