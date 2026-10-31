Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793451947;
	b=pYFA80t43rV++jZxXeeeQOijsJuYNpoFGtSKdHqI2C8skzv9sBiJUCEG3rR6r8YapI73
	 7Hh40XxNz2yTNcIzSn95AfyW9h54+WYPsvbpyWw9h4KoyE2KfUI1qYGH+4ewtdOsPVxlT
	 EAJ3dQgE3bOa3dHLQN27z6E/4kzheQP8AyxoeWYTKY9H+tPaMykwSt1MZHpx5oC9uPDnH
	 h7iD7NMaTGtPBMGSiBSwIb9CLGcKiHj8bowh+Py1SsavVM/zw+Tgwxls71pY88azxwtxN
	 gE9xF3ZeMjB0OT5IClpFrgnigYfkCegTpp/l1D+amJmtqcmRj/1ea3N55HqqkP1Ct+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793451947;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=bPqsacQc0zbv20k2lImH6MGENdzusvAyxHn0G4Pxgs8=;
	b=Ds6LDX5oLUuy8WsVIov5V9bprzZ6i4a9MKCZoIf166jGOjpzNOSRhlXgHocfWce4Dhyb
	 wu/qR5cge6l6g57osTDnmueNPyB2bL91XJv+VvcOr/VNOnzIPu3ElpWDua41BKvsTJl3O
	 TerCmw1zEuCmBlv8NDvWflGdzHrQxjptd8WTeZsWZU1zo019GC5K46qiry8ErfAvTr7Cz
	 W4gfCLF257NDhQ5xU+X1rMSVORYmTDR4VPLTUA/WYX6jPB+DIPVJQalVJF22dmCOAGz2a
	 8h8MclMIki9Y0F1sUowIZUGU+bfk8NN/GhgGV8tw0Hn0YCZiHjcCB7OfxT4E136PzBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=cnoTmKFZ;
	arc=none smtp.remote-ip=45.254.49.198
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE959606A31A;
	Sat, 31 Oct 2026 13:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE959606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=cnoTmKFZ
Received: from lgs.. (unknown [101.76.249.61])
	by smtp.qiye.163.com (Hmail) with ESMTP id 530655121;
	Sat, 31 Oct 2026 21:05:39 +0800 (GMT+08:00)
From: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: accel: kxsd9: Fix potential use-after-free on removal
Date: Sat, 31 Oct 2026 21:05:38 +0800
Message-ID: <47d9e9120165e819d706f922c798517701019bf1.1793377431.git.liguangshuo@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa19210d81503a1kunm472732cb83be0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZTx1IVkoYTUhLSh1CTkpDH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKS0pVTE1VSU9CVU1KWVdZFhoPEhUdFFlBWUtVS1VLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=cnoTmKFZxGF3QtRiIwThX9aSLMuFgVb9l77epTEt9OcOrLBTfiDBz9dWQCpOSSKNh2Sg0L/D/g6h/9y7bsdrRW+no9fDKSUlq81cFrOA9bf5i063KqOolZ5tmGzJBprkaypULxBtGSqZYLZ8yUrS2RaYaSAWbsibq9tDEHUmj/g=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=bPqsacQc0zbv20k2lImH6MGENdzusvAyxHn0G4Pxgs8=;
	h=date:mime-version:subject:message-id:from;

Unregistering an IIO device with an active triggered buffer detaches its
poll function. Freeing the poll function first can therefore make
iio_device_unregister() access freed memory.

Unregister the device before cleaning up the triggered buffer.

This issue was found by our static analysis tool under development.

Fixes: 0427a106a98a ("iio: accel: kxsd9: Add triggered buffer handling")
Assisted-by: OpenAI:gpt-6-astra
Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
---
Build-tested the changed object with x86_64 allmodconfig (W=1,
CONFIG_WERROR=n).
No runtime or fault-injection testing was performed.

 drivers/iio/accel/kxsd9.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index 7ac885d94d7f..27adcdd31201 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -478,8 +478,8 @@ void kxsd9_common_remove(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct kxsd9_state *st = iio_priv(indio_dev);
 
-	iio_triggered_buffer_cleanup(indio_dev);
 	iio_device_unregister(indio_dev);
+	iio_triggered_buffer_cleanup(indio_dev);
 	pm_runtime_get_sync(dev);
 	pm_runtime_put_noidle(dev);
 	pm_runtime_disable(dev);

base-commit: d89e1d186ec9271bf78e62771779e9fc03bf0fc3
