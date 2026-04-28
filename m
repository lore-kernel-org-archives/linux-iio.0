Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48D442E000
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 16:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392840; cv=none; b=YddLEHSiU1EsbrFLzSR2x4V5KQnaoLY0hluX+bZ2nKlGleAUvanyClDylbrrmPcED8Akqv4n2jMkyA1r8ynLV6GmbSGeJLUWJMnmsXpbNRFavRoSzGeaXb5CPypYv9dQlbF2vkFP2nlXU5gzIQiBEwq1aFd+Cz+bsqg09oE7LP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392840; c=relaxed/simple;
	bh=5lkvb/wsA5/YvIaUBq+WUWeprvDI/3b4OZ4NvUxazcU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kXVY1YeOXKJhp8B4UGpWcdJFiYz89NDSMKR13pcQPW4NCekPQTC1CxxVuBSsI0eGtgvEZoyhKVJqhnJBEC81yMAWIsSeBQauBaRl1hxr0Zm1Jjhz1o87xRzaFlWGbSVQ7XKUcQHNLUsxDtq3ogABcgEGlUh1Cuu8QnYEEWvRd8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=SCvmAEk+; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="SCvmAEk+"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so4063588a12.0
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1777392836; x=1777997636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+dx3LH3jjaBkrRuI7gW9d67cKHIpeRdGzFxneZTd1ec=;
        b=SCvmAEk+FnoBycQDmWKtpzV5Ib9HGvguOhZXZXXCFuYvLJDLRBk8yDQjL67dCxKzcR
         yPLmuDZmDBFOcS4U+5Wd14o2j4P8MEVctQgRnfvVAgeU2aAiAfS5Qyp2k23Z4hGeYVni
         XfDGtMKD37YCXLFMtkwz6swYKVHt0RrDrIVGmoQfODtt4NgCWqF9woCkaQVPPH6gMKs6
         f9b1CDiZjxbVD3hMSZHH/XFwGSEsuJ1tKrjfYZUJzXIb/flqbrpf0YAViwcPVQ08aqxA
         SEq1ZO7WCM1cTQrYJEO5u5RGSNNd2ykGrzHAGsj9ZwjjtOKdknkDpr6w6Q0/22yaA5Ez
         UO7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777392836; x=1777997636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+dx3LH3jjaBkrRuI7gW9d67cKHIpeRdGzFxneZTd1ec=;
        b=lXwsazmMaqVSqb5xGl65GQLQp1Q5PvQmq2sNU/RlScTc4mtAORayBqm6v50/faAAFY
         mk5dPlMXiMDZOuNrynEZdam23N0/h1dDiH3weOMMuG/hISDhcrz75Sl2yIA9RwcFjunM
         OvaG3MwjHYxCHW/HE84CXgIND7fVEzNcRy6fQHrnuJXnziLhX3wijbnJx6aFwrZaelXw
         qgDbS+gBtKZ+XU1NrBbTTNW5fkpHXOF2/OvPqVUwBiCNPSuh7F+aDytTVHNTX5uJv0Cw
         i68ErCKG9jOK3DwNvOR4ijgiZtL/YviXWZkH2idJR/nPwv4+rceCH+EbffWE/vAaytJ0
         vtQg==
X-Gm-Message-State: AOJu0YzAgrGv4Sa5rlETftojBgpOiL6SpiJyu4YdBvhssKKwZFoNcqjd
	vjVgKYT814yGBkKC5apMGdH5zhUeyUz6zE1brVT3NDsmQP9r7Hfzg8B6t8HkwatuXVM=
X-Gm-Gg: AeBDiesRscaPKrDR+eHs5x8Zx9LK2886Un4xI5HWnYK/BRpkA1g3nVtJW2CA9qWjqV7
	JsIvz3zkO1QPDw8af0k34XZSiShfnofiH41sviCQuQnADf0T9ohT7uI3IYPtaFXBQpa0jX7td6B
	GNuiW+qtdYgj6KaCsbqUP09ztOJk3upUyf7ZieHlaPItr3rjFqV1Pa6Y+aTSM53Zr9hlIWn7bhl
	2Wmp8Gu8egy4M9kHZjNFMUS+/YDiYF4ivxmJArWg0n/MO5PhG6Fk0xgcP48yIMUNpS7Db5IrpPN
	FrBt5AuBxEsOF5Ad86IQdV+DLsiX16nSJ61+/ltFAMX0PuN4y6lJ3stsbGt5f0tJ3vvMk6zQr0o
	NZMpzi2AVOW8dhvQheCYOKhTJJaCjN52k79albSBJ64FzCW+ODOD+T91J1K70xOBGB00ZCZOSjH
	8lAQDVRjX2NYTPu3kRbzNZwyuAV/d1y+a9wC/kUfZ+QADX5VjHmEDTf5w1oLEZbtY=
X-Received: by 2002:a05:6a21:e083:b0:398:8204:8d83 with SMTP id adf61e73a8af0-3a3af38b1bdmr380517637.5.1777392836015;
        Tue, 28 Apr 2026 09:13:56 -0700 (PDT)
Received: from rafael-IdeaPad-3-15ALC6.. ([177.75.207.206])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7fc35d9313sm2887728a12.30.2026.04.28.09.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 09:13:55 -0700 (PDT)
From: "Rafael G. Dias" <rafael.guimaraes.dias@usp.br>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	joshua.crofts1@gmail.com,
	"Rafael G. Dias" <rafael.guimaraes.dias@usp.br>,
	Felipe Khoury Dayoub <felipedayoub@usp.br>
Subject: [PATCH v2 1/2] iio: light: stk3310: Sort headers alphabetically
Date: Tue, 28 Apr 2026 13:13:38 -0300
Message-ID: <20260428161339.1187956-1-rafael.guimaraes.dias@usp.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort the included headers alphabetically and group the <linux/iio/*>
headers separately from the generic <linux/*> headers.

Co-developed-by: Felipe Khoury Dayoub <felipedayoub@usp.br>
Signed-off-by: Felipe Khoury Dayoub <felipedayoub@usp.br>
Signed-off-by: Rafael G. Dias <rafael.guimaraes.dias@usp.br>
---
 drivers/iio/light/stk3310.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/light/stk3310.c b/drivers/iio/light/stk3310.c
index a75a83594a7e..1fad9367c2d4 100644
--- a/drivers/iio/light/stk3310.c
+++ b/drivers/iio/light/stk3310.c
@@ -10,9 +10,10 @@
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
-#include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/regmap.h>
+
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.43.0

