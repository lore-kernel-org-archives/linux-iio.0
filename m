Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC29259CB9
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 15:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778340006; cv=none; b=J+PhmGMh0fFZUIXAAaWn+1mwwEzyDjDFIu3bT+TZ0YOk8Zxax/Hg+c5GETAS7EuOlFj0UtBY+8O49J8v1bj0dtO6LjTewom3BuWE3RVWElyUbTMVvmjC0gvLoPO5VW/NE9NcNdd2HgRpEvqxIi2CfqYj+BDUMBtOOujqUV/ejFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778340006; c=relaxed/simple;
	bh=947yr2LJU7MWNEeNnDGreq6fKI0j9FlCtMVXZZSC8LA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ojPcngbpHhU4weYAdJz5wIZ1XDd6sjmbbo8N5x039MVVNAHABVSv7ABjibL3rA4KwHkM/NNgzvgCQUM5TBrxhR3eI4cmL1z1vC5CoRm/nSTk7dhwUrRQy92TZQQKGiGBF7oeFPZv0Pw5cQE7crPDQt8YOIQzSd0msZX9ORe+4pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dir9eUbJ; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dir9eUbJ"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a88de2b52eso3947614e87.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 08:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778340003; x=1778944803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uTK1Uag8074qP5KWqBVm9Jj0miTO4zcn1XWQKMsTbrQ=;
        b=dir9eUbJwOame8Fdo0+7o+ni+o1IBvvtnyGarfh3cpZGC3DPa67pNkXtaqiADELttv
         ikPvBhTTSm+u83C9CyZ6s6VHs/ERxiz7SMS78ffbB9uPHaf+L4BblJvlPE8FJRbRXt6s
         wNScBr7oTFPOAljI62OHJxn3gbqFNKwAd9HMwzC4SNp8vx/eL14uI7RftY07ELlqo06P
         LYHeVzEB4YrkD3T2hVR7pU6CzEQ9ifY5fLd4uUyTRo6z3eeyK2Rsit5+jk4rT9bs6XwT
         4rxnLblc4F/B6tHmVJJvVKVVfG5lgYahiIm35/otdlwt79Vd2vYwM0a8/SADbnbdn8qZ
         ytag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778340003; x=1778944803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTK1Uag8074qP5KWqBVm9Jj0miTO4zcn1XWQKMsTbrQ=;
        b=cyP98CD8t3j5FFmmc9q8kljrOptXKMop+JuGAa4RFte3QLlZk0T0b2epi29CU1R6vz
         dymMr3LpNw+U3/HgL/ZCVQ73bV1cC6T5kx9yAvQDbb4ggIevhIXILW6ga8sHXIF6Ehi0
         WVYvl/8Dt3N6iA9ubMrRmDscKHc3H1HW+XSfg5VD6PT5HBzaWoP+bH2llBmHDwQk2haq
         6XWDdyWsbG+BzipffNoVS/Mg3H2VLdOTsYnSPkVD5222VQ1jovdGHlp+KmiRBL0kVd9t
         TwjGuLGEKH7Pfm0NgmKli0sTyuFGmtzGzprQ22ivAcjuJqcCRfB+iS2PZpceo7wl59ak
         nNHQ==
X-Gm-Message-State: AOJu0Yz25HCZIY8kfsbVu0K7xYRWU5DDhNbfQ10N0mkS+36akbT7QGYa
	BXGKf74ot1Zyg6fF4ywIUmizgCBI8m4Cj2izA/5zxeY3FZ/bWmjqAQlTzizGW/xy
X-Gm-Gg: Acq92OHZfaSfrpELj3mUiNHwnwgBEP5VUE3Q7g8//TdJL/dzrWfR5zQbPYgUwBLptJ2
	/Jon5h9vh/YTMYYAnW6THcEolr6J40njzQ5hP/bW5BrWrk57PqThnPgMz5NheQ8QQSBii+tvvCL
	+OFkDy2jqPx+ag87On/Aj6a6rUqHTv/UyETkvSP/YKt0COZXeDK8IzimTGCYLocMLi80yfurFnl
	7Lnp2bsUh1K5+1sHXz6C6GvEPiskxINQhMguWxl7ygLwwubKbb6NyRCvgjcIjkalmsZEmWQbt+8
	hFOOxOvhEB0Cx624V7pbI2xqrzm6OfktmFJ1IVH9cfmjkXIpCUj8HB6FuhaM6f6s83yWvX3bIBO
	plw0IM2g7HZPuNwJW36LkUSImMHulxX7R3MNQKZV0N4O0ruduPtDvWqwC91wGGg15Wy5a0rwbm4
	lqy9FzMzjpFwdrVhHE1owfHVZ+JIyEMmhrkogRYTvKWxdxSpejS3oSkjXVn+Si9x6we9Im9365Q
	NU=
X-Received: by 2002:a05:6512:692:b0:5a8:7f30:609b with SMTP id 2adb3069b0e04-5a887aa0dfamr6358623e87.0.1778340002687;
        Sat, 09 May 2026 08:20:02 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8a95664easm1301975e87.70.2026.05.09.08.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 08:20:02 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: jic23@kernel.org,
	mike.looijmans@topic.nl,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v4 0/3] iio: adc: ti-ads1298: Minor driver cleanups
Date: Sat,  9 May 2026 18:19:56 +0300
Message-ID: <20260509151959.3475-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes three minor issues in the TI ADS1298 8-channel
medical ECG ADC driver.

Patch 1 adds missing parentheses around the macro parameter in
ADS1298_REG_CHnSET() to follow kernel macro coding style and prevent
potential operator-precedence issues when the argument is an expression.

Patch 2 corrects an incorrect comment: at the lowest supported data
rate of 250 Hz, one conversion takes 4 ms, not 40 ms. The 50 ms
timeout value itself is correct and is not changed.

Patch 3 removes an unnecessary CONFIG2 write from the init path.
The driver was enabling the internal test signal generator (INT_TEST,
TEST_AMP, TEST_FREQ_FAST), which is inappropriate for normal ECG
operation. CONFIG2 defaults to the correct value after reset (RESERVED
bit only), so the write is removed entirely.

Changes in v4:
  - Add this cover letter (pointed out by Andy Shevchenko)

Changes in v3:
  - No code changes; resent to correct the recipient list

Changes in v2:
  - Patch 3: Rework following Mike Looijmans' feedback: remove the
    CONFIG2 write entirely instead of just stripping the test signal
    bits, since CONFIG2 defaults to the correct reset value
  - Patch 3: Add Suggested-by: Mike Looijmans <mike.looijmans@topic.nl>
  - Patch 3: Rename subject to "Remove unnecessary CONFIG2 write during init"

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>

Md Shofiqul Islam (3):
  iio: adc: ti-ads1298: Add parentheses around macro parameter
  iio: adc: ti-ads1298: Fix incorrect timeout comment
  iio: adc: ti-ads1298: Remove unnecessary CONFIG2 write during init

 drivers/iio/adc/ti-ads1298.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

-- 
2.54.0.windows.1

