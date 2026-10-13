Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10F73C988B
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791900441; cv=none; b=RpxR9wR4jh0sgZOWxVr65aIyX9QQxRLihRtrNHOxLIs9ajzBsAARhlvJ29IekjwV/eEfbneLs+j3fd1wU/6FJ2KF7P0z9Ife3ZXRX7K1SpzgCz399nU3BiJi7QCpe/3IEvA6Q5//cCjBhz60ZI/e7X43hBEo8Pwct+kBvM/EJ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791900441; c=relaxed/simple;
	bh=PwY88Z4+XMaMMJpWgpOoudQzWVWqs19jK/ovq3xR7Qc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qU6BfGf0GS4+PwKquSb3/Djw1VrRGploWhG/BGu0nb84YXWPo7DjIyLm/NpttyleflDsr/oXk6Ck7Wh66aiywxwCfktCnFqac7ma7d/e0JZdNS+oBSLCXDuiYpXIPfEzhJecXNOddbubHhBf2DAXNXGyyot3K8kmlNSw7Xbus6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s8IfWpH2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s8IfWpH2"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-486e8faff03so1316856f8f.1
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 07:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1791900437; x=1792505237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9uAIb9ozMRkPqsmw9yBOOJKC9hD2HvYyYUjtqyKcWIA=;
        b=s8IfWpH26EupeKdnvT9OWhVaTWmveVRQLLATFvOFmHX3TX7viikZ/ufRoudHtuYIev
         Fv3GgifpBRBtXoKgrh5Np/ZFJUnDuupAl7atSeDf1UqZptV4Qh7mlTHrCFezLuGEDGjW
         sDr27Ssrdy9lJ5VS+7SlFDQHM9Dcvzlb8H6TFDacjjxZPYNfpI/AfW54Co9fg1rUs5e2
         BF5qW3IFjZSjzxnswrar4mcV30Y5bxeVIkjVw+IqxqT6wJNm2B7v2977RDUznsm5F70i
         StEesq8TllqejAlUOQGl9vHaUF7RbYWfN8dvCufFLz4bx7dTKQ/8loLYhXjPiNicn8gg
         devA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791900437; x=1792505237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9uAIb9ozMRkPqsmw9yBOOJKC9hD2HvYyYUjtqyKcWIA=;
        b=piyW70FU8XDuOOCPyeyjRyIIbrR/c8dxckB30wJd42siN+a3HDo6dGUYFy5IuHke+/
         QDzVONjf3eWKJ6JaZGs58/JtSY5PGQVH0Ba6O93ZnTXf+Q3XniSPynB0fenvDxCe3hc3
         EfHT3z9b/Nn1EZFgbXnWTK5+9topwUAzv04K1noNbxYgFowLCa4kW4r27NicyJwnm0tx
         YJD8k58uop0B5PzHyn50OD8xwsLT1b2HpDw94JdemCP2LtsM7Q2f+6co8zf5ZZFK8WJQ
         NY2efrsT9mFZuPVVl/+MZaFE+4nqguPxhaqkq03zArt3kp9koyRQCOJF4gXyhkDi/YQT
         1WDA==
X-Gm-Message-State: AFq9FYL0+MTUflII+T/H9llLv+HmtvUHa1sip1wMz/lfkhHnLqU9JVwI
	Fg0zYVXQflN8YqFPXmYgE75Hapo7O74+b9A7Roh9OPhfP2TXdIjVp6kwNVpfAhNX100=
X-Gm-Gg: AYBFou0faEdxNQgM7a4Vm76CyNes7qIZShZTa26zANXgy9S0znPKfCXQ40Ar8R1O4XO
	Qe/Gx6iOOweS/JJG7BZanjSU2bZpFk12SkNfh+V51Dk49f10E/cFirNNND5b+rs4TZFidtyZRNU
	hjDQiZ5xQPblYwSdRi4QgMBlLJH+5TuqhkEXG+9rmonlteRc6JhijHp7OWHz1QOnrLlyTFSv5oL
	gmo8IRnB2r6/CDQdBYpKVIJ4TdUlrRu4qdQMhUmyGb+zFHUyurnMKkekUhaiaZdBVJ5k+bQNPzk
	XD1XGsvvzydn+U92v9iNF/W8l+2AdVsfIcKJ7YotsakMN310QP14u7iEB/5SIskPHtr7J1ChmLq
	HPTKhM4eEL/nK/RU0cmbOvjYvNq+fF178L3uZ1Xi9A+ht0sxzlvHpm/iZjoFmy1yNtspGAcT3P+
	Alj+3RPPEn8EJyMBrDF2zJDORuMIW12IeMZRDngf7Uet+20Iy4PKJwxXdqWBzm0nQsgujN1//T1
	f9bStqBN2X0RdFSjBLZ+EUZ3qTWAw==
X-Received: by 2002:a05:600c:3b87:b0:4a0:1b15:8852 with SMTP id 5b1f17b1804b1-4a18e4a977fmr315806495e9.16.1791900437031;
        Tue, 13 Oct 2026 07:07:17 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bead84esm364625305e9.13.2026.10.13.07.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 07:07:16 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 13 Oct 2026 16:07:12 +0200
Subject: [PATCH v3 2/3] unaligned: introduce be56 unaligned accessors
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-topic-sm8x50-iio-max34417-adc-v3-2-d3604ae4a229@linaro.org>
References: <20261013-topic-sm8x50-iio-max34417-adc-v3-0-d3604ae4a229@linaro.org>
In-Reply-To: <20261013-topic-sm8x50-iio-max34417-adc-v3-0-d3604ae4a229@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Marius Cristea <marius.cristea@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1443;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=qfQWKiFOPYNKQaFmvtbGsS16Zvd0DPHnTyBZWWyunTE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqzjsRf8f9CCRX3WhkWssBiYtxRfNs1C838kl2ok44
 vKjfqemJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCas47EQAKCRB33NvayMhJ0UY3D/
 9D95tPgiwjHCBdjbSQsRBU/1olO7spPQFVohqobqNYWeNlSuys+9HpmAYH36U8BMwiIQQwODpp5WgV
 xgYVezJsKBRxV0+NcBdRnVxePtIhiRQQ40S1VBQ0kVegElsB1IIMDtnrqvFLpO6k6fXJ1I87Rreb6p
 IMm+ShCqGKBeqyk1eYx80eiyqX7u8ZdtJnhrZDHN2mW0ih8FeZyUCOLkS6GwfBBELarvLiwe9Y64aI
 22HUF0uXMVJEkj2tuBSPjVPABREYBEMgm8a17xUI/lsaWrWIb0ZMXihNGg0bXa97IKXn9Cpbzvd6Lt
 rryrP7hJlHbjIXUmJ8Ii/sa/UfQUvc4Upm60/zbYQawm7WaqjG9hm1GeByP8cja3OnQ2+3a0kiuG2x
 NcOKwV1hG1bKTLKd8b5b73K9xuvfPo0ESrZ03LMHFo4wQxREYuI8me57Ah/bV5tIiM2+Lwy+qFx7k6
 dTZx35YA9UcrdF/kXmh6um5J6jN9fK91UMyj56uS2McqhvZBQdsbNG7IUuRm6qHhoKuYqgdGSPK9Hy
 dQ9AZRZQdq54JLFiC++8ygmVl6N5nFiKd6oR77h+G1jRVUoBVuLQVhRjVaIGO0Msar80JX7jEJvzem
 RIWl8a2ePH39JtptiXPvbSYXLxua2IeCrikPBDD79fWUPUdQc3rQ1l74s/uQ==
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

