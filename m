Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CEB3E316B;
	Wed,  6 May 2026 08:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778056081; cv=none; b=WjLXtuhq7t6ba9QTjDKiRgEilIdIiSRptLeIyY/KY6wJ3HJ6f5O1h0xpX36TRfrrkoGR8TkHO1GNlJghb9mM1HDK9tDkNhzFB2xDvOBN6+f0tpneAR97AToTfcXV8KQXKPUE+ez1FOMwfxNxTnNGOAGxWdaCO9DbfQEqiYN49fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778056081; c=relaxed/simple;
	bh=uPbCF9oMOccJ3rSBfBu7YKak8zO7f9HMERS/MHhbomA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fDjVZdgZniFqc05rbRoda71cTdXuPoNdAGd9DCCo3csiId3Pcflq6FstNqRM8frEtcMqILE9KxSyuuikhAq9mTREiTi7QT1tvHvf0ynXw+2mLlDanCEcLZnj5yNS2U6aR0cD9bBzLwJQ1X3JCLEqPY+c8FyTx/ZjLbCWBYNliR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lszoH7aB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lszoH7aB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778056080; x=1809592080;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uPbCF9oMOccJ3rSBfBu7YKak8zO7f9HMERS/MHhbomA=;
  b=lszoH7aBuHSE3D1fiAKLy2oX0EJKpHndWGLpWKANygE69nspCDmSvGqc
   fyti1790g4qvhKDTrjCs5zP0gfHllaQ4bp9W/Fh9B7xdkO00B63eiFHUX
   ViggWWbSHGJPIA45jWdmHmno7LwJdqMP4nEKJxPHvW8E8JWiBViVexX6R
   7WeqOOn8OIISVMhB+ben92QosPfjp1WU1b2uy/jN1k95fzpHoenAJ8ObA
   OwCrX0j7lLOTgmuS3SGHVpri512gGi9R7RSlDfv9zRS56Q3iy364adwSm
   5yM5sy2dFSmrVVIfIJrShqu+VrATGM4WPzuPO31Qgz6K9wspIFzeUAzUl
   A==;
X-CSE-ConnectionGUID: YruYDiE3T/qBgs5adgqgBA==
X-CSE-MsgGUID: jPtyX2jQRJq2n7HqmfAeMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="79026972"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="79026972"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 01:27:59 -0700
X-CSE-ConnectionGUID: p1XjNcAuTLmn8omyCTDgEw==
X-CSE-MsgGUID: 8CtrP3YhRzWnIHYp1bORtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="231700197"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa010.fm.intel.com with ESMTP; 06 May 2026 01:27:58 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 87BCE95; Wed, 06 May 2026 10:27:56 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>,
	joshua.crofts1@gmail.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v1 1/1] iio: magnetometer: ak8975: Add missed pm_runtime_put_autosuspend() call
Date: Wed,  6 May 2026 10:27:55 +0200
Message-ID: <20260506082755.860523-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the failure in the ak8975_read_axis() the PM runtime gets unbalanced.
Balance it by calling pm_runtime_put_autosuspend() on error path as well.

Fixes: cde4cb5dd422 ("iio: magn: ak8975: deploy runtime and system PM")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260505-magnetometer-fixes-v5-0-831b9b5550fc%40gmail.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/magnetometer/ak8975.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index b648b0afa573..b3468756bdf1 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -784,6 +784,7 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
 
 exit:
 	mutex_unlock(&data->lock);
+	pm_runtime_put_autosuspend(&data->client->dev);
 	dev_err(&client->dev, "Error in reading axis\n");
 	return ret;
 }
-- 
2.50.1

