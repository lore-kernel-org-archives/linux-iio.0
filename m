Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795781003;
	b=cbxRXD8kg0p+SxEYNJQckhvbTK65bDD/6KHqIMfXBI+rRBtOEwt7oaXY7uyKTwkAcqHy
	 nOwbCttfZECmwCphVV4Rf5MIjsA81RyEYCzxopf34Uq9b5AmIJsDI4iADPO2ijOkFmoH5
	 pxYsLZjaiPNO8niZezrSSlON+NJgjhCsIbJ9WX91ZYJYRDRDidtyPmZI5WQQdeopa494l
	 otNF+c/lL9L63gq7IlauVE9sXdQxcc9HAeJMCgFqDmgjfSKeXlyexawZWMZd3gAMukkx4
	 d6Efrr7fCt25k5lic/rQhVXlEXtQaNbc3PzV3Su1WKEGxG4ue7HiPIB4kP2aVgygPQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781003;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9/nDijksJw6KALaGGlf/a5/JRLLpSspkdN/yseFIqKg=;
	b=Pv6vczhYnsM7xPSrzTBToNfpNaXpzQZjNMk3NSc6x0YBAKvKUdG0GA8suWieTIVqhHd0
	 ETBvGF51sMwlBx28b9l6fNnl6CMD8PYTeF11Z7N4FhkjdN9l05e5gcY2cU57ZVqMCUOm3
	 7FATwM+I1zA0nao0BBEBLb/VEoVT8Fi9WpgZpzc4RvqNSkB4Q/bqB9Krj8pub2NOrnwgB
	 E1Dr2ACm9nrYkOkdbaaQ2+OeLD5QxIkG4Rg1qvfEng7XPVG6fsFC+27/Qs1lJOFgFGj3S
	 1Z3eQyc9VDjBin+KRy0MTTJjW3tOzN/AvXMLA+YO+gpYEjC5CgrPQAFBt87ImuuT/6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OeF3d7iV;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F963606A31C
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 12:03:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F963606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OeF3d7iV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795781004; x=1827317004;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+lgXlY3RlJxL8P245yDUCcSF5YzarXBnZ11VcrutGPQ=;
  b=OeF3d7iV3uqaa0zI/NqiOM2+Zj58MMH+z55R68Fi5wFjq5Vs5CiRsav7
   1leMgzXufWSbqfxtsQ6fu5YAE3ABe924Ydaal8LHaOc/zQJtbYfnzA6kp
   bViAnT5Q9l72C2NDP2uXY59E3iBAmAdOSF4TjupsAuYM0fZmZZpCZv7a7
   uwiQvrvV4WqoW11Cbu5c2bFO78ksyUm0lBtbwAocqZtM5uQILfxXxrLxi
   bGTMsGjQorZoD906bwtFxun8m2aHXUWBFF28UkL2rhoLsqxJqaKrKiVeC
   7nrvT+MsWgcLckKhND78V/J6HuRPE44CvzLifUojUDLNJq0vLbaEHc+KL
   Q==;
X-CSE-ConnectionGUID: NG2TVuJgTg+/67xcL+OJoA==
X-CSE-MsgGUID: Oyv1A+kYRpmoz4dSr4D+Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4598759"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4598759"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 04:03:23 -0800
X-CSE-ConnectionGUID: Tpsr4Tv9Rse195y3JkXaeQ==
X-CSE-MsgGUID: 1sds60n3SjCPZBFzDkT3KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="14403746"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa013.fm.intel.com with ESMTP; 27 Nov 2026 04:03:20 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 47B1798; Fri, 27 Nov 2026 13:03:19 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: common: ssp_sensors: Use __packed instead of __packed__
Date: Fri, 27 Nov 2026 12:58:52 +0100
Message-ID: <20261127115852.1720736-1-andriy.shevchenko@linux.intel.com>
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

Sparse can't recognise __packed__ attribute:

  .../ssp_sensors/ssp_dev.c:30:3: warning: symbol '__packed__' was not declared. Should it be static?

Use __packed instead of __packed__ to make sparse happy

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/common/ssp_sensors/ssp_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index 40b658d39294..456d59dc53dd 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -27,7 +27,7 @@ struct ssp_instruction {
 	__le32 a;
 	__le32 b;
 	u8 c;
-} __packed__;
+} __packed;
 
 static const u8 ssp_magnitude_table[] = {110, 85, 171, 71, 203, 195, 0, 67,
 	208, 56, 175, 244, 206, 213, 0, 92, 250, 0, 55, 48, 189, 252, 171,
-- 
2.50.1

