Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1BE334C05
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 08:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775897960; cv=none; b=UelerJoy9wp6hV1ucnEDTzu4vCO7IVXaJ/+Z6tYAEaLfyjoBTSGKwh2RZNCXwRUuGQgDcCBcddngQkDtPfO/2MNne7rOkORLHzZkCLh0gTuwH09VH3KpcY9K+tA/vTRPAy2FRUYZA0RnGNZjUWNOf5cQt1RL/OWH7WbkYemFuJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775897960; c=relaxed/simple;
	bh=jglBWZpM6gb6r4jnk+50+pDuOMLGeUPfxSTArYCfDN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DwmxBE2xDe1yX1OvgCtP3tJaS2XHpIE6qjquhSfTlyQP9o1vmnh52aentmoIAZGtQwnrCt+Jrk480GjxGkjCb10dS+UBVKUpxO4CqMGMqT4Uq8ITRe3soqJg4uh5BanccEVx11LFf3GPCt6zDSPauujHZToD4jWO/Xzj5JZ4TwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmMLNrva; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmMLNrva"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43b8982c2f4so1672988f8f.2
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 01:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775897957; x=1776502757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqmzVUPIgrnm/cJHXSiJKFWklEbsgCfd4TNnk6J9pOM=;
        b=fmMLNrvaqciVRA9whIYmJap/DntcDqLwNlzL/NtYv7P5P3tn5Jx6Zv0s7JRLIX+3jF
         726pbGFmkevJFMKlgqrrhRgzpn/I2Sn8sGE4ziQyIC/mpJd/taipBdiqMpIpHRC2R6c9
         FGRrYu/J7UhDK9CuZR1xMczLfLpxBLA+fxP0zFwG8QP97VqaxEDP97PMZTdYlTA5iDW2
         WVfbiLr66O6th58Ai5ZFLT1X+BlhPCC8X2UTuhBSFvMaY9MGaAp/iSvGqc259x/iSJxM
         na7ZP25qAp3wFw7ml7OTIO4oTfQpzXCUy7UDVwAhv+xI2Ch9dXug+EHw2ACElmispTUt
         /6fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775897957; x=1776502757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZqmzVUPIgrnm/cJHXSiJKFWklEbsgCfd4TNnk6J9pOM=;
        b=lbanuoGiDphqa9VE62vrChbBzUrc+4tMksT7wpM1lTR3UnbBJ61YBIWeyBV1fIa/wX
         f18+lVGhNPdB4ynSEUP4kWPmopK/SLQxZTRBZksyFX6VNtYhW0r/WGd8RLwSQ/Cx1vNY
         2uF6XOuU8a5L0ycVg8qpkxt/4Ag2pXQF/x1rijkyqJKtN5kRJDnv6HVOyMjpGKVzceey
         0hqOBTYoQV9zJeJ9YoNS9kxeG94nclAoUjrBnbe9SWlfDEkok/tsVxPh3Zkg5+BSkA6y
         rb1hvCsg88lq0S1wYWWhrqJAfOegG0IydhR5SMKyUb6e86/DbSvyGSkr3rGJ2zVehLHC
         ovoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3auiHoW/RSVnrttTu0u2YK7dRrW+Fw2DztODttOw9qpClzoNNAh7S7lPmNK0aeHgfMeJGTGdxKS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdUDOAdkWHWuTtNaxfN7TwB+gSmQd1hcecMuYzXyMv7ufGREq7
	WuY07r4xEPzXHcDCVfwqT8zv1oeiKt3iyeIakQC+9gxm3qPQy829ZuTK
X-Gm-Gg: AeBDievR3fS5IaEHU7hL+Va976yXqMbAy+32Ke3PWLT17FZR147wLSt14tB8GtmsdAc
	iX8MNGHv+L5fDFyFd9Z+JZTi1Ja6WaUC/yo+bfApXOVQ3QYILjL6FySCI/RUsGMUldE2pOQTV4X
	IAVLH6bNDc3J6uFirG8y+PS80H/VMc+mzgz8ViA0mpZ2zHnbDDTpRdFZEylqtY1h551mcTvbQbh
	TBYjQwwZEDV1bzFs+oT5DJ+J5j6MRJcOXy08OK9CV85jTv4BmHAdDoLbUXbnzXQXJRS7eVsizQQ
	tVbKE3b9RWUneo7m0IdiGrHDw9dul02OdP5dhifUhVo6YRj4N+PCHpVMFNDIXFUR11fGWkdZjxc
	MQqxFSed4j7d3QSDQvu80pxtBs2b1Zm0NttIAdWurjZ+9BWFPXSr1okMOJnhOv5cO2LS/7OiHYb
	NVR9p11uvF5TW+E5zo+dE2geKXBK1CEYn/ALvlj2EymOtAYFfHAsgKZb3XEFnW11800FsmkMKCo
	TAiF6hi0FLm4ouxSlpEzJEI64mPkQQx+5y4rkY2a0gtTzq02FKBXH2GAYlFcp7MThY7IdNYsH7r
	1tII0NJfFppVhlq/dmEFSBh0O/zVEw==
X-Received: by 2002:a5d:5f53:0:b0:43d:242:b9bb with SMTP id ffacd0b85a97d-43d642711ffmr9663810f8f.18.1775897957264;
        Sat, 11 Apr 2026 01:59:17 -0700 (PDT)
Received: from localhost.localdomain (ip-86-49-246-182.bb.vodafone.cz. [86.49.246.182])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a69sm14483593f8f.4.2026.04.11.01.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:59:17 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [RESEND PATCH v2 1/2] iio: frequency: ad9832: remove kernel.h proxy header.
Date: Sat, 11 Apr 2026 10:58:47 +0200
Message-Id: <20260411085848.75381-2-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260411085848.75381-1-joshua.crofts1@gmail.com>
References: <20260411085848.75381-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove kernel.h proxy header and add bitops.h for
better dependency control and code clarity.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
v2:
 - removed redundant bits.h header

 drivers/staging/iio/frequency/ad9832.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index b87ea1781b..8873a6d11e 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -8,11 +8,10 @@
 #include <asm/div64.h>
 
 #include <linux/bitfield.h>
-#include <linux/bits.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
-- 
2.34.1

