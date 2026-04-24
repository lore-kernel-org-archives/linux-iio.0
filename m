Received: from mail-244106.protonmail.ch (mail-244106.protonmail.ch [109.224.244.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254A1321F5F
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777035015; cv=none; b=R7Qvouc+tQkQuZnHcjgLGa9iw5AN6s9k09MISxPFvUmaj9Rs7F8H7Uzckuboji8NhRBnCfKePj2kP7NUVgJiLYPUKoqwbhafGw2WhBpm04O27Xp/BTMsrTaUGuJlWZnEqYjA51X3fBKpcJqpoAxFvpwfdJyMlioO7ItkTfX84I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777035015; c=relaxed/simple;
	bh=8zKqiT1DexSQOhs7jSruimCbKWNodBAbc33x85P/RzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdnycubv6J8H6KdVQTPcI8/UCbFWBlFpbTtFJkUHEgqBAr6Ty0GKfZluuQ8SAvCFAJMvg2zDwTTjBtemziVvxJkS0zknfkNdVa+K7JWm0YMjNdgv6R9+QiWobNdPwEESoMHLXAS7AIlHQdb3qf1ZsjPdjGte/LCH4rGt+XXUhQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ciziks.com; spf=pass smtp.mailfrom=ciziks.com; dkim=pass (2048-bit key) header.d=ciziks.com header.i=@ciziks.com header.b=c18RVUc0; arc=none smtp.client-ip=109.224.244.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ciziks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ciziks.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ciziks.com header.i=@ciziks.com header.b="c18RVUc0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ciziks.com;
	s=protonmail; t=1777035008; x=1777294208;
	bh=lW9CvvbxfdCOQiWNuSMZ353bx9h5E9AW84DzKAAw/Yk=;
	h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=c18RVUc0ALwMiBDpz8RuCLeGVmuaA4gmR3fW+Jq6WJFbRnRcYG2KWrGHutw4fCzBc
	 IW5hM4C0F2oTeO6A/bJF2Qep+L7AWN5UVdqeZJ5FCAvl9R1dItoMZU8o3duVR7a8oi
	 EQ2hcqonCUFUPboltgSX7sTJgyL69RWDk9R6xTmIM1ky/gZzmFgJzb6MDSB4/FWL0f
	 mMeLYrrktEcaxMRy7y4LpJoo0FrtLooMxxImb0ba2FQLKEhuJYrAZOaGsregW/BE0N
	 EF2fFK4nrnMrqaZxz3yYoy0juYDQ2dGYxLqW09m/42HRJpQF3JYTFb7c/bEastjp+T
	 D2hPRzKOL/XTA==
X-Pm-Submission-Id: 4g2CV56mwrz1DDry
From: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org
Subject: [PATCH v5 0/2] iio: adc: ad7280a: use cleanup helpers guard() and scoped_guard() for mutex locking and improve code readability
Date: Fri, 24 Apr 2026 09:43:38 -0300
Message-ID: <20260424125001.17822-1-lucas@ciziks.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series converts the ad7280a driver to use the cleanup helpers
guard() and scoped_guard() for mutex locking, replacing the manual
mutex_lock()/mutex_unlock() calls.

A preparatory patch is added to extract chan->address bit fields into
named local variables across ad7280_read_raw(), ad7280_show_balance_timer() and
ad7280_store_balance_timer(), improving readability as suggested by Andy Shevchenko.


Lucas Ivars Cadima Ciziks (2):
  iio: adc: ad7280a: Extract chan->address bit fields into named local
    variables
  iio: adc: ad7280a: use cleanup helpers guard() and scoped_guard() for
    mutex locking

 drivers/iio/adc/ad7280a.c | 70 ++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 38 deletions(-)

-- 
2.47.3

