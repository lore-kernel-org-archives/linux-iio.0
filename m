Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3752E3360;
	Tue, 17 Feb 2026 10:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323809; cv=none; b=h+0VSoqwmkLA7aDuSTt/E16m2QBCK9j0njyQYmKhp3P5mbfiVB6Kmkt7+3/BRBMTYVDY1mSnnXLED0GQMT7UJbx1L85rLLku1LnYHP9nfzE0icjaHMmY93wJWvSRXyLXwsKkwvnuU5eItjNLZzJyQ5gIYv91BnartI5E2Lu5bgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323809; c=relaxed/simple;
	bh=U/ogBITXVXdOtdX/tjVKkffvwQl07ULXr24qES0ZlpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRupt6/7N/wDqpb0QUidLdMd31DTXFJD65jonbmh6ahoi+PdxVwS75xuCxdBfkPXjVkECKk2cDiWgTca7KZMk4mMz2N3126bEe/YEYFgvb9CrWS/UU9Jw9TzJxG+75H9wt55EJEuNAqDud8s6iP5sV1MGnUZd4OKny3FDbOWj54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mcz9OMNv; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mcz9OMNv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771323808; x=1802859808;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=U/ogBITXVXdOtdX/tjVKkffvwQl07ULXr24qES0ZlpE=;
  b=mcz9OMNvp6BHJ786jYzICeohy+hvHrygi5ECpXSrdw0lwXkNhn+y9CdV
   kQD6nBfpYySeTYjBficD0Zc401mh6jTW1PY0iKLZb9isSM39Pd/2t5NoR
   /W7s9uP2uhRtrVor/9Dlsi3UZlGS/3H3mnRqL5iFdN3QJNYxfRyJTMFxU
   WXLz7cRK96CQUBEeAbWB4aI97X75GRp6mULaLTi4r7Xrfyt4Khs3GFH3B
   RZk2uvzUTIA0xDR0IAGBdCxZX7RgAFCrteaNN4Lqj6TbYN69cuhyJmRG6
   QZdNY7VJveYzpRDoWgBpwqdOr49okUK+9YOEePPSPXuRNfnfmCvDaBKUs
   w==;
X-CSE-ConnectionGUID: Nc97z9FRQsmb6VuhX0wmqQ==
X-CSE-MsgGUID: fDVYSI/9SJS03nbGeAoW/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="72099171"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="72099171"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 02:23:26 -0800
X-CSE-ConnectionGUID: kzzAVFqdR++gGUND2HS5vw==
X-CSE-MsgGUID: ewfZyTPwSWOoFhfygJuwVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="236851650"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa002.fm.intel.com with ESMTP; 17 Feb 2026 02:23:24 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 599B39B; Tue, 17 Feb 2026 11:23:23 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v1 2/7] iio: light: gp2ap020a00f: Replace custom implementation of min()
Date: Tue, 17 Feb 2026 11:15:12 +0100
Message-ID: <20260217102318.1354103-3-andriy.shevchenko@linux.intel.com>
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

Replace custom implementation of min() to save a few lines of code.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/gp2ap020a00f.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
index 6f75c845f258..64945690cfaf 100644
--- a/drivers/iio/light/gp2ap020a00f.c
+++ b/drivers/iio/light/gp2ap020a00f.c
@@ -38,6 +38,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irq_work.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
@@ -45,6 +46,7 @@
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
+
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
@@ -454,9 +456,7 @@ static int gp2ap020a00f_write_event_threshold(struct gp2ap020a00f_data *data,
 		 */
 		thresh_reg_val = data->thresh_val[th_val_id] / 16;
 	else
-		thresh_reg_val = data->thresh_val[th_val_id] > 16000 ?
-					16000 :
-					data->thresh_val[th_val_id];
+		thresh_reg_val = min(data->thresh_val[th_val_id], 16000U);
 
 	thresh_buf = cpu_to_le16(thresh_reg_val);
 
-- 
2.50.1

