Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A39D372042
	for <linux-iio@vger.kernel.org>; Tue,  9 Jun 2026 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021269; cv=none; b=u5ZLs0LWpkJGowNQbeACv7lIXMOtPulAZgj6k9ZuFFaGeXzJhteFPqhWrSzMcoWGq798Bevv0PlffJ3s4WwTiR7mz8JSz62nOGz9FACr/Ct08Sl94I9Pn2GtqNWEVMzCkk/IYZzsAwYx5tRoUYlO4Pky+tADrqcKlc1dFZzkpCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021269; c=relaxed/simple;
	bh=Q79k8W9vOzEUW+r+p6LYN1WSF1e8vDMkHgr6pRQpJOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AZwi8NgCz2JzkRnpVSFvOBK1yoL2D8OtAKyc8WI/LsS2t8wFpEMnCg9ju0g24D9bcqAEb4CfSemMnx5E0rgDG6RAjgvKLL2LMBbO08q/jwkOWEr0X0XNoJy6CX4eLs2ZEoigkFLJgVe+CgYvBWCe8bR82NRzakqX6Trz6qGlUdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxLUNHnL; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxLUNHnL"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-69dead44101so3406852eaf.3
        for <linux-iio@vger.kernel.org>; Tue, 09 Jun 2026 09:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781021266; x=1781626066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tr78Ec++ZHHyKCmRsLimyTQ1g5Bjk2CPqZ1jeJIAnco=;
        b=pxLUNHnLhN1rM1Yxf2R1VcR4carlwTLN7F8S9MCsduhpkCCYmkwqkKIksCEpwWTa1l
         +NYPbkrwMVe+63ej+U/caOhcF7faUsWfSCdKUMW18qh2L6KY/XDZN7w65DyxXgAl9JK0
         Gpheg2SvffT2omcqQETFgISEWlv8wPtfmt6fksrSWRKwBt6ESvdMBPjg9miOnQ9QntZg
         BGIJfOZinIK/gjIT0tfqyAYbbeewqKLsO+TDJIeSH5JPUOzGI3HPR41kuhAYYL2TOHY7
         Sdc35XF9gl4tMVDYsDNFpjI0LBc2GYGYlfTVVo83rd7KJHN+hxREddJjefS40Nt1vBzo
         vBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781021266; x=1781626066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tr78Ec++ZHHyKCmRsLimyTQ1g5Bjk2CPqZ1jeJIAnco=;
        b=Zh4a4MA6OYLWSG7CsvUDln0S45HrzMwFMxFZ1HfK8lNXhUOe/5TjBJv99WfCVvE6rj
         vPVAO7E75o/1U6fG36mGHPIfA1rJQCWCE9UuXdPTma887YwTi3soRZodvmvzyqOy+lYZ
         FybgsPhHLexbPkU8sDU5dqIaUtzCQkBnjbYOn2aCXEEBR+vRbl6NSk+obpQ6m80IpI5v
         K2BgoSVEKGdgdtERU+GJYjlFTMyPMPj9lGPIIEqkT17udfySpJFnPIHQzDH994+m3aad
         ZKyoKSCHTctGoUjqgefpdMJEESLjGnGqE2wKP2T6gcWuOno4mY5dzmZzINZm92M65r8L
         Bb+A==
X-Gm-Message-State: AOJu0Yy0y4ZUzA+RWdfbgL8muZLuEy2fGfVbaef4MraoqTtZfkq1QAGT
	c61voNlzfSSC/4X4/oGsquKo41UcRVau9DlH8sreA7r6OAWfH9TyCqvG
X-Gm-Gg: Acq92OFku33CymyVEY8GoqLcYujSw5+/mEqCg1DHumtHjqK7vFhzqwSYnZF3VZZVAO+
	j3yNV2qIvXdryi/AsfNwV7J9WDS5C3AiHe9DhtINFgHgHzj/9ZuQ+F2XFn1gHNZhp6an0pm0NnE
	XHGY7VTK3mjlWqHqCmgUmgEHu5A/FXguVxUV6sz//QjEMnkRg8rCPiTEFK2HBjSilZQrhwJarNg
	uERzqNMHGpW40XWD3r7TGskaFo1+sR94XIrFxZ3nGWHPUX/dFgS5Y2pb8D9KM1QQovCvHzWJtQf
	mgKwxWERI0UxV/eKyV/qyZ88uKCZlZpuBDPk9WhS3QOGbD7R+4+UNvgz5FBiFi6i/AgotESK0ml
	4Fm7t0xWItrytjQUL9vk6h6ayQ0XdN7DIWLyjWcsbW0O33eYCZiMw/BUyLx9r3AtMOnXgR78en+
	KfHAAZUTcPq0pPPdpEHtChPpNRizcKHW8S2CG284M0JlAd5Pffya7ZGTeY+9YyRnCBWjD/
X-Received: by 2002:a05:6820:1687:b0:696:89e4:5493 with SMTP id 006d021491bc7-69e68c06d10mr12662859eaf.34.1781021266482;
        Tue, 09 Jun 2026 09:07:46 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e464050fasm11393859eaf.9.2026.06.09.09.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:07:45 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomasz Duszynski <tduszyns@gmail.com>
Subject: [PATCH 2/2] MAINTAINERS: Add myself as maintainer for PMS7003
Date: Tue,  9 Jun 2026 11:03:26 -0500
Message-ID: <20260609160326.45123-3-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609160326.45123-1-m32285159@gmail.com>
References: <20260609160326.45123-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tomasz's entry is no longer valid, as he is not active anymore. Add
myself as maintainer of the PMS7003 to replace his entry.

Link: https://lore.kernel.org/linux-iio/20260609140712.2e5d1640@jic23-huawei/
Cc: Tomasz Duszynski <tduszyns@gmail.com>
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e035a3be797c..d1b0a40c02e0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21147,7 +21147,7 @@ F:	Documentation/devicetree/bindings/input/pine64,pinephone-keyboard.yaml
 F:	drivers/input/keyboard/pinephone-keyboard.c
 
 PLANTOWER PMS7003 AIR POLLUTION SENSOR DRIVER
-M:	Tomasz Duszynski <tduszyns@gmail.com>
+M:	Maxwell Doose <m32285159@gmail.com>
 S:	Maintained
 F:	Documentation/devicetree/bindings/iio/chemical/plantower,pms7003.yaml
 F:	drivers/iio/chemical/pms7003.c
-- 
2.54.0

