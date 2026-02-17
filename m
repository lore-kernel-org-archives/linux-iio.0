Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6693242A5;
	Tue, 17 Feb 2026 10:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323810; cv=none; b=g3/XPLTl7/pwUAD6aXNxtr9fh9M/wy2vMxGDj/j4cfn/Z/39kUEf8fJpn92GvtS5/d2f9G3uhpau5f1QwV9kpkESpftUl/JAN3FORLNNtwxYZJdPYp6YFvrVLG3Z+bHnaTbomN+ngetRTsChhEvWapLLjOc0e4FciNkNsjtLGi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323810; c=relaxed/simple;
	bh=QJfNQH3aPqYRQAKfbv0DQakWT3JiLi+G+CyBfYPttIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c2xK0ycqG8/XlSTAxrFnXKg6iAn4jKjNj7NNNM3QEZvRoYYlK5RIi9VS8/sNp+GS0GJU3wDdRUesSXG8n6iBvqJrYLh7jdLs3GlOJjlfixSTorIqEE+866XTQIDiHhd1ijtIbx6HY4U4w9fNM1ojje3MUtOGg9Pn1/jrQx5HXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jih+KyI1; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jih+KyI1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771323809; x=1802859809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QJfNQH3aPqYRQAKfbv0DQakWT3JiLi+G+CyBfYPttIM=;
  b=jih+KyI1VISgemMhb8DRTxcITQcSjBNyawF7HYe4eEIkbU45yVAS4c/i
   zJcXd8lqwGAf5VmKndmjN/lphST3el6MqhsJ7B5pgzARC3GlPfLBkpqjM
   8voch2oIZm7Ex0BQEZk1XqTWBYBMEhEtayFbpnxyUocrSCGDC2qzyOfIE
   /VEaj9PJPKmySyP30SfPhPILwRKMlBJdOd9OTMED1PNXFZAB+S9k/MEpU
   4VDduUkpwYeXJ2G+o8zAaQzF3rN91bjjyGGDRxWhw8aUxYcwXtWgnCjoe
   9ohaQ3D5fN9E/3fL8w8LzTDppMAagxuCPX6RPBkcsgQ81dM4d1eBeGPyC
   Q==;
X-CSE-ConnectionGUID: XbS9h22CT1aQD1t0+Y3l3A==
X-CSE-MsgGUID: yjkbJcCcSXCGQLNNg+Iqhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72099184"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="72099184"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 02:23:28 -0800
X-CSE-ConnectionGUID: 51IgBdYFTPaZ0trdo44sSw==
X-CSE-MsgGUID: 4JnYDAAASoCpNhfjkxncdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="236851656"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 17 Feb 2026 02:23:27 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 6AEDAA2; Tue, 17 Feb 2026 11:23:23 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v1 6/7] iio: light: gp2ap020a00f: Remove trailing comma in termination entry
Date: Tue, 17 Feb 2026 11:15:16 +0100
Message-ID: <20260217102318.1354103-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260217102318.1354103-1-andriy.shevchenko@linux.intel.com>
References: <20260217102318.1354103-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Termination entry by definition should be the last one, hence remove
stray comma after it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/gp2ap020a00f.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 95479154b6a4..4b7afb62ebf0 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -195,7 +195,7 @@ enum gp2ap020a00f_opmode {
 	GP2AP020A00F_OPMODE_ALS_AND_PS,
 	GP2AP020A00F_OPMODE_PROX_DETECT,
 	GP2AP020A00F_OPMODE_SHUTDOWN,
-	GP2AP020A00F_NUM_OPMODES,
+	GP2AP020A00F_NUM_OPMODES
 };
 
 enum gp2ap020a00f_cmd {
-- 
2.50.1

