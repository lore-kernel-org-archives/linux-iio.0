Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CE7314D18
	for <linux-iio@vger.kernel.org>; Thu,  6 Aug 2026 02:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785983970; cv=none; b=sZr3DYfrH9YxqlNaqE943WQgMod9fkt1TWBNogFJ3DWIA7Tv7CQ34yo7jLwnIxCGW6v2eTxFaWeVZXC0nv7RhV9pq8upxS8pii4noIo/q7bCpBM48RDEOLrwz/l1MjJN04eiu1PD6BPPFRFWA5uT7LqbKYh3ZlP/0diXZNaaPic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785983970; c=relaxed/simple;
	bh=xHHaH3i8lFBA3SCAkN81jlTaC5OsQciB0vsfjFmX/4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KsT0nYS4hEMdualWBlm9LBhKKKyzHsJmxy518CWY09wZvm5f5i/XCx3ClKvdXpMB369sifzhy1LQDAksNnd6L2Iu8UCWLIo9KLzKwr142SnltG5VmGIOMTGs/jL/uyZn2qpV+NKXp+zTtwsE1z9U8b2OmhuRaXiFbTKh6//ljnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORfuh1if; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORfuh1if"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so1526565a12.3
        for <linux-iio@vger.kernel.org>; Wed, 05 Aug 2026 19:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785983968; x=1786588768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RE5+yp+EO4sGvggz/JN1MlhfuJ4Nn1zTwuioIoIeNsU=;
        b=ORfuh1ifc6n5a2c3O/NB4r0T60bSIm6ql4i+cE49DET7zLZOUG+OKXZgAW8sw+oTIB
         B7cWOD4FbmapdO7/81oKDiLFZmMOER4GLDMPuBN2thZ8R1ztdtLgvhbw7aQ7ZF23U2UT
         MRp2CpxL9oURn41bmN1Vx4cpN2q81H3dhbE7P14hljfcV5vyA7yCkDPughdaprOYGCfh
         yjbaoGtKnkypXLBhc/KtWL4cvue2x3XG+7DyUg+jBFt6MdS8fqb1GjFZoKEvLAwFW3Kv
         MsbHTfX32+wCqotxMVUjqXB/leIYKtoK0F0Pdjb4Xvr01Dk4N0VSNuw8aaLugh8XI458
         eLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785983968; x=1786588768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RE5+yp+EO4sGvggz/JN1MlhfuJ4Nn1zTwuioIoIeNsU=;
        b=mUyGDMfgfvUiyaassDpXl74DWYXwspo4wul8ZMqtUCe+Yswt1hMEOX6sInrrvEpuYf
         mRbiB3q3aauIku84xIlVgsmyUE4QA32KQoOOvZDGxHVZtFqM8nofOnBF5+kirgojdsK3
         hynR1ErECWsr8BYR3Sk3seZAwmhxXreLZJhxHRwO5zajeNUwKyWOJTl8dmc3jvN9bnth
         8d6MD50u0oX+GMtLOkuWYfpit43pytS3lEcZF1EXE/UPEiVHptncsNwO2F29O9HQeLeF
         K2NxM6QaVuiKrsizHJ4OyQaljQGwTtk+/bE+BOJIj3EgwfqlNsv69EbhdlJEZYaDdBwG
         ksBA==
X-Forwarded-Encrypted: i=1; AHgh+Rp55U8rX7tXtMGEV8CaX6Fc8W3lP0/OYxdMVzlUiCd0Kupz1PKVNlsTPfNo7Lm8dLoc4JTjY1NW7y8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk0JRuI5xWU9HVlTNefK9xfCeIIY3ZeGYpjjJRYy7j2ezxJYEl
	ayl0y5XUHQzSuvroQ0/t/v4TB8cnaHhGJkZpdl6JPHikhi0RuJCESFbB
X-Gm-Gg: AR+sD113HQ4kUYWwP+bm15xy48ZO4rd+22VlFcBTNS8cxEkKclyrrSajc4oDVbmLAE7
	YxW4tlVxuf5a7yMOsEYckh8fdriSeRt9dVBSaKBX0Z8b1THiDTcgxpXBv1PozBzKop10iOCFhix
	t221Hum5N1vS5rULq16YICeYm8hI/5cLsHDmYpgdMfm6kkv+D9eZolJq8rqpi2vsatw3Wb5d+SB
	jYP1+dOTe4qWrMXlfZ5e3lOkbpvDYMpIVLWkOqfXjK671lrSOMWm+zVDQbxYGF8wQMv8U8h95BS
	Sb4nxxGb2hZcex+/qrPrKsK3bsmfw6L5vVzpJPyCrzusRuQeAwCw7J4r8K4MsHPrLZT1nkeNHMX
	dSif/9SFMz6MGnL65F16ETHk/bzUWbypDmLSxSLITxxgmzj84JnJLvyfjfCU0AMUh49ICno8rFv
	ojtpwwZ96bEKfmdxYwPGfnZnYCPs5pyJ6Qp/ywJhkKnTvBQpEkW+M2SSJRP3E=
X-Received: by 2002:a05:6a20:4391:b0:3c0:b4f8:bbfb with SMTP id adf61e73a8af0-3cb85e5cb78mr14282873637.22.1785983968204;
        Wed, 05 Aug 2026 19:39:28 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:3194:1e48:e141:80ab])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315867d4929sm22404383eec.30.2026.08.05.19.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 19:39:27 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v6 0/3] iio: adc: bcm_iproc_adc: Simplify probe error handling
Date: Thu,  6 Aug 2026 08:08:59 +0530
Message-ID: <20260806023902.8608-1-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

This series simplifies probe error handling in bcm_iproc_adc.

Patch 1 removes redundant probe error messages where lower-level
helpers already report failures.

Patch 2 introduces a local device pointer to reduce repetition and
prepare for subsequent error handling cleanup.

Patch 3 converts immediate-return probe error paths to dev_err_probe()
while leaving cleanup paths unchanged.

Changes in v6:
- Restore the original formatting in Patch 2 to avoid unnecessary code
  churn, as suggested by Jonathan.
- Reduce indentation in selected dev_err_probe() calls in Patch 3
  following review comments from Markus.

---

Mohammad Shahid (3):
  iio: adc: bcm_iproc_adc: Remove redundant probe error messages
  iio: adc: bcm_iproc_adc: Introduce local device pointer
  iio: adc: bcm_iproc_adc: Convert probe error handling to
    dev_err_probe()

 drivers/iio/adc/bcm_iproc_adc.c | 46 ++++++++++++---------------------
 1 file changed, 16 insertions(+), 30 deletions(-)

-- 
2.43.0

