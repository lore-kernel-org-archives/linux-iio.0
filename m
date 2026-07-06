Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AB143785F
	for <linux-iio@vger.kernel.org>; Mon,  6 Jul 2026 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377586; cv=none; b=oq/3vJZMxBIznbK+j+r/+xDEoR2nB2gcuoJveJSZQWFWU0Cf1zEI7lxRGlWvmVjnMpSxeBSxyJmQZAUya6J/oXaTyCXltthliGWD3AB1X2u2v7IEJ4XWExpigT39UZJriqfTlKuR+Jx41IPdKctM32Mll8clR00LNhaYYmBTSwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377586; c=relaxed/simple;
	bh=qtk4vqlhPObTvIRf/THvZkrPF1lP/W1tsMG1qKWHhsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EuNYmUgH0lojCaS+jLgP6kgF0Aw59pgsqj40ZjP2WRuAWwFAbxGS85PUKRbWQ5rZ7Qw4zrGYU6S1NN5IMlkAUwvnWDY7YsinyIYiPpYywRXwAvb+8HBUcee/ioEIWuLmllJTGUZ3+61vw3j6cdGQr6DfxC3UTpJMTdR0aGFXsgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5t/6Hvo; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5t/6Hvo"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-39b217f54daso588831fa.0
        for <linux-iio@vger.kernel.org>; Mon, 06 Jul 2026 15:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783377583; x=1783982383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URGsqbwEeYJ2KiyjU+YkBFpQKN98xegqJqUmOjed2Xo=;
        b=p5t/6HvoIlgPeUBwyafcpdcP3ZMX0Hyp4oDgfTPf35ZKxoIybHqO/5iX1AdqF2b3uW
         PkMA7mzCOTq0xd9ElUtGisBypYVrn8yfSbG427442OlQ2K+8IapREAnXz/rUFLfNkHv1
         YaMO6ARkunfr9jJ68FkojKf4tKU8E59jZtSI5fpK2EQoP8IuY+FD5vXA/HMuZbcltXEg
         aps6UkZVcpLqbSITT8dl/Ig969NZFqXkn+Lp84L6OWL9a2bqqjZwqRwZVNZiRQAaecDm
         meAmG8GyBKMYAmWtmPjhHKuCDxNbtAZKD9c/CdqA0yKUVLYptur/tO2HJn+tkJmL6dW8
         rp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783377583; x=1783982383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=URGsqbwEeYJ2KiyjU+YkBFpQKN98xegqJqUmOjed2Xo=;
        b=i1C2/Avb0g42S3HFYU0ERfRH4DOMxnPydQAhHgN4g86nDoFVA57PSRkGHCbJe/7H0g
         NxFKbfKmg0InW6tMB4BNlX/BcBUC0t5egwyGSXQeKau1vbsAH9p0lrGF3dRkgbWxjpwN
         Z07bL8mMlgFtsAuE7Q9E1+t05XOo9DZbgdSccfkHCIhX2j1YJ8NFXM6F21SqE+lDwe9N
         Yy+JEvR15hePGAmiG36YP7vmPvday7drPY58CCPXlzjr1KH7/cXWDgFIPgChr+W+X1FH
         q15kOePcEZG9HvvMm+T6OcHiS0i5LQ/wZYdSErZVqWiEZnQYHg7Ki3KiLlpsZrMKUlpf
         K3ng==
X-Gm-Message-State: AOJu0YzNPJDGWSKBE1NVAzuCDd43nAMyPlD+RTzjChUlkSNyei+wbY3s
	CQUpjeGGlRT8Yn6bXVr+K/TGL6NOhYpRDACGaLNjuXdkFNMsUWcH7hMQ
X-Gm-Gg: AfdE7ck2gEhx6gnGO/rsXV42sNTnVUcWtb6TWxGt6szKUauLKQOstYbpPdtaKS4PSLA
	OBh0/24+Md9edbTKMfeWYyyQNgjO221NZN1BkGSBldOAOV1bfLAtU4MSKS6pXuzdcbFcqvImHkI
	MaujQeYNhnHeS73yQaMl2RFj+wit633AEcRUy0KSAGK0qi6/WaMNlH64jKtRr2hA1pUZPlJT6R0
	PYE16EnobPV+OpDIrOTjEn4WVdMyxsszRg8oyRka84mD/w0su+UZv2skxnq/r3Dq5kANSqTVSdL
	quqohzzBIxlXH6HfSFUW+1P6RaXFn+JnDxWnruRghIZuok+ekNKBE33RLPdErUZEZassD8GXN3K
	YnGWKNb5ErPfIgG18LbrxRNPQR9M816aL8asg124/RNZLBGGJNaE8azDrwxCJxWHKM0896WKiSr
	Gg0M9Ds1QNX3fZN7mbgOVdLtHl8qSthJw/nuMzemHFInYynOX8Y8ZJXfSy
X-Received: by 2002:a2e:8916:0:b0:39c:60e3:1cc9 with SMTP id 38308e7fff4ca-39c6a04fdebmr251681fa.14.1783377583173;
        Mon, 06 Jul 2026 15:39:43 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39c6631e1ebsm965691fa.42.2026.07.06.15.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 15:39:41 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 v7 3/3] MAINTAINERS: add entry for MAX86150 IIO health driver
Date: Tue,  7 Jul 2026 01:39:30 +0300
Message-ID: <20260706223930.1807714-4-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260706223930.1807714-1-shofiqtest@gmail.com>
References: <20260706223930.1807714-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3115538ce8291..361a7c8b99ead 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15863,6 +15863,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
 F:	drivers/power/supply/max77976_charger.c
 
+MAX86150 ECG AND PPG BIOSENSOR DRIVER
+M:	Md Shofiqul Islam <shofiqtest@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
+F:	drivers/iio/health/max86150.c
+
 MAXIM MUIC CHARGER DRIVERS FOR EXYNOS BASED BOARDS
 M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-pm@vger.kernel.org
-- 
2.51.1

