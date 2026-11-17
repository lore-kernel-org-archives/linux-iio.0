Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906611;
	b=BPpWLnibUe0sOqWOOWi1iO0DWzUZyL4sbqcwxHz3bxp2jtSMDo+3AaJyi6rQ59i5jCKW
	 rN4RKn6uNmD7fqSlB0fLe3wjuHL7YfmCwKni/G+X6oNjhHQAGXzIc3InWXUq0LtVyPBjz
	 Ku4wjLW32Wtpo4RNvzYD5RhKf0poNMmRu3IGtUg7RNKiqINeI3BW/aZgcS00AQhSWgXFX
	 2AP0lAC6c7YkmHHU+CKJSnSqj0bQIwabwyMlBwNp55aVbKbGU1LlBJ8DqZVy23HVYS/Pr
	 USTDYCfNgr1BGiju0lLJMEzjo38CiifcM+Gl0OROlDYf46fQew8y0XttbowPKrzTbPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906611;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ywuM15k7Y1lHbNzqXX5bV+0RaESQUsSSZKpjMWtqTeU=;
	b=OyEVPymXJPpkjrnSCf0SDN6laqsIhD05y2TFEmsleXYeZJIFTMMX8yRp0WnrQtiSL9mD
	 SwpBihGQka+Uw7gyaLHEK4Ku+eCA3wmi4JcCKk3GxD75+1F04McOCd+6Uvg7kf6D3BfSz
	 rJUo1Yg1Jmdyu2KoFOitpIr8xDGDuDdLOoBw38LqiLoufXG+gobOCBAkZNl/298fKmKjo
	 uK9b911o+faj7UdRMxTsX6brNA2Eou5ksSrfHJbcEIvSCkSVhWOfDcfmctgk7aTBjV5XP
	 gK427L4Zf7TeOg8mriyyllrw2q1BOOkcllTL7YDjd+oBYP7ogP6ZluNtxisf64nJkLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i0TzJEpn;
	arc=none smtp.remote-ip=198.175.65.15
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E95606A32C
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 09:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24E95606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=i0TzJEpn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794906611; x=1826442611;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zXxgmbyttqtgR5wQ56h8ITgHeXyKPcLYeQBe616pJ80=;
  b=i0TzJEpnXwgAbRwj4HBOu62rIzpmyxRHLorAthK3NXxl0dtzMxwO8Wj8
   i2qDlD2CUH/5vYvuMBlgnHmMl5Aq6M2JnuEAM5yh8MR2oGME+yRdhK+6D
   8oWOd+wgFCKAD60Q0gBJQJa+v3IXIHfAXdbtbmqodittE7upMzp3lbQ0H
   3iy+QSsY/X98Wl1vXI4fsguvGDgqUKCpZNiNaJPHtTtPTyu4q8vXL1qEI
   yXuSBfZpI0gWuH+Tv52nMKhxMN8Xdgqy68fn2YnNTWeAIJHtm4YyOha9K
   8IWqWgCEEc4B8pukOUCKWuJTn+yfsoBppKPPWftoOup7slUao8q1af9F6
   A==;
X-CSE-ConnectionGUID: 3SfiBYukTJ2quSy3RJVnBw==
X-CSE-MsgGUID: NUqdL9WTTrKhTAOooBLa6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3670972"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3670972"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 01:10:10 -0800
X-CSE-ConnectionGUID: tlZpRHiBS+aXWcsPbb+xmQ==
X-CSE-MsgGUID: jbkmIQg6T66Ue82Q+gFK6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="10048977"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 17 Nov 2026 01:10:08 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id B7AB499; Tue, 17 Nov 2026 10:10:07 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Kurt Borja <kuurtb@gmail.com>,
	linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: light: opt4060: Remove dead code
Date: Tue, 17 Nov 2026 10:10:06 +0100
Message-ID: <20261117091006.1452131-1-andriy.shevchenko@linux.intel.com>
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

The struct opt4060_channel_factor data type was never used. Remove it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/light/opt4060.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index 8253a6a8bee4..3413b1c64d01 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -145,11 +145,6 @@ struct opt4060_chip {
 	bool thresh_event_hi_active;
 };
 
-struct opt4060_channel_factor {
-	u32 mul;
-	u32 div;
-};
-
 static const int opt4060_int_time_available[][2] = {
 	{ 0,    600 },
 	{ 0,   1000 },
-- 
2.50.1

