Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D91C38238D
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776790745; cv=none; b=ck4i0fi74+WFfd9CiouvQq9hwNNH+TCvJhtnXEAWK+8R8wN9M2PwUKynitwfu3BpUl8NDiR1uuTjxe/yNDin7mvScHuPcq5SY/an8mq7F61XToeSUPGLKJZoQoMc9+7LG0IP1OXXNPj4/vsyNOCIWF2Zb7YbKXh8JksDpHimLL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776790745; c=relaxed/simple;
	bh=eFtqPDTcs7l1KT4mpc3/UHNIEo6Sp/n6zBVVDnpbez4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HxePporYK0WaDPXW85xXADK6FNYOzATIFwFrmcV9u7OnA3R6MZWF4x6EeWa7W1KA+5b9Fa1oz5aoeXjO+VFuSuXKnyQOqwX0tbjjB7blqlcPiSmYasRHH0ZPF+4IK0ppc6aQxJR3kQ0ZTjL1LzR7LzwG9T4YO5wORjTer3l8Wak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVcJFJgf; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVcJFJgf"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b2503753efso43975175ad.0
        for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 09:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776790742; x=1777395542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M4gTfNuNRiJlpTgVpa2xXtrrGycCdn/zFfs6qHgKuHw=;
        b=UVcJFJgfKt4toOYTGQIwe+QnPhP5ZH0KUiG7YiUR28OhvYo15pcbxZA7rCJOqe/xyc
         nFfGKXSwTrj7Yl2kflvQa+X8mGKdOfUgVQwvn7XxjogDZNbqfTMbOair1CHoxi8/tp63
         iyRfZ5xqeon1DNR/oBhf+X0UvH6kQ7yCewYaIMs8JlZifPfo9lsgTS6qkGI+mzZCgf7f
         GJ/RFUptbjSG3xUaTPfXMqZmm5Ts9hsaAIk5yL+i0T7bhQxgW/59U4JJc7yK57FiAuEN
         Uq9ixOs1xxYMM0SOBctG5gU4JFi/fC1vCESkZrLvMrc0CH9VH3mb9UmwrYEs9ETyuRxe
         BdQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776790742; x=1777395542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M4gTfNuNRiJlpTgVpa2xXtrrGycCdn/zFfs6qHgKuHw=;
        b=OuRlxjErmU1mt2ZCrjkpcqrlijtLDrlomEdVwGTghh4cFtVgk85H+Tw4jXQWUGbdk6
         EcZVSj+TZY3SqfnAH8BGuKAXRA/nYbZXj3KRTAIcwweVsgAyJRkPkDn080lO87IH/PqK
         /8sUFjsY/C4bbDadp3EL0GGLb1IBkJuVKwjpppW8lvC3EXJ4FgcRGg+0FeQWsQHwvzhh
         B46gTsPaoCajrhvI37c97jLwNc2RTTuyYo4LVyqSd3bP926hH0GD+mxd3rOW4JbyAejn
         Uw70Ry1WHabItDhFqSsunZdegYQvK3B0pRyRBnRd9w1pRGwv4WHGkXqrQ3YNaN3dNBov
         DFCw==
X-Gm-Message-State: AOJu0YzDbqIJqVbWSCJoiZyoe7pAXT1XB0ZES8fh3jy57fPV5lYdGLoF
	Lz6RD4ZtCLpV05KMmWkhYagvLvAgznnagbs8cV9QSWZ1OCwPuOh/ICkC
X-Gm-Gg: AeBDiesUsYTNFzIOoLpCaA9473ZHZ7IrX1xp4/3pqkvMsquCE8FY/Kp7BJMDdUWLg1L
	G1+nEMt4LsQ70gAKK2TmvTyL7BfX1FJi/vqlPz/umPyeAxUAIX7os3ibeld+QPWGkzuv2VvwAiS
	OeBb0AUDe11msgaXC4NWxrApUmRhjohzu4Lowg0j9Kl5fBZ18bQU7fVZDp6bm5tiPyRPwrJ9EUo
	a4GOmT3gKzaVd7SAZx+gT+2it6jdgWqV+rZLUOZ+mnqsyw8j06BjoeC70wGhLeLVt2EwFtGYzZa
	6B3UC4YLki48ljUfsW9Gy6mXZN5xrmk7s/l4ccWF/h4B1dGa/ritlvSVRDKasd95whmP+BO6fJT
	SHku6sifh8tgIgmeoT5HZQXwAb/HP5FVrzcbTQ3db0bFsnrPlOXjMdL60PNtQK4iHHxUsHZYRF4
	/5pNJbWh6rrjKdlm70aEiF1cl77DifSjLYTjPH1AcxxY4PQndKOr2qH6xHN+Q=
X-Received: by 2002:a17:903:17cb:b0:2b2:67cd:9963 with SMTP id d9443c01a7336-2b5f9fd5c04mr187220735ad.38.1776790741750;
        Tue, 21 Apr 2026 09:59:01 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab32cfasm179748185ad.69.2026.04.21.09.58.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 09:59:01 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jic23@kernel.org,
	nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org,
	demonsingur@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] MAINTAINERS: Update maintainer for iio driver(s)
Date: Tue, 21 Apr 2026 22:28:56 +0530
Message-Id: <20260421165856.2245598-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

The listed maintainer analog domain email for Cosmin Tanislav is no
longer valid, and he would no longer maintain this driver(s).

Replacing email maintainer with list, to keep it valid all the time.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
Changes in v3:
- Following input from Nuno and confirmation from Jonathan,
  replacing domain specific maintainer with mailing list.
- Link to v1: https://lore.kernel.org/all/20260418211336.1800221-1-sanjayembedded@gmail.com/
---
 MAINTAINERS | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c981cbdff500..6498f0aed1ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -644,7 +644,7 @@ F:	drivers/iio/accel/adxl355_i2c.c
 F:	drivers/iio/accel/adxl355_spi.c
 
 ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
+L:	linux@analog.com
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
@@ -1461,7 +1461,7 @@ F:	Documentation/devicetree/bindings/iio/adc/adi,ad4080.yaml
 F:	drivers/iio/adc/ad4080.c
 
 ANALOG DEVICES INC AD4130 DRIVER
-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
+L:	linux@analog.com
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
@@ -1549,7 +1549,7 @@ F:	Documentation/devicetree/bindings/iio/dac/adi,ad7293.yaml
 F:	drivers/iio/dac/ad7293.c
 
 ANALOG DEVICES INC AD74115 DRIVER
-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
+L:	linux@analog.com
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
@@ -1557,7 +1557,7 @@ F:	Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
 F:	drivers/iio/addac/ad74115.c
 
 ANALOG DEVICES INC AD74413R DRIVER
-M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
+L:	linux@analog.com
 L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
-- 
2.34.1

