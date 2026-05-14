Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2C840DFC5
	for <linux-iio@vger.kernel.org>; Thu, 14 May 2026 14:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778769852; cv=none; b=uf4wZoyApME8WNDYXAF8TUYVfIyXq8J3/ui9xmQa/TB1xMnQfcBEhPxr7PnCXV3IIpg0p3ZF5KRzi7qKT/GSohz3FvuxAlm3XQiBfLgAmh7K+GP7izZqSgdy8N1pV9IVTBD1x1zjgE8ajNJ2iP5ElBvwXNrdvpgtBOGbMjX++kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778769852; c=relaxed/simple;
	bh=6n25b62lPh2X1tEt+smWWVSeIbgE+aoTOIk63qm1678=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dlEyzpslNC2T6XYqWLlm3pIpILT1ukw1whehztoVpFQ/SS4/OwhyKOWOFaXtH4LJmgDkozsi01Dt2D9bP7fRQ1lUvkF/F+Jd29p4lwguV1t1sM/WefB84mmdw61iE7QDECYMtsRCtbeVHGaIZNsu+Znf+xzti12Iwu1qCvBqmnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1wNXHu-00050s-RS; Thu, 14 May 2026 16:43:46 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1wNXHu-000mEf-09;
	Thu, 14 May 2026 16:43:46 +0200
Received: from hardanger.blackshift.org (p4ffb2dc6.dip0.t-ipconnect.de [79.251.45.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id C2C395365B5;
	Thu, 14 May 2026 14:43:45 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Thu, 14 May 2026 16:43:41 +0200
Subject: [PATCH] iio: iio_triggered_buffer_setup_ext(): request
 IRQF_ONESHOT only if threaded handler is present
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-iio-irq-fixes-v1-1-3bc28b094ad6@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAJzfBWoC/yXMyw5AMBCF4VeRWZtEq0S8iljQDsbCpYNIxLsrl
 l9O/nOBkGcSKKMLPB0sPE8BKo7ADs3UE7ILBp3oPMmUQeYZ2a/Y8UmCyhSZa3WeNjaF0CyeviE
 kVf1b9nYku70ncN8P40QaPHEAAAA=
X-Change-ID: 20260514-iio-irq-fixes-1485db263ac3
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.16-dev-17187
X-Developer-Signature: v=1; a=openpgp-sha256; l=2247; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=6n25b62lPh2X1tEt+smWWVSeIbgE+aoTOIk63qm1678=;
 b=owGbwMvMwCV2xirl17qZay8xnlZLYshivT//TATDtPRrHg/WNi48+z1j4Yuc8wkTee1jZNe28
 6+s/GGk3VHKwiDGxSArpsiy9McJRYFAh9LelwmTYOawMoEMYeDiFICJ7A1h+B+by5H19apUryXv
 tHIbaamP6/8VX133e/aBz8a2n6MYLD8w/NP2armxuojt0Cb5mfwLZMp0uHbv3leUb7GhYUnXfN8
 SIyYA
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Since commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT without a
threaded handler") the kernel warns when requesting an IRQ using
IRQF_ONESHOT without a threaded handler.

iio_triggered_buffer_setup_ext() always passes IRQF_ONESHOT to
iio_alloc_pollfunc(), even if no threaded handler is given by the caller,
which results in a kernel warning.

Fix this warning by only passing IRQF_ONESHOT if a threaded handler is
given.

Fixes: 23f2d735a932 ("iio: Add helper function for initializing triggered buffers")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

I'm not sure if this is the correct fix, or if the
stm32-adc.c/stm32-dfsdm-adc.c driver needs fixing.

For iio_triggered_buffer_setup(), they both use iio_pollfunc_store_time()
as the hard IRQ handler, but the stm32-adc.c in PIO mode and the
stm32-dfsdm-adc.c always no threaded IRQ handler.

As iio_triggered_buffer_setup_ext() always uses IRQF_ONESHOT this triggers
a warning since ommit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT
without a threaded handler").

Another thing I noticed is that iio_pollfunc_store_time() returns
IRQ_WAKE_THREAD, which should trigger yet another warning ("IRQ %d device
%s returned IRQ_WAKE_THREAD but no thread function available.") if used
without a IRQ thread. But I'm not using this subsystem right now, just
stumbled over the new warning.
---
 drivers/iio/buffer/industrialio-triggered-buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
index 9bf75dee7ff8..40eea3a44724 100644
--- a/drivers/iio/buffer/industrialio-triggered-buffer.c
+++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
@@ -64,7 +64,7 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
 
 	indio_dev->pollfunc = iio_alloc_pollfunc(h,
 						 thread,
-						 IRQF_ONESHOT,
+						 thread ? IRQF_ONESHOT : 0,
 						 indio_dev,
 						 "%s_consumer%d",
 						 indio_dev->name,

---
base-commit: 86138b484d6367a57312f69af4ec958806c2673c
change-id: 20260514-iio-irq-fixes-1485db263ac3

Best regards,
--  
Marc Kleine-Budde <mkl@pengutronix.de>

