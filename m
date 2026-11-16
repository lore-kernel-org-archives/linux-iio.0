Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870011;
	b=xGVtoUYudVu70bU+XeAov7Y3YlbLMmcj8mKOX96IdtY1LI80KcJ0WSNlMZKiHN3sdgLF
	 pZ+aEzCum2l1jjnPOTo9xMqD5KaJ+8A+zWm7B1BCS5nFHhnEcHNfdCZ11Fedfwe+Z536o
	 4iseWFXYHic69dOWpNJc0FHuWbuJ9SAFJIL3DaSCCXmuKtijqFblaD4Cm3qBAE/i2qUxq
	 fyhsIGo5CduAaMq4jJzZ316Tabku7+r9e3g2cw2eOi8Q0jWyH4BEJPqphH5bdBuOZHHB1
	 ha+fvxqCUJ30tGLPiyysyFlDCBBxf9Ofz0ZN148yZ8X7KaD6zCAAsOs+gk/t54Qd1iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870011;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=qec2792BZT8xMgh2a+hcg7RSIyutDzwTcHaSiTYIrKU=;
	b=ZAXXo0JQD/r0JGa9YDkBDVUb2Fldvhzq4NS7sWtDVCN887+A/uOOAbjwxGQuKEXW9Hrk
	 g+BLCuBjy9Mv3sn/zbDGuKl43DztoQ+DsbYq3xVglm+WN2ZVGqhqU+OLJKcjzlIiceQyl
	 iMYMhoE1dy/lIgVEm0gundrVJABUTAZLmZ2xA4CGx/OuSF8rx7+2DDWUaEtBerUz+ezGv
	 4FGL+WNRUT/lj30WM5+sqixSriXTDBm0aqTcWegtCz9o1juard+0MPspSiRZt1j97WTGJ
	 hb/NS8wc0hGGYpibi49GAdHMhJVYic5Ek8UEtLTcXCElS1zyMpOunbdZWDER0BoeJJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F76606A33D
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 23:00:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05F76606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b30cbfa628so32515147b3.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 15:00:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870009; x=1795474809;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qec2792BZT8xMgh2a+hcg7RSIyutDzwTcHaSiTYIrKU=;
        b=WjfvWo4/3PDomKLE9pGmNlM5gNWsI2pmLMwlTt/hENKnv4/ibmrxDqDa0T7uNYY1FD
         My3LtB7VOmTmjfKXkEkX8ffEYSmUBhQpyfKd5lLhw5/htliuEVTb4RBQbetDxNTuW3S+
         HzuvmAPeXL9F7HSk6gTuNZKyz9kF6fIo86ctpV7fsXI4lGLc3o4uOTm13dAOF4p914fO
         d+murzDEOkbpgyjau8pUdmkLpaD05T5XbHAlXLisSV+KEGzXe6nSkL5hESLMFwadW2lc
         5RA8BrsXFicPx5GqRjkDCiBEwdfU84jMGL+i4KZ6LZhlUp238H48vHFdGEAFb515Yt9C
         GpsA==
X-Gm-Message-State: APuU4Z9UQK25JsAIfEplyOyVDZhRGl71xJofpCBOXIvq0AqiR7Tl95Mk
	ETpmIGhX/xyknvYSiDw77vN9g0lxx0iDmZhyNuSdpjkKLWV0SF259M26
X-Gm-Gg: AZFdTZeJDT44IStjqc3lbxb16hgbwaKkAgvtWVjAJpHcJNBgOxw12TZ4OIvrx0WFG7J
	PahQBF2ikRpxbLGzahfOIHcDHntDUBkKzJPEOwjbvJks5Ca98j6ZGCG7OWLGf4D/4ZxWbYcDube
	Gjaqi/xiqGuQTayHwWn2rJ1ha2WkX2XQbOahsenO5jOc0He2eYYR8GTPsVJwY7cpkiWvXGD7QeM
	u8bjUXTjwxGPkzWKoX0S/qRDuXqGj2qhyCtRWu7+JtWBYEjhK37KTym7fme+EVMw7S6NDfxYJ7l
	k5xHnhlqENUSwOFADWBqAxBSXJDI/yfIqz6MBTX10qMEGK/tcLt61FP4t3g1GNgIL7Wnv6PMMbJ
	h2d2G39+vx+6lHozO6h7DF+jelyve2NS2vZ7XwdOlmWlXnk3gSlQi4TWxy4nXZmrkTFMisaK4Oo
	rmKWy8uzuzTnxFd+NPt072st0gn8q42z1xV7I64egnSnWoZsF+zOY+V1ANXhmtVnfHVg5ZSM3zj
	6SdSMvwpOlvJP9BYgNqsiwfmHOvdT3zhZrgDG9dGBe2t/lC43I1De7L3ulDXBvfJ/1XGW//OlC1
	DUc3e72pFMxUE/RCgNGH971dO/mlNsg96TYPzH8Ux+FJKoTIAbmb7gFBAC6Q3OaO8Hkbly/M1nG
	VJ471WQ8s1hPATUVnnMfJyfgblUnD1V24
X-Received: by 2002:a05:690c:e3e7:b0:8b1:867f:389e with SMTP id 00721157ae682-8b4aa0cf270mr66552587b3.6.1794870009077;
        Mon, 16 Nov 2026 15:00:09 -0800 (PST)
Received: from 1.0.0.127.in-addr.arpa ([71.68.170.161])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4ebc50e40sm10721347b3.17.2026.11.16.15.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:00:08 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Mon, 16 Nov 2026 17:59:50 -0500
Subject: [PATCH 1/5] iio: ABI: Move out_resistance_raw_available to
 sysfs-bus-iio
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-iio-ad5246-v1-1-ef6b7c06d4b0@telaak.dev>
References: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
In-Reply-To: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joseph Telaak <joseph@telaak.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0

The available raw values of a resistance output were documented only
for the mcp4531, without the channel index. ds1803, mcp4531, tpl0102
and x9250 all report them, and indexed channels name the attribute
out_resistanceY_raw_available. Document both forms with the other
generic resistance attributes and drop the driver-specific file.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 Documentation/ABI/testing/sysfs-bus-iio                       | 9 +++++++++
 Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531 | 8 --------
 MAINTAINERS                                                   | 1 -
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 5e987c502b13..28ce219caf81 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2017,6 +2017,15 @@ Description:
 		Raw (unscaled no offset etc.) resistance reading.
 		Units after application of scale and offset are ohms.
 
+What:		/sys/bus/iio/devices/iio:deviceX/out_resistance_raw_available
+What:		/sys/bus/iio/devices/iio:deviceX/out_resistanceY_raw_available
+KernelVersion:	4.9
+Contact:	linux-iio@vger.kernel.org
+Description:
+		The range of available raw values, as the minimum value, the
+		step and the maximum value, all enclosed in square brackets.
+		Example: [0 1 256]
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_coverageY_raw
 KernelVersion:	7.2
 Contact:	linux-iio@vger.kernel.org
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531 b/Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
deleted file mode 100644
index 2a91fbe394fc..000000000000
--- a/Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
+++ /dev/null
@@ -1,8 +0,0 @@
-What:		/sys/bus/iio/devices/iio:deviceX/out_resistance_raw_available
-Date:		October 2016
-KernelVersion:	4.9
-Contact:	Peter Rosin <peda@axentia.se>
-Description:
-		The range of available values represented as the minimum value,
-		the step and the maximum value, all enclosed in square brackets.
-		Example: [0 1 256]
diff --git a/MAINTAINERS b/MAINTAINERS
index 02015eaec312..9cb91ee8a56d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16680,7 +16680,6 @@ MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVERS
 M:	Peter Rosin <peda@lysator.liu.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-F:	Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
 F:	drivers/iio/potentiometer/mcp4018.c
 F:	drivers/iio/potentiometer/mcp4531.c
 

-- 
Git-155)

