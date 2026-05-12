Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCF439EF05
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624347; cv=none; b=Yed7bpefnLuJR4bhSRFX9xPzm21RVwYw8QaHo0r4ogr+5pW74o1gQV9K57IUlFFOZRIF03sYWX63MSeg+rxa6gwD7sxrnOQCPfaIQosl6aCgeIw7FgxdVv1dMDc5AIJTekYN2Z6Bmnxg6zEq/8s5RlAvCHWNOMLnt99udyd5stc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624347; c=relaxed/simple;
	bh=pZ5AZCE8CUlKxhBSvGXDDmIUbmvrCQOnJDfJS2TH6eY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SeNWzTSWAbmynnU/0rPoT9jUI8abXkUDYZLmB9H/GEFLUpz4Dc3dS0ZGNXCFhqqqpiRf1yorYxTiQ+mURU9gMYO/3L70VbidLZrOX3DnhZ0/FJfCbio22e6brfz9D+IAPviFoh/llanimirTv+x4aSqOwYFwmIEk9xsS6+2sU3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBDe5nLf; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBDe5nLf"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4645dde00a7so5673096b6e.1
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 15:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778624344; x=1779229144; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=glwT5koQsVbYhX7I4MEF51k8vuLfNT2TtvwRkG3+C44=;
        b=bBDe5nLfjFKrhqUya1g6DhZlX+i2MZWmMYUTidZMKZEZjJNxk41BQ6+xhd+Yczkd83
         7t4nxQr/kX9ZihYDG7RnqqmYpt1EP9PMxZ3hNG0gmbXFNGiIvbMtyOEAah0H5eosP5/J
         5ADjIT2JpsmJW/z3gyujdeP/fQkRFA6S7aMljKjjdYSmXTuTs1XA7S04QLpnrhHOPtM6
         Xwb0WHLszRqopyEJu3/rLE9ACB8k1AJzYniHAMxyowcXSLLg6IUCnG3cFKMhWWVB9rSh
         /s0dCrCQFd8+cUBY/eqO56ea2M9KSp572lvKXsHa74m0N05UQEKsisnnHfnyx57hpNuW
         VxPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778624344; x=1779229144;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=glwT5koQsVbYhX7I4MEF51k8vuLfNT2TtvwRkG3+C44=;
        b=CI3Rj+oZ7WoY4rpnCZ1pb9gX7Z+hJQmsP5DhdLzjVHYUN/nC2a6MykbFC46B6yvcQL
         LIjR83/O4LAI8pAxOQO9IFdwA3GT1PSZq7irIXOmkeVuEVarKJsM5CDc2gpgposSqnEg
         pT/3iSFepW5/p9fTWgPFWMc16MUrMs+xCkB7of18BMRjzc7zrMLg8sWMQwmkWHjBlJdH
         lXOlgxRt8d5ngfWxwSsKr6D6G/06VSzO07TQ7vfR7749hQ/9pEQpvnxmPsH4xdG7ruaj
         Qm3yirjy126/WD5v1KBuxbpK0SWq/nukFDRpUUK53JTPghQx2cS76lSGurY4QEKOxiXj
         HjUQ==
X-Gm-Message-State: AOJu0YyD3e4fcXELBy38GZOoAeOvpesFUxTbl3U0f+3THQTDCkUGA+Hh
	7IgvioZOk0KegY9uxm+1YtidHqlkgfXXXjBHsjYkaEPzuCemwmxtEUEHNI6qT6ug
X-Gm-Gg: Acq92OEal+/NynUrK8OiiRpVxyXTijCSZ4W8Izoo5KI9IhXJrvcp/uGMXShaSNxF+2n
	FJZHsqaIYROoG9lRD4jcJvs7HQYQa9QcSVmHaKaK64pdI72uMnN4IwsXihBH88PNO2wDO376Q02
	IWLDuJqhQpT6+9wSq6+IpTjijyPloXDVUzkZ1D0wIBYkBzuFVYqjm5j2CBOq1DckOIxq+BaZvWm
	TCUtxgmHdz5V1RNaK5YB/Xalt4RpDQySnK+mpokHq4lNjkyZI7bE1xLGLlEz9+rtIbTtKK6Ygqc
	5wheV9nx0qsMP774wgpmlTs7N+yLEmByNKVB1+RqHrJoLzgQ6g3sZZknq2wj8O27TLtCt9rwxJW
	u3B9Fuft66O2GaTjxZz223pvvGnSftJWJvSKXHPHL2gx2zW9qN6AGMfd0CJ7U8bvADyGnOAhaug
	NOH4yPLejyb5TaZfHVWKyM
X-Received: by 2002:a05:6808:19a3:b0:479:ae1d:fff6 with SMTP id 5614622812f47-482b2cf1259mr540768b6e.11.1778624344580;
        Tue, 12 May 2026 15:19:04 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-47c76986f87sm23291473b6e.13.2026.05.12.15.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:19:03 -0700 (PDT)
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
Subject: [PATCH V6 02/11] dt-bindings: iio: imu: icm42600: Add icm42607 binding
Date: Tue, 12 May 2026 17:16:23 -0500
Message-ID: <20260512221634.256747-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512221634.256747-1-macroalpha82@gmail.com>
References: <20260512221634.256747-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add devicetree binding for the Invensense ICM42607 and Invensense
ICM42607P inertial measurement unit. This unit is a combined
accelerometer, gyroscope, and thermometer available via I2C or SPI.

This device is functionally very similar to the icm42600 series with a
very different register layout.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 9b2af104f186..b69c6bbb6f6b 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -30,6 +30,8 @@ properties:
       - invensense,icm42600
       - invensense,icm42602
       - invensense,icm42605
+      - invensense,icm42607
+      - invensense,icm42607p
       - invensense,icm42622
       - invensense,icm42631
       - invensense,icm42686
-- 
2.43.0

