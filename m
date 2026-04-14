Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A51B3BD22E
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776159031; cv=none; b=IOmeERrMJY6+7qNPie4GnuXM6LPLEsmmS1r7eC7JhcaxrdVna1f69GxttpSUcPTlQ5mOzW6zIV0w81FQazwOBkfGSgs0a1U3zmnlBiQHbsNvhJX1BcUA93as6Ss9SEEXj4KXRX4ReFbPSal2QHvnuFIenyoPlEhvOymhOypepGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776159031; c=relaxed/simple;
	bh=nA6q9uc1XooEXzBX8iGdxfjdQCrmPN1pYn9bUtcfSEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KfvOp/3rXpqDoueKtxlF5k+DGgdMhWMEIkDYQZEPofK9tSuo1JAaYappZm9UwjKlIlwgx3dr1W8RDCxS+MZSDKa4tthhCqhHuhp+VX+tlZ+YmFTSQjVYax417uj8uvd4Xi1qVMKYQisJXNVLOflWCJP/zzy21PdkoaPaUqCe8r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=ebL4qlSQ; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="ebL4qlSQ"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c565dd3a7so163454c88.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 02:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776159027; x=1776763827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4SIzmfde5277ChYiQL5qk9STfDI4POt60DO+vrLKpk8=;
        b=ebL4qlSQb0JF9Z55JCHuwk9CrVPDj06c9vDRWJkphS9r1t4QnVSZcHTkuVjsXSImxP
         t6n/EqRInhFGDk9vzHvG49RR44q7LBJDc4I1N7KLMe2pZPmDrNCs33x+iQ7rsgJDoJe7
         crueo5jyFtSop0eVy6QhBwCe42SFRh122sSneEka5aeleRNi0NG0/ZTtOm6SEKRoMgy0
         zCP/PVqxTnZTpew6hmkuiAmlX4Gz7SBuXRAJMM/I0xRUk+2c5pkK556GE4zolVt5uY7d
         rceLVJF5b/x1MOU1KSdGThKW1DUeESFK5jopYb+MrSJa4dMj4AmhmjJdGTatDtXuWwLI
         4W4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776159027; x=1776763827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SIzmfde5277ChYiQL5qk9STfDI4POt60DO+vrLKpk8=;
        b=qd3vGojb0jmy0fMvtszjs8lM8JcGQz/LSJG74AXPn5awQZzXsBYdGlDpCWtM7QnWxA
         VaUAeCzygvKu0d0Q+kPMAqJ5EJ+MCtrDG4KFdthrSAUlWRfc+GzmHwUuBTP3Lc6O1Dfr
         r9rvMYWgpz1V8BS33delXv6BJSnaRWFyeL/J74DJjbKomoFB6G6PWI9FmTEgH3vA5uSB
         uZwpPL65yi/dOss/pmikk++JnSjf03ebJoMIViZdHCaH3S6N0YUuIzJQ+n9+jeWD9VAe
         2QKDuq7WNuX/0CFc+wuMLkLkuTuADIhn9IIcn8KvklmdrlgROea+Gg6qQXE7JNS2BeV2
         FBSw==
X-Forwarded-Encrypted: i=1; AFNElJ8sTIFcPTD/90lmMZKTpJ3uKOXWusIsDHnwwfep791vRuRiZh0EVKC8yMfWNtfTWOdBBQlsdZOdqOo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4CXGH0BjWUOzs3uho8wZcl2I9fTRuCF1ZtQV2FydwPIefe1qu
	PzZwRMBt16TIOwhD4wrtGqeE4/c/CeijVrcu11uSI51u8OSLLpB2gJV82YBxnidZjY8=
X-Gm-Gg: AeBDietYCm5nn80/91ybUKwK0qjpVizPB6aaX9p5s03VbqKlOg9yod3xxK80xL2Sl+y
	LMZ84RmPaYY0oPD+WvYeytSdnEofMi1f5zdk3QiEKSnqNKl4ZPeLqQceH2UDvMftr50XcvXyI6w
	/t6SD9dIS6Oqe4Ij4FgZkTngzL0+04sHsNr1mVsXJzWYEJdsYMITDt7P73O/r4exue9sd86rr/o
	ryzJc+WevIdlJ67Tf8LcsfE9dDjWLp04U1c/XxUOC8+GwSgPst0OLr9B4ozKJDtlQfUMmvYHXQt
	hp9gmYBaCjNZpnNs6YF7FdBwpbEEKG6ataHflfEtCpRdggRB7n27fUCTpFMVcxWMwi6Hzjle/9t
	yY1IEGxNbo9Sx0Ps07ObknqGUYxJaFWG+gRRxwGLxpHA5z6On+xPeQvIM809PH2E+suM4tCpn5A
	1oZLXkhzAITrN7SVAW+qg5IxsSnSKNX/kqB3ESR5Q0ySAVjAuPKzvMtyZSBJNtIp8xl+TvQJaCd
	22BuqJXteU1GWG0NPGVskcCGrfe9wCKbtPUPaHJsT5J0QnamA==
X-Received: by 2002:a05:7301:4089:b0:2be:a2d8:e9e3 with SMTP id 5a478bee46e88-2d58a2a171fmr9796479eec.29.1776159026550;
        Tue, 14 Apr 2026 02:30:26 -0700 (PDT)
Received: from gui-host.Dlink ([177.33.104.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d562db6ac8sm20327599eec.26.2026.04.14.02.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:30:25 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: Salih Erim <salih.erim@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michal Simek <michal.simek@amd.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Subject: [PATCH 0/3] iio: adc: xilinx-ams: refactor alarm handling to table-driven design
Date: Tue, 14 Apr 2026 06:29:27 -0300
Message-ID: <20260414093018.7153-1-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses significant code duplication in alarm handling
logic across the Xilinx AMS IIO driver.

An analysis of the codebase (ArKanjo explorer) revealed multiple
duplicated mappings between scan_index, alarm bits, and register
offsets.

To address this, the series introduces a centralized table-driven
mapping (alarm_map) that replaces multiple switch statements spread
across the driver.

This improves:
- maintainability (single source of truth for mappings)
- readability (removes repeated switch logic)
- extensibility (new alarms require only table updates)

No functional changes are intended.

Series overview:
- Patch 1: fix out-of-bounds channel lookup 
- Patch 2: convert mutex handling to guard(mutex) 
- Patch 3: introduce table-driven alarm mapping

Guilherme Ivo Bozi (3):
  iio: adc: xilinx-ams: fix out-of-bounds channel lookup in event
    handling
  iio: adc: xilinx-ams: use guard(mutex) for automatic locking
  iio: adc: xilinx-ams: refactor alarm mapping to table-driven approach

 drivers/iio/adc/xilinx-ams.c | 192 +++++++++++++----------------------
 1 file changed, 73 insertions(+), 119 deletions(-)

-- 
2.47.3

