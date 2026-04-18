Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96F5199385
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776517446; cv=none; b=N+zSzHr7P8wP94xuPJRcOKE69jOUmxK3cglMzldJPR3orP+rU//Hfssd/dHpQkdebMF73k+rWvdUqGxAlkWiW0i8GGOVl8FUy+4yR6uThTZ/lD+JCH/pY5A7rEUDEC4hFCkuh3/s8H0YeWrpqkt5KHbp8ZKBxczWFzVWNPDlfX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776517446; c=relaxed/simple;
	bh=qeJshGCQqFO4DjZW1jEz8EpT6HPXh458wD9+sA/l9Ug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uv/XtM9Azwg4Aq976DMkRTsERE+mEo0a4y6pdc+oGmrbQbs/CrPF4ayEhmX+FZq4StNB/OnF2qMGZlqrBmc4TMnPt4PO9hTNiW7jXrqk9SrcjSu2xcoBTIJp5xgLKUAVs5b+QrqGzKdIGr9K8jl8VcOiVyiOHgkK7mcwKkMrFOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=PvIZJokn; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="PvIZJokn"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12c79c7ba8cso642280c88.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776517444; x=1777122244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkT2r7fJiYwCaYwKBJ9IoJq5JEUahcvvpqpQZZoUP0w=;
        b=PvIZJoknFYO7oVN5O7CbxppN2RFa3hbu0zahxs//O0/rYlEhDWncnjy0VmwHHz4Q1x
         FOhn4vLwP8X8jbDk1n5spCQiR1N3F0VtbEGKr0SezER5aHzYwfTvgL6InLE0Ehv+SrpZ
         78t24kZz5f3HLv6NrSQNEFbDeC3bv0gNOKhnTx2RmyslTYaVhQHYqJMeM/VoJSHo/mEl
         lHAW859TjFor3WqTgCbHCLfFY4GeThrichuO+J7q38F6BeZsHc+cyCzKZ5xqg1VGnT2r
         s14RP/ZjJF664QeuHd7kPJN2m2f5oGLAq1d0NA66v4WKFWCg0K/i7YzIu+JntXWgXVj7
         5Miw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776517444; x=1777122244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PkT2r7fJiYwCaYwKBJ9IoJq5JEUahcvvpqpQZZoUP0w=;
        b=CM9ANGTSJ4cK5QajvURZgTzrC8zm/AH5/4sg3Z6p6K+Zjabl9+qz9kyolPPZM+ZYv4
         dI/4MyxLcHZT2TduhTi+Rk/nsD9NBIIdaah7Lg/urkuJaNdpqEtOmgWsI+UFtNqaP3W9
         lf/k8g29tgynLtgRJVGq08UnXHJLdztslUr09lNpYYi225fyU77N2XFdNxCBjFpYIUXb
         3zsXBT+SnXuS4Drr7ZL/4astIJaw+LqxpYSes+wEH+yrBVLxmuJ+nLXPw33GmWENWLkl
         JXSiEGt6G5TWrhEv6OcWzcC/utOxtqqbwAg+dnVCAgXjcCnj7pxZNEZQWaGrGOzehFcg
         QBjA==
X-Gm-Message-State: AOJu0YxVmN7BEXIMqKK4fu9FJMipn6TNDpjBjWzDqnmR6u79YcIQwQpW
	X3SVaRsDWALCY9cNt2SXSHClk5TJGorK6dHY8ACDLds8Gw0AVWvNa/H7LqzM/qb85oWio4pGOyC
	hVnIv8SqvNw==
X-Gm-Gg: AeBDiesbufL4e3nKoE88d+5UfFLJ1bPzXhkbDAM2HybjjPaJpqS3MjwitNbi1oEil77
	W8PkXz27NX8ZfDMuAKc85te0m18UOYAjUdhf8fh7fVdTj+Iz8Mxi0peoA1MbCi62BGwP/fTAVSN
	8vqYg90qJ71cxK1A0CGB14kwtDFi6xniihxcLegRlL+MFX3VU0zCQiAJHygA27X7gPVKjCeu3BX
	J8a+KJBD9ZrgOvuhUAC3nH2HJiykshiZkyq00vsqWKEqNTXTDxp4PtxEQLrAAF0eW0BpJe8izNl
	0kO/+KMGhv/7EQjC83P1kM7EegFN0xXLn+INXKvUeBZMqQy1E8Wu8nPsYbahhguYyaGbv85yl1p
	cOk7sC0L5RwlRH0QvH7CFgOJX0eaEZ27CCoTioQQQZYJGz1CsSCkOx7vga9F5GYP5kJDKTu/qyo
	pKcuwvCzk8Cq9iyrF4coMJVEAbXhPFRO/l/QGYm5aHW6cwgC/i
X-Received: by 2002:a05:7022:f212:b0:119:e569:f84d with SMTP id a92af1059eb24-12c73ae8ff1mr2495666c88.4.1776517443658;
        Sat, 18 Apr 2026 06:04:03 -0700 (PDT)
Received: from localhost ([2804:1b3:aa80:d8ed:6b55:82c7:991c:cbac])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-12c7b62fe87sm2630057c88.2.2026.04.18.06.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 06:04:03 -0700 (PDT)
From: Erick Henrique <erick.henrique.rodrigues@usp.br>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com
Cc: linux-iio@vger.kernel.org,
	Erick Henrique <erick.henrique.rodrigues@usp.br>
Subject: [PATCH v3 2/2] iio: dac: m62332: Use guard(mutex) for locking
Date: Sat, 18 Apr 2026 10:03:22 -0300
Message-ID: <20260418130322.106769-3-erick.henrique.rodrigues@usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260418130322.106769-1-erick.henrique.rodrigues@usp.br>
References: <20260414233912.662606-1-erick.henrique.rodrigues@usp.br>
 <20260418130322.106769-1-erick.henrique.rodrigues@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock()/mutex_unlock() calls with guard(mutex)() to
simplify locking and make cleanup automatic when the lock goes out
of scope. Also simplify the i2c_master_send() error handling by
using sequential early returns instead of a combined condition.

Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
---
 drivers/iio/dac/m62332.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index 4b139904e818..a9bb6c307431 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -10,6 +10,7 @@
 
 #include <linux/array_size.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
@@ -46,33 +47,26 @@ static int m62332_set_value(struct iio_dev *indio_dev, u8 val, int channel)
 	outbuf[0] = channel;
 	outbuf[1] = val;
 
-	mutex_lock(&data->mutex);
+	guard(mutex)(&data->mutex);
 
 	if (val) {
 		res = regulator_enable(data->vcc);
 		if (res)
-			goto out;
+			return res;
 	}
 
 	res = i2c_master_send(client, outbuf, ARRAY_SIZE(outbuf));
-	if (res >= 0 && res != ARRAY_SIZE(outbuf))
-		res = -EIO;
 	if (res < 0)
-		goto out;
+		return res;
+	if (res != ARRAY_SIZE(outbuf))
+		return -EIO;
 
 	data->raw[channel] = val;
 
 	if (!val)
 		regulator_disable(data->vcc);
 
-	mutex_unlock(&data->mutex);
-
 	return 0;
-
-out:
-	mutex_unlock(&data->mutex);
-
-	return res;
 }
 
 static int m62332_read_raw(struct iio_dev *indio_dev,
-- 
2.51.0

