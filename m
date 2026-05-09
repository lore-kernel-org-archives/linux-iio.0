Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F2F35A93C
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778354500; cv=none; b=XutXIAA93I2q6HH6lUjDmWw0m96bGVQXVqhTRprFxexYQNy1phiLwDCiD4Rj57CpArcETzDaqcVdpiK3WXOdCNCC0Kd5Y4COnz20kg6soydTqaZdgE3Bagwng3YLLkoOKAZ5pGRB53WfXQa/MSrcmRjs9xrlC2gzjk3rViNrMuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778354500; c=relaxed/simple;
	bh=rzSuhraAI4cLyzTVmma+9iEM834IMLSQLVOxkCesmqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Huo4l2l6lgtn6aZbpYCImqhY6MXrpiGZi9zqAIEsloJEdYjQ3Vtun+UbZwdyfCb4M5nXcg7+JDubPvuf9fzjE3SXx0JQqVx2fFd6Acc8zDveFm6dJxMjnmXaBgqTb7cPUEaJjZcmp0JxvU3Nog+/eJ3DAF5DheJnBR2Pu1dBaUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hzGFts1c; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hzGFts1c"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6967080e6beso1016947eaf.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 12:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778354498; x=1778959298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A10z2V6mAiVce4BytYqy/qmrWiH198BizlsZzZUSoec=;
        b=hzGFts1cAtx8dASfCS7EAkKbN1fMZ3B21SlPbmRRUDt0fiEahvvitTvOO2mUI/N984
         C871YpsrAbpSauuMofi0dGJc3qIusriOSURT3/FoEMa00q0cAxv5fBJS9YxhDgYbRwKX
         wKF5ljLjYVfmO6glMo3v1sz6MGwX9tBtutcgQgxEH/P+r2E5F0uRvFG5NYBndo3wfYCj
         iHhJiVGaUsU3OjDJGVwIr0FUrG8vJP/0gDl+H2UnQq7fvihq/4EXceMKmOcG5QHSFsDy
         Hg6fUGEjgks9OlNH0Im5o0vPJPAdAWS0DjDveFRdOpgVezM+mROOOrXxA86f4NPywzZs
         R6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778354498; x=1778959298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A10z2V6mAiVce4BytYqy/qmrWiH198BizlsZzZUSoec=;
        b=NAn3ij1GF8wZWnYdpVJVLpatl7dp2Mi3WBk3UFo90r4MMTFhNwHPdAlD+iSr7vYhXw
         2JK8lhZabcjZSVQ8QYSLt+14vY4DRBpXYvLr06cG5PWiiCLY/kJAuaD92XGGPGElwIzH
         i8dgD3a9bsh2hC62cJsaZKiwdK7gmMqFIWH7Hsr+LcUodCqzKIXT/e8lxZYsVGdx2Vte
         Ts88HDsBtaZHcZcKMNkVsJXpuTkWIcGceN3hPS6oLeV3pUOgm53hljPKfxzh+2G3XiY0
         8C4kxOrhtYIfer9YBfK4LXXNvI47DddBTt7i9ffCyDaNRnWmhKpGM/TkjKfJ+q0rgOYs
         jCKQ==
X-Gm-Message-State: AOJu0YxKG1KCxkYR5nyosvN27QiXxZTUe21fQBiBkZL9piKdBl93SSK1
	hu4VK2Irm3iN782AQB3mfND3haXcH8x1G+hGBMHIAzj5ZRMpvVasGmNHaaJLVw==
X-Gm-Gg: Acq92OF9+0Usn45Zgqts7fYD8tY4ooHZDT/MYpzvk1ljaohGVBb0tk2ZgCn5N8oBb7J
	udpdpaluzqS46NRtsxZb7G4QqH4SedyMN/VPNRhUplkxNPx7mFH5U/2xnFbvjPonxbPJtx8iVXd
	b6updmqm8RanwlV86ReNILjU6+H9MIuwTNSDUUFpgeXsUPrIpUYeohWX0s38OKaqsxfyKS7KR30
	gVXxo9P7Nh7FVbUvRWCn2ZksbBnOMwQzdG8itpA8Cl8sdnZNDuo8PatsXA3qW84yd9CdAaiVt+Y
	01rZHDSSTNIYsTV+doQVIi0+PJPRvM3OxqseJ8jEdyCUfQU3qm+l0TvCeFBjoCx7xG/vCkalVAK
	a0MhZ2mEaWVKT6CXvnhrsfe5TEJCMlZeKKmiGJzg7zYRx0zmDcuofYSBtXnVSZ5VLneVGo2K/Jx
	hd6EJSh+mxjSD+7bTOwre3
X-Received: by 2002:a05:6820:60f:b0:696:1bf6:2674 with SMTP id 006d021491bc7-69b36d66941mr1897588eaf.40.1778354498305;
        Sat, 09 May 2026 12:21:38 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355736f517sm5243896fac.12.2026.05.09.12.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 12:21:37 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH V5 01/11] dt-bindings: iio: imu: icm42600: Add mount-matrix to icm42600
Date: Sat,  9 May 2026 14:18:55 -0500
Message-ID: <20260509191907.24734-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260509191907.24734-1-macroalpha82@gmail.com>
References: <20260509191907.24734-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add mount-matrix attribute to schema. This attribute has been supported
since the first revision of this driver, but was not documented.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 119e28a833fd..9b2af104f186 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -53,6 +53,8 @@ properties:
   drive-open-drain:
     type: boolean
 
+  mount-matrix: true
+
   vdd-supply:
     description: Regulator that provides power to the sensor
 
-- 
2.43.0

