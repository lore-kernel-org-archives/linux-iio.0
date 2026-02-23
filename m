Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294F5346A04
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 06:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771829120; cv=none; b=XzzclhEOAL42XvVVJ7N32cXaPAmqTVI04ZbgsfWpYZCSVsAP1lqdbDdbAsKSV1Wu17K/WZBAnQqKsIToPJ2dbMjbSLi97qX+OjlgWxD13vE4V45uNOz+ZlsJMddQi3If6VSmG3qnSlNvj+MBj0apk+9IUlkDZN56t+qbEdOwuxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771829120; c=relaxed/simple;
	bh=K3P9fxNP8njIO/P502DKIOcwz10HNvUMFdtrVjvufv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MiZ/aQ/WS+jJhxD6/VnWVs/PSQsWXMfefiy3A0lSPcwVF+zHtwyQlIwSjWaD2iUqN+CxRhb8FWq/coHjK/mMR0/u0LP+iGQ1z9t1wUk9/oIwFP4s/1dmHVjdanwSmtpJqoX4Y+M+QJAgqjTSnLZhdfCcxFJRX+7qiI/FSrLeKig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIyDlUeU; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIyDlUeU"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c6e77ace76aso1886924a12.3
        for <linux-iio@vger.kernel.org>; Sun, 22 Feb 2026 22:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771829118; x=1772433918; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXhV0azrPlYS6kNUjPVnW8F0uHA/pAl/zuGixwAcoHE=;
        b=bIyDlUeUtb4r/iiAfK7BoIfnHtrXVpde09dswjVbIKeHwTHlLRZE5dev9S8x8kURTr
         bLFUF2WfcruOv6XrPeRv8+iacVBf0qHFGySk/ePwLS79rpBtddrNAENqYCCDfVaS/HsR
         /NTlZ4yEvp03wWmcQOWMCuYcukW0ArIFVfhfZnP+cUWld4IgHoRoEagz/u8mzzWu/3Ef
         IEia9GY/lmP/bXiYYVjQRmHC5TscgT+P/lt7HE0rD+H1Vo9y2I7ocJHVusEnYNKSSHId
         VgqngyBhKwnXfS9LrfpnoMBmBxKoCTzXK2456Aou3T9TnMgmlUvhRqxfKqKwQPpDV060
         WyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771829118; x=1772433918;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXhV0azrPlYS6kNUjPVnW8F0uHA/pAl/zuGixwAcoHE=;
        b=J726M34lpdCbmyoTtixX7kAanX0e5yyt9BLkbk3l5wbH+dfU84Rq1UIeZUV3ei/mcv
         yEm62PGsjQ+pkYwSK59O3MkzU5CcKOKondNzaDDPScjOflgMUWIlgCFTWgkjef3iEdKz
         EaRI4eF3qH54IOnj8Y0g8cydAiHIELa90h826Vm18pCE5bw2I25AtGT7bZPi5THrLnlm
         i/eT3n77G31hY1A2FTe9R1fMYmkKqWWpt7RzujU1pzDgGntacHam7MK9BFxCOsg+TOwj
         XdBwJC7RtWz+P99RHsI8Oh9e1FT9rXynhYJIgTARIgSeviim6ev95b1N0QkGMogddLLd
         F3Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUzCFHdofy+H7BHMMIRfosdYjRZNadrzkYwWEP0cXEVCNFselp/0IHUQharx/W2E+/pgHJViRcs1Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZx+Ub0TWtZ/xNULkXJnHMSPZvwkF3k9qW/DtcfgqRsVco597A
	VMaSrVDonXKCmHpY3blCWXXICTIsdMe5V+5gOfSqBAEXFy4chhNwv1qsv7wxzVGk
X-Gm-Gg: AZuq6aK5wTFxKz06h8KZ6nVydAS8BIkxgTaghwf3a9yLwrOjDFozemMayudgqoS4dBq
	WgETGiV0v3KoqthmOfwxl5pYUIhQFN3Whmcymtzg7/FClcy2W2f2i68fpNHQwZ8TlkXCBT7Q1TW
	kjbXDrl4l/1dawPa1hMAVYfngbrx+Q06vdQFwVB6QPb9q+u/Kipu2L9QyV8z3pqhybQd9MbtmUN
	VRYu85iqPK2KvhsAyn3hCE0wmmxSpbtIN0ABmsO2u6oPrGYAiS1vD25vmKBw0K7gQgWVZNVYSIU
	c1pF/Dt2twIQiGpIjhgvV57gBpbVzbPClYXiR9gQfbZbAVXQ3ezWH+oxDfHCQVyP+qkr4+GK46F
	UFEwh/kO/emNHTcg+cMJfW9ZTY0d1MKCLnK3HRRrlnMbERYAnkkxoxjteXIl52YUhB2Z+2nkSy6
	vDW6JkgJ3NjUdQNoVYTTKEEEp7uzS+4ECJVqGR+A==
X-Received: by 2002:a05:6a20:72a3:b0:371:53a7:a4aa with SMTP id adf61e73a8af0-39545ebb5a6mr6042952637.29.1771829118211;
        Sun, 22 Feb 2026 22:45:18 -0800 (PST)
Received: from junjungu-PC.localdomain ([2408:820c:9008:ba52:1cfe:ae34:fdd6:6b97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70b71814f8sm6068485a12.4.2026.02.22.22.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Feb 2026 22:45:17 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Mon, 23 Feb 2026 14:45:13 +0800
Subject: [PATCH] iio: adc: ad4062: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-ad4062-v1-1-8ee93ea173a6@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHj3m2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyNj3cQUEwMzI9205FQLE4uURDMLU0MloOKCotS0zAqwQdGxtbUAib/
 5l1gAAAA=
X-Change-ID: 20260223-ad4062-fce848da6851
To: Jorge Marques <jorge.marques@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771829115; l=1887;
 i=ustc.gu@gmail.com; h=from:subject:message-id;
 bh=K3P9fxNP8njIO/P502DKIOcwz10HNvUMFdtrVjvufv4=;
 b=4z+Fvhu9FezlIk7BDp6PCuItg5/Pgv10nosCNzQvA+LUGgMPCw1j8SBeLJtW9y4UloYZV4j9R
 Ekx1o5zjmALBV/9pORuHdRXQq5H66RmZmVYZwtnirgaLT/2CmFnwLB5
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjUXwmjchVN7Ja6KGP55IXOzFeCl9edaHoQIEUA+/hw=

In ad4062_request_irq(), when request irq for "gp1", the code uses
IRQF_ONESHOT flag, which is not appropriate for a primary handler
that does not have a secondary threaded handler.

And since commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT
without a threaded handler"), the IRQ core checks IRQF_ONESHOT flag
in IRQ request and gives a warning if there is no threaded handler.

Since there is no threaded handler, replace devm_request_threaded_irq
with devm_request_irq, and replace IRQF_ONESHOT with IRQF_NO_THREAD.

Also remove an extraneous semicolon at the end of
ad4062_write_raw_dispatch().

Found by code review, compile pass.

Fixes: d5284402d28f ("iio: adc: Add support for ad4062")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/iio/adc/ad4062.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
index dd4ad32aa6f5..8b03736d55fc 100644
--- a/drivers/iio/adc/ad4062.c
+++ b/drivers/iio/adc/ad4062.c
@@ -719,10 +719,8 @@ static int ad4062_request_irq(struct iio_dev *indio_dev)
 	}
 	st->gpo_irq[1] = true;
 
-	return devm_request_threaded_irq(dev, ret,
-					 ad4062_irq_handler_drdy,
-					 NULL, IRQF_ONESHOT, indio_dev->name,
-					 indio_dev);
+	return devm_request_irq(dev, ret, ad4062_irq_handler_drdy,
+				IRQF_NO_THREAD, indio_dev->name, indio_dev);
 }
 
 static const struct iio_trigger_ops ad4062_trigger_ops = {
@@ -955,7 +953,7 @@ static int ad4062_write_raw_dispatch(struct ad4062_state *st, int val, int val2,
 	default:
 		return -EINVAL;
 	}
-};
+}
 
 static int ad4062_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int val,

---
base-commit: d4906ae14a5f136ceb671bb14cedbf13fa560da6
change-id: 20260223-ad4062-fce848da6851

Best regards,
-- 
Felix Gu <ustc.gu@gmail.com>

