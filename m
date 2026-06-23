Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6ABE3090E8
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782230167; cv=none; b=oagniFkhnYijCfd0HhXdVJpDq7Jc5NoKBsQe90CAcsnmX/l9VaeE8mFv0I7/GOIOCZBugaem0lBDY7XjHcy+m+0SaWsLHKwqkHPf/zUEPbioc5+huE0bJcYGgFyNWlyeLy+wekMmvrz7HQlO5bvYwDdkGNt0hDVY33xSPwRSPz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782230167; c=relaxed/simple;
	bh=y2KXMCDWXXGemV7yWHnHWQ2qnuKVqyDX5slmjDbcZ/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L7tXqsoEDp+BcUtkNz7igZKYcAeCI6ZnmgQwSkI302pa+GliRYDuF28wOjCVVHPs+yINtOOqCK+SZ8dTBMz7/7z3E5prKujRbkekPJ1jWXt/xCACwsqge8rWlERH0XLXVubi/wFV6e7nhCh5As+GHHzb9y+1gBUw6snj6vSWU8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gjwj0sXu; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gjwj0sXu"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa68d9dc18so5692002e87.2
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 08:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782230164; x=1782834964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkFtVL7QRxrKD//LGq3+L1fKIniXMCP2r3Lzcn90r5g=;
        b=Gjwj0sXuwu7MIMNRV2YD2V1Oh0b6uiBiGEBjkcAzLNcI8YVvGOBIiUkxKrgiwgGOrj
         XPwPTzz1L6aWCv0VOiqEXAj9V5AK+KS8x1rHSgHXsIw8EZYtmfP7q7Xp1jcZu7zPZ8Kr
         83CR9R0Y1Mi5mhcCWO6h9toXygT0UKN1ljRDBfXTjSnXUyV6Uv2U4yB64POU+hIXPMvj
         Dqy7H6LE+Znlcbtt9NnEc5V3d9MpnPglZ4IHVVPMUxVEARnT9N4X3ckuRuWqSfZtNhWF
         eyBAtOfQLHER/uhlLgjRU/SZaolDgnLxBry89nMsjUDOAEdDf2XazWJHJOFtXYMTpmIa
         fE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782230164; x=1782834964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CkFtVL7QRxrKD//LGq3+L1fKIniXMCP2r3Lzcn90r5g=;
        b=YETzsf8loCMMMWXC8jURiFFw2OiYL5X63tK6Z3OwAoCOZPXrlnr296GEdTzxHHL2/O
         2nd2TsUaCwfIVVfmsQUmgxNkn0SMmwdhxgO7ZimhnWjU2m4dZjaxgp9AwKUONPjR7Kbe
         5gazz7MStPSO79tyJMl0hiP/nDQPniuBN6E8l3k4a+GE5HHGXz/c5tvx6eEOroDI7TqH
         tbzxV7A02RKN6FmgTZZbrT1+NOITcJRMb8I0EzYJEKtwPuUJsUAlbxGJE6uqI5nk8cCf
         sh36eQC6zpE3fFaaKypFOMj+5yq09MIFTYx6Em1gu4LlthW2PVYivPe7TqoWMfsFxeYu
         vfWA==
X-Gm-Message-State: AOJu0Yz2vpcaIjHmTYs4mkt0NiBHH4HzSfS2xQmg1cd3ZmdkbWBSy7Px
	KtAWVBewh9tjdmk2jH0lTdgjwA8WgSr3/EGl1ZUzcjpM/qUzhFhudmWA8yueRYQ5MCKizg==
X-Gm-Gg: AfdE7cnK4aHbRYAuLdM4iU+UUBa2tDq/nChJyWWfnnyqZzEucg1W15uMwZVkspoA3H7
	DSG01ShclMGG2qqS/Sor2I6tHK6bXKzpFx11IKaO57AU1VN3s+AXvWNTHQJyR4d070o4wHDg5iT
	FfaB/kcVQoxeq9elNwsgR2ONdRZ8h5iN67px/URfGa9nBSOw8z3qg2JTvwHsifacZHpiMsdJz6U
	R+h3INGcGryas0hFFIS+/I+jduk1rNYp4FBZYfmuUjCe7Jt9GQG4VNeV4RhLnAVMDJZDDWBS6YF
	0hejKutRPlu0TCGLUkIL+8WOw2ZfDq+hX4OzVH4pw7l4dtUqBK8jcPJfliPg6V/JeqFnLRSnBdp
	3sc3xtJBsmwbF30XyDfejA0usa+9anukicYxE+0uhQD5KOR62PeMK6Ue4VIOIBBzUThoJV6yY7g
	zqNngjbtosy2azAY8JnkQwSsOka60mC0w9r0MfeOxGIzq4V4aKSCya+9uv
X-Received: by 2002:a05:6512:1357:b0:5a8:7426:d2da with SMTP id 2adb3069b0e04-5addb817ae9mr1005200e87.7.1782230163929;
        Tue, 23 Jun 2026 08:56:03 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad6957a6a2sm908946e87.46.2026.06.23.08.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 08:56:02 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v2 3/3] MAINTAINERS: add entry for MAX86150 IIO health driver
Date: Tue, 23 Jun 2026 18:55:56 +0300
Message-ID: <20260623155556.13701-4-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260623155556.13701-1-shofiqtest@gmail.com>
References: <20260623140113.12574-1-shofiqtest@gmail.com>
 <20260623155556.13701-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add maintainer entry for the new MAX86150 ECG and PPG biosensor driver.

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

