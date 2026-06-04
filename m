Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C182253A1;
	Thu,  4 Jun 2026 01:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780537702; cv=none; b=OEKxwS9scWB2PcyRw9dKd4cRyy1GUXmxJwMCa2vCQBmDXZiMhFctWy/TJNoMa2ZJMeL+j8CZmv2jPidQhhJsoCmdcWVTPRDlholPSriMTFROvBWzVKPDvAr2bjv1+dCoi+VFTxQ4YBWYmgmxzBpkqqkZDm8ystN+ueh9vMnrQdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780537702; c=relaxed/simple;
	bh=t5mMHiVJ2trV2fDW4Tl2dCrIkljr9+fgZpU4OeEw0do=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qF7Ck/6kdjB7lfHQ8zxjR5ka/IxDr1LK873U+Zs6Y/TJJX2gPJWFkroJNYtYDMn3Qpa2tGegJR/qDotjcggxx6znzOsovusvKc+mra3ljagz/O++ZYv0w/gZKXjJImwVeNLR4PdAYuYYNRLZEyG+/Pjo8QBT06IkxFZgl00ikh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=aly7W2Nx; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="aly7W2Nx"
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40fe0c71d;
	Thu, 4 Jun 2026 09:43:06 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	andy@kernel.org,
	dlechner@baylibre.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	Runyu Xiao <runyu.xiao@seu.edu.cn>
Subject: [PATCH v2 0/2] iio: add IRQF_NO_THREAD to hardirq-only trigger helpers
Date: Thu,  4 Jun 2026 09:42:45 +0800
Message-Id: <20260604014247.124724-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e904c65fc03a1kunme7d1e7a121c41
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTEkaVh0YTR9KSElLSR5MT1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=aly7W2NxFlq90Apl9z/SgG27Ct53cPvxwxckUlFzIGeEKHDCXVpLi9+JNHxIgSl0GSTeB/YQDZk+S4xmpxD7eN0345zcKkie4t2U5n3Jc2stMpzx51Ae78LYIGv0PGu68Krgzp2z3r3/QBMGPLlGDjDiknKVOWyK7raMM6gMmyY=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=TsLJGeG8WvLxl1i5gZ+5b8PQ39pQtLZvkNuRuMLyEw4=;
	h=date:mime-version:subject:message-id:from;

This series fixes two IIO trigger registration sites that pass
iio_trigger_generic_data_rdy_poll() to request_irq() without
IRQF_NO_THREAD.

Both sites are intended to drive iio_trigger_poll() from hardirq
context, but under forced IRQ threading they can otherwise run through
irq/... thread context instead.

This issue was first flagged by our static analysis tool while scanning
request_irq() sites that register iio_trigger_generic_data_rdy_poll(),
then manually audited on Linux v6.18.21.

It was further validated with a no-device QEMU selftest using irq_sim
to model a parent IRQ and a child IIO trigger IRQ under threadirqs. The
same trigger path ran from irq/... thread context without IRQF_NO_THREAD
and stayed in hardirq context after adding IRQF_NO_THREAD. The selftest
logged:

  3395 selftest: phase=bad current=irq/30-patchpar in_hardirq=0
  3395 selftest: phase=fixed current=swapper/0 in_hardirq=1
  3395 selftest: validation succeeded

Patch 1 fixes the ADIS non-FIFO managed trigger path.
Patch 2 fixes the BMI160 data-ready trigger path.

Build-tested by compiling adis_trigger.o and bmi160_core.o.

No ADIS or BMI160 hardware was available for end-to-end runtime testing
on this submission branch.

Changes in v2:
- move build/runtime validation notes out of the per-patch commit
  messages

Runyu Xiao (2):
  iio: imu: adis: add IRQF_NO_THREAD to non-FIFO trigger IRQ
  iio: imu: bmi160: add IRQF_NO_THREAD to data-ready trigger IRQ

 drivers/iio/imu/adis_trigger.c       | 3 +--
 drivers/iio/imu/bmi160/bmi160_core.c | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1
