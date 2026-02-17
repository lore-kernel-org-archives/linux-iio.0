Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C095C2D0602;
	Tue, 17 Feb 2026 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323808; cv=none; b=ZVQIKUCprcLH1T1MJt/Co2xOg8sLRue4z4WF0UolHk1CcvMnO60C1WU9Po2nDsiJmxTQZ19TP1ZBwnp8Cnv12r4UPRiQGaNVnjOXiTlH1CGvw+HUL1SP0uzhV310xmG8/IUCd54QhVzPcRwpDTpI6mtbOnEk7r14vOwL1IsBiDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323808; c=relaxed/simple;
	bh=wtL6AOYbYZoJZtN2QlCWZT5/5nnfysLjemg9rJ+7HBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dHR/cQUP7ZNQmw8fEM5ea0SGNGV43VTla0j3tHe2cfzsMGn8nAV12G+JINL6/m7CzxiZ8LuZRo38CiJezfrT39zeid7Dyo4Vhxwev7dOCzbIxSEaosZe8gzzz+DG3wWVX/BO+H8IcxpZd07OALR3Y21M4khdoWy+bnTjBrXe71o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MlYMfYDz; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MlYMfYDz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771323806; x=1802859806;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wtL6AOYbYZoJZtN2QlCWZT5/5nnfysLjemg9rJ+7HBA=;
  b=MlYMfYDzdQJ2aC8WrMWPWgLMKDWLwAmfd0ixw6gRM/YlLzZS4Vejj9mq
   eEgHa8Z/F1FRl7YP/bf8Rw7esUZCAmGbTnPeRg1/zhzgPwSe2YQ4NLFMi
   yBSGxwFpLjmNJVpgpovzYmkPqs0MlpNQ7cWsVhANULnDblA5LKoBcZVW1
   vhTldB0j9rOf/tWViHNDCUjGJHCjgAMFOK6ofrFCRBVEWwZcpuldImzH4
   v2PRa5x3T4kXDd3NV+CqxfPkYJpyOpY7pGUwvEBehC2cDYDy9OZq9ie/J
   ZwAtbdNHM8qvZJT8sDz8UDMrvMYBxWKdlHyy5KdvPB17Ivkd+Wfy+njVM
   A==;
X-CSE-ConnectionGUID: RCUC1nfUSkGWG6o9EqgRbg==
X-CSE-MsgGUID: /+ONNSvcQs2/XxOfbhREOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="83826976"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="83826976"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 02:23:26 -0800
X-CSE-ConnectionGUID: zdiWK4nCTJatYb59pzCFnQ==
X-CSE-MsgGUID: ATfgaJlmSvebG/a2k5hYig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="213943858"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 17 Feb 2026 02:23:25 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 512A398; Tue, 17 Feb 2026 11:23:23 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH v1 0/7] iio: light: gp2ap020a00f: Set of ad-hoc cleanups
Date: Tue, 17 Feb 2026 11:15:10 +0100
Message-ID: <20260217102318.1354103-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While reviewing the series from Ethan, I looked at the code of the driver
and found a lot of room to improve. Also there are some questions about
how driver was tested initially.

The third patch reveals the strange asymmetry (and I believe a few bugs)
in the state machine with commands where some clear_bit() and set_bit()
are being called in the error cases as well. This needs a serious audit
of the driver algorithm for which I don't have time, nor possess the HW.

The fourth patch moves error check in one case into the loop, and hence
I think fixes a preexisted bug. Perhaps this needs to be added to the commit
message and/or split to a separate change.

The rest of the patches do not affect functional behaviour. It might be that
the first one needs more thorough review.

Note, this series is not tested at all and I rely on Ethan to make necessary
compilation tests and rebase again, as it's based on his series and includes
something that has to be initially in his patches.

Andy Shevchenko (7):
  iio: light: gp2ap020a00f: Use correct types for 16-bit LE data
  iio: light: gp2ap020a00f: Replace custom implementation of min()
  iio: light: gp2ap020a00f: Return directly from the switch cases
  iio: light: gp2ap020a00f: Use temporary variable for struct device
  iio: light: gp2ap020a00f: Explicitly use string literal for driver
    name
  iio: light: gp2ap020a00f: Remove trailing comma in termination entry
  iio: light: gp2ap020a00f: Join some lines of code to be a single line

 drivers/iio/light/gp2ap020a00f.c | 210 +++++++++++++------------------
 1 file changed, 84 insertions(+), 126 deletions(-)

-- 
2.50.1

