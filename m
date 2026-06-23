Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA3B3909A8
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 17:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236776; cv=none; b=LaQVpyZ93AiCCIGriQE3jrVfQc5w9UcFnCrz8QiqZx6qVIVf3nr7wzT6SlTtX0u24SDLUaRmEzd6RqgXeqGQKiP9VDdZ0DE5SMKFpiIF2rw4n0P6PJlT+rBrSp9cbU8wactXcWIQUlrCaXPDRWxwVNI/rARMx/34MjBgZoV3JeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236776; c=relaxed/simple;
	bh=8GDvnyzfgPqmVvVMz61DihCf8JpOsm/P4ZGMUjP06ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAyxb79vwO+ff4g7C2GfZD/HYQCgtMyWNmuVMUoA1RjHMrB5xFzrnzJH6svn1ceBLtkQWO7rL6h9Lz3+vcYuk7ZsZHWUha/7FKc8ZH/x1zcEt6gEyFt43HX3F8d2JV5JOawXBJi8xasHdhhr1uMfw+0NPFWDrrv3McNLH3SHZCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GGat/M7h; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GGat/M7h"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5ad4f39064bso94502e87.3
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 10:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782236771; x=1782841571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qulQKjibAH9eps6SD566ixYFtJxwVLM36PRtnWBIt7A=;
        b=GGat/M7huO9c+FIDg1O4BVPJNNGQ4VQrZB4qnHx9VvsENtzbrqiKcjeLuSTBGODo+v
         +eFw48THmUv24Gc+EgCaEflaBFZe/pNeNyjMFzoGGMjmSnxIrGDM+XYuNmcJC/0vIiy6
         oqQPaf7LC/3l/aM5I9+mkvYwvi6p8dQpKLsrVwUHBhSfwyFaByBX4NyCeWUwxlcCwn1x
         ww3lco6KINBTtEKFZXruYIoK2zhxDUiJgaRMWYluN0EfpGwnpmY3xHnERZ2K5nqGSv6D
         mtInWsdBCLS4UjnMm6+3oTVBQDLgo3cZ0Pq6NJokc1iKQe/Rj3i7LfmySFkncJUjFwVz
         d6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782236771; x=1782841571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qulQKjibAH9eps6SD566ixYFtJxwVLM36PRtnWBIt7A=;
        b=BV8fprQLrZuDIJxjT4H51gzGMCMVqoHMYL/WFbD1eOrHMChBzzUSNbgNu/A93zmFhp
         6RRXlV5ZHjHR7pruzLd8gg4AjDVuWv1Ef4Ok+94JHBs2s1x/ZB7mPTeSrzTJWvcJmXND
         TGquIgSMW3oe5KItpLDhESn383uCTCBTKy2dtWVwjWwGfXgSC+w53OrRVkxZ9x7gIMsH
         9sJvXXEJXMa/FKUGh8XycqYWhLmxlqi9fs5w0b22p52H/QFeiXaWL+EUaeaGPsFRys2f
         Heun8zQUxJGWbwcupsC9kvvHm8QLB1VY8KAlDW682NzmS5xVp4OAyzdcvg4dRJ1r7It0
         +zDg==
X-Gm-Message-State: AOJu0YzgQljoYMG0TyAyiH0IWc2gTxf5aJV4LeaP5SDsnZBYiXoMIBCo
	qJoN8VNwUKf9ATUtZNAA36nB5PCBwSeRhtrcskpHsYKw9NQJ5bWw2XS58qEFhu0Bt736JA==
X-Gm-Gg: AfdE7cn9mN7FAjSR2RXWG2mCAgAeh0jjGJzKMhSbSh2FVdzOPBOag5I649XLSQdrayx
	T0BVcB1uEZBipZpW0Gr/wXG4Mdu+zwiDQnDQbBOybIprSm/Rq+SEwUUjeR/lxjkrBhrZYGtjC8j
	qfG7F2z349RNRRQaIICE36Uuwxf2ajFEDBcyOSMLsCFdiCzFSeIjHk8oSrfYEj0eLIXWC0hXw46
	Duy2y4JukJLAUN1Sh28oG5Aqqcea8KBdhfG4yeKlUFToTlmkAuVFH8mH8F90zaeVK6e5P8JtR/Z
	2MNgNuGkjF4G8GcnArZW3E2/VSmfjL0oMec+yEaW4SCgHywnQkaIkd1DbIR2IggpeHcQAfPiy1k
	BY2Q4SDG/CIef1QPpSGs5lU5xILXQaxUSJcUxnkuCcCibIMmHhwQvWCxqD9n+X9SdMb3thcqvlR
	//bpe4vSXfVyzvkZ8ddIWPFn4QSyqYGk3WQZSLU9zbhGdk7V6dwlXokVzM
X-Received: by 2002:ac2:5289:0:b0:5ad:4cb8:ac1 with SMTP id 2adb3069b0e04-5ad576ed89fmr4427480e87.23.1782236770940;
        Tue, 23 Jun 2026 10:46:10 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999afc7005sm27198651fa.13.2026.06.23.10.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:46:09 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v4 3/3] MAINTAINERS: add entry for MAX86150 IIO health driver
Date: Tue, 23 Jun 2026 20:46:00 +0300
Message-ID: <20260623174600.17100-4-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260623174600.17100-1-shofiqtest@gmail.com>
References: <20260623155556.13701-1-shofiqtest@gmail.com>
 <20260623174600.17100-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MAINTAINERS entry for the new MAX86150 ECG and PPG biosensor driver,
covering both the driver and its DT binding schema.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3115538ce829..a441ec44bb27 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15863,6 +15863,13 @@ S:	Supported
 F:	Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
 F:	drivers/power/supply/max77976_charger.c
 
+MAXIM MAX86150 ECG AND PPG BIOSENSOR DRIVER
+M:	Md Shofiqul Islam <shofiqtest@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml
+F:	drivers/iio/health/max86150.c
+
 MAXIM MUIC CHARGER DRIVERS FOR EXYNOS BASED BOARDS
 M:	Krzysztof Kozlowski <krzk@kernel.org>
 L:	linux-pm@vger.kernel.org
-- 
2.51.1

