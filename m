Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0C83D9040
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778748824; cv=none; b=duSRSfAhW3dNFz8EJ2TslDWfiD8gA51z91WzPYcdVRv9LYs4zkmE+rOaNZWf3bMSvZWQveAfyEWE3wLT/KiNaDrzPtAQNGQ1N15gNbS8Uc/xWEYQEYqJ2S+RgSxCUF63FuPj5nN1M0X9WbvyauqwPIicD2bHpjabiFlOBUkEaMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778748824; c=relaxed/simple;
	bh=mdcOcRFdk+kFxge8RF1JHjCRLxgOkic/0vjen1/AoRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=swsPEoC5f1t0UNEz2uwv50E/lH+nZGvEWMod3K3Mq6dUUeytIQ2VAj/dGgXJitDPtYcFxWTwR+jufoKifzn5Nm3aW7aYYy5iTTkhw3Nc6vSw60JHP2knxufhhma97aUDl27ycN0exu1qNWnf6j5CJU2gSl03rMxk4TWlfA0s1cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByTl8RvL; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByTl8RvL"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48fde653997so118545e9.2
        for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 01:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778748821; x=1779353621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H02A+VbK9Aj1S680nY/rdW6eTeDyQxWPgrNJtVSjlqQ=;
        b=ByTl8RvLFh2+HKL4oGqOqjKY0x9jo29ZPMKCr3r2UR3+wEIGa0yFCCSBFpXk3iSzL5
         yUB8k3XyIXMUUcj4iSLqjhB+eJrWAxJDutpckzEK/r2Y2YHQ7lLnkj/r+yqHOz9rOKTt
         jldQQfAaEbGvjsLzCrIJOcVYWVA24kBPhZpIl1aGl8U8J9x7QjN7O7aBYbhHm1cbaly5
         6537hupxkp9UEE9/HHvzyXj2Pjl/Nhb/H2NMyshlusQdt/1p7DTDTy9uwi+yPuN0HsUt
         aWGDc62KaVuEczpNx22+lBx6j5XA5HxYLWJR6WZqvL46TGqXdvSfr3UbyoN/rIDW0Pnx
         JPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778748821; x=1779353621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H02A+VbK9Aj1S680nY/rdW6eTeDyQxWPgrNJtVSjlqQ=;
        b=E8W8s8OW+E1A87spDtSJGMVihA+m3WvHIc2xDE8HJC+bpf4qJIGncd89cvKarMpGEh
         tGyeh93OKkbOXGJ5z3HWZYxWN/f3so+ggIVoTIQl+47OlkpLLH+9s6q4QC4c+ukOQbqX
         A5F9XrfV1Mc81deH5j/yQ0IYqkyBxz7BtT8T7AIg5lC+L/i82mI8/CCKWLWwM15g/su3
         WPHnSjveDz7iqRHiRy5m5QJTOzSnoWXOB8V15bEaVsNxxUEvbDYb+TfnsHB62wQfS1ia
         slRdwEq49AugHglWKzmqQNY/l3azWIe0p6CyGMP7wxK4U4mzBAWz4q/a/4/30kqLgt6x
         iTVw==
X-Forwarded-Encrypted: i=1; AFNElJ80pTdviMu2CB5yxtk5wWPcdbQHla5lGijwDQ965/OnYQ3O26PcodrKg2jS6x6q9ovfExK8Hnj0OJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo88vEXydAm0rAo2c9SzdFbhpAB9qItaLdxGCcvNwBKmA3T28+
	82eqwUB02Pe4Exl6Ks+/C20xQ9E876Yy2tj+nKEOLcV1b981sl5+BtpBTgZbCitRX+w=
X-Gm-Gg: Acq92OHqmhN/3DnTGcrFGCZA2gFwOICdg0TEqqa0PFG+FtgrmiVCysyE4F/paO07qBC
	8yXN5/mfbiy7I+uqQFiyFWIam8jkSrsszrTEj03kyUFIaLyc8djR9uTA9Fz0WMxaXhFsVVKXUxn
	8gGVZrl/IPdRIrA81MNIoqhNyz2hpnMSSP86WliOOyNyusS5LRQA8cTUgk/y/WPj5MKq6b8Jus0
	dDlphwP7BWVs3q9epn7+lJYqWXYx8u8sGbecNSb2+stpuPDOUQPtlOi0dURkST/7RGUoFAmfGQ7
	lufbbLZJDQ07gDWCxf+hzMKjUb2fXYt07j+pxfvRwRQ5Qc82v4UbwMrR12Miwb2p9BynvxqA5lt
	0gtNiiTWK2ymAtODyNBM0k25wSlr9aAU/gILuTx+277rpgjxES88DnNTO9Nh1UOjuXMW2HKozKh
	oeABCT2VT8TGY/CsvQOzD22UstycXsBZfBIDsH8rZDSzk=
X-Received: by 2002:a05:600c:a08:b0:489:1c1f:35e5 with SMTP id 5b1f17b1804b1-48fc9a44496mr50115175e9.6.1778748820886;
        Thu, 14 May 2026 01:53:40 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd649a21asm53831875e9.6.2026.05.14.01.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 01:53:40 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: corbet@lwn.net
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	hcazarim@yahoo.com,
	linux-doc@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH v2] Documentation: iio: fix typo in triggered-buffers example
Date: Thu, 14 May 2026 13:51:57 +0500
Message-Id: <20260514085157.20327-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the "IIO triggered buffer setup" example, iio_triggered_buffer_setup()
is called with "sensor_iio_polfunc" (single 'l') while the function is
defined and later referenced as "sensor_iio_pollfunc" (double 'l'). Fix
the misspelling so the example is consistent.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
v2:
- Drop the file name and line numbers from the commit body, refer
  to the example by its section name instead (per Andy)

 Documentation/driver-api/iio/triggered-buffers.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/driver-api/iio/triggered-buffers.rst b/Documentation/driver-api/iio/triggered-buffers.rst
index 417555dbb..23b82357e 100644
--- a/Documentation/driver-api/iio/triggered-buffers.rst
+++ b/Documentation/driver-api/iio/triggered-buffers.rst
@@ -43,7 +43,7 @@ A typical triggered buffer setup looks like this::
     }
 
     /* setup triggered buffer, usually in probe function */
-    iio_triggered_buffer_setup(indio_dev, sensor_iio_polfunc,
+    iio_triggered_buffer_setup(indio_dev, sensor_iio_pollfunc,
                                sensor_trigger_handler,
                                sensor_buffer_setup_ops);
 
-- 
2.43.0

