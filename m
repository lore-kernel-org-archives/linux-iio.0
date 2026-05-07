Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EEC43C057
	for <linux-iio@vger.kernel.org>; Thu,  7 May 2026 19:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181095; cv=none; b=dnmdsvZov8QeH9HKxXTokAMd3AlI3KuKIJ3tuemHYScAkMLnXc4wqlT9ob3YKkWIreTUpxL70oQY4CpwWZf5v+7FhUXCD+iKEe9WFUvw9ARTi87RsfxIFybMU6O6JdBfD0HNSYUCuCAtAv907hstArbN4eosymP+5lNm/Wueoh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181095; c=relaxed/simple;
	bh=+7ILlnyn5c7XEc3OzoirjlxN0hSd6JV+0LLZjBvfOIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f6qXb2LfZFK3P59Hm5QgEX0JqhIvy8PiIvqvv1I+Paw3TmIXNRQRw9OhIBbBzOdI+A8YL4xhbDuwNbg+0BfZm9dR9ovHUvL3JMlKJ9+vmddY08xMT9R5AMzgoyA221DQ2+/bz9u6oHeJr+yd+jlpFL9sAzQ5KmEzRlMGN4D0rS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxhHqXIZ; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxhHqXIZ"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3939d2bd7ecso10655701fa.0
        for <linux-iio@vger.kernel.org>; Thu, 07 May 2026 12:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778181092; x=1778785892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nJUslQhKjmMp3xLS2mnhOf51II473zj3YZKbaX+WqUo=;
        b=pxhHqXIZhDFOjK/EKVxTu3np2DrBHHBfyLZHT73WmC1gTrvjBEfiXq5fUUgLVnYuIG
         lAWCmFGJgW7JkKAnxRK4hSOmV6iTmVQ8MDRw/Ns2oHfYqedVHYyRFS9jfnvEB2T3yK9H
         ukDUWyQ3gzqoGf/wS4fLECP2Zpt9ar4FGeh1H/jjSuwA2Yre/V48UDKxmfVgYPIpfBOD
         Rg9vHzB50hIpmaFK/SRi2/dJehftSLjnYMXfn5yNWUBpWWAxF/BHBQ84mYKZqcYdjKp0
         lqdjNc95WuRPldBuCg48CMlfTnUm9XV+KUrykApLD6pkYdoRsxwddxBb0Jqo499530Hr
         9F+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778181092; x=1778785892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nJUslQhKjmMp3xLS2mnhOf51II473zj3YZKbaX+WqUo=;
        b=U6hu8fzpn7ckgo0DAUQFljWoE/+sBye4uFyy9Lwtss0KNs1oibOg3bGavpsAk691YP
         oFHYAHhwQ7jpkH1BsinKIA4L5u4ZoAMqT/eXmukPyDH/wxmY5hbj8md2zX/G46O/uM7Y
         MUDHejspKfHKM3fOHwCS/jb/mOKpiK31tCEgdfR2Zauz6FiLLwfi1+zJcBkfXF1aAGPn
         Mot5PoZ0Zb9ovaRcXon8Yi7KBpZazyOGf2PM/pTx4d0CvDmg5RuuZrb2NXaSPviqHFV1
         nsufyJwNXV+mqb3sJX9Ce/y92gURwAcCuP2JKc/6bLufX5t20sY3p/vmMlA2+YvBTfCx
         bR2A==
X-Gm-Message-State: AOJu0YzvjafDY1gMncTjAPahbn6hYYPepSZkBJXE2cDkrXNkgPXc/jUb
	Rk5o7AN5bJ/nHMGPqcNmP5sMBl1D/+yUyG6W3c2AYTFXw2sNwWz2m2PF
X-Gm-Gg: AeBDieu2FMAgBujrfhKiXD4q/xs5/6A8cj9yqQPHmNdJ8UI94R9KDDABo8VN+zorwF2
	Aqr9qaIy7v/gxFgJUA0CyfLLKIQRKmH7L7l9yTfp1zDk0FLMY5D9x79r6u0R956KuCetcsrbM6H
	VG/QGUiwQ4RUJxLb+Y+bpqfwqwooJBExK1dlpJ4tYJHLjAaP59wTFmW4vT2vpqPOqvi89Z0ww/0
	hGFqeX1lxdkj6tIbq4hty4xqak5EB11H/dm+sU3aCCDupa+D95qYi3c32zaCRwfSHMsPV1y12Ys
	k3U+Wp2HAjFFtdiKLSFHXOphuxqMgNWfD6jKGSLaaOdH3+uTSuRdWFJxpM3xD2L2mn/kiDtQEZV
	0zBtJxt5BBKMo92rRh6qwCJ8/3l60wPuuMs2ckHjV4FX1vMD6vaRes8bpT6g81IctF0GWTxAfWz
	wnIwVqO1n7jR88alCk/XiL1grJePjwWU1qB9DtRyMsOhr2kD6bw7jgtS5Y9hPZmKaHuExYqqCea
	u4=
X-Received: by 2002:a05:651c:3543:20b0:393:a39f:5826 with SMTP id 38308e7fff4ca-393db0b888bmr10325471fa.21.1778181092185;
        Thu, 07 May 2026 12:11:32 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393ef1b2b91sm1612271fa.1.2026.05.07.12.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 12:11:31 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: jic23@kernel.org,
	mike.looijmans@topic.nl
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v3 1/3] iio: adc: ti-ads1298: Add parentheses around macro parameter
Date: Thu,  7 May 2026 22:11:26 +0300
Message-ID: <20260507191129.25924-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ADS1298_REG_CHnSET() is missing parentheses around the parameter 'n'.
Add them to follow kernel macro coding style and prevent potential
operator precedence issues if the argument is an expression.

Acked-by: Mike Looijmans <mike.looijmans@topic.nl>
Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 drivers/iio/adc/ti-ads1298.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index ae30b47e45..cf5f954206 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -66,7 +66,7 @@
 #define ADS1298_MASK_CONFIG3_VREF_4V		BIT(5)

 #define ADS1298_REG_LOFF	0x04
-#define ADS1298_REG_CHnSET(n)	(0x05 + n)
+#define ADS1298_REG_CHnSET(n)	(0x05 + (n))
 #define ADS1298_MASK_CH_PD		BIT(7)
 #define ADS1298_MASK_CH_PGA		GENMASK(6, 4)
 #define ADS1298_MASK_CH_MUX		GENMASK(2, 0)
--
2.54.0.windows.1

