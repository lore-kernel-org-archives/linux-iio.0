Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15E13EB0FE
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324035; cv=none; b=msReXoX2pbInfWLNTB9skDJ2XEciC/KfnRHeMkit50/qUBYwnS8VuFPu8gXjdpqHdvmvaly7v+kVGnROssMvYYXiZ7iDPN89XMqa4xcM0UfYnYND/5aSE5d6La067sPFf4sZJ+UgOm0WMrkbMRwG/fyeJG3QX0RJnIYFL+hK9KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324035; c=relaxed/simple;
	bh=o2u3tmJ4dbMJ8f3Ubk+i85Rmq4bTjeWeJ9eBvYu7rDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AnOHcmLpMvpicx+ZrGlFn+8FRgIc/DwUVJ9x+37+wGuYlJIcZ+z9wefxXu6UDuYX0/J5dhjXcptxVZD/CNiA2pEHGpeqbhatKruPg9CXXFrVNSDGWQvGyUfQHHf+lcJLIXPyJ3tvVZ1zhCtnGA649mNx5Aa8BiBEqyZWR4zmLio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCCfluLQ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCCfluLQ"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso1944023a12.2
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 00:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783324023; x=1783928823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y41AW65ugwoCZQW1jZyzd6ERQyYcwsnWPoHTIi1U8oQ=;
        b=jCCfluLQdmX0llksDf+kF7gAviMz/ioKP1nuoxwnPNn6AIGbp1Jh9w96SJEvBQEv0O
         AdDLyznKEv6K3gza5qBOW34XBLDFP2wBn2Gb0oG1PJ69DqSVV0xu7w5j0SoVF776yboz
         nXgvPpSDL2gDwAYlSUJjISnareEAvjjHmLm1/LGSzVztQIdUjW2kYS8jaPNWTKcOhNQ9
         bkWGJFprvzWyKP0n4C9CkWH2gB6F+YLlhh9rp/BeunB1Og1nKsfcKOa1DEOAf6Tx2M3N
         SdyV0I37KLl2cA3BfISI47nPvFMHL5q57xmLsK6RHzfq1daIXO7DxZSvSC/+BsF+QexE
         hfeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783324023; x=1783928823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y41AW65ugwoCZQW1jZyzd6ERQyYcwsnWPoHTIi1U8oQ=;
        b=hE6TWKJZdGXx+tpNZELAaSPsWScE/v9e24TpfJBqM+ljHzsIxhjBJRnaCFhj9N8Ufd
         pj9o2IYkBRezl7YI2gzuCtvd5rMn4PLqFjP0Wuqtejm9f75182NdGrCM2EoIJDDRgEOf
         xmgtz1eAEkQwsW8/ZBRP0JijGfOHFrZePHzbmm3gIWNRb5XMryXjdu7+ayoRTlTxnRZL
         zV8ohBCx6SW2i5UU7sgpAyxsS7guAnqHZEjZBeYeKZxayNAaZ5GuhIzIoHF6Hqv6sLqo
         q/GDCCEYcpE7hY3+z34WqkqQ7X7q7z1bHKAVf80Lptet5yfEd/core1V/SWvX/pVE597
         PVJQ==
X-Forwarded-Encrypted: i=1; AHgh+RpDoFnJcZywyzvcu++i5m7I0z+oTZE90H70WAanr3ZS88IiRji3x48/GZ6dZN/f3DBT3rF9liOmz+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF2ahFX/3bEfP6TorGNXuIXcWTjFgFwmTs3RDmiZ91MJueAP8e
	SAQ3UFkA2LxU7c4eKM2p2PmQcHpIFK4+I9ymRJq+NthHd45ifj6PMDc1
X-Gm-Gg: AfdE7clRy7mRX5cjv9ScdNtZ/x58+IOdAL8lctlyMzIrj4ee/v/XBdOxxfHSC2nEBPe
	4Z+2jtSqPhcXfvHOmSqXgtKzkbe6qSlJscVwsMtkQcpL+rQqsunXFu6j/9JhliDcrsuCoeBCPiI
	ZUPXtMxpH13to/l0vbGr3d+rN+c7rEcVMGElBrGdbOO1TrwFtZJBQqyqFA+VyuYNQmlXxU8uuiE
	3i3dotNbnQUDwbAiNWAnElbm49irLYjDqw1woRMqFktc/yfj2ct/MVBw6/SIkMtDmnT4uZs1zKv
	ehFOpmInX3Z4Lh917ola+6hTdTr/83N9797wdQQuoBQCXXhpCS85FSbrWLjS7uIZ4DiGjlKRAoJ
	s38268Tkmq5WbQFmCRqPoJv2EMqgjaXag0VL+rAizg3D2np+KoeIaI8rOd6kxn0pt4c/T+t98m6
	Qf/oIPoqPTiBa70gFyg7wTIUakgalfep4lys84/R2wfPo=
X-Received: by 2002:a05:6a20:5499:b0:3bf:a8d7:4f4a with SMTP id adf61e73a8af0-3c03e50ca0bmr9757761637.40.1783324019938;
        Mon, 06 Jul 2026 00:46:59 -0700 (PDT)
Received: from localhost.localdomain ([49.207.223.101])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c7ef5b3sm67081836c88.1.2026.07.06.00.46.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 00:46:59 -0700 (PDT)
From: Biren Pandya <birenpandya@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Biren Pandya <birenpandya@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] iio: accel: kxsd9: fix Use-After-Free in remove()
Date: Mon,  6 Jul 2026 13:16:51 +0530
Message-ID: <20260706074650.96042-3-birenpandya@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kxsd9 driver currently calls iio_triggered_buffer_cleanup() before
iio_device_unregister() in the remove() function. This order creates a
race condition where userspace can still access sysfs or ioctl interfaces
while the triggered buffers are being torn down, potentially leading to
a use-after-free.

Fix this by swapping the cleanup order. Unregister the IIO device first
to guarantee that all userspace interfaces are destroyed and no new
accesses can occur before cleaning up the triggered buffers.

This vulnerability was flagged by the Sashiko automated review system.

Link: https://sashiko.dev/#/patchset/20260621193036.78549-2-birenpandya@gmail.com
Fixes: 0427a106a98a ("iio: accel: kxsd9: Add triggered buffer handling")
Cc: stable@vger.kernel.org
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
---
 drivers/iio/accel/kxsd9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 4717d80fc24af..7569201ed3c75 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -477,8 +477,8 @@ void kxsd9_common_remove(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct kxsd9_state *st = iio_priv(indio_dev);
 
-	iio_triggered_buffer_cleanup(indio_dev);
 	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);
-- 
2.50.1 (Apple Git-155)

