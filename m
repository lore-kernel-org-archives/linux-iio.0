Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0508F353EC0
	for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 19:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782416310; cv=none; b=EjPdL9V4tDzDEZpPjdDZ8p1xx0/F8fpRSdjQJLnWeMxDua8J08/fWICyuOyGPHXz7I3skndyHlbhC33cvIB3gBMvP8eZvbXcaHoF1G7EDIASNFVTtlx21OjPH7d+JXLgrabidOesjQKNZZsDqOPElm4ROHXboByfRxrWFCnngmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782416310; c=relaxed/simple;
	bh=6iCTPDsH70Mt6p4jv8W+S2SB2AGbk9E11obLCxaWMaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eFdFslUOw617ohP94L1NAd2J2VzEH9nIcxvxjs++LroidB7scZo6H9/c4qOqGsCWWzkY7JLNjcRzN2yJHdrAy5GCJ5yy4+dbAyxl13VFw3ZrIXguqAzjtS9oWpgffpYCi2W2u/8TbMciZzvHX49WBt5WgBXJtcKL8ZdRxoynih0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bV5HaBk9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bV5HaBk9"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49241a577d8so1657255e9.3
        for <linux-iio@vger.kernel.org>; Thu, 25 Jun 2026 12:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782416307; x=1783021107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5x6S14VNMO22r8jT6axuxpTn82AqymERgIPMs45BjA=;
        b=bV5HaBk9WashtnefqLXg2cMh7Kc02KnzppQP8k4jzoCTSc+1o2ccLZAoDAVOMT0IBU
         MFbYF5x5Y2m6ELJVbQdqLxTMD5qoh/f5gT/K4QMFPl+rozHjN104mCc9QBYi5T6BbRNF
         tD1z9EHzIJ92NcuFbjU/iuR9858tJkuL0C3IQNNvXAJjzWgGe9wznGg3hauRn/PDtFAA
         HCD0C4Bn5kN5pVNelmTRI3m7K/7afI3lM4EATYYeJeNLkqTFEPe4iSL+gi6Q7jZhbcAt
         GPOoQdmbGGbLDEcfOucsNx/5/ysekHTiHOg9dKKvH2YFUBiuLsQFE0Z1Ra8h9uRgkmu3
         uB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782416307; x=1783021107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j5x6S14VNMO22r8jT6axuxpTn82AqymERgIPMs45BjA=;
        b=plRypHGmDEmy6HgHYRO9bmzy+tel7MIaOBqKTHiqV6/UGZzPIWmbOA/BWtjP6rrhCd
         NzLLIgehFUehfWJTvXiqMyBEdETN6YZlVDzjngJMSfJNN7PEdHODRknoMShRHmjT5uZ7
         Hr0iUYlebo9esnWSnobGqA/qIGAWAp/sldQE/WrXM50EN3pEcmRQIMi/9rXd6iFwgK7H
         3Brj5SBRRnJMJdKECi/zQGwoXFuI5NeZQ6G8aVPK9KaGnDHlxNS9eoudLyO5i55csUHY
         irHdQAmEKwGbUwq1++VAZSOzqyFbtZqCMFlQQZB1DTch8E1tNMJzkrzxem/dPS+Mlil9
         ExNQ==
X-Gm-Message-State: AOJu0YxHIc2zbTBUoydOhb66BY8QEcr8c8H9VIPYXKmamq1+J8LnM9Mq
	we71+QU4SLponWYthQyDXYN6o6Wfvchksd2eamHvriSQV8WnjJQFMuF9
X-Gm-Gg: AfdE7cmbF09JLKCW8IAuf44/GENiHyOtVufpgUlfem8Cdt3TD/BNUwPkVyYeH6LZa17
	qM/JV8p3BixEmdTY/xRdb8YxiOD95iWAzDOYK1yDPwrwUoL8CJM4mZmchm3tuzhWwEaOe1hHcLc
	FB9qS4A4U5fKeydBZDQ+YWiIjTU61/AuhmAMPLbFiYAUViQ/Qow0kh3/DoOKjt5NIGvsYu2ddzu
	YPEdfuU+KyPfjDAVOWAiWXAFcNkCQXrgmDNsTZCR9yiK0crcemI9Em/x1KQtwsvdLuI3issIOV9
	Hqkt3temtMpF4HDm/j9+svx4Go7e/I+R0vqX6qF27zvXRDIkiQ3lNoUBCeu2EO4R5pRRWNMC/C0
	WTlVI5W7HSfFGqMbJioZCh4HVq5pEQZGQi6x2FmBM2TN67adAU8ntO2pAZ1ZwG66hdFwSTYWBXT
	NI4XhSbDKbHa7loP+qi5fLUP/pD4ZrzK3VR1WCZD7vgtO9WgW7u+XiQPy5Nvba80ecXwLMMa0uc
	cKiqx3TQoAzDmHqgmza2AkArQIXurLOHuoB7PW09+VHi9CmPuTUIIF9UdnpCBEistncuzrTGOWf
	Eh20MyxkLqkrb/8wHg3Z
X-Received: by 2002:a05:600c:8716:b0:490:bc46:1a58 with SMTP id 5b1f17b1804b1-49266880f2cmr56565445e9.18.1782416307226;
        Thu, 25 Jun 2026 12:38:27 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690168d5sm28898945e9.14.2026.06.25.12.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 12:38:26 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Thu, 25 Jun 2026 21:38:10 +0200
Subject: [PATCH v2 3/3] iio: light: al3320a: add missing REGMAP_I2C to
 Kconfig
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-fix-al3xxx-kconfig-v2-3-796cf8d7cc49@gmail.com>
References: <20260625-fix-al3xxx-kconfig-v2-0-796cf8d7cc49@gmail.com>
In-Reply-To: <20260625-fix-al3xxx-kconfig-v2-0-796cf8d7cc49@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>, 
 David Heidelberg <david@ixit.cz>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782416304; l=704;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=6iCTPDsH70Mt6p4jv8W+S2SB2AGbk9E11obLCxaWMaI=;
 b=zyJnqV/opXCyj2nAaOwHv/upPwftu2B4r7DXiY7lnM3RWL3O5Pqfh8ag5ZR2SsZIUNcluXv9/
 5Y5Y66n4kppA3pGY6OkImJoYedboFC1s1tjUqRgeO4eC+9uEu6qPYoC
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The Kconfig entry for the al3320a is missing a `select REGMAP_I2C`,
causing build failures.

Fixes: 1850e6ae7f91 ("iio: light: al3320a: Implement regmap support")
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/light/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
index 4ba3151ebea7..f23bbce12c72 100644
--- a/drivers/iio/light/Kconfig
+++ b/drivers/iio/light/Kconfig
@@ -67,6 +67,7 @@ config AL3010
 
 config AL3320A
 	tristate "AL3320A ambient light sensor"
+	select REGMAP_I2C
 	depends on I2C
 	help
 	  Say Y here if you want to build a driver for the Dyna Image AL3320A

-- 
2.54.0

