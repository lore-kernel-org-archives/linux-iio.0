Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB1A33A9CD;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117860; cv=none; b=B6wsVqaYxuXv025mVeTikf65i/DqKc+IBQnYk3dF8KQ6Ht/9yQE0iS0fSamx4OF891C8UotL9AuYHacMF4ixkL3UwS7bLPJiqXOEoUHi9xNi7U0yTj4+7Wvtdih5w/ruz7W7WORrR+UkTBDro1x1IyLdx2NijlAxQPwxGw1zBa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117860; c=relaxed/simple;
	bh=ZEudIFOMkZH+LXKC81DG++ePZDeFIx28avMwVNLYPO4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M5fHcqRC8zE1p5lFgQEpnV1iVGq3tPLvX/h8caEREilQoR97dHm1F8ok3NdXysxb5NOjarQHKalHjQ1IHwzOSc4Bj7/Z1DjjgS01W41xpFBXRfkuh5rLlaZ1s70pYNqdKCzSysqvht5zU6E15v9FNmjNLjJ00/Ulq0TLo7OiTbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSUEvto7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSUEvto7"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5742C2BCAF;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770117859;
	bh=ZEudIFOMkZH+LXKC81DG++ePZDeFIx28avMwVNLYPO4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HSUEvto7lfcPnDF1WWwo4GvznIEeyCqGn1z+LudgiNGZYDz05o5/qLVt88L1zjMiX
	 12/t47dvqKFj41J3+OAf+NLEoEWzedHiKYnKoF3Z+TSXgvlYvZOw1Ktc+3a+LdCX/A
	 wyq8q6fAZwv2aQYR5kJYFR34bluvzooUDZfCcrJ4oJkFHNPRVqn6yncXAZrIcUs4bQ
	 7Xfu0VOTizC6VghPsxEqNapWMhDd+u/H36+WzYGvwS5b7/TRJXH5ASp/mL5XaU8hLP
	 PaFPMs7GQjLTEQC9Da7hV6fAPT0el7CsG1ABoX/EenIKwEQwArwBUuxAFkuKTSo8YF
	 EM72alkKEejdQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9724E6E814;
	Tue,  3 Feb 2026 11:24:19 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 03 Feb 2026 11:24:12 +0000
Subject: [PATCH v3 6/9] iio: amplifiers: ad8366: sort header includes
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260203-iio-ad8366-update-v3-6-5d5636b5181a@analog.com>
References: <20260203-iio-ad8366-update-v3-0-5d5636b5181a@analog.com>
In-Reply-To: <20260203-iio-ad8366-update-v3-0-5d5636b5181a@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770117857; l=1177;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=s8rA3b2H1BNCIQuGiHV+VZ+q0tCGOGK7fNQac9O3/2A=;
 b=6nC3fXTKZ6yKd6LIm5kdhd1WpXb+6nc/95oKvrPcHm5ISsHtbPa1K5gWxYdl8ecEO9Og96D8X
 pgEXHp8iuFZD5YaPCqylqB8QTeiObfXzBpxgdk014ZMYv5aFWG4Lhhn
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Alphabetically sort include directives and drop include of linux/kernel.h.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 drivers/iio/amplifiers/ad8366.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/amplifiers/ad8366.c b/drivers/iio/amplifiers/ad8366.c
index 2da10c748362..40b03e417be8 100644
--- a/drivers/iio/amplifiers/ad8366.c
+++ b/drivers/iio/amplifiers/ad8366.c
@@ -11,19 +11,17 @@
  * Copyright 2012-2019 Analog Devices Inc.
  */
 
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/spi/spi.h>
-#include <linux/regulator/consumer.h>
-#include <linux/gpio/consumer.h>
-#include <linux/err.h>
-#include <linux/module.h>
 #include <linux/bitrev.h>
-
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
 
 enum ad8366_type {
 	ID_AD8366,

-- 
2.43.0


