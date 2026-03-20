Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D336E46E
	for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774045476; cv=none; b=oJC0fFoJX3VrMRhmHLAq3jMbbh05O05vjb9jcbZycimOH7dnoelXJq/Oi5jpQ96NdcHSxFnbuk417vn2GYG1vo8G5DD7vXi54xtJ01HFtOjQVZIFDnBejMpEYRdvV8XJGedxd/7TgxvqDFIVLS1XzrnbgMsY0cGjfXjiuVuFJtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774045476; c=relaxed/simple;
	bh=24s4xN6YFjoYXIk8uTUy5ywo7jxmwS+0fXPQrONB34k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CqbQChsblnvWShZQjgIuKjLBAZsJDPMNgaVyFMeFWujDnn/Jz28u+PVPpzBgcyStfDA4uFe6bVU4OrGKXzyiSUITXFzuHgj0NQE9u0mqxPwZTBT5Dh5lclFXOXEJhED8R8WhZJspbvwVDGoIjjg6p5mWV5DR6kDUu4yJaHcwDh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pv4HZlku; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pv4HZlku"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso19818555e9.3
        for <linux-iio@vger.kernel.org>; Fri, 20 Mar 2026 15:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774045473; x=1774650273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=besVw0Q61aUOkSVGtpMPG9G/0SuwwqrtJ6yLz21HoDQ=;
        b=Pv4HZlkuZAqIfT7F7q4jLO7WFVpiFwAMptuvNHtlDE7+WNZsd8Dt5IzHbqSiSbJ2QS
         CNy1Ck+QbbP/MXzPtA/7DuxMa+AhgTMl3DeKNKokHaHseWhP0klAOYnQtB/1SfzIJrT/
         3WaAV9qUL/AV6vWvvXFdcOVfcyBx6Wl7vGFVRtL/j46Aaw3Wgf5LziUeZXBbnYtw3IbL
         jEij2n5cuw+TUa20xF+OrLYQ5gxOVp9HYY94xsg9Wqi/mXPElcCO7hLcBUb1/Y+UC3LF
         CyqtVHv2rJ0L0VJYRPNfxmaeqvrDvzimobVdJGuyjI7nmZYSCCo0ZsriLCntLWD/AFes
         Jz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774045473; x=1774650273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=besVw0Q61aUOkSVGtpMPG9G/0SuwwqrtJ6yLz21HoDQ=;
        b=KkuUKUmudlupRY0DN1tq+X70bDM4CVxHZerIDAc/0cV+WKWizU8Y/kVPjjR3g3KmRW
         e6qkkiSalcaqqGTt98BiJFsXbZsz0iSgwmciKAcXeOBfzXok7a/BPkeibWEbrbgD/1iS
         DP35HhgXCUPciwcGxrzZZIR5C/kjTIapfhVlmGTzfXopi/dfCihbaGrs3Xw64Uhhh/G6
         UBWB0Sk/+GkWotnM92+GT+9BZ776hk0qOpi33gVk+5+pqkl56krZcuVtIrMDVt5ZLvTA
         eGlwexBT3ujqotsMCgYBo3AoWBetn3lHC9f/zIkGDMIJiuaudcO6VGTF9OLf87LDC+ec
         Y1xg==
X-Forwarded-Encrypted: i=1; AJvYcCVDLVeWZTSsW3S17kjJNM+7lTkDg+L7y5jj6eQ5XVvyBXFFIi1g7Bmg4zCrmucvNTYiMs3NLna2KQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAQN67CgXxx4eYKxclT/e3OBqrs7LFOG/4nXT4JmllifRsCBnX
	DV40esOfqYQSWRVie0jEu5rnGZjrhHluC5jZRvrnOwrxCgVERv+oDfE9
X-Gm-Gg: ATEYQzwlgVQRRfORYC3pUX/GEwnzVfXRiVOaEJeRSZtZn4sxKLKG5wSAkVU3UnaGmwA
	yM3SxwPI1A8xusqRHHUnZytwvo3yl6F1gXmfw1Pmm6KT2P272Ff17L6z/PL9A8yRpkpkTCXWGPD
	PmY24pOkha8Cnm6WKMtlH6mUMBs2wm2gXIM5OKOTacq9TkbpFvVDYrt4MBg1Ogri4AWsL+H5Ofb
	1c53Ms+oMc+TOoNxRFOyvuHFQf8KKdQm+0TVyZMWi7VHBgP70vBevBJA5rc5va6FoG1xH5QrJIv
	mk3dHVozOnCcTfKkoX8tNj8/JxGhSixQ+mzIIbnSsgRcy1hAu8R+sb6Z8U/46zEU7qDg+3eugwa
	Vtq3yF4bxxsmIHoVsgI67SKPTm7zt65tKVYmO47VY9rG1/FwuSrxyT/sfbqUtXdV5cbNDfBpuQP
	nV9SAPq9g9zt8yCdm8jCHHycC+Z3M8gf6ysMK07SKZ7cs/N3oF8/MWfczs9A==
X-Received: by 2002:a05:600c:4e8e:b0:483:c35d:3659 with SMTP id 5b1f17b1804b1-486fee04a48mr64997975e9.18.1774045472933;
        Fri, 20 Mar 2026 15:24:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:8a0:6c9b:a000:bc11:6b0a:79ed:3d9f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae016sm9290237f8f.4.2026.03.20.15.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 15:24:32 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: andriy.shevchenko@intel.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] staging: iio: ad9834: use sysfs_emit() and simplify show functions
Date: Fri, 20 Mar 2026 22:24:24 +0000
Message-Id: <20260320222424.53294-4-grondon@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260320222424.53294-1-grondon@gmail.com>
References: <20260319225719.73587-1-grondon@gmail.com>
 <20260320222424.53294-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sprintf() with sysfs_emit() in sysfs attribute show functions.
sysfs_emit() is the preferred API for sysfs callbacks as it is aware
of the PAGE_SIZE buffer limit.

Also simplify the wavetype_available show functions by removing
the intermediate string variable and returning directly from each
branch.

Signed-off-by: Gabriel Rondon <grondon@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index d339d5e8e..bdb2580e2 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -281,16 +281,12 @@ ssize_t ad9834_show_out0_wavetype_available(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad9834_state *st = iio_priv(indio_dev);
-	char *str;
 
 	if (st->devid == ID_AD9833 || st->devid == ID_AD9837)
-		str = "sine triangle square";
-	else if (st->control & AD9834_OPBITEN)
-		str = "sine";
-	else
-		str = "sine triangle";
-
-	return sprintf(buf, "%s\n", str);
+		return sysfs_emit(buf, "sine triangle square\n");
+	if (st->control & AD9834_OPBITEN)
+		return sysfs_emit(buf, "sine\n");
+	return sysfs_emit(buf, "sine triangle\n");
 }
 
 static IIO_DEVICE_ATTR(out_altvoltage0_out0_wavetype_available, 0444,
@@ -303,14 +299,10 @@ ssize_t ad9834_show_out1_wavetype_available(struct device *dev,
 {
 	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
 	struct ad9834_state *st = iio_priv(indio_dev);
-	char *str;
 
 	if (st->control & AD9834_MODE)
-		str = "";
-	else
-		str = "square";
-
-	return sprintf(buf, "%s\n", str);
+		return sysfs_emit(buf, "\n");
+	return sysfs_emit(buf, "square\n");
 }
 
 static IIO_DEVICE_ATTR(out_altvoltage0_out1_wavetype_available, 0444,
-- 
2.33.0

