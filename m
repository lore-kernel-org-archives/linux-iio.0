Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DCB3C73DD;
	Tue,  2 Jun 2026 09:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392174; cv=none; b=V8Oro0W0KvM1IM0EZf+vFQ5DX5pv5lgShwB2Ihh3dSwDAiOswJyL3XmLRDUsi2cs3Djl0ZIktdq1wN5h61/kg9LRbjOYhL9IurDM5dogyUmKc4Kxc0Iyp9rbRUi5AVlelZfNjKewno+yffawJgP2CesmjJXxi8tSDgEzYRJvUAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392174; c=relaxed/simple;
	bh=ovuHPjI99FzgiY5riz2sE/yrvqtcgdbKpW+cIKKWKc0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cylFHfw4DipICabpR+ghJSSPiEBhpWxtzpX4WrgTbl5TAz+lnQ97G8Gcjmenrv8Me6hCXiREzuhrSgWbXEWG7QlHtryzNmf6HBzhYHY2J9JecayjvQch8Y8/0zkjXC3yZlAVVfXEK59oQ4QlIGlBGLeYE79uyy0IUc7VyGFVBIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Sd2fEPXH; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Sd2fEPXH"
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 40be0f4e7;
	Tue, 2 Jun 2026 17:17:35 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: jic23@kernel.org
Cc: nuno.sa@analog.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	andy@kernel.org,
	benato.denis96@gmail.com,
	martin@martingkelly.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	runyu.xiao@seu.edu.cn
Subject: [PATCH 0/2] iio: add IRQF_NO_THREAD to hardirq-only trigger helpers
Date: Tue,  2 Jun 2026 17:17:25 +0800
Message-Id: <20260602091727.2406720-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e879fc55f03a1kunm7cf82aeb184122
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZT0NMVklCHkkfHx1MT0xIGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE
	5DQ1VKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=Sd2fEPXHilOOCzzUDllBaqLj3gYIZJgf4ZyzUF/8nrD54XwonIaDoHn/Vvf+NSZJta5MOjEmSGv2MtQvaeYAJPRZcD8zZ5bGZBh6rzoRNYQH4sbAFDf5r5JPYehQNkHM85zdA+n8T/s26SLgTpWZEjGtPXXbESaNNghNQiiW5jg=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=JM1wBFu5vfRwrancmDb4G39efpXbD2HpFKPmY33Suww=;
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

Runyu Xiao (2):
  iio: imu: adis: add IRQF_NO_THREAD to non-FIFO trigger IRQ
  iio: imu: bmi160: add IRQF_NO_THREAD to data-ready trigger IRQ

 drivers/iio/imu/adis_trigger.c       | 3 +--
 drivers/iio/imu/bmi160/bmi160_core.c | 3 ++-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1
