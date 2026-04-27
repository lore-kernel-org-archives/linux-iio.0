Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C365636AB5E;
	Mon, 27 Apr 2026 20:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777320868; cv=none; b=dd14XPFFDeeDBLMzXpexjzqtecj4saN3XI1hXhWhZ2ugaOSP6G0ZM6JThyjp3i7SNJ8chuGG2IGLkxNrQztroIyA7795PSnv8tZd0sSM4buzy1SoS/ZSQGclIso7Iiy4zMYVsPy7Ua3p+vlQ73iQckONrUHnrNKn7nYK/YVoOtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777320868; c=relaxed/simple;
	bh=Q7qtNXag6aWKfMJ6Hbb92WsBS/EGMi9QSTNvOE5ITFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3bjFXxEw0V57FQ+i2Qs1RVPENLbJeNCr72Zls6Q+LkSvtbuNZymgjVlqCKlJIOgcmO4E30843omcQnnIwMYvskqorF1fl+2yNgaZH1yM604EQ1G30J6i6iRjCy1FPhDVloEoVMgnVS7EKtEU4Nbt9u3KvXvvrzlf8VHx8/D6S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ceH6isge; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ceH6isge"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777320867; x=1808856867;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Q7qtNXag6aWKfMJ6Hbb92WsBS/EGMi9QSTNvOE5ITFA=;
  b=ceH6isgeQOXXq8G8ymJwTLbXUSbB+7BnKoBVzY3vUWo/SGEAJxwfUFxo
   L7fbVqZ4y2MWTgoOgbsm+5A0Juq+H2FF5qqdEIqXo0pYvDO1K7f7T3jUT
   KTuNunH9RbBIb6Dvh6cVxvqfuMnsr0KRNltdbqXVEiFFSgJ873B8E2XN0
   sYd5as+R+ZXFHM4zL9Sd54Vhyix46pmSOcUi5JKWvnuyiRfj8M4d2d0pp
   NSJSirG9SaFId9koMeJFBCXOTfry12eaS5mgq9sljocSgjN9tunEzCmnK
   KtQIhbIRosm0qNOK9NWJBFsQXdSJBEaepUwVWs8pfq3nU2SKKLvvyJxyQ
   Q==;
X-CSE-ConnectionGUID: rlkmBr/KRji+Gdtu4jI8ZA==
X-CSE-MsgGUID: sI+ZnEY4THyrZ7GEepWDIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="77384084"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="77384084"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 13:14:20 -0700
X-CSE-ConnectionGUID: urlWibbWSwCuhwkpBlm81A==
X-CSE-MsgGUID: FbMHmlN8QA2f0/7Zp+7bZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="232857720"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa010.jf.intel.com with ESMTP; 27 Apr 2026 13:14:19 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4F42499; Mon, 27 Apr 2026 22:14:17 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v0 02/14] drivers/iio/magnetometer/ak8975.c: fixup for the errno fix
Date: Mon, 27 Apr 2026 22:09:47 +0200
Message-ID: <20260427201412.3067235-3-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/magnetometer/ak8975.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
index 378940e82550..833ee7ca9f46 100644
--- a/drivers/iio/magnetometer/ak8975.c
+++ b/drivers/iio/magnetometer/ak8975.c
@@ -693,7 +693,7 @@ static int wait_conversion_complete_polled(struct ak8975_data *data)
 	return val;
 }
 
-/* Returns 0 if the end of conversion interrupt occurred or -ETIME otherwise */
+/* Returns 0 if the end of conversion interrupt occurred or -ETIMEDOUT otherwise */
 static int wait_conversion_complete_interrupt(struct ak8975_data *data)
 {
 	int ret;
@@ -703,7 +703,7 @@ static int wait_conversion_complete_interrupt(struct ak8975_data *data)
 				 AK8975_DATA_READY_TIMEOUT);
 	clear_bit(0, &data->flags);
 
-	return ret > 0 ? 0 : -ETIME;
+	return ret > 0 ? 0 : -ETIMEDOUT;
 }
 
 static int ak8975_start_read_axis(struct ak8975_data *data,
-- 
2.50.1

