Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795520439;
	b=nc6NFQGofbKbRUlCL1RNV5/ZN6WhosqZ4fkubcCvNptydY2tqgBVWpGxo6RovRfP941N
	 Vr9k50JXTe7N59XV+6LWivFywwxX2iutEwb9bxYrRjZ4zVJs8RTTg0jZV+vK6rYvMUH38
	 +LuSr2HsJVUCqHAU5ZlsvXbjBFXHd9Vr/AXNMN+NPc0eub9i6+rVujmW+XCZMw7pZhukY
	 WWuF2nzMy0AuNNyxDu5HMMr8L1im5hnjs7WOb/FP22zzqGv4j4IHiyt4+W0Ku11vrE2wV
	 ygDRaOcnvp5xu7PyLkf/S3hU+5KGdpuBqzLPwSkpyFmmV/XpeF1TVRd4+36aD5Q52zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795520439;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JWnXXrVLja2UtmmpTmK6EUX+v4o716Bau3tx9gf4ZU0=;
	b=PB0OWdodV26gVvsleqBg4GVjuJeEOAwy2rX9QNiNfDRJrONBDe0nnpg+czN4TbaZ0kqL
	 oGrhST4tkZ1VE1FFF+Gu3PBAxhfIS3nsXwwj2ThUXTF3DcP6qeo0/azXjPNUimVYCNuAi
	 GpjX6NXbeFqLX/QWQkXZlkdZ9VP3SJfp4zEH6fOPl3BZwUjnSoE0ydLWUDzdURsnDXHq5
	 KCcH2Yn/X3C5j8Ca539ykxDefjto/XFmpdwsgXJY8QNNUb+T1f1rjvM2JhBDlIfffQE40
	 lCqqw6QRfu9G44ONch1vEqDCLrCmIRDD49n1aREKBffXy+RC14ufBjab97C4dakAwlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EmgpZvjT;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F684606A31E
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 11:40:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F684606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EmgpZvjT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795520438; x=1827056438;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fNNJhRRZju3FsS5uiXltzr3JglFfek64F6EntRbuq8k=;
  b=EmgpZvjT659FjNma20qC0G4MRlkPbW+ceGPSMxi/LcKIBU1fy3VWFZy5
   zge0a9Mnu9jLfb0InyVf46CgaHOaYWLuoqEim+l5+KsnoreDvmkIS2gpN
   KNqLY9+fqSonAFketr/HhWZq5w6obNrFmV62Qmub3JTy3F2ekdVQqyN+u
   iFc6PRuvZuIYstL9x5PR/3cX6XBsgDnhp6pLiAMhXm2W6IeR9GZFBJ1+z
   x/SfZtD6mwoNIXaxGqsB02PoSD3BWOh/eDoVTtYnnCowJhOPoWC53PfUs
   tACz9XchVbWkr8K/RM3fwl5qsV0jAlu55Rlu2lRIFwgP26OT9exSVmoTE
   A==;
X-CSE-ConnectionGUID: CES6qIaZQBGN1fTtdwTHFw==
X-CSE-MsgGUID: b0oM7JltSp6nwdhdbOpXuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4248514"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4248514"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 02:42:50 -0800
X-CSE-ConnectionGUID: yxI2bE9sQmG5yPlxM4WHhA==
X-CSE-MsgGUID: 8eWgHd9PSu+JgKA6BVDdhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="11318985"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 24 Nov 2026 02:39:49 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id AFDB29D; Tue, 24 Nov 2026 11:39:47 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] iio: core: Use an API instead of relying on a specific error code
Date: Tue, 24 Nov 2026 11:38:41 +0100
Message-ID: <20261124103842.600399-1-andriy.shevchenko@linux.intel.com>
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

Use device_property_present() instead of relying on a specific error code
when parsing mount matrix to reliably detect absence of a property.

No functional changes intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/industrialio-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 3b66d7b765d5..5f9d6e852286 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -567,6 +567,10 @@ int iio_read_mount_matrix(struct device *dev, struct iio_mount_matrix *matrix)
 	size_t len = ARRAY_SIZE(iio_mount_idmatrix.rotation);
 	int err;
 
+	if (!device_property_present(dev, "mount-matrix"))
+		/* Matrix was not declared at all: fallback to identity. */
+		return iio_setup_mount_idmatrix(dev, matrix);
+
 	err = device_property_read_string_array(dev, "mount-matrix", matrix->rotation, len);
 	if (err == len)
 		return 0;
@@ -575,12 +579,8 @@ int iio_read_mount_matrix(struct device *dev, struct iio_mount_matrix *matrix)
 		/* Invalid number of matrix entries. */
 		return -EINVAL;
 
-	if (err != -EINVAL)
-		/* Invalid matrix declaration format. */
-		return err;
-
-	/* Matrix was not declared at all: fallback to identity. */
-	return iio_setup_mount_idmatrix(dev, matrix);
+	/* Invalid matrix declaration format. */
+	return err;
 }
 EXPORT_SYMBOL(iio_read_mount_matrix);
 
-- 
2.50.1

