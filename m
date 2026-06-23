Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CFF31A045
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 16:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782232996; cv=none; b=KvHBRAIjouHxQq+E6DtMKkwYFEYNmdFVdut7CoSGSSRTD/+dT/9FeMuJgazYC0f2FrPjjEpX84hS8y69fF7X0kMQhEe5aafvcBsn+qVeGMKZ/653aBTCzrhkQ9fIfGWhDa8xZIPiHIy4t7VBk5mwmDCgTsv04I9pGz29P0TUdEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782232996; c=relaxed/simple;
	bh=8GDvnyzfgPqmVvVMz61DihCf8JpOsm/P4ZGMUjP06ok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdmGJ9ZqpomfeKeOaCcbFthpn3U2P5RRFBS99YJDgq4sLk4HiBfGaiXPf3I+06D/PrwF34lOI3xNBvZDatWTpVMK7UZFh/tCIFYTNpj8XycMZ9X/fU02a19z4nmxeaLIzkzh2jpux4VRaB82bLTTG8Z/r7yn26AMNtkrI695D94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bcn7PC20; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bcn7PC20"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5ad4a5647e5so24223e87.3
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 09:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782232993; x=1782837793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qulQKjibAH9eps6SD566ixYFtJxwVLM36PRtnWBIt7A=;
        b=Bcn7PC205LdtFdgVayctT6d2c5XlZnenYoLfjcLYj2Dz6i24e9pqV069bz/qD9+CuF
         JSUvQkAvXqtuFgI9dDJmk5UkEdiCPkpyq5ZndnSqCqJevUtchOUnLb3r6wMqO315Njvl
         PB3KH5oxBRPw4+4O2ESLXxw3byjTxYoHWGdra33AegAOAef3fAzo+Ji7tqdCEXmA+cOi
         iQO55wsm+qO8Hk5oWJgqfBh1a0oSL/YtZrTif19GofJtnAVarP7JSIIhGYCGqHfbAxBU
         6lIr8OyfmlPz2QNmdgOsvh8Y0/6JmL2uc0joQQ3zo5g+UCjVu8Lr6Om9E9iJkqa9dKW+
         /xGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782232993; x=1782837793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qulQKjibAH9eps6SD566ixYFtJxwVLM36PRtnWBIt7A=;
        b=OpDiEvOTfNq9TPK0+0hOVo2KB5ePMCtegZk8r97/CZjtUz+2vA3AxvdfH6cpV3WYIl
         P6ko7qAlM+nDlb/XkKFppz4N8d9RDLsfjoMLW+9FEQb+0pOt3bDnLN9HjX21ll+OF2UU
         FkZNiy6xOpy1iNYjov5kQptRLQWPpuQoxMsOpI0Xxss6EZ7lkkK0Ag5175/qy9ka3Hbq
         xLXFyGqRjEvr3Fym0ECCpiUjmrE9bkKPfnL8iubRWXHyyODuJQ2++9pLOwS95CNRWijN
         Joz+joWRL0jIum8BZAWevzsMtbmNBrctw+Cb/9BZ+5wQMRR/+vOYlYgYJZF10NFaUmEy
         djGw==
X-Gm-Message-State: AOJu0YweTkgcTPpg4lNLuGc11g8ADvVGKYD6Vf5HzyJdqi6LOAw23szJ
	v8MSxVwcau44zYEz4c21dpGZ28R+YhMNeMllBUt0w3jG3sn+zgG/AjQa+vgYXI7X9n/YXw==
X-Gm-Gg: AfdE7cmGmK4xn4aCxBVR4dqX5eyPim7yGON+NgDxoL95BWPkuLGz1WXKZ/j/wZAWUOH
	tcekXv6Wv6kTYOgVSR4WEiLb78KmD6WN+3RIEnybXlOTE28edliV66AmgAtaJr3jJTGCMalWxo7
	utSidM19eKifrpm0SneXdus0cJwtUn0Wr5GPC+E6UAlJz5wOmiwSywCGJJ2Qp1yPkEmtGzyR+t7
	TMvrKjpuuO1DhlVMM1fYzbKOwgIezaqWPczQYrLOtzMIEUAgIOayNyu5QbfO3BhZHy1P1sON4cr
	iDgIQ+ivnhkHEyxn1LU88tDqK4OmttnIK70ZpnHLfOpeQOUFwRBvxczzAPWlJT5s9SIIfNNKaGS
	u0MQFGczHOUxO+rRgNtm7MxPsqF6G13PyU/t1dBMXGIT90UW76Mxisy+RG2qx16SJfQGvcfp10J
	+9cHLvKqxtkpUD4KKQMD+XF8IElXlRoYp5SBQFER5dgzytjA==
X-Received: by 2002:a05:6512:3087:b0:5aa:6db6:52d with SMTP id 2adb3069b0e04-5ae3511a18cmr1145369e87.44.1782232993400;
        Tue, 23 Jun 2026 09:43:13 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69555c45sm948253e87.36.2026.06.23.09.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 09:43:13 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v3 3/3] MAINTAINERS: add entry for MAX86150 IIO health driver
Date: Tue, 23 Jun 2026 19:43:09 +0300
Message-ID: <20260623164309.16452-4-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260623164309.16452-1-shofiqtest@gmail.com>
References: <20260623140113.12574-1-shofiqtest@gmail.com>
 <20260623164309.16452-1-shofiqtest@gmail.com>
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

