Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1D6397E81
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 20:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782245495; cv=none; b=Lx0fbp4gvIJ1O1RY81RwROJwRnrYtu4/XsA7H0VDja9vMNgL5kgAxueath8cjDdOFhkUIPGBV3LCT/xQb8n2eLj5JR8nHfXBfqPXlJz+LhZbKx2BrMikVOcYSLG1zDLZ72UVp1brOEAcu8t7xW1nPvOky3RL3003Jo56rECyCTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782245495; c=relaxed/simple;
	bh=YCdG7V7i0jUzDdTSWZ5jw6saiIr3RdMEJtuV17cyB00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdKh5loWVEu/6WyuEht7XLhbPg3jQDxBXZ+5C1ZPXN01rhMVqXsXmtR41Ceb8Ds/Mjsezl+qxL41xrf1nO8uYyusnoFL9U/sXROyumokRLGB3A2cV51bhE/s+jxMONClhMisgjc2DYJWHvq3fiyWX/J2pBOpG10T+KSuzzG2tlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DcUxPn/w; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DcUxPn/w"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5ad68a06541so301986e87.2
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 13:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782245492; x=1782850292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrmXakNpkIbR2JV2psQpG19wT49o/K7Ic8w+q1SLzEA=;
        b=DcUxPn/w6qus8n06CccJCWgZIvdN6jcXnZuTp+5vyFCMccTYbc7nVbzjPtvXtl6+pD
         ctqcv0Q2u1OfmY0BU1d6+x+cOd2m1alA9e9ebYnAHdpAezvXu4bh5knfp+oXGMYJizx5
         R3yJ0h+3kI3+6t/ewUyPsi+W+bbIzcW5Kfxo+9aTUnoMEsbTgCBPrboJCTDAagoRq2my
         a29VtBhrlVFWUek/XfLBDmsU/p5P9kARFdFUTAPRgID6qNM/uux5NGPfM6fT7tfh+cd/
         KqOXCgHlCzqw0u9cztioCMgri0WW0HSgViL8oHaEvzjDniM0KzFCd2c4D1NuhEyJOSWR
         nqYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782245492; x=1782850292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DrmXakNpkIbR2JV2psQpG19wT49o/K7Ic8w+q1SLzEA=;
        b=SMYG0aaibQ/m5tFN6vtpFcEHrdl7xjx+jwX7VLqgdmR6NjyWDe7iQUhWr7A5poL4ZT
         ptFCHGCOZckgp/oyXs1ieQ/JRgUFgf6kG1aztDFPrEFyolckubhWkvA3vfH7i9/GEsl6
         Km0w11KzFA6rl9rzdAmFGshj2wyBIEqDZ5OzfyQKY4Ngz0e0yTgJG0sYEmyUFMaKATYV
         XMqeE0wHCZD0uJ7lq6Eq36D2AJBlyyLL+Ps7lJ4bX1rwa8T/8EUEi62VBvQzpTp08fjM
         L8frQirIU57P6Ec2sF8Ha8/QqbxFLTc8maetjj0Z1AZiSdmaYakV512jObEuaOdd0Dw7
         H7ew==
X-Gm-Message-State: AOJu0Ywm5RRqTYDdBFhNUFY1CRWfS3N73rFzULX6QD7ej12WfKIrd6aN
	HfL/YRN453nYaW3lOIYeX5hJ0Lwe2wvYx/U5OjUWX2u6/kFmu4OORZi3byTlNY6kJv5s0Q==
X-Gm-Gg: AfdE7ck9jZ6gp+asnVHulBL6NaM6MMEOm16APLdXyn5Qmfk64a98dTO9RJJSV6EMU+Z
	+ugEPwNgvKXK35V/rXjuCfP8mk+RRarCZix/VT1K7F+FUY5WlntQps3FTsfD9M2vo08/nAUupuw
	kWddBbt3s4ef2MIfghQcBBTjeoT0wQ+V8dhAK82fXSXd/pKM5kmvn7Yr1PE+U5+1gW2uQSBA7/S
	jWEMYvrKTQVutySlnYbLQvcDxww0nfEmUxicfSp2Rmp0h4tW1DLw/4L3oUzKCIipcRte0iYgz6u
	89ZXzDxyWARJ4dgweMmDOuRm6SLALEap6SwjNXwz3LC6rAvXeAMIY8AfsXAnavLGyn5jPJRXoHh
	LyQGqLeLj7/O/1X3tMAScVNDl3r1D9jCQLIxAbX+FE+O1iS0Kbe9xc526pHyb/VwxhsXefLH1QU
	MiYAeVt6RQ3XiKGGuDggDb/0PIMz+YGwsBIeOwAe0bVzE61g==
X-Received: by 2002:a05:6512:3993:b0:5ad:3035:b35a with SMTP id 2adb3069b0e04-5ae9d590a68mr14275e87.52.1782245492024;
        Tue, 23 Jun 2026 13:11:32 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69551082sm1063392e87.26.2026.06.23.13.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:11:31 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	conor@kernel.org,
	conor+dt@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v5 3/3] MAINTAINERS: add entry for MAX86150 IIO health driver
Date: Tue, 23 Jun 2026 23:11:23 +0300
Message-ID: <20260623201124.18271-4-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260623201124.18271-1-shofiqtest@gmail.com>
References: <20260623174600.17100-1-shofiqtest@gmail.com>
 <20260623201124.18271-1-shofiqtest@gmail.com>
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
index 3115538ce829..361a7c8b99ea 100644
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

