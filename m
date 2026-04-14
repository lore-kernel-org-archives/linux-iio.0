Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53E7237713
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776158586; cv=none; b=iiABAL3J8j+YuEqGG4mERd4kDkFbwS5N7THIgTfmR2ldHnd/ELaByuk6+T++vJg0w7zgJStlbnfB1CbYEwYwIjWINvVksL+5DVtXhBKB/oDM87YJjpP4yv5wfenVdpVrXPRnbaOb1Vi5sMeZnLFRNGN/AMPHybbMagHp9LYFvk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776158586; c=relaxed/simple;
	bh=2EAhbEunbnWx1STmqHGbdEe3uOxnWZWtoXBQNQ+eexs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHAjv1z0QdNyvVnBLDQg02CfS2cQGGASIGL/HZHqRHxThy9Po3JiK3i3+2LVGWY+xsufQhYsqzk3TX/H/H4PSfLavTHn3Lqn3nomQ4k2dPQCbtbbvmy2wgaxfEwyBogghuF27sGLAq0L+O4kpCPHo50veigPZt1WYelmPMf2iN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PT2mZ/P8; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT2mZ/P8"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35da9c0c007so4772855a91.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 02:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776158584; x=1776763384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbmBkzDiWaveSAX2sdx9ysFjfKAEklV0Y/mejTh5y64=;
        b=PT2mZ/P8MJ4UIyHd+T2fInQjAkXmBRbJjQS4CjH5M/HkFqq9ug5xwU26ENtoiErByC
         9Kkt0DR+GyfeJ3Cg4WKGUJzJ1Dfoog4ihwzLgVytUvID5M9DWtXqGmBwF22AC8iE258v
         itEc2yevrfkIJlT5i0IVALAK/8I8nZr+INxbc04q+ybwROV7UxJvy1qvF9t+Mt56+Wqc
         7xyRPCzE47V3tGhn/FChYI7pV3L7mQ5Buyx5cBERLQJeHNHlSO3eUFYqNu0su7xL68DH
         jcTR6p6Jp+aAuz0wAPzEBjEsaRwFFQQSgl8OFpZAUjUDv6azxo9UbPDXdIdaoAkTBon+
         oQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776158584; x=1776763384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wbmBkzDiWaveSAX2sdx9ysFjfKAEklV0Y/mejTh5y64=;
        b=TeNgB+oqudUcH/uDLLFQ6+U3+2HS8rw5ZvZJv6nO3iir0p6faF4JD3elmViwi4+uvc
         Qh9rU33zmZu6W3SuJhFuXIhH8fUbsVio33WiBYfd4GCpEk3a90QNMXWFBlBboToX07PM
         5Ppaz4c7IYUN15mnDT4v09n946QDxiwQ42+djEoUWHu/lIcLYpABvv775h40uDoVZtvc
         E8ctg4R6V7An0ZNxbQKAF41T4iZkA+v2RF6QblPYCcAezQYU+7HPeOptz1gdSa6khxAo
         9IQtNgejTebq1B6eNv1uaDH5EgfEWOeCBtOgSIZ3BE9I3JhOVeeVuduWKkBqmKiKqfZD
         XNUw==
X-Gm-Message-State: AOJu0YyoDEwJWqropend/CpPU7L1UOHgJ2XoeZ4XGIb56qPTDMkxv62K
	HLEirOdqLfGhvS6mMymsc9vzDhU7CwGQbHFHt/8/QVZgG7Rr33vMDVAzdMwE5m8=
X-Gm-Gg: AeBDieu+BeqOemz8lCd7IF+yNpIi26sAsOCupk27Z1olPQeaqvXpZ5za/EzchZysDF/
	zv+qM1U0upgb7kmWzFgHS0Ly0D4rWJfPkCtHQB53GZ5VZOq90ivoGzsuX/xn6VWRuhBGZkLj+XM
	6IluzGNZ4rxhwI6Wnze8Rhm9lxc9FYqi5LBhZHtnb8kbcdBg9HGbvgQSWzv1pb5x5XFmsQ6uDwG
	/g5QzPmJMsfGBCgsbN3iMoSBGgllLXyujrbGpSXf0BVKiYCFJbYV1ukMLVj5ZJuDfY1bMg+B7BQ
	MlXo7Un+FwtznzuH1Qx6DWeIjsh8n0iZwilgZO3ztrDNzk0QRNTS3haJyFq0McgDYDJftdgLDP2
	JFGB/OmQhPQPsInydFvCocYbrpRe9yiWgAh1jlNCzr0pYBLAxkWzwBDGI1+1ccpsNJN9kVlEYty
	AAjRIK3UbOHmW1Qmy0q8j0y4XfYvuz2TIQEaaCyNfvGC0DEpfMXxThuXl3WIiCVRCMLWuA6YMxv
	zjIJsTtPyyK7MphTN0VJtT/kS/QusP1+YP9eTC9bjOAQAtaQXXTxzayCMOdXXu5CsE=
X-Received: by 2002:a17:90b:4c0c:b0:35f:b306:5d47 with SMTP id 98e67ed59e1d1-35fb306602emr8283744a91.1.1776158583775;
        Tue, 14 Apr 2026 02:23:03 -0700 (PDT)
Received: from nik.wlan.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35fc6e75c38sm1448991a91.11.2026.04.14.02.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:23:03 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v5 1/3] iio: dac: mcp4821: fix spelling mistake in enum name
Date: Tue, 14 Apr 2026 14:52:51 +0530
Message-ID: <20260414092254.34883-2-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414092254.34883-1-nikhilgtr@gmail.com>
References: <20260414092254.34883-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in the enum name mcp4821_supported_drvice_ids
by renaming it to mcp4821_supported_device_ids.

This improves code readability and consistency.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/dac/mcp4821.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
index 748bdca9a964..29187f2a9d3c 100644
--- a/drivers/iio/dac/mcp4821.c
+++ b/drivers/iio/dac/mcp4821.c
@@ -31,7 +31,7 @@
 /* DAC uses an internal Voltage reference of 4.096V at a gain of 2x */
 #define MCP4821_2X_GAIN_VREF_MV 4096
 
-enum mcp4821_supported_drvice_ids {
+enum mcp4821_supported_device_ids {
 	ID_MCP4801,
 	ID_MCP4802,
 	ID_MCP4811,
-- 
2.43.0

