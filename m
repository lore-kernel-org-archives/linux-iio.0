Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8BE3CE481
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776087755; cv=none; b=WqP4bKBj4FGndWuQFXYo9ldcu3giLekPFeZMM/tMHHrBcfYRei/zY9F8tGuPjl8qfwt1u0HoY40HpbNSRpfw+DnO2cLLU/ge2epEqJh7TPU5yfIVyxXM4H18Bu8yYd0peusHGrF6+GPn9eqGnfCVfG/O1qWc7HV0fMnvqABpbUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776087755; c=relaxed/simple;
	bh=XOVtpjNiph+fEtee91Q6d9gDd4/N4NC5lf9pRhWA4vc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bOErlvZfG6Om44i55lUDBFV7lpJHOdaimWXAXSdEnUwjycdszK8kQLSQnwlU2+4SfWBaaX1idDfhlhp5JJkq4Gbsxyb4YZ53IxImIwdekF3QL6dUXvhtLXSXWBNlOjfxtSEeqs55pVcvleh5IS2FE45lqGpntmYevoBGngEopqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggkxl/m6; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggkxl/m6"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-35da01fc0baso2836381a91.2
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 06:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776087752; x=1776692552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fYWMlLL5TYaz75dyBMOZrNgr6uPtYLT84dsBhSwY/A=;
        b=ggkxl/m6I0TClhT9qUS6tHPjp1oi/+Pkcywz8w4njSo42xT8h4tj0Sicfwla6eVEd5
         Y/ZRRFcw+lRpJbGq8AIQy2gACHW2qmR+jeFgCWjr8f4nVz0CKR8h/BKHEKznf9LDGHgx
         MdYObYWfZtHvUnmUzbk4+b6pUe0tqb5H5eonoFsU0x9TeqIPRqia1wzlQkgHvKhhutyh
         7hONi/SXdg3riu1ZMr/u9OgXKIGqzZzRzG+/QwXLmovwN7pdoPJtmkORcPUOhjkExf6s
         +UNVIDhvFnZ1swz/cfswH35YogAOAHy5oGVclDyk539w+P/zkbVL4wvN/oGq8sL3eXKL
         FQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776087752; x=1776692552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4fYWMlLL5TYaz75dyBMOZrNgr6uPtYLT84dsBhSwY/A=;
        b=MHY1pFbXhV2867lFJNppMKKieQnMsWtwgX5T4j0rW5+6L9wd960yJ+7DdkBsEOO8YX
         T7mlph9gB9R57ITxLu8CMZxl6faErbJEFzLEU+aO+Xn36ImWxtcQH7NrzCyYgzhO8UoN
         inztDkOS3pKwDkqiYmUUcpgV9gTacwViFFLzzWpz+ffw43KDOekr9QZX9Saw6buM2jY/
         jmnh7HrwI0IsLiehAhrQ3u896uajnzJsmWNyi8VzWrtkwM/d6qF7mlJvii4TzJWS7n4u
         D3duEF6Ox4wiZpmG9lCD9OfS31ihf5U4RIaYzcEsW3svtkx86XKJe7wcodjFx+Vem9C9
         V7zw==
X-Forwarded-Encrypted: i=1; AFNElJ81N4PQpREFaHU0gfYeVIEk1WMcCLcBvK2hcoNb7wrNpkA1a09aAz5k0w/t3ege5XxJPWheYF1ur0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjsOHK5tzz7pf3/RuQjFWp/Va5VMRdDQalLH2nfS8eK5Xi/0VO
	14qLVDv3fiKFJaea/V10YgbO0fHQjtEqmlwCKnP9bbCJLZ11c5+cLgRW
X-Gm-Gg: AeBDievwDuQ8UJD79YUIwXWg81nV7p11m1s3yIvWTc5LQ/jcwJ5M0dC0E+oXOXVDNVi
	2zQYyo8R8vMbr3yxb5A9VbHVIHrzZ/1hjMs04BQj3NDv7qlBjr85oEH3Khh/CX2YmTVDl3oCBf/
	iMYbMcrIF8cRlwBHATUN146R34a85FNUqBaWrZlg1xUK6RonZ861iG1oHS3HgVlVL2RzVmZjLEQ
	bb/9arWyX8buhT9PC5sgbKniReHmOJj4zDDZX+0PzYhTn/bhVwcaOcXkLSZ0oLRzN1j5U8yiMhk
	cLAqdTAk+8yoWBtQATKUssMqZE4LSNnBX/ygJbXZDm+UyYdEfVTUeFlcoWwMYsjVyzwHIHZHEcB
	ITyk/ak3i+5FYTA540Yd9b76wSAvsXpO4/MKjutALo+9RjUf7F0B1ihZ6cgpM5dqTHKcjRHElSF
	1fj5cdWv2bYmrv5mzNoCYNMvgwra35/G2mJmXQ1uZRTeJwrhsd
X-Received: by 2002:a17:90b:1a90:b0:35f:b5df:456 with SMTP id 98e67ed59e1d1-35fb5df0e12mr4285783a91.18.1776087751930;
        Mon, 13 Apr 2026 06:42:31 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fb0dbd953sm1832186a91.12.2026.04.13.06.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 06:42:31 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iio: adc: ad7173: cleanup codestyle error
Date: Mon, 13 Apr 2026 19:12:21 +0530
Message-Id: <20260413134223.2331911-2-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260413134223.2331911-1-sanjayembedded@gmail.com>
References: <20260413134223.2331911-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Reported by checkpatch:
FILE: drivers/iio/adc/ad7173.c

ERROR: open brace '{' function definitions go on the next line

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/adc/ad7173.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index d36612352b44..f76a9e08f39e 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -1763,7 +1763,8 @@ static int ad7173_validate_openwire_ain_inputs(struct ad7173_state *st,
 static unsigned int ad7173_calc_openwire_thrsh_raw(struct ad7173_state *st,
 						   struct iio_chan_spec *chan,
 						   struct ad7173_channel *chan_st_priv,
-						   unsigned int thrsh_mv) {
+						   unsigned int thrsh_mv)
+{
 	unsigned int thrsh_raw;
 
 	thrsh_raw =
-- 
2.34.1

