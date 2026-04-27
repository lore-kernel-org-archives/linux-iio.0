Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BAA36DA0A;
	Mon, 27 Apr 2026 20:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320868; cv=none; b=lWx9C7U4R2Ef1bvbV92Q4+gd5yGJ0EjEdp1kVJw8zwZrc4fozyifBZXXsklmEIcu+Qab0IhYoRs/1GKLupO1b7HCLXowj8D/jqQV3HPwGQvnFWKApUSfvf25+R0OXWlsulXbYpNl8x2ZG1RY3V79F4Cz2JB8SHuk1TopS8mQEnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320868; c=relaxed/simple;
	bh=aseIrcz6Ex1dScsc0MGOOOOU+gdhgIyBS8RygfiFzl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFntXR3MWG+Z13vJibyMW5SdND36pi1dmFdzhIARGna+I1IuYMwoMvRctOIs5MaIBvF2bMg2SuaAVFLSiowbexbz5/HW9tDFx6Sf4wa+MnmnZLh8DePdWgrYm4QpfWkiEyC2MYdKCtj75bKYN04lOR3HF1z55bWkAsRtmN9F92o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SFq4Zm2h; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SFq4Zm2h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777320867; x=1808856867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aseIrcz6Ex1dScsc0MGOOOOU+gdhgIyBS8RygfiFzl8=;
  b=SFq4Zm2hMxjLJ4mGVikGqw2/CKn9BXJqy2tMVrpKf4WRLiUx9YMlvxPZ
   pc64xvZw/fxMPOTikFuLqEycTJzmlQy04qy7iUfr5aEPXWixnXuFmNSUx
   SEx5MNiOKrGUGKQL0CQRO6p1efkRr2i0VcT19QVjJDhtk21TU3ExJScxJ
   Louc+MRDLd6nNd6d7Bj3EV8Of8RoyI1mnRF1BMIKIGHiAK7cQlbQpW7M/
   ngFLud0SS4O9NI+Fbld0rMEupiNsaTLPTcSUfM3wE6QfZxLj82HsUmho3
   rPFI7s6viZo1zz41SE4mZKLx9RMcJByFg03z4cycAh8iWBbVxlG77ke0W
   A==;
X-CSE-ConnectionGUID: 6VstPah/RSK9BoAqx0KFYw==
X-CSE-MsgGUID: IfDT7SnRRWur06Qq6HSkyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77384096"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77384096"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:14:21 -0700
X-CSE-ConnectionGUID: wwlj/bV9Ski9frqy81hhng==
X-CSE-MsgGUID: cVSxsieMTYa4iapN8+C37A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="232857721"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 27 Apr 2026 13:14:19 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4B3A798; Mon, 27 Apr 2026 22:14:17 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v0 01/14] drivers/iio/magnetometer/ak8975.c: fixup for the IWYU change
Date: Mon, 27 Apr 2026 22:09:46 +0200
Message-ID: <20260427201412.3067235-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index c09db212a6cc..378940e82550 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -16,7 +16,6 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/iopoll.h>
-#include <linux/irqreturn.h>
 #include <linux/minmax.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
-- 
2.50.1

