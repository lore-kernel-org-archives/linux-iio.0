Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91251DF970
	for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771683193; cv=none; b=jOUVyLZzvSxE7TXpIDrDM7xWs/6A84h6K345v9SDW/IWr8KeZYc7dgjwrQ+wI41oMzN0ocofQgqHw8HyDxYxJaAKgYzbdYO4iITDg9rYNXJqVX9vP4gtfgxm4Aq719SjZ/l2EOWInn75NKVXtcnR0qEbvPqlq69S6tpZDWimfOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771683193; c=relaxed/simple;
	bh=9/7QTpM9w9CetgDRp3W/v439sqmC/gELVsuHbq2pmD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdPVA7eQnznQhhghLNFeHc9MUGAx+o4fu/lGxvs/9Qzn7VujatVSN9t/dBpuH4XU0xaxYLpJ6U5qnUrLqfF2UtOkiNAz3VgsrNv1A1OeQ8JQ14KsgM9pnnzm/W8RLXLTu9yMGLrN6K96t7kjMRGWg2LucM1/sziOZiEaMU32/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsjNUa9y; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsjNUa9y"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4807068eacbso23740515e9.2
        for <linux-iio@vger.kernel.org>; Sat, 21 Feb 2026 06:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771683190; x=1772287990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xbmaZh646ZKImMHo419Q/3GSUkucF5/edL1/4X8vppA=;
        b=DsjNUa9yuLHsE0W9ueq4IambVxlVhi59Ff5uXyEoe6zTigob0cRUsBUoZ6j5bVof+V
         pYaGouhxYZp221b1KviPOKtGHrlP+nCFu9jMz9UcZ4CbiXX4KmKCOj8vVJAPN+ltP4LB
         AAz63wRk+p9RHzxSljPoFWCbcNFRZBE/5xg09vcaNawRgY4z+xK93juGUeSlbkLlmF4T
         8uhpf5Cv3exltuK/dQdCVPJgKltl11Blf0xNvaaE0TVr2wnPmK6Gnqpno7N03sD1xBiH
         BBkYHQuyCkLMNKGUmoiHHKcccZbJCoapumt74ZggisoAGDZq4FMvgSisBlCG+GtHWUlT
         RBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771683190; x=1772287990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xbmaZh646ZKImMHo419Q/3GSUkucF5/edL1/4X8vppA=;
        b=nO1Qhc9ISLik4/Z/xzL+4SRBp9m2h/NBXgT36NFOjJhC/3F15zo0l6S61eMT306xwN
         z+5iu+4ov9MjHN5hb97e62L7z+Zb++ogd0kFy4+uMar2H9g7bnve5JT1YysySfAV7Bt/
         uoFab2kIqi4GmLCiNkd1+OoxOnbH1bXJf7jrO5pAmjV0T523gd1K339wCPnYDYUxklB3
         SSuUEeOmbfZXLOICcVHMf9oAdtOfUlnc4f8k8nPcF+r+fX3ReyOVjCbxkkwiWXLIR+Rn
         ZUKiBebM3GvZOuOw1xhmhqGcyRsX8rZv0xg6HS7Jth7u0dT55XfH+8FCNRZabpTQ80an
         06KA==
X-Gm-Message-State: AOJu0YwMOV8YFbLaue49xP0LeLTxYx/4r2lz7okJuz1MBLfcc3jlBYex
	xLYMi7ikR7HOvbKjsFjjklNKzQwiTSN2D/z0r0V6aMYmJy+PcyaPXXiWe+5FydKK
X-Gm-Gg: AZuq6aLvrFhXdJpOSIl4KwhFcfGvFUN1OGsrV2N3y3B/BvfNirkn8MXGYxFXoE/3XO/
	JSk8GuUT1Hecv9+HQnFaYrkdKKi3OaBNZqNi5xNFPSbP77BQNN7Qaczz9wJOd2HtXv8z2cxRfyE
	Fq360limsnuLBwMY2tqjH5TONR9dsmsru0bUPnq9yrA/xN1HL/Y7sRliraO4bQLnBDLjsALXP1Z
	gJ4wwr3+4I0+c+xrQIKZFL0e1+tiDeiPDPrpea3KXdRqScac3RF312mKXBeCw1+4amFkmnZ5/WI
	vD17eCBv7pyswV339rJ7viWbM9KHvXv1dZ04u1uMSZ5COrwFgnzWmA33eDgMEMhCAxdRnaVbCvs
	Hxc3wybZyPUu75tkrC0+1gRId20spqwqHXSrJVIO4EFHxwVCbnjfU+KwAIybkrQhxsAQq4QyqBZ
	59tv7KXf20mNDtyzHi9gs6n83nJB4W0log6XDHJJ1DZ5VW3t9Db2fzZftCI0T7os5AaOqxlYue
X-Received: by 2002:a05:600c:3508:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-483a95bf3d0mr58953795e9.15.1771683190057;
        Sat, 21 Feb 2026 06:13:10 -0800 (PST)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a3e01c27sm50169825e9.9.2026.02.21.06.13.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 06:13:09 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v4 2/4] iio: core: Add IIO_EV_INFO_SCALE to event info
Date: Sat, 21 Feb 2026 14:12:45 +0000
Message-ID: <20260221141251.34855-3-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260221141251.34855-1-0rayn.dev@gmail.com>
References: <20260221141251.34855-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support for IIO_EV_INFO_SCALE in the internal enum
iio_event_info to allow proper ABI compliance.

This allows drivers (like the ADXL345) to expose event scale
attributes using the standard IIO ABI rather than manual
device attributes.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/industrialio-event.c | 1 +
 include/linux/iio/types.h        | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
index 06295cfc2da8..5096baf233f0 100644
--- a/drivers/iio/industrialio-event.c
+++ b/drivers/iio/industrialio-event.c
@@ -256,6 +256,7 @@ static const char * const iio_ev_info_text[] = {
 	[IIO_EV_INFO_TAP2_MIN_DELAY] = "tap2_min_delay",
 	[IIO_EV_INFO_RUNNING_PERIOD] = "runningperiod",
 	[IIO_EV_INFO_RUNNING_COUNT] = "runningcount",
+	[IIO_EV_INFO_SCALE] = "scale",
 };
 
 static enum iio_event_direction iio_ev_attr_dir(struct iio_dev_attr *attr)
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 34eebad12d2c..4e3099defc1d 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -21,6 +21,7 @@ enum iio_event_info {
 	IIO_EV_INFO_TAP2_MIN_DELAY,
 	IIO_EV_INFO_RUNNING_PERIOD,
 	IIO_EV_INFO_RUNNING_COUNT,
+	IIO_EV_INFO_SCALE,
 };
 
 #define IIO_VAL_INT 1
-- 
2.47.3

