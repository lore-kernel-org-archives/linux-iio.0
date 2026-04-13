Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A37A3B27D7
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 09:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073503; cv=none; b=cJxtzEiAhDSOWgn5ZM8Pst+I2vinI1ARMJiXrktPz7uE+mHYletVyZaJ4HTLF7NkuJN6H3eI3U4Suwr9CyqSaOwVebXgnNC93+KG5Z2kOWhPdE8xJxYOqY0Jt5G/g9ztPsdDl2MmsYZ68CF1jrUcrGPWpzSmPRaBc9vmoKuDvj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073503; c=relaxed/simple;
	bh=2EAhbEunbnWx1STmqHGbdEe3uOxnWZWtoXBQNQ+eexs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q53ycfYAZ90hgtLSOCM7Q21RK/X/Y2k4H225Mtsr0BR9CaT13wsLFiEHQNjNN9L+2xTyH4an0H6m8Jd8yc1GXLo/25J66Pfgh7mjrNZTaG321JNp1/zqdycgBnPyOf2kEtu8kz8J4vIEgoKC3pyhkmNT1jnjYAbQlljiLjhOKKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jTioXLQc; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTioXLQc"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35fb0bb27e7so632657a91.1
        for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 02:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776073501; x=1776678301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbmBkzDiWaveSAX2sdx9ysFjfKAEklV0Y/mejTh5y64=;
        b=jTioXLQcZaJneyfY7nNwaHzBWJ8MMHFnks2muO0pfLCr1vAlrKe4oj0S4CoMY8M1c9
         mORuN7ChD8RirsU5BXK22U4lsm73PGLaX19c5Vp0qKJfsbb4GATcBXJ86YPn9V1zquYE
         UjC4BCKPa2C/Sp0YiVw/Iok7u3rkETaDDefezberai48egYP/aeroBWYSGr2Lj/nTmqI
         fhF/nzeEQdeEfSx6QVQDkqFAQ4YKBMM36E70HH6/a3yQX1bg38wgQCIA4m1c77NuORd5
         d2t9M6l0jCWppgq9AFvPCzemQ668VBYWfqAg0fcTFf12cLojCwAhbP8OkMAhpx8VYIVi
         zRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776073501; x=1776678301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wbmBkzDiWaveSAX2sdx9ysFjfKAEklV0Y/mejTh5y64=;
        b=Jd3mE58yJmH2ALxmLy0/1AqEHdcTVQ1n8c4rb2hILV6zZN9njonhGi3G3UhCbJ14Oo
         SpkYeT6BDd3fwFCLEi4GKZvYOC9rskYVDhc9HEjUOBBfGd1YW+xNDfQKN2TmDFdg+3Rb
         HcGogSejq/B7zS0vyDj21LiNC6glIlgWXkX0P1B7xlzcgz2m/7nhl4lA1xhqi6JfymS0
         6a27IxzIllei7T19WWeX8oLlAZMPmj1HkzEjlz9POTYu0SudV3LfL7VaGUMDvre+0vFJ
         gEjgBR8pNHM7OVF9oJSc5D9Rcp/6QZxMYek3fFZvn/07JagF+RYUHsUQ3SDebXYjQjdU
         DYUQ==
X-Gm-Message-State: AOJu0YzU9m+0B2ZDvjojZAWx90DotCfK2CR4IOG+C7NT6/oVZlNGddls
	agAqcvD5t8zn4Y/Cxq4jl2RZMEUkv7JneROWXocjnvFySwHpv5wtQrqYbzkbGVY=
X-Gm-Gg: AeBDiesGrgbQT6rdmmGLRlxyAfA4VtzL1A1SJb59YJXgTixuDMjgkMMHRcVFub/dKf+
	0CjxjJtm7dUipouu5z+3ngTKtiCzzdwTMPwJPcZuBaMc2rFfPnPJBQgdeN8+iHC/bg2BWLDKJhS
	7LHYukxskuKVCtG/bJQ7NFF4e4FL7EMrqY0CP1QkVOtP9cDs5dpp+CUEM2iB2clTgusefcxTfMI
	hJvGf/kgSitF3VLHKR9ZrXSVpM+zqwTvR2NJcV5kP1ydqPGZPmnHPyi80O3SKRYP+UHis6rtm7i
	iRi0dQo8Nd7pTpvFurz5Kj0aQQ4Gpt+n3sZfQh/hv2skSokW6uGx/Dx87kZPpZxUb7+Rd5cmVQA
	L10gn3MV+zWT0UheiqwbkhmXUWnZJsCYPl+2KWWyX20Xlvdm96SsfC8i1WRLSv6BRqdZE3M+Df2
	7xMrk/YIswLgVZ7Icxtzw2ktER0yx/Yz4P1yIi/RDrw3nNjwtgPgkFj4wTNEh8mZJU6afsemQiw
	B4R+MPWjJNKTtrqaEtAtxhGwbqb6ykJ3O+NSojVFQI2HJb5gfSJ/CUvKM67EGO47BA=
X-Received: by 2002:a17:90b:4a04:b0:35e:3afb:a3ff with SMTP id 98e67ed59e1d1-35e42541708mr12930494a91.3.1776073501450;
        Mon, 13 Apr 2026 02:45:01 -0700 (PDT)
Received: from nik.wlan.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e42db1b51sm4832562a91.3.2026.04.13.02.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 02:45:00 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v4 1/3] iio: dac: mcp4821: fix spelling mistake in enum name
Date: Mon, 13 Apr 2026 15:14:47 +0530
Message-ID: <20260413094449.18837-2-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413094449.18837-1-nikhilgtr@gmail.com>
References: <20260413094449.18837-1-nikhilgtr@gmail.com>
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

