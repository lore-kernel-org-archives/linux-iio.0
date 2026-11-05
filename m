Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882576;
	b=Gbje8Ap/ms+BYHltT0INSsJWTBXP+0yPDXxmRvtvBUREPMp5uneuXvKtp8/4H29qgbfC
	 Dd+ywAMf9pd0qoVhdtxJqXQJVcr1LM+ugLwYwUb8vGSQ7fu8De3knHFtHO1YqOgi0hkRT
	 dpKauFcmy/Lg+i6pR/yfbKJ+HFfwiKgyLKXMdNzUJKxywZqRVE7QNsmveEvNzVgYf9Ub7
	 JOzvG/8pMgFbqLHHReKPp0t30IdaDRk9Sjn3+I7s+AufrjWH5TLX7iwb8CUXZL0t0iEP+
	 uvdlavfv41/g29CVGTS/Unh6QEZlHVf68hpxAfVv80pEFOnHWG8HWfc9tkRo/aewlJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882576;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=K/V5t+jqFiHhP0+zyx64+sk+HwdaCdpfP+GPzqrY/v0=;
	b=JQmdgYl1siYfbB9bhmT8dvL5Ao3cNE5LzkI/xZbzjCLEIzlZ/K0dEMOjMvP5dmnkzPjI
	 3bf8yTIQkA+tNpN4qezw2f+SpuIew1FTupIOJKAkJQjgcwaweVrUnzRLautO/l0mWhNUq
	 w7Rz8jfGMkgwdkysnBKq+XK434a+elD+ciHo3M4wbMQpXePkH9D2zTdHe+F/RLSK7WFgm
	 Z7/EA4WkAuLK9mNKhnNAXjTdRA5dGl+8n58hWTETEOun6CfK3QKwQ3LQSf63RfAPlo8hI
	 Kts2206+GzmXdUlAf5yAKNopoqYZZbPl6IKbiL+hITiIf06Zaipo+TLEbIQHoZgZKNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=H9okgcbP;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E526082BEE
	for <linux-iio@vger.kernel.org>; Thu,  5 Nov 2026 12:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0E526082BEE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=H9okgcbP
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e00eee27dso1039188f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Nov 2026 04:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793882574; x=1794487374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K/V5t+jqFiHhP0+zyx64+sk+HwdaCdpfP+GPzqrY/v0=;
        b=H9okgcbPSjBNMwvztiZTix0H1RSa93G0pSfDKK6EnbuXehpLZ05M5CWd7nExDKprD9
         KwulzDFWraiuBhUlZCPgf9BOLgFjoacw5op7rIwl/yEn7LoSKjkJxz9u9lVQxnX+tY04
         OvaQPdd/yGsWFkagF6tGZu+u3qxtEFcKULQ1MTgQMXTRRcVPkEFtTpDZMAG0et2BGM2d
         Y+2JjNwLiUJMV3L7/xW9tUISZ2rO/LE/iFZLJW/qFKBD/9eqqvqXPeD/2H9H4l5WFC8q
         4ZDQyXRep7fqZILvwOwqLSEOrFJVOaKZyBXxb3HDXH+DNLtc8tUGri1P++qZuMDCmbmr
         iJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793882574; x=1794487374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K/V5t+jqFiHhP0+zyx64+sk+HwdaCdpfP+GPzqrY/v0=;
        b=iuFFA7tdYXoYdYCC4fhg4PkovKDrk5yCmafRWGrjbFJrVwM5BM32OTjy6pcscfTEPw
         7dwzWReX8Fnx1gW3b4FhC32a28vaoJSnKEHhx8l/vVqirH/7DQC6I3moP0SCVPzywv40
         ib0sOGSrgjvheQXTGHzvcZSrCz2vQhdKasdyQgPSdz3s4x8+JdWqG5dgufrAqgkYK4tM
         ggBOCEjz7vq3SKLB4IJGUrvKE983mpv7D4wilrq3HJo1e6f+df1K3dxqxsIsPbzLnlQR
         tEojGL0L0+Pq6ZLBLLboN0D40BDR6avNm9jqBY4VM6i4HnemRxyl0/pdgcTSNY8H/71n
         YhJQ==
X-Gm-Message-State: APuU4Z+sC1KE1EKeR577sP0FR6iCpBAJA+67RZ3jS0p1ploMIA3FdqR3
	goBt/VCv/10FyBKpYsgMMtgoLJN14O6mEOHNNAPN16lbBBl+vdd9cRHUq1ie8Q5P+A0=
X-Gm-Gg: AYBFou241LCFoiWVv8jtLr94gGI44sVkVrcOJE6Qjap+MSlCL57SsEPtNAKQB2KJnv9
	85VQntutAb2112yOTXMwpb1HP0BSJogDRBKVDRi185EX1o/GTJ5VdUcL22yPc6R6JCCFGk+VIhK
	yIEy1U291qVNYqpTHCb/MKgGoufR13oKpOoP3RsNL1GjGJm3qPFGnl6Z0WRs1kQ6Ch6Emi7nfdV
	ckcbuyqyPOy3VORAfUy+T5bIoaUWMxwLev/XgNvytHKrhj4mfB2G7XTONodxVwUx0CJGqxjmi53
	gw0yzmnQ2UsRyMpFcPferA3mZIEwLYZvr1OGGhQelIJ9cDTQaCILLlWz16rTIypjjervaTFjgAo
	a8fWpqqdeidR6PTCkWgkEGRC7qrHiXV1xbBPCm6Tb6q72XB8BN3Z3YmCQtAXTZ9dIYhdHFCG0pl
	j5FhYQtBihkuBbjl1ShQnI7k8YUzqUaJcAskGTnQCGReyYamEZpOPWZdvTDonMCnwDy3gIMd59W
	6aQ0u1BmDPOFAZDPWl/cIMv0I7nYhnvgIVJNz/7Fz7WUGHiqyMODn4XH4/sdaS3NBtmnCx45N7X
	32S5EgIpzSM6lB5gqUKklsrBgjUrB/qNEJYv8hQbe2OZ
X-Received: by 2002:a05:600c:6384:b0:4a1:702f:c736 with SMTP id 5b1f17b1804b1-4ac150b20famr423844785e9.3.1793882574155;
        Thu, 05 Nov 2026 04:42:54 -0800 (PST)
Received: from arrakeen-2.home ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b57373f7f1sm73487895e9.15.2026.11.05.04.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:42:53 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 05 Nov 2026 13:42:47 +0100
Subject: [PATCH v6 2/3] unaligned: introduce be56 unaligned accessors
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
Message-Id: <20261105-topic-sm8x50-iio-max34417-adc-v6-2-63b4e8279633@linaro.org>
References: <20261105-topic-sm8x50-iio-max34417-adc-v6-0-63b4e8279633@linaro.org>
In-Reply-To: <20261105-topic-sm8x50-iio-max34417-adc-v6-0-63b4e8279633@linaro.org>
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
 Marius Cristea <marius.cristea@microchip.com>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1503;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=q+s9IUw++9sNzM9FIO/G1OqBY3KuaSP0G+EMey77yQE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBq7HnK9rfw2wWoTGuH+jwP+i35rXB5WvMZ+jpraK9W
 rwN+BIOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaux5ygAKCRB33NvayMhJ0RkeD/
 9cRCQ6b4pl4S+7SXkMrrob6IWUG/2drVzNBJXnHQR8xH/XtyJmJP4IiW7MP/0UJCMYFVDDP78n2nVl
 WYFwPP0zp+V8QKA/9q/fm1I+DzPqlHL+CiOUwV9+3PGROZuOaAcWngkDOETREe7K7WD6wYMaU1r+Us
 BYZWwKRF4ebe/hBSDI2/QNSuo+iiZyzp6xavIRDYoDvVZuxFipN/BGRblJCii3iJ2pgQdHTJ4WrGaC
 KvpvvqwH+PRp+d8jlCh27v+96FGiQ/5HFz9yjOF06Ln8RLsMAWkTWLKL4lOz3OBuPUkF5pVFxva9oR
 D3o0D/Ox/edONKs0iXJOaymctFX84W6qPOFiTtIlUl7wLNI3Y8ozIcs23o6N1KMLC3rLzsNIE7OVxN
 7qU6cWB2jY513+5MzuMg1ec7IqAt8nOWPS3yb1pQGlB2mLsCNm7OfNt0ssQ2zzDLmgx/jn4x3L8RLz
 mtsfIrl41kTbZkRL/oX6IVmrtPYJnk1Z/m2yu8A5GsoceUQZ/8c9Yb0aI4YHKYf2PiGMu38bviL/+k
 xA10jiJ3z74tNJJLywQIcEubAhi8GGUOqldBEuTeevI8hDW1iZlzonH6Y6GB+QmBaK8IxPL5aUcrMp
 1SLU6S7ndwusHEjTQPuxSrut/s4FeL27GHR25oh2cOgr/dh5morJT3njn/oA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

From: Marius Cristea <marius.cristea@microchip.com>

The MAX34417, IIO driver, is using some unaligned 56-bit registers.
Provide some helper accessors in preparation for the new driver.

Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
[narmstrong: update commit message and move to include/linux/unaligned.h]
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
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

