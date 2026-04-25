Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B4737AA70
	for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 12:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777121693; cv=none; b=t4GnxTzciyikZzGMqGwbOwVy/Cv+H2z6hIkuytlqT71CzB79R2wN3HH4/PKu70UCVFTYUP3L8QI2wUKT2d/AwA48s+OSEfAi48A4EHDjje9kv2w0b+pi/Ez849hvcVNXSxI2lad/uKw7iQKNJB/3rliHfeqZXxHVBB1LBkVXb1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777121693; c=relaxed/simple;
	bh=s1LkY4RG/HBml6jhtGQ2WI6dyTLJTlmZW5O0MgLl3uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gip2XfwNJ7jJbFqazmybmS14R1Z8Ih9vjriF4G8J8ksSKFjAv+p6nrR23myrXw6AbkFkiP3iQozv5C2Ldk4gHU71Cd3UvtHOQ3dSrWYNVIGC1jHsrPKpksHDbIb9WzKZDcU4C6UtcCf9SqVdqbz7DtiyxVc9adDhQQ8abn4Jfyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QHmgnSKe; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QHmgnSKe"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5a2b5ea59a1so12666078e87.1
        for <linux-iio@vger.kernel.org>; Sat, 25 Apr 2026 05:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777121690; x=1777726490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cle9rd5kldHX8L+jS2LOdlUtcsTtC25NJ0LIkE2xZTk=;
        b=QHmgnSKe0EB8bgS6ZPnKR3TXX3oUwUAO3w7pAWZRiuWW7g8AK67EEAUIKB4QiUc6ej
         9XWJC9NDPxM0YWwqFbKqL17nEzKDyBeWNb1qMuNxrG6dDfHheFDfnXoKbrg5jqXZAWbc
         DiNZDZdyECuw3X86ATuvjkJM8+hRBpwj36YXhLlx44N8oUabybdi0ZKZNDXvnrdmvuqQ
         iBapytdTsUX5oarkJLsvgTF3moEQbCLrix5UmIDszxihvsA4t+u/QVn9Fyat7iFgHOPm
         lVeowKPB7wNe65QY86zIiDE6ROmIb7bvSt0gkz7s1F/RygnzbElcI5g+uyRWC5sshAL0
         KH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777121690; x=1777726490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cle9rd5kldHX8L+jS2LOdlUtcsTtC25NJ0LIkE2xZTk=;
        b=LSqPkPHkOXK4xFAAykFOxoGu2Wvho5ScPj+gbnsvHSQcpsz7Xusii8KfJ2SBsveyqg
         OaB/5+92iT0m6XwKS5f+rTzV1NpQMWHUWpk8EplbLYHpDOZl1hYZlMPVRtHUT0LSG0zJ
         VGIxVbVl3knXVIA3fJmAvuhOZuKpgBECNGHAN4mEcQWKH/nIyHB+kbn6oA5FbQWIH5Ek
         bXtJsdiJoRhx4FgoGTu9rU7cfiX8e9j0CtOElVEPdb/NAbHIqOd+Jl9kw8o+Lpn5kQz8
         UovHJbSDUQ3yhhmyxFguxt04PrKSQcFQpPwdK1Xv6+zubcLMx5bZo1nwRcJ9wwbAnOrh
         585A==
X-Gm-Message-State: AOJu0YwxYXyhu3lxNcwPAMIKmnkAHR9d8cY4j8S2wf4VGkB8IBjbCfoD
	wzI6MT4GSjzF/wgrU4vIvQ2QqnMnBIQm6DObxa92vebk1shW4QE3Kjsi
X-Gm-Gg: AeBDievPUwAV8Gpy02sTJlkeb/hbNe9ZP93D2x12XVkjIubdWaJP1TTRMzGKqi5k1mg
	lW3My0oU/GEGjKaIPSw9CA2jhCskzDnraF3qOB7bz88WdCWqlHQ0wzsw0jJfQoUdMJV74gg6hfk
	yxRE7bEgXIRWcVAMtH0kpWjeKh7wCZRll8gLo4TkPadfLfXZeIav5NT6m0PF8tcTOl4jBgbjKRp
	e3gys0CUf+l/dD8veNLZemztGzUItwFJC9ShLxKdgOQX63caIN67KiU+2Abt4gsDB+vyehPJGgf
	TRHkXR+WKH1UYoVOk4SmBeXdU7hG0V4TJPaeKrM10StQjgzbYXYZz+LilBppx2zW4++PgPvjM8+
	jx0QghRs57uVV0PsLONMkG0LUITAAfDM1HndCuO89wWQztxxJsvqQWSM01x6+NeIy/H8pS8n92r
	/cttIuc/rvfLFf+nPiMafjypE=
X-Received: by 2002:ac2:50b2:0:b0:5a4:18cb:884f with SMTP id 2adb3069b0e04-5a418cb88d1mr8643626e87.24.1777121690073;
        Sat, 25 Apr 2026 05:54:50 -0700 (PDT)
Received: from xeon ([188.163.112.56])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38ecb5f6b20sm58334271fa.18.2026.04.25.05.54.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 05:54:49 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: iio: light: Document Avago APDS9900/9901 ALS/Proximity sensor
Date: Sat, 25 Apr 2026 15:54:27 +0300
Message-ID: <20260425125429.65154-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260425125429.65154-1-clamor95@gmail.com>
References: <20260425125429.65154-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document Avago APDS-9900/9901 combined ALS/IR-LED/Proximity sensor.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---
 Documentation/devicetree/bindings/iio/light/tsl2772.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/tsl2772.yaml b/Documentation/devicetree/bindings/iio/light/tsl2772.yaml
index d81229857944..9921ccaa64a0 100644
--- a/Documentation/devicetree/bindings/iio/light/tsl2772.yaml
+++ b/Documentation/devicetree/bindings/iio/light/tsl2772.yaml
@@ -26,6 +26,8 @@ properties:
       - amstaos,tmd2672
       - amstaos,tsl2772
       - amstaos,tmd2772
+      - avago,apds9900
+      - avago,apds9901
       - avago,apds9930
 
   reg:
-- 
2.51.0

