Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794931557;
	b=pl97f2M0mytnh64GVh7514SQx//4w0XZEWloKBbZWWUVijRyU4T3fk3oG2PlDct2Ry/B
	 P+WKzJbcWjqlDM0IYe3w1rt61l9+fySYqMt1MKwjLIui3V2MIg6CulVidTH3QJG+st9ig
	 X2CvhniH+HzjemqoGQKJ/Ov+95+G/tUXyQSLnj9ByFClKM4CFjlmh9Jn+tatVABz4/pLh
	 OBDgG7KqV9cbKSmyScPUJ1NgWBn2fU9XZMN0oGoNRikXQw+Mp/a0douPYuMzaedB3uqgR
	 YKYG8shmBk2nmy/FuJumBIjhnRP5mKPfqPf2VQdhLZ21rTLgIYE27XbmmGEDhNIGLHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794931557;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=4Mrtl5T8ASVo1BeX4/auSJLx05MPhgMjlPI4z7J9mws=;
	b=aUrmlbfhpiijr+DMztX0wXIaOJuzafx/R+XZCHY1DN9UbCoVw+txJFRxUCf2d2b/bduw
	 IjiAKZSGWSt3aXfrYQ2XiX1P/dlTYE9qbHKLDY9MK/AtsPVPe2F179bo4VCZ6UkEjkAIU
	 Q0WO4Z4ZJZQHjyHWLiOYrQ8RcCB9PD1QrMA87kwM+npusTLtgoOpDoQloZ3aeqihRom2N
	 oLxnNxjgN/0b3c+IBIlo63tAC+MAW+Mhqpo5FiW+05sHIiR2ytwxTla4p0Pg4mcJmHMAO
	 A8HwTTssxqeTUxYuzDZV3MdHKxxpoOWuplnP/+us+qrav1IranbgSUrpI7UNgigQElw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HCMOEd8e;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208B4606A32A
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 16:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 208B4606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HCMOEd8e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794931557; x=1826467557;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MQMLDkzJ64+B9yypNWypjaJbH3aZEykbE0zY1/zXOCE=;
  b=HCMOEd8ena+YEjFHYr7JvQ++b2gWqqC6p8rkKisff3Tm8Iir4YzKiui/
   BIcgEgSeN7L7zFsDPZ36obp+aA+I9jgZSxe2G5g8t5AcqUQwsXT3u8ady
   ScUxnH3ATTrLfxI262HJz4ORe4tNtoMdMuUSXEmmu1a7mEIlj9JLg7F9b
   HvjB7fBnx+KoJwBqd0tK9ZUqh/KonjGxSOYkkQxvR8L/Q7ElLdmpnMxKG
   IPnuoEeY59pbu3nkZZ4um3SHdggdOuMirxpO0ioa5npdagfspuPeP5glg
   DlRHhzJ4x7waioWZ3OdnqbJY9tAK2X+jVb7wagjiBuwar8XN88sz/Nx9d
   w==;
X-CSE-ConnectionGUID: eNVHxsslQAaVQQG2NL/fdQ==
X-CSE-MsgGUID: iVgT3Wy4REeUSnfV1v9j2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3603305"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3603305"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 08:05:57 -0800
X-CSE-ConnectionGUID: dmso+JDgSO2RnK3acHk82A==
X-CSE-MsgGUID: Eavt0e0pS06VHVHn5Y0Urg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="11605728"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa012.fm.intel.com with ESMTP; 17 Nov 2026 08:05:54 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id AB71899; Tue, 17 Nov 2026 17:05:53 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux@analog.com,
	linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: dac: ad5766: Convert GENMASK() to use static parameters
Date: Tue, 17 Nov 2026 17:05:52 +0100
Message-ID: <20261117160552.1799177-1-andriy.shevchenko@linux.intel.com>
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

There is no need to use run-time calculated masks in the code. Besides,
GENMASK() over non-static parameters might lead compiler to generate
much worse code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/dac/ad5766.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad5766.c b/drivers/iio/dac/ad5766.c
index 061b43fc0345..f600d0828860 100644
--- a/drivers/iio/dac/ad5766.c
+++ b/drivers/iio/dac/ad5766.c
@@ -18,9 +18,9 @@
 
 #define AD5766_UPPER_WORD_SPI_MASK		GENMASK(31, 16)
 #define AD5766_LOWER_WORD_SPI_MASK		GENMASK(15, 0)
-#define AD5766_DITHER_SOURCE_MASK(ch)		GENMASK(((2 * ch) + 1), (2 * ch))
+#define AD5766_DITHER_SOURCE_MASK(ch)		(GENMASK(1, 0) << ((ch) * 2))
 #define AD5766_DITHER_SOURCE(ch, source)	BIT((ch * 2) + source)
-#define AD5766_DITHER_SCALE_MASK(x)		AD5766_DITHER_SOURCE_MASK(x)
+#define AD5766_DITHER_SCALE_MASK(x)		(GENMASK(1, 0) << ((ch) * 2))
 #define AD5766_DITHER_SCALE(ch, scale)		(scale << (ch * 2))
 #define AD5766_DITHER_ENABLE_MASK(ch)		BIT(ch)
 #define AD5766_DITHER_ENABLE(ch, state)		((!state) << ch)
-- 
2.50.1

