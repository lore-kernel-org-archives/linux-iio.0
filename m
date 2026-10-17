Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C174D54779
	for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2026 05:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792214387; cv=none; b=W20IWZHOsPhvu6hIEChwURGZzSLVyWOHJ65FVpCKdjVB4yCtVadM3pKpFdjBDkhkESS2h0Et9HfCQb/GfMjC7vaF4tyjP+8fZDIrtIN2C3ldsI1CWN2TLtCuBg86OvFiqZT7lnuT/n9gr/GRtr8N6OawM62kp+dAMXDIcOJAvQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792214387; c=relaxed/simple;
	bh=gXw+7TLfwGKFNKp/KJZijwrd5UKSHlNDKFQXo0yS+uM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L7mryoaLPjgYtZiZbSJpZ3nSjjE9JM2ywTQf5ONwm8ViplE4UAn1CV26eyM0woijFYkvpi+Zn+AATihUtru3axZWmZKw5gB89PQBO78OPNwmFyrKJXESZ+2ztCVKOORH34jQrC+jTGibENjY3r+EyUEvXsEK7qY9/ifc9T9QooY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FX9WQObf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX9WQObf"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so5337185e9.2
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 22:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792214383; x=1792819183; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7LHcXjNkmsuk5TeKHntdBtjC9h0fmxosoVJ6Kahrwto=;
        b=FX9WQObfhOmxAA2cvIjLLoUklxaCKX/HIYaincyp8wlWq/t0jXptO+s8CFJxOAu5yD
         SpgjwF+G/isbSOTi+RO/Trzyn/rWbP4HBx6CektOst/cdt/NE8GaB3nV24MWH6GOy2Bt
         +FXRFjcBEt3Pbl2QtD8bUAfhGUSv3UQuMLYttYWrftfELF+CBCgagOJdCzoaQ9GdHX/U
         kSJNuT2xg8iQnd2fMYeLpIC0RVCtrSjlnptUD2QXw3dfl205VRszu9kAtZIcPhyw0yNT
         8aV+U4H94kFxfdCSUyUamCZOFOko8ZsCz0WRVbcJIpwL7etzU5q3RP7kkqhkndsv4qBz
         CgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792214383; x=1792819183;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7LHcXjNkmsuk5TeKHntdBtjC9h0fmxosoVJ6Kahrwto=;
        b=Kzlu8p12L5O2O3KhN0e7mlK3Xrsbfy5zXL+EK6WB5xWcreVFa3toh+nKki1A4wKFBg
         radJ0nc90nQGZVZarylFPNI1hxEzw0ta7C7RfSzGz0fcgWNmzMlrc5vtYhp9YkuXjHOL
         citONDhySgqglXu6wA6jkYp5OWo1CwsHm+wPd23v1+CkhNhFKC+yizA2stCyykKa4GMH
         w2bAbxvtkInLBhBWLjSxSXVZRRMPnQgmUKnsnd5zjxJ9iaTrofRMXpTiGLjzsWbmH7Dg
         fnEeXFi848t7eJgAhYDC062ssC8PRTz5OSIEVsG3cD5pulYplekwbDDVrv+SKYrtDNy1
         is7A==
X-Gm-Message-State: AFq9FYLLak4mF5P6vSH2rFcjrnxXNER5+Y/DZtsCoVpPC0VehO10sEjj
	GzQ6S2/Hdtnxxw0W8O66P2P7qMRpsOa4o9OT6M6mH4CZ9gu40RPCN1Y8
X-Gm-Gg: AYBFou1k3A98HPUlEgXo3Wrxmet/Y13yZJ+bYgGKog2SLzagERsvY+RRpsZgA8s7GxF
	vSU2t9yObl+P3m4q1pJqkb9stUENGYbymdMA4ybS6qemL/pu9qTomIdOk0aGgCNXJaHBCnYHlhR
	dT3bdd8itogpS5BSEHMwnIhtWACPWEEr6NaTHo1OibQa5hejM1PPkadCRZ4FSOrbrKqeDbmGfWu
	PGITJkK8Ukss5IYp4zQekzo0X+kWLq0RlRlvDNdsPABHvZVYpQHFOyiLV5C7USahLvl8Lk1gAnv
	8ynMDJAntM7+7XR2OhwQotjLj7VA7uUqAQgaG+SMQSquBI4iF53zKp8fVFh7bWGKEpaegRawBMg
	MYR+pC0IQfPZoiQ29n+tF3tifYLzSA918duTcvZlIh2PayprHu/FF8PIGdcGhgkImgCN6+Fnl9J
	VtClC/4sjBwia4eaDvO4KEcEZIPM3dh5f2c5ssqmDOxcAbjFTLc/9YxHXSk19UmdYAHubXE1PyU
	Dzd6J9M2AeJwwjnAYAc7aJ8u28Szd0a2JvnNNAcJacTT4PwIFuBHnvr7DrpMtEjwQWukA3lQIYu
	4MG/78C4o+iEn8AU+SEJlp+WJPw04nWPJ50G+IzjYAZkhnvbVeUkqDqHfIBnYB/KjbXeVFr+yUD
	Yb5w/pi47zWM7gHYuVrHeODb2QDImb22GpKRlLe/yfEIyh88aPOL7oSlptu1uXEKxmQ0smhwg
X-Received: by 2002:a05:600c:4e50:b0:4a1:76c9:5408 with SMTP id 5b1f17b1804b1-4a1d7600190mr43042945e9.11.1792214383002;
        Fri, 16 Oct 2026 22:19:43 -0700 (PDT)
Received: from [10.200.7.52] (109-81-110-105.rct.o2.cz. [109.81.110.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1dc952d63sm16432585e9.2.2026.10.16.22.19.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:19:42 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 17 Oct 2026 07:19:20 +0200
Subject: [PATCH v3 1/2] iio: gyro: mpu3050: fail probe() on trigger
 registration failure
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261017-mpu3050-fix-v3-1-d6f29f335a2b@gmail.com>
References: <20261017-mpu3050-fix-v3-0-d6f29f335a2b@gmail.com>
In-Reply-To: <20261017-mpu3050-fix-v3-0-d6f29f335a2b@gmail.com>
To: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792214381; l=1394;
 i=joshua.crofts1@gmail.com; s=20261015; h=from:subject:message-id;
 bh=gXw+7TLfwGKFNKp/KJZijwrd5UKSHlNDKFQXo0yS+uM=;
 b=mHpAFkWrfA2yHnFAXyecRF0dHDXXg+N36a08VbYhPaR87pLuFUd+4j7PO9AkSaIrj6R/h/CJR
 6dxR+T2totYAKjlGrKSnwj7gvYY0lmuQosTz6vmzPr+n0wT0ZBdEO0O
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

The current implementation lets mpu3050_common_probe() continue on trigger
registration failure, causing the device to operate in an odd polling mode
and making resource management harder.

Jump to the error handling logic if the trigger failed to register.

Suggested-by: Nuno Sá <nuno.sa@analog.com>
Fixes: 3904b28efb2c ("iio: gyro: Add driver for the MPU-3050 gyroscope")
Cc: <stable@vger.kernel.org>
Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/gyro/mpu3050-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 07c0f9011c63..879caf3b729c 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1231,8 +1231,10 @@ int mpu3050_common_probe(struct device *dev,
 	/* Check if we have an assigned IRQ to use as trigger */
 	if (irq) {
 		ret = mpu3050_trigger_probe(indio_dev, irq);
-		if (ret)
+		if (ret) {
 			dev_err(dev, "failed to register trigger\n");
+			goto err_cleanup_buffer;
+		}
 	}
 
 	/* Enable runtime PM */
@@ -1262,6 +1264,7 @@ int mpu3050_common_probe(struct device *dev,
 	pm_runtime_disable(dev);
 	if (irq)
 		free_irq(mpu3050->irq, mpu3050->trig);
+err_cleanup_buffer:
 	iio_triggered_buffer_cleanup(indio_dev);
 err_power_down:
 	mpu3050_power_down(mpu3050);

-- 
2.56.0

