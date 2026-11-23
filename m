Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417328;
	b=I1aOGWxI9X3IL2xqosc2gSjdvL4IwudrfVpL+4ZeSMhDAc/ndXqXVnhW8zhAqCEh35qz
	 emsGZLcXJYu0VEZSpNaMOKRAsGCcSJk5cM+FsaBqEV4OWfS6/g6N0ggI7Fi8hskSt7bRH
	 zki2az1phsicUcTfVcvM48hapFhghVN/AdkuoiqTKqHjBAWuwLoOhG2qnyyb/aV4rMjwN
	 2Y8mLgKrMCcGrBsYLZGF8w6g+rQE+oa/1Wlt8V1k1gCfgdRPvJCbqPG1YsLn9UR2khdTl
	 P67WM4VPrQgvVe2KraTjreHDbMhCZHwCURv9HZBNVZTem9E85BZ2g3SFAIOp9/zNaIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1MJvqtEQ7KzkrkQd7jNXZvcPx36rVpHnL5D10mePtG8=;
	b=xxwDZmIxTSgLPDA1urg0Ey8yh7oD9B69/4QYm6BwgU9ur9KidXCYjlVlyxiBhRC6ehL+
	 JmJvH/kPXbfO6Nhu9h23BNZ+aiIaJNLIG4KmfzCiK/6lHC0Yq3tm5b/Gu/KfKRZ9rSTdh
	 r+u2DI3prO6hSne6CWosmnm9YrMmVEc8ieTLYIHEMHUHT6GiDHbl2KzOTu0cqhT6MjRUU
	 UgXu8mDzLY2H55kUTzD+7pSbZXb91f2yRkUdOxQ3uIXtzS7Z3QHJZt+MIXjCMl6q6ZtpK
	 TzSla9sd05DnBwjAM5T6B/divCqKXqReomYWsvEjZ+BJA0iZ/YMVrtXxzdEqznlW6xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FpW1R1DD;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2198E606A31A
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 07:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2198E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FpW1R1DD
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-491846221ffso2422321f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 23:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795417326; x=1796022126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1MJvqtEQ7KzkrkQd7jNXZvcPx36rVpHnL5D10mePtG8=;
        b=FpW1R1DDTCilk6imzhNgeaMna/s08vWK96icEENFis6O2JY3T7yQhwo9qtSkB8TsNw
         3vrXdBdIcmfjerV6Cm+GhnQtAiID5z4ngvKoGz3eKqFJSWpb4ML3nFVzgFUAA6WETOhH
         siECVSDboNa8tDGu5i2CNmayyT+zp/jUjePWLx5sB2DuAmD+7e5+lwejcP2IGShCkSyh
         8CJhTbhbu8lY6zm9raEyY93HzhFn6lwbnvQEvxhaMBOI1hFUIErDEZIZH8O25o0ilxL/
         /17Q9KRp8AJ26PK3YRi+BvFLcjn3EvdBLEWR3R/vuAxRFRWM3a0cSajO+LMpErfu9uph
         1RAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795417326; x=1796022126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1MJvqtEQ7KzkrkQd7jNXZvcPx36rVpHnL5D10mePtG8=;
        b=MYujGOfu5lXA6fq8Ys8/U6cMYAMIE2bKIjgyeM4ubkLFvHZZGUxUmGmdQ0fmVatu65
         EDSAJjS4PJZBmV6k+wYwj2/JRS4ctmw0mYBxf9whxB6At4rCnOrPavDVBJBCGSPyjauj
         /0WQQNdkOhFDxvWk48gKS0GO0SKVp2X39y9UzpxMoXQWkVmWxP3NZbjzNde3CC2iqAdw
         3XwcdUsl28AMDAhyWZqUdr4D27FRDMh6faBmLafQHM3mIJHbfNlxffgpSo8MRtxu+I8i
         +7lhsJ3SuBiPrf9pePrEb/TLNlx0jlbhTcQMBvtvMVxjkAcrGcyo+Pa4VH5FEFDfHmJg
         yYgQ==
X-Forwarded-Encrypted: i=1; AL+hErEi0CAQi5zftPFi5o4kr+Nb8tSwp+8nIw0tP5ir6+JkOxGsloBsppVVAVANkhnoDIM2B6xpdZLdEcM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9SN1CkETrOIdgBFUqCVo9YIZUgzrDltaWXRKj32aB66RzTA4x3
	+xM/icT1vzOUcaYzZEK8vhTXLtfJNRGt1gHjcl1Lg+t/FbD8cOZThczLqe2c/g==
X-Gm-Gg: AZFdTZdQZyYSgNk+YL0kjrN5lxyfj3p6erg0OJb+6Q9LILTtYyBiLQQtg+SmX6XEL24
	S+RMtJwJ2cG5UogKW/FibZk8hj3L0FqP+LWgmrjsx8IPUVIituRL3B92dU34hXydvnAHjGU1HP0
	hmU4ZF9BB+3cxw3Ci5h0hjyea5oHyCfoZnppa2qPVQSh7kVnwcGRXrs/vLJ8sROTouMB4SSoXJ3
	21s4cIwtj1pvKgOUtN2+tYhRb2DzYrYEcxNeFG9QgpfYsh+RLMIt9kWjS5odM2+QnWxP0gzz+re
	NLtobsY3/V0kiU5x6aBGgbebrFl6MWzQYymQWzZvt4keTukVmgq8PZzwGT8xKbejQVHbdV+QEJZ
	efffSB2/HQIugkkImP/kNzTcRePk5OQHbbr3WMrj/VEqzW9rrQECxA0eWNiFSavP78f3UVxOoVD
	sK5sW/QNg9xv9yVyn9RYmwO5F59wKjssuLuLmtAhw+w42W/U/LQrUNot2revTAdOzC6TwEiUdxU
	yXJ9wOFUY1H0bpcSlRD/+In8pued2uqyPtj6enM8DcWYU57Te3VrKqOzHmlgJNokfDpXnxu+wuu
	SY0RK4dvKl88cUvMc14oeybOypzItOaG/Rvw
X-Received: by 2002:a5d:64c9:0:b0:491:92e5:b5c2 with SMTP id ffacd0b85a97d-4abb1baaaa5mr21008231f8f.15.1795417326388;
        Sun, 22 Nov 2026 23:02:06 -0800 (PST)
Received: from fedora ([154.182.66.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm20779007f8f.3.2026.11.22.23.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 23:02:06 -0800 (PST)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	giorgitchankvetadze1997@gmail.com,
	amin.gattout@gmail.com,
	antoniu.miclaus@analog.com,
	gregkh@linuxfoundation.org,
	mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v5 7/8] iio: adc: at91_adc: use HZ_PER_KHZ instead of raw 1000
Date: Mon, 23 Nov 2026 09:01:00 +0200
Message-ID: <20261123070101.53868-8-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the HZ_PER_KHZ constant from <linux/units.h> when converting the ADC
clock rate to kilohertz instead of open-coding the divisor.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 05e8b3deb043..62f8db630640 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -21,6 +21,7 @@
 #include <linux/property.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/units.h>
 #include <linux/wait.h>
 
 #include <linux/iio/iio.h>
@@ -1094,7 +1095,7 @@ static int at91_adc_probe(struct platform_device *pdev)
 	 */
 	mstrclk = clk_get_rate(st->clk);
 	adc_clk = clk_get_rate(st->adc_clk);
-	adc_clk_khz = adc_clk / 1000;
+	adc_clk_khz = adc_clk / HZ_PER_KHZ;
 
 	dev_dbg(dev, "Master clock is set as: %d Hz, adc_clk should set as: %d Hz\n",
 		mstrclk, adc_clk);
-- 
2.56.0

