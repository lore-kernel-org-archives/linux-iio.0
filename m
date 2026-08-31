Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58EC039AD5E
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 21:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210836; cv=none; b=MAg3jDBraOIzJ0cfibKk6Zga/N7E0/wxk6B/UvcoRKonrFn0JPH6WUfTIVOKjXuqicBYI+oHk9QzztI3KcvV9UlUgUFEW+K4tEGmEB/OYUzLBJmmfkLaCQMyZoRfYwrs/VHT+VzmXOzuE7XNLUvRx9gmEkF0+4pbW+LCayTEdnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210836; c=relaxed/simple;
	bh=Ok2JWMFdmq9RBhsH87s6dwlbv1t1d+AHVoRVKb5QzHc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PmuQ4lrRT/8rYqmOZJKb0oDHg7DO+bK9Z8xDOD9okNsLdpwbH6b//AGvVFvax96yAjWlntYPf4Qwlu1MOulMe+NhVJRNOC3ejhE9Xmksw+8j6VnKfsbJEBpeLu2Q5Cp7Td7DwnCbSO3S/tyFLe2+L/wYrvY6V3QpmqBWi5Sy/hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acqfoHy4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acqfoHy4"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so38207875e9.0
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 14:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788210832; x=1788815632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xVHnC576INwGC+7OJYbd+v8J85oq1PFxo2Q5XCB9L3A=;
        b=acqfoHy4bdFpLa6wxYumc5TmTqmDuGGG6WlPLEIA1ERHmuyFwUg/fD3Jb5JtxSvmLP
         VO6yeH1gTflBH++gZI4k6l8ieH1edfIy2bwJB3XUKqFicezOz4OeL9GVoHW4Z8LTE0dk
         6C052WZiqE3mHGpYxDraRRck03WLXAjTq97CJJIcWhr03vOhBLrofmTpb1TK+u9Hrisv
         eSbHXa1lZs9HZ8m85kcpct788mThvSwz/5nVsnHKTkPH+GVeJkJNMRzegWojI+76iNCw
         z41SZBS518r7NAK0MZMZZ0SdDzX5H/TwRtswF7gYDl5nop7ePIDa2ILivFLn3nURsldl
         /Q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788210832; x=1788815632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xVHnC576INwGC+7OJYbd+v8J85oq1PFxo2Q5XCB9L3A=;
        b=RBYuY+FbTeYnb4BQM+F4Y1ZIHoCcVovtewOvhy0tswwiOWH8h1OmpwNzzvTB0Y7kU6
         0EDmlwZHj6K7dsdx5C2IQrsiAboy7EMtUSuIhC1TJiGJK9kglWMMxrDiAjBzCyB3gI3y
         X8hdcMz0HNUVoSgQ6eKHBluk1806FGFmzFUEHKJs7G46HZwHyp5AzHjW8iR/no7ds9O6
         PKFvK+ABUVMnzMIrbd0sRT6Zf9pmxZI7jVno2H1LRElC0YBDpupcU64dxNe65xVsqEwF
         tgnjrUAirSvICR5x927mulfZh+L8vRVZc6fBnrOJAfNOzCXVaK7YtrSMYxPtIK6MS7G0
         ZY5A==
X-Gm-Message-State: AFuF++lNSMwnZGx35SZy7chepG0Lug+1g8nDkpEwtsQnHjiq/9S4L38s
	oZFY0P+6wCJQptXUHcw2uCQfpcplF6rLE2tHGxqgm/5REs2RjgqU+PDn
X-Gm-Gg: AR+sD11flQpZI4+fqUZe7iKq2W9M1k4cvhqbOXkY6jVbaE++LtoucrrVEzZpzUzFQrA
	paqdr2G88vd1vigq4yLOb+8Rwk8sERyPw7H963301OWB3AW1byOHC7/FASWGSftNXoWCWD08s/8
	yCNz++ycG/SxfOau+BBlUVaCZuHyj92pyWRowXdP0RomfNqDcIvuRPIgGQZs8NTO34GqECvc0aA
	ZWLf7oq4/o+cD8f0VjrVC5joT7PXvqGFKqnv9Fik86jkZV8BhpoE8H11x5uKrer/bJam5UqTtMi
	LAbHj6EuuZb75Hp5t5LH2a6n64gPqWJnigg0W/5OCgbCj1bMPdk+s8xkHwIEmxdE/3Gom0EXnAl
	Kymgs+vAI2e0bjmB58me4DQvhaL8bvDGpIo0r6Z5aUIWkxjkYVwPZNCRRLmR7c1ASFmWgrlugx+
	xu0yV4DhoEq3CXApKSqLGk9O4D3tRKFjq3u51V/BxQqxgGCIv1fa1Fj7W9R4VY/sgqWnujdD2ac
	ePiUTkFrRodYlaK0tIw2tN1SEVv7JVjwT67D44b8iEAvYaC39ZIBvqWIzvKHFkZ0fDFaNGzr064
	VsPvFvNf5kOdYSpGQp5lRjjMXZhY4HSiST0LQxm6g69gwt2nmgkmbmnOynw1MdV802tpTmwCunC
	x32xREe2uYKd+Rnk+FDZSXYfz
X-Received: by 2002:a05:600c:5391:b0:49c:cedf:f870 with SMTP id 5b1f17b1804b1-49cdc555577mr65597235e9.16.1788210832372;
        Mon, 31 Aug 2026 14:13:52 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce1754csm17695925e9.10.2026.08.31.14.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:13:52 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 31 Aug 2026 23:13:41 +0200
Subject: [PATCH v2 11/11] iio: temperature: tsys02d: make headers conform
 to IWYU
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-kernel-header-removal-v2-11-b92b580ef5eb@gmail.com>
References: <20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com>
In-Reply-To: <20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788210819; l=1427;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=Ok2JWMFdmq9RBhsH87s6dwlbv1t1d+AHVoRVKb5QzHc=;
 b=sdtbEZ0fv+v7g1gD1vpvJpEtE0ytqFqg+qeh8VNucbBY2BBxibYYV9gdtzajDNk13hbtRpAE/
 IE2KM+Qk+H7ClyV2LVfsWPN+0bN+W3GaQrKLl9KK6/4aFfwrr+Fsdvz
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch-all kernel.h header, add missing headers and remove
unused headers.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Header changes explained:
Added:
- <linux/array_size.h>: for ARRAY_SIZE()
- <linux/bits.h>: for GENMASK() and BIT() macros
- <linux/i2c.h>: for i2c_client and i2c_device_id
- <linux/mutex.h>: for struct mutex and mutex_lock/unlock
- <linux/sysfs.h>: for sysfs API
- <linux/types.h>: for fixed-width integer types (u8, u16, etc.)
Removed:
- <linux/init.h>: not directly used in this driver
- <linux/kernel.h>: catch-all header no longer needed
---
 drivers/iio/temperature/tsys02d.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
index 377e27b45fdd..2c67faebd90c 100644
--- a/drivers/iio/temperature/tsys02d.c
+++ b/drivers/iio/temperature/tsys02d.c
@@ -10,11 +10,16 @@
  *  http://www.meas-spec.com/downloads/Digital_Sensor_TSYS02D.pdf
  */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/dev_printk.h>
 #include <linux/device.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
+#include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/stat.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>

-- 
2.55.0

