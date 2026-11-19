Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116255;
	b=Ynj19SW2+NVOoJfpVjmVQqwOxgh9dJzsKb8AtCUOmJ8gJ82zGrYD+OOsQwBYRt0IgHjw
	 F3vTq92/nA1SXtquFJSdRvcVCDIzL4wbr5z7YZufPoVl8gEtD6PGcsF7ygS3e1KKmMNH7
	 CUnGqF3tHdg+Y9em5Rwu1mivtr3NyFy0ddC+iwDjeFZIc5y6yINwa7HgAt6uMfkdQhyfu
	 XJftTTYqq3jz6qGs3lK9f51AK4pdvic9f7X8p3bu1oviSRj83gLdEbFPAnEd2CVwYI3GR
	 X81iroZnLvR1sISWpHKmluLSlWE4zn9zzMBK7/A8gNNfMHsKSaWP2FPWCYphP2S1SMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116255;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Iytc+/MyW8zlfIAacLqJvjEWEbRA9CvehMAbvL6ImK8=;
	b=dXFe58J2ZZqTzPz0C3Y8n65GQStmq4E0ZdC9JUgrdVDnPTurkljlpLP8ti03e9kSx4H8
	 zPObeT+Y6t9nz6OBCvIwj2rMqSqGTL5fH9kuY4gpUThaYgqMAWKOMm7nMb+WdX0GQPChU
	 F/TnMsJNnivP/Mx1NfUun1crFhOFycHATNNfvJMm16rwokTJrODFvicx6H0UB4tq3jMHF
	 mVlmT4cA5YjM+6R2+pqgSDGh2EUAeQ/uDb06c4DXwya6NFJYsgESkeuxGYK6qv2EgrSvr
	 5wtVUSSjzmoLWgzpIt3KU090vsfQyXx/pI6oZQOj6HZqGoID+Q80HpN+9ipaOB9Mb8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X3xhorSZ;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C121606A32F;
	Thu, 19 Nov 2026 19:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C121606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X3xhorSZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795116254; x=1826652254;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=z3L6SLjndmyp/9mfFbc2vtuxNst7iCsAeE3+x0T/NVU=;
  b=X3xhorSZbjCT9g6GKaJMjGta0ndPBYnesqjiXoLuXb0Q4ZjPE3w6Cs5o
   SKq2FkoK2NXS2zEkCgUyC7G+FgAJCbzvx6ODSUMbNPwAIwmcxqS7erGKr
   muXieqLg7Uj7LfXSVNHtuXFumCrzbU5tpsEVfQEy4IBgdGiGED7mD1Aoe
   uipgXS8Zz/ekNtdvCRSKpX50llO/oVYBjyXcmWFkd20FbS19IJXgzy4Hz
   RUu0vWzLJ4x1F+OlniTGFNtLMijYNxz3wx+1V1iMrV6tma5RerWZwALN3
   z2KFRWjPfvX2jHoxOS+28WGxo46/xZ+fHnpZo1aI6DrdCszuvM9nlgRev
   g==;
X-CSE-ConnectionGUID: MFYXx8YTR1exHVltzREWRA==
X-CSE-MsgGUID: CQq4lOanQa6H072/1uXdUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4010429"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="4010429"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 11:24:13 -0800
X-CSE-ConnectionGUID: qRXt4jM8S96HMrCFbERcDA==
X-CSE-MsgGUID: /IyRy4BTT5maPrYYLZSb1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="12227136"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa012.fm.intel.com with ESMTP; 19 Nov 2026 11:24:11 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0618999; Thu, 19 Nov 2026 20:24:10 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v2 0/3] iio: adc: Provide mult_fract() and make use of it
Date: Thu, 19 Nov 2026 20:19:44 +0100
Message-ID: <20261119192408.1724611-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a couple of IIO ADC driver the suggested new helper mult_fract()
may be used. So, provide it and update the straightforward users.

The helper has potential treewide, hence it's provided directly in math.h.

In v2:
- updated commit message in patch 1 (Sashiko, c/o Joshua)
- used local variable to avoid double evaluation (Sashiko, c/o Joshua)
- collected tags (Marcelo)

v1: <20261117091638.1463621-1-andriy.shevchenko@linux.intel.com>

Andy Shevchenko (3):
  math.h: Add mult_fract() that takes struct __Txx_fract as argument
  iio: adc: ad4030: Switch to use mult_fract() helper
  iio: adc: ltc2378: Switch to use mult_fract() helper

 drivers/iio/adc/ad4030.c  | 13 ++++++-------
 drivers/iio/adc/ltc2378.c |  4 +++-
 include/linux/math.h      |  7 +++++++
 3 files changed, 16 insertions(+), 8 deletions(-)

-- 
2.50.1

