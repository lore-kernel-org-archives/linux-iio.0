Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116255;
	b=zUmG0ilHrt+1bwOnoOAWXi/GBWBGnmzdeFLKBlUxWY+QpLFcaTloZED12mggMFuszXM1
	 n5UMd3RfHVCFYxquj16g8CVkGi8W50wBa7mQSAODlukMAmzlbb6x550HrZ7fQJ5ikEeOW
	 pI7p6xQQrLs9T803035X24GdKwi+A5Lei6ob1qBrMya+i7QrVqnWJXyP9E0xIpsdEDolp
	 8XP/A+0gIzlCdsLa2GmqBK9ekD4dfL4h5gkpDbrP8puQIkxCJCVuK4dme3mrvSdI9wh6V
	 ys5u12hQcrJ7FmiTnnTd7AdfRfUtZdmEe50w3jcN/0wvEgOLe5ybpbGBEqfDgXs5ReA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116255;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lnraIc303nC0CPdpVlR2Q4DFqFq+N3vNGTmrPXIVFJg=;
	b=2hfZMoj3zf/oEvtOlTtfC6KbBCRejDfl3TiWP5WZ17qAIe+HX9D34gqLfNUBXhlw9xrC
	 DWjdtPBCufsPhi/gt82lHPkc+lCLLYeC/ALPHPN3fgDg3HhDLFQLGt/QCv8Kf0ccmKwe6
	 41zOd6XVKIyp5RRgLk5k0/jClD8tLYW28qocf4w9WIe9JYnACR11zxk5GeV0VSBbJi9rr
	 YERrcamc3zuYtMyXNBLiLpsCEwGHfwEPeiLpG3kx0AUGHcy9KuisKsvPdSFTIhs8jajMT
	 91xUWMXH8/J24SOKufqFqfb3RkBOOL0sSQRDr086i+RyPZPDzkUOKEI5xtg7N7+sPHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nheaTQdS;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C08E606A32A;
	Thu, 19 Nov 2026 19:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C08E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nheaTQdS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795116255; x=1826652255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CzipwZNBH2C8hq3jPjmYKMfeeKiSg6qKhK2uDXKgg1E=;
  b=nheaTQdSCMktp2y1Kxvz2tbgJ4jKKrO6dQt6jMtz2ESquExdmJE68yvq
   QYl12KPUajbOpiPv4X1PV/m55bl+NJbvBTsSCmGSMgpstTthdz27gd021
   shL3YGTcNFIf6PRu7DSeff14nhPohyK27cEp7BS0+t8TVVknuJ/6a0Rjb
   o0MQ549FlVPhbuDsQK0jHM4JF7/DmDSCWiRh2apddHpSRZXSJvLqdCzC5
   NRvGhysRC/DtuAdKTnt3vZm0W1tWNUDPr8XLC3ZHiVBGCR78B22CXlo4F
   hlSCO1ePHuHPqCyxamy0xfhv4wwZsP9xZ0wVrzVwUo9AV58hIJuj5dXXA
   g==;
X-CSE-ConnectionGUID: DMhDG1zBQtSA77prRuH19g==
X-CSE-MsgGUID: HioF2WXIRgSLr15She8haA==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="3828864"
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="3828864"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2026 11:24:14 -0800
X-CSE-ConnectionGUID: 7DdbQUowRr+QfKPNff13pw==
X-CSE-MsgGUID: NGHsAoGiQHGxhDD41/LNQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,221,1787036400"; 
   d="scan'208";a="10801245"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 19 Nov 2026 11:24:11 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 092E09B; Thu, 19 Nov 2026 20:24:10 +0100 (CET)
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
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 1/3] math.h: Add mult_fract() that takes struct __Txx_fract as argument
Date: Thu, 19 Nov 2026 20:19:45 +0100
Message-ID: <20261119192408.1724611-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261119192408.1724611-1-andriy.shevchenko@linux.intel.com>
References: <20261119192408.1724611-1-andriy.shevchenko@linux.intel.com>
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

Add mult_fract() that takes struct __Txx_fract as argument
and calls mult_frac() underneath.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/math.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/math.h b/include/linux/math.h
index 1e8fb3efbc8c..0f584ee48753 100644
--- a/include/linux/math.h
+++ b/include/linux/math.h
@@ -128,6 +128,13 @@ __STRUCT_FRACT(u32)
 	q * n_ + r * n_ / d_;	\
 })
 
+/* Same as above but for a struct __Txx_fract fraction */
+#define mult_fract(x, f) 				\
+({							\
+	auto f_ = (f);					\
+	mult_frac(x, f_->numerator, f_->denominator);	\
+})
+
 #define sector_div(a, b) do_div(a, b)
 
 /**
-- 
2.50.1

