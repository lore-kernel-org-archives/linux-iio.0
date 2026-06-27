Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD6D374192
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782566739; cv=none; b=hyEe2PaBbN3tnbkWuY64ORXZrClkUifkp0UkvdIjWhGZSKF3LdmEZm2sfjm3YMkuT1eLJgu7snqiYQf/4HAFcXKoh02+dzrtaDeEgf9uht/OagKPaxCRZiRqrHdw7NFxrpHvT1nkBoS8dAbcZztOJLOrA5GLzS8LHtXo4AL88mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782566739; c=relaxed/simple;
	bh=DI2Hhpda7T206NPAiNQfIVBz6jkJ+MQ8YRd8wwJpHPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kkoWo54eRXFqa94x8f+vxIvfnJzkeMV/tx/HDh84mwTG3wSafE28zjVfmUBxD4SA1qo2avku/k2A292IuUBJDbEZ1fGirAcDVksUsmwKWx7t00HKm6/zShMURWi+c6Z10HSylbamiOIhfsb3OEa7/DEM4lTZ2CnCiv0y0yBep2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Y0Se5vs0; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Y0Se5vs0"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-30c9c8c2697so2107057eec.1
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 06:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1782566735; x=1783171535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WerEFzaFRM4ES8B0laSE1YeaDDNFufXGkMrsc6kmxrQ=;
        b=Y0Se5vs04vU/ZzrPqZlzzLbozYcre74IRqn/2ukM57UebQ0RnSuzp4k0/t2h0Cazz/
         E1bys62KCU5pTho1iIA+DdVJLHcDTxqgvrID0R3sSSbJLm1HruCXCueTl8tJ7R2L/dlV
         wv/9FIlrwgRa+EpkYfafANqcxMyGsOSzMmag0WOFyWkQpNdIagbL0RTiO+1TH8eKC1z6
         jRypb2Rrsu6A7TRD46Q4cdyUNXnbOvWS+18HyHK8APomF9hIYi0oQhD8Mw4qMJaajmN7
         8ixOH7d3gXu0IfpJCRzDet7w+l9A7/gSZ8XmwTrUuQPFbeo8DklyuJHAfbrgdlQ4gUy6
         p0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782566735; x=1783171535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WerEFzaFRM4ES8B0laSE1YeaDDNFufXGkMrsc6kmxrQ=;
        b=i+BimWzYgc369txmw+ycDulIkNXdd+aXn2KW2retpYBCk7Z1QXyMEShmkHebuLckXM
         5Q10VsY2/f6Gcrlnbt22DF5cJBWdUr3SX0fU1xAf8kaXre/+MoVEt7180iP6Z/Lv4O6N
         6tiipX/JIjiC6FfuunY2pjTtLWRR1L95KpP/y/GBnV47VLweSU4voolHDyaM4Y9PMFuE
         VqbYUue0mfUDv9VjYHP6VeJ29ICkIHAaQclrLfJnqN7UJ/y+7+c1yLhHGu1PBkdkqqJ8
         5StKPUWSZw88ztdf2KKCNly42bUWfj1QFxeGqkTTbFpuI+uOCq7pYSv0Pf4n1zajrLPq
         dTEg==
X-Forwarded-Encrypted: i=1; AHgh+RpRraKH/vVuFg0tKTkplzkeu1JENhdRC8Od90vyev+vfFDvjiN8oTOHGfyk8Kd4c5teL3t8b4Gpb+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlzXsIPM0CrQX4rjWRKouSTUDPNS0oIOjDe8gsL+mZWEcPDaLU
	Sxq69ez/zISz1aY/J3bMjLuLrZD6TffSqTIRK469cEtflLWhd8CSX9fm2Cau4Uydu3M=
X-Gm-Gg: AfdE7cmRtcm/zTmpzCTHjcjTgwAcdPQW+SqyIMtEJCNUvJtDExwuEex+BmrZJSR1T9h
	g/5D7zpNmjLZNd2U15aEqgbhPPr7BGsfW8clkEKa9/QIPZqEGvLmr2w3PN2YITgQM+jEdxVYt4d
	hQIxaSGvdS3WS2MQBPAw0kSOc9VfLtaJRDhZpGxsxz1JRq0tn238AG84f5Il79MfL1kX5f6SM6N
	I69/t8oWEMJICUU4H8/P8F9zWYTkHpHVpHs8o6sZNniMPmi/AN0iPy9Ug/kGMMBSl6Kv3gq20fP
	eh8ql9I9Wj9YgCztigoQd+ITI5YZ0OPpOtliYOs+cbaOILdOWnAZ0KL8wvOr8spu+cqnE8aGYbh
	ME7Bm+lo/6wM28r03iOYi1nkKBJ8ZFQvHyF3C3QOtR84tHp3MKuuW/gpZVDMJErc2+87FAPtUoi
	aJCeNtEFndsug502/U/gPoB4gbFMw=
X-Received: by 2002:a05:7301:a84:b0:30c:52c5:6e5b with SMTP id 5a478bee46e88-30c84dd56f3mr9855212eec.29.1782566734930;
        Sat, 27 Jun 2026 06:25:34 -0700 (PDT)
Received: from localhost ([2804:1b3:aa80:ec21:dab8:1927:ea27:9d41])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-30e79bc5ca6sm6452975eec.29.2026.06.27.06.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 06:25:34 -0700 (PDT)
From: Erick Henrique <erick.henrique.rodrigues@usp.br>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	Erick Henrique <erick.henrique.rodrigues@usp.br>
Subject: [PATCH v4 0/3] iio: dac: m62332: header cleanup and guard(mutex)
Date: Sat, 27 Jun 2026 10:25:27 -0300
Message-ID: <20260627132530.96680-1-erick.henrique.rodrigues@usp.br>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series cleans up the m62332 header includes and converts its locking
to guard(mutex).

Changes in v4:
- Split the include cleanup in two: 1/3 only re-sorts the existing
  includes; 2/3 does the IWYU add/remove (per Jonathan's review).
- 2/3: drop the unused slab.h and add the specific headers the file uses
  (array_size.h, bits.h, mutex.h, pm.h, types.h, mod_devicetable.h).
- 3/3 (guard(mutex)): unchanged from v3.

v3: https://lore.kernel.org/r/20260418130322.106769-1-erick.henrique.rodrigues@usp.br

Erick Henrique (3):
  iio: dac: m62332: Sort header includes alphabetically
  iio: dac: m62332: Clean up header includes
  iio: dac: m62332: Use guard(mutex) for locking

 drivers/iio/dac/m62332.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)


base-commit: 4b570552ea4788d49373d3e31c5a802210f4ac45
-- 
2.51.0

