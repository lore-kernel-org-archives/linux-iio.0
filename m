Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793193554;
	b=P5VPA5GDR736Gw84WzasrdX+rRV1CvKAhRTIOP8MgWS1fvuBvb8lY3kRr3BQ0pYY2jmT
	 o6w2e1SqxvMVQDLSTS9F1VPwSnw1TzHpwN6WtA3XCX2dOF3NrWDNQTTaUsiVBsTXt/qFe
	 ivR9hoCD3Z+Rp6WMNv9SbrzaIFaQFDKH89kP41If/FKVOwSZumOfo+Fh3zVYXS9hSfzN5
	 rXVNxc5t7SHdXAsH4SavcKdJ8sYi+dnQ72XxBXOjoE2qdwJfzP/UybKl6y13nFO/GL9SD
	 BrJHL7S6laHO0t46Uwl1xY/llTOeURIi5maf+SJ1hLds0Yx29j9dgxad7PX8YaPZJNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793193554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=9uAIb9ozMRkPqsmw9yBOOJKC9hD2HvYyYUjtqyKcWIA=;
	b=pcrLFzGruwgx14suF7sXimIesOKVuatXBdKquFYTp28dkhhg3ooBpZZyNx/+wbDzad5K
	 mypEBFI2BOadDYu4KsyzcrsF4VVJKuYAIVdcWD6SV2pCTje8DemNaQi8KCIy3qzdO/KN0
	 f3uq6cy4zVdhGVEME1Tu8mrIJDevfHYnqEphqdbrzEAB6KB/SvaOLrJkXp7cbo4T8uS6Y
	 iWmRdjXIIDEZxzLImvr4DABYecsizYLviXxhWokb9MmY28/KJCpOWxmGu5Gyo3sFD/sNR
	 m7HOsQTYuQMKV0K8EA1r+HHWADO5yxOuHfqR5ohUV5KFhknzz2lSX+plpX1qSIUpg5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iMXd1g2t;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B9D606A331
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 13:19:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34B9D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iMXd1g2t
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso8526675e9.1
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 06:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793193553; x=1793798353; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9uAIb9ozMRkPqsmw9yBOOJKC9hD2HvYyYUjtqyKcWIA=;
        b=iMXd1g2tBYkihoc5u1/R6QT7SOmDZvI4CPOEn7qtT40TDcm13pH4/Pqg0nJ21lcYMN
         gHz/cTy1n+cpf6zzGsmzUoPogBB8yDicYGgqgPh7uMeWP9l8uQSDqycV5BLDnXCJLg1+
         I0d8K5BFFAgAx1QJp+E6GKeQMSCGfz8VxXILv5cYyOxpxmupe9jT1OY71A/0RQqHzG4x
         CRJr7brk0pe2OwMXd/97r675ix8hGQ8rY4mkMWKXEmnur8BiURLbsvskC5+PWfHGYXKt
         E0st/FZrILS+bsFXETdskOqMVnF/6/Dt5FYD5FcG45/PA8GV9Z0syqf8DDhZFXkMZZ1F
         r+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793193553; x=1793798353;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9uAIb9ozMRkPqsmw9yBOOJKC9hD2HvYyYUjtqyKcWIA=;
        b=hQpkmOi2uZQWwccQokDw4ON640vN4qXB7fodvo8ZQLk7LLuxvuWNThQfVRRe4vQEJF
         kOD4L5LTSqCasGMxwYFYsJQUFWRQeNNtuIJfRXCJkxL7fulBQpR9pDPfLSKBzcimVa7t
         arXIUwYaGObh14hd4RBV1FJk+g4EY6pce98TDNpT1phbUQ5zs6GBjTYyiMCze1xyApvQ
         OGIDKPTS6Thr57gep7ezm5QAM3/n4OEHjBJPoV5fCUDSFwHpcNFY97D010O6WNBwn2Br
         ky87c9YfD8Q0VVoSFuyNbSAXXTDgaegBiGD7jNKsN6sJf6mraLDRTJ2WLgMRZWBvEOjI
         j7BQ==
X-Gm-Message-State: AFq9FYKu4uI21++y0tyO/Gzf4Y4qDQwIjEb1rQiXj/VKCsvsXqKyGLrC
	g3PtdZvJIfXWT08hVCLbb9g5rxso4Dz8tjKm6Gftu73RzxM/5nUiIVjEtdgKw7XVa/g=
X-Gm-Gg: AYBFou29K8r5IxDCsCDwapnr0HKKYfzhVEmFphR+/E1mFa2RMHX1C4GFpN2P9GP87Nx
	iqihv9v9RQYWyXO9RuvEN81dg66ZQH3rzRTiEK3SNTbOg1miEK/3to+95DiRmy4IoVMkvvvdLgH
	bhf803D1N2vJZwAbxSV5dVM6+jIUo6epswxLm3AhMucAYgl4+7x25MzpMjF+Wb/VboYxHZ5o1je
	FZVfnO9rhP1XiQcRIJ4ZH9SVoki1/Zr2mBqUnkOBHAP58fM0iPRNnP4a0CxZJE4I7reJ3zwWDSD
	ndCjnYhWDoKDxvr511HqHlPTHEBt9m2Z2m6Nv6YIa8OPxN8MwzT8tF+8OGrya0f6Mq6O436OQKq
	NvTlHdzzUZ1o01Jw3KinaNIqYOH0bGQrgX1kBxgr7e1PACoh2Wh/1D7LsmVE2LS70qjexO94Yyi
	sJGOxTISyDLBoVnnC8jHtNdiMOXKHitJRKJeq3evK9ooJkZb1JiKcC0EHlfFphLKfFg2nLsc7vm
	5DMP9mD2C/kpHwS0FYGtcmrvJsjn4zQfqb+Hk4MJnZEvjse49lsIGzQp9K9dN2wbC/n6bpYmtGd
	LFf6LwSb1VXUTS4+Trdl21CEzEjPWuWbUfH6U5AW1cc=
X-Received: by 2002:a05:600c:b8a:b0:4a2:b89:b02 with SMTP id 5b1f17b1804b1-4a96667c848mr47048085e9.10.1793193552104;
        Wed, 28 Oct 2026 06:19:12 -0700 (PDT)
Received: from arrakeen-2.home ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a996aa0ff3sm19869395e9.1.2026.10.28.06.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:19:11 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 28 Oct 2026 14:19:05 +0100
Subject: [PATCH v4 2/3] unaligned: introduce be56 unaligned accessors
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
Message-Id: <20261028-topic-sm8x50-iio-max34417-adc-v4-2-d4baaf3ee903@linaro.org>
References: <20261028-topic-sm8x50-iio-max34417-adc-v4-0-d4baaf3ee903@linaro.org>
In-Reply-To: <20261028-topic-sm8x50-iio-max34417-adc-v4-0-d4baaf3ee903@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux@analog.com, 
 Marius Cristea <marius.cristea@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1443;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=qfQWKiFOPYNKQaFmvtbGsS16Zvd0DPHnTyBZWWyunTE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBq4fZLttrDpTiI9a7fF3u6Vq/mkfoNhMhsaRUKeks4
 cPp7zECJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCauH2SwAKCRB33NvayMhJ0Z6+EA
 CKtHVa7jGBl285caxNm9xQSN4MTl330vhBNWXGFu5yC82S4NBo/cW0AGmnjb0hfLCbcQmTv14Qop90
 Erqm6Sern9H7ljNz8gHZXmipoIlYUE3U5aAB3KSCJBau5tNqWrBrrI9FAaB6kX71wEFTiQNpubSz3A
 ioNyLm6FRaoUTIdqQhuosHkJdM+inqv0Qtw7fwVESL7VjZGTSK5rSFE3WVyHPMW7HJYAVRZPY6ys3A
 qRjQjGf8XCJxLTqAJ8vBAIkX3Ztc1m+7ry0unPW0MkPkTjY5ceJFo6XqRtufZRs+igf7B6BW7Vxfrl
 qQBdJJkcCOixBr3gJqgm2iJM9oUvx7MIX2H8otzdtuowO2soismpKaLCzOV+QEd3P0joa538sKaOWd
 QXeY1Kw/+qDruF3fCi2APWxGME/ksnylZ8+kwN05i5bPn1L831P6rx4GLDcdp+qHSUXGwpZ2cmqZj2
 cyLqlu+TwNptFZbhj5eJS0bU+eQ3HarEwiH+y1s6eO0Gh3hr9XzL0iuDMT5yNizrlUOKZ6oPRnJ+R2
 GlNxzjGsVUraP5xTi39msbI0AwN9+xl7TeW7rA6PN8CypMvq6Cw5u+Gb5EpTxqIt04ltktxPpK7ZdH
 hO6qIAMtABkT3ACIed64a3INU5dZnqtgyfN15/EREM+0p31qcL/KrNppdoHw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

From: Marius Cristea <marius.cristea@microchip.com>

The MAX34417, IIO driver, is using some unaligned 56 bit registers.
Provide some helper accessors in preparation for the new driver.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
[narmstrong: update commit message and move to include/linux/unaligned.h]
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/linux/unaligned.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/linux/unaligned.h b/include/linux/unaligned.h
index 4a9651017e3c..2105743b1800 100644
--- a/include/linux/unaligned.h
+++ b/include/linux/unaligned.h
@@ -143,4 +143,31 @@ static inline u64 get_unaligned_be48(const void *p)
 	return __get_unaligned_be48(p);
 }
 
+static inline void __put_unaligned_be56(const u64 val, u8 *p)
+{
+	*p++ = (val >> 48) & 0xff;
+	*p++ = (val >> 40) & 0xff;
+	*p++ = (val >> 32) & 0xff;
+	*p++ = (val >> 24) & 0xff;
+	*p++ = (val >> 16) & 0xff;
+	*p++ = (val >> 8) & 0xff;
+	*p++ = val & 0xff;
+}
+
+static inline void put_unaligned_be56(const u64 val, void *p)
+{
+	__put_unaligned_be56(val, p);
+}
+
+static inline u64 __get_unaligned_be56(const u8 *p)
+{
+	return (u64)p[0] << 48 | (u64)p[1] << 40 | (u64)p[2] << 32 |
+		(u64)p[3] << 24 | p[4] << 16 | p[5] << 8 | p[6];
+}
+
+static inline u64 get_unaligned_be56(const void *p)
+{
+	return __get_unaligned_be56(p);
+}
+
 #endif /* __LINUX_UNALIGNED_H */

-- 
2.34.1

