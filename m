Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E207C348866
	for <linux-iio@vger.kernel.org>; Sun,  8 Mar 2026 18:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772994549; cv=none; b=H4YWw8XvvBoe9BkaA9gb8KrBa7XXzX7eUNiAU5q1wG3AZChoe+if3FTKLnNn/Jw21cauyMW0nFpL6HjNsjgWUZHjnP/Xy4VxXZgp89ovPzWFR3GVr2ZQkeXiJ3/Iay5uNIuzWyiIXo1qTMn3Ei96mLWgLSvmfZiDJIsJezKHSPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772994549; c=relaxed/simple;
	bh=ijqO0RH/c8WpzUF3ch/7TZ/yblp4KMzkFtx1ZZAn264=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MVKNtmHIozIVJZKBtbBgsosPBBHXu2L6ZylrtkN3XMXpFgFP3TGro0ml04lUPhG5vRirPZKb7pzIvCWJHwXhuG0rbbj6e07xpPg4HfmRxioRIOgJZCgDm74lv2SNgo7/NBayCfbSMpe5QVqxhdJU+fm7ateeDMWG0rr+akGG3nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hvCdw3GA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvCdw3GA"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ae3a2f6007so59657245ad.2
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2026 11:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772994548; x=1773599348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H4m2EMUIvaZ3HIXTiDn2GW7MNo5qWlfcC51az5xANqQ=;
        b=hvCdw3GAJKTZmRAPqQdGgnZFlYB0oVQNcuXdHPqlw86RdwgHIvgs+XWIMq5feDbcvM
         BzECDL+p7r2Goi2VXvbEfneE/F1vbmVg/aPOPU+lvPs0v5bmbMhiGGMJQ7ihcAZiBDQ4
         mlcJtwixtOWCTTxFIfEFJ+YG+UBodyQvA2PmviwlNkAInvWPtr5dzKtjhpl+ipxMy6/k
         yrKDxJAmz/F2HIVsZd9v1BRbV5tL92pQFr5SOfHGgDmNdv23wsrQhS1KCoN2j5mnjml5
         Y4RIFpSrbYqbKjHLKOxtA+P49jL8/iM7CeIa8esUV1oQF/P8OeeEljnZbUM1obBK+IbS
         gPRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772994548; x=1773599348;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4m2EMUIvaZ3HIXTiDn2GW7MNo5qWlfcC51az5xANqQ=;
        b=F5fQ7KT5JjKxFAyl4TQWKbA5eIp39Bq2Z9W+s3nIDZqRZdsea7aDK7lbVLlxeT6AxT
         siSkvGMbnImLl3agi3RNVjarQSpM+Iw4qpQTdYHetquHblRySFsM6mLryLX3ahc0OmF/
         2a40KiSGOdT3N8fU5XwC5tC9Hs+h/oGX/gGDJPuW8aHRxignX/hjSaJ4EH0wZMYouAFC
         4B3RXDbBOUIMBOaUPMlt2yggEaqJjZXYum/ZebTBjNH1VFlTIQMIvfcmpTUuGfWJ/nNT
         nqP2nB7kyLALdwsTDinGWct6twGPbYR9vR/V2eQsWqolG/cKD3/SJOAwukCtkbZqf1SL
         qC5A==
X-Forwarded-Encrypted: i=1; AJvYcCXjhq1t51o2A5BDboN2r4Yw/ngMEXdYr0g12HScSBwx9vk0dHceCWjZZPck2xXKqkcMbS0BJBdyXGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuW57YWrqIAXoyfAdNeJnOk8A6B/jo71fNYkF/8cXG3485WSVz
	erVNd2uf/Ap5wGywz65RDIBwqyAmHUR+OtmsLxLGTKExSWByu8IySUP/
X-Gm-Gg: ATEYQzxr/TZwv1i1WblCHZZVcuzii0C8MFJxqiIXiaW1bDIdRaRys4r38IN8caztSwU
	SXdaqRq9vintb+oQ5XSMi2ii9KEQBAKVAFvhHhQlrglZVMTcMifCgqoCTEKH5PJa+Llu0laUd0y
	0F7YgdC36+FRnMlggnqhZ/14XhTOPfLZLiMU2ISUHCHaak4DY7Ji98vQVIK2uF5GIep0Xwxl9Eu
	u7apO9X6Knoey8etZbfSqdSqinqkpne3iXwWY6jdCkSpgbK0JJcx/XAyGgHXi69iGzBAvPD0dV3
	Do7MxywZJDtzeMLL45/MTEoDf8A0NtfON939Wsd8S+q8NeSiN++Bw+Pais+KWAWOY4K0jykSBAj
	v5CHzuiVLd43nE/2Jl6b6JrOtx9JQeVE9Tn03Ds7JrkqyL0JCLKeQiPFd+pb6bfcxtrx7R167nx
	zfVZnQrzESnI8+Me98ZTsV4jRoBoPuGzEMYTNWzI0o
X-Received: by 2002:a17:903:3bc7:b0:2a7:757b:35a1 with SMTP id d9443c01a7336-2ae825046d5mr87272245ad.38.1772994548171;
        Sun, 08 Mar 2026 11:29:08 -0700 (PDT)
Received: from debian.ari ([152.58.179.53])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f783dbsm89006965ad.42.2026.03.08.11.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 11:29:07 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v4 0/4] iio: adc: ad799x: modernize resource management
Date: Sun,  8 Mar 2026 23:58:07 +0530
Message-Id: <20260308182811.33471-1-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series modernizes the ad799x driver by converting all resource
management to the devm_ infrastructure. This results in cleaner 
probe error handling and the removal of the ad799x_remove() function.

Changes in v4:
- Simplified voltage caching to use a single 'vref_uV' variable as
suggested by David Lechner.
- Capitalized 'uV' in variable names as suggested by Andy Shevchenko.
- Removed redundant 'if (ret < 0)' check in read_raw() (dead check).
- Used devm_mutex_init() to replace manual mutex handling.
- Introduced a local 'dev' pointer in probe() to simplify function calls.
- Switched to IIO_DECLARE_BUFFER_WITH_TS() for the buffer declaration.
- Moved goto removals into the respective patches where devm conversion
occurs.

Changes in v3:
- Split the monolithic v2 patch into 4 logical commits as requested by
  Andy Shevchenko.

Changes in v2:
- Eliminated dynamic buffer allocation (feedback from David Lechner).
- Cached voltages to prevent devm/manual ordering hazards (feedback 
  from Jonathan Cameron).

Archit Anant (4):
  iio: adc: ad799x: make rx_buf static
  iio: adc: ad799x: cache regulator voltage during probe
  iio: adc: ad799x: use devm_add_action_or_reset for regulators
  iio: adc: ad799x: use devm_iio_device_register and drop remove

 drivers/iio/adc/ad799x.c | 101 +++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 57 deletions(-)

-- 
2.39.5

