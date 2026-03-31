Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895EF3EB810
	for <linux-iio@vger.kernel.org>; Tue, 31 Mar 2026 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774947054; cv=none; b=WkcGmPubAJdRmK9MW7KDjZweXaHOV2+UsjT5QYG7yspr6rVugobia1kaFD7+XijziFe74a8yAinhakYL70q8aP7MIOx7+QesJ3do6QNksjVCH8ksU7wrhmcGO4GaFTg7e5SH73mdDw5p3dFwMGoHZ8HJxmXZPEmzADSNXumTSkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774947054; c=relaxed/simple;
	bh=hEvrg1VgBxZ83vGHPoZyelEcdFEP9n7WwNRrQgglhPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tPS/fTISypwiSellOmz7HLuRlfu2aEggMlXDBssKDRwrplX7ouB75khJC1/duiNceNKNHYoVEoAVQst7wiK9t4T6t9pCLwhZRz8FD8sOrXZhB4OpR/10CnWtAXgi9tXvQW0GTI/htL40aFdv7YNMsWo4Xp+WC2fJqe6SQkJN5SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WE75VddU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WE75VddU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 186F01A30AF;
	Tue, 31 Mar 2026 08:50:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D959B6029D;
	Tue, 31 Mar 2026 08:50:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 92E3E1045049D;
	Tue, 31 Mar 2026 10:50:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774947043; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=g/R8nvIUjydE7o/OpG+ZQm7VsFlI0MLtO6nqskaGhjw=;
	b=WE75VddU4+vhxp15YnMHtJ2uohhTNkS/uJuJ76AXJ1k5PpOrGIi54sSPAbaUzPe5SwBCIK
	eO4tnHn2oS21KAeqStzhj1KFrSTStm/ycAxeWY175dELF6WkTucMNwKqEnEMPYqvrBBHyj
	h6M7c0rAiXExdJqwEppam+bz+5957gqa0Jw13xCoaXBYSqPbWc6nt+FctYx8WOLNemRg4G
	WQz+1avByt+94QSyKvnsUFnGGw82Cbk1dwgaFkYPcly8nB/gM447KS5gMw9d0iQuv0Nhui
	ySOgyUV5NvrYVVqBeESo5+cWojhvD9APFsmjAG7/OIVvYpvL3bkwo1XS20LHuw==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 31 Mar 2026 10:49:59 +0200
Subject: [PATCH] iio: inkern: Avoid risky abs() usage in
 iio_multiply_value()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-iio-multiply-abs-usage-v1-1-2ae8063e80e4@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSQqAMAwAvyI5G2graPEr4qHVqAE3GhWl+HeLx
 4GZiSAUmATqLEKgi4W3NYHOM+gmt46E3CcGo0ypikIj84bLOR+8zw86L3iKS5apSqOtctarDlK
 8Bxr4/sdN+74fwwiP5WgAAAA=
X-Change-ID: 20260331-iio-multiply-abs-usage-2762180a8b0c
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

iio_multiply_value() passes integers val and val2 directly to abs(). This
is problematic because if a signed argument to abs is the lowest value for
its type, then the result is undefined due to overflow.

Cast val and val2 to s64 before passing them to abs() to avoid this issue.

Fixes: 0f85406bf830 ("iio: consumers: Fix handling of negative channel scale in iio_convert_raw_to_processed()")
Cc: stable@vger.kernel.org
Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/iio/inkern.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 0df0ab3de2709..59e8c01457f72 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -618,8 +618,8 @@ int iio_multiply_value(int *result, s64 multiplier,
 			denominator = NANO;
 			break;
 		}
-		*result = multiplier * abs(val);
-		*result += div_s64(multiplier * abs(val2), denominator);
+		*result = multiplier * abs((s64)val);
+		*result += div_s64(multiplier * abs((s64)val2), denominator);
 		if (val < 0 || val2 < 0)
 			*result *= -1;
 		return IIO_VAL_INT;

---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260331-iio-multiply-abs-usage-2762180a8b0c

Best regards,
-- 
Romain Gantois <romain.gantois@bootlin.com>

