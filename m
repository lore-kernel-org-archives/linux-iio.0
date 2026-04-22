Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9F42BEC55
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 22:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776896820; cv=none; b=H+lab6h6+zHWIirh6ts3CznYc2ZHBvaobV2/Ulmv6RxXzvRzDEnrvrx7rCbAR95j13Mil0WGa2qPoivrS5rVD1X5GNCm60FzEszgwhJDrlBydrHwIY5u/vHqUAG1u9vbh/Ptr8dlm/29RsgiJn7+mg3rq86i7CN8/MqZY3RNuvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776896820; c=relaxed/simple;
	bh=OAlJt4RlxsRL2WvEW3bfAdWumjV43pAUnI+x1VhkpW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cg+OE/D3XEd3jhnddvwOioINcPBPoySRITdpW0TeW1mZzeR2s1reKIX+5QqaLMdcSw79NzxhkferjXZiMTbXuua0TEK1qrw1rQuSiDfpvM5jMmc8YnpXyE8qLEvcy5gEshhzkhz1PxVoXKWOtEt9GzL30yvwTe3hJFwTnZ/2AHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br; spf=pass smtp.mailfrom=ime.usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=Hcq/CscP; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ime.usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="Hcq/CscP"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-12c565476d7so14648924c88.1
        for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 15:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776896817; x=1777501617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PepQPPeojheSPpHQw+R4ii8kTQKdxWZb+GAeuIvmEMY=;
        b=Hcq/CscPpCfFfN5JimTDXdonLZb0uxGM04cApFB70ALdsMe+cwbHpHWWOfiswCUsbD
         8URx7c/9Zz5j0ubLTGKBOL/0vOwqa/BnMoj/eG6y3rMCbo6SFz5mGEusrngJYcbs/PNp
         TwZ5buBhOD7IXJsEs5Z/fus4Z2V77vZ0vFK2KGTdpk8RDNvMIXJZ92fayDFxIviAfhMv
         Ec7cb5Aoc67a5Cu18U+/1q5o1GBo5c3I7l+ouLbDYUbVKFn5TBkE98QqBn4rNu4WqRW/
         IwkjB65J6JW/tnHv0c9g9RvB1InAzvMXp5wwVjoV8KoBAOjZEKh/gJR6eGG8tDtQYKd0
         XuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776896817; x=1777501617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PepQPPeojheSPpHQw+R4ii8kTQKdxWZb+GAeuIvmEMY=;
        b=nqMxgakRi1Dzc5jtsF7X61yu4+0l47AeS3phaMpiT9c9yMjHt1AcigyATyQZPKCkMi
         BOh9d8uBDDotpDo/TNZ4UdzP3rYmXXusklQeZD5aJitKP2Oiq6LEa6w71vqhFk6sOT+8
         1V8jTayut0h10qn0jUmfJ10dsumbpSnHe+Tx/llJvD10bgDXDoOA2r/h0t+d87fffFnQ
         4QfGzXu/JJwMBRg1FicEuITj+02dpaFKH7le5eqnT1VxlOYjS+ev4wfmZcvJaRaCerUa
         wd2TXkrDdiviLPWMNR0PSvOIktzJslfpKcEzmnSpuDKPCw69eVAVNKzp8RrVX52Z2F03
         9iRg==
X-Forwarded-Encrypted: i=1; AFNElJ/Pp0muElIIfcr+tt5QdjZtENTbtkQMLO3eUvcHnJsOm0sH2/BxQAluNm3ZDmBE5efsHjdyS/6x3eI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFO0elMMfl5EjM0FTC1BWCnp06XB+38gPih41vzEeqV/gMUNCR
	IjLNRLoLIQddY16wxb8IESj46cXq6TC/OulwYsiUBhEpTJmPKCp/dFGZT4BLsnKzFRs=
X-Gm-Gg: AeBDieslSDPUyaCOwrLUX44NHWSoT2iTzO8CBlOC+2IYqcWfqhPKXT1fuEDQKSVr7jT
	daEUH5dQlXuzavk8UdrCWNbZ1UKCut855Af3Ti6XxdNipXXI/1GeBalN0SCHuyBnx4WCThYtxTK
	fUASqInbFqjK+jSAySsF1/TntdCzelEXlpV11H02YNfKMQCdrH6sZCr4Ou5uvARod7Nmn9PXga7
	vR5OkRz3k3YMfAVWD3zB48UzjKXUNiNy2wqZfRPMUnr1fwYLRSBDXs6U0nzApuD1ldwgzb1cgOt
	D42Wua4kcpCwYIgcoeb1MXSZV0ZZ9Uy6YXhqKGsjGicj8Zg4bl2OXppJXcX6FHkPVUSPjTXynrx
	c0pPrqFl4T8RiBhNLbZfMA1RJdezoScgDU2EAf0LU9yVezwy258w1U3nYvUdKh4FMhJcGkcL7Ay
	P99Ms+XZoyh/EWuquo40RfKtwXIyotxx+TeI6Pf2O984aIBrzwKGyFm1RB
X-Received: by 2002:a05:7022:eac8:b0:123:2c98:f6af with SMTP id a92af1059eb24-12c73f75a96mr14207542c88.14.1776896817456;
        Wed, 22 Apr 2026 15:26:57 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:190:8d7a:cdbd:474a:802:34b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c837f7feasm26293952c88.0.2026.04.22.15.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 15:26:57 -0700 (PDT)
From: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
To: andy@kernel.org,
	dlechner@baylibre.com,
	jic23@kernel.org,
	nuno.sa@analog.com
Cc: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>,
	Eduardo Augusto <eduardoaugustoabc@ime.usp.br>,
	Christian Barry <christian.barry@ime.usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v4 1/2] iio: adc: mcp320x: sort headers alphabetically
Date: Wed, 22 Apr 2026 19:14:12 -0300
Message-ID: <20260422222553.67660-2-gustavo.pagnotta@ime.usp.br>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422222553.67660-1-gustavo.pagnotta@ime.usp.br>
References: <20260422222553.67660-1-gustavo.pagnotta@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort include directives alphabetically to improve long-term maintenance.

Signed-off-by: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
Co-developed-by: Eduardo Augusto <eduardoaugustoabc@ime.usp.br>
Signed-off-by: Eduardo Augusto <eduardoaugustoabc@ime.usp.br>
Co-developed-by: Christian Barry <christian.barry@ime.usp.br>
Signed-off-by: Christian Barry <christian.barry@ime.usp.br>
---
 drivers/iio/adc/mcp320x.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
index 57cff3772ebe..d011f1732bd7 100644
--- a/drivers/iio/adc/mcp320x.c
+++ b/drivers/iio/adc/mcp320x.c
@@ -37,13 +37,13 @@
  * http://ww1.microchip.com/downloads/en/DeviceDoc/21950D.pdf  mcp3550/1/3
  */
 
-#include <linux/err.h>
 #include <linux/delay.h>
-#include <linux/spi/spi.h>
-#include <linux/module.h>
-#include <linux/mod_devicetable.h>
+#include <linux/err.h>
 #include <linux/iio/iio.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
 
 enum {
 	mcp3001,
-- 
2.43.0

