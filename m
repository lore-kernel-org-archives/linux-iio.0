Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630958;
	b=Z0eZ7CgYSi/gVEtku0wzrrPj2myZ2nIzgVIeWp+P1m9TQS5AFuUCq/JJ0kscFMeTdgfj
	 J/JNkXqcPBL3HAxxOyoxhqFCWQQzhmWZ9of5u06YEgJwZaLn5TFvWlcp+/+SAKbkSFzCj
	 /Cp1B3mNF97gUk+HdANKvbAVvgLZCu16MznPUaLOSZc1GllHPijwYNZ7LMC+pmBWHwAtO
	 4FuTBVYwhxkYaTBYvv/WNM3NInlkMtpFGxeX06y3vzNWqztNDTZtpnB3uzCaqY/EiJZoW
	 HtmYuYKC5sZHECgKJRbpUI4HjjN/y1QwuQiAzy6Arfl+XxfVYQAlbf9YCxIOab0f+Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630958;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=K/V5t+jqFiHhP0+zyx64+sk+HwdaCdpfP+GPzqrY/v0=;
	b=y7ezZU6g5VZaI0fBhM6jgALsZrq4XefVjQfOi3BeUXKLyA4kWbM1ibxWVMg7gUv4EOFN
	 XlzAJmAccuUxxddZ0skSv+a+5med6GceS1YJRx4tGKb49pNcN9Br66TQYUxhTe44ICwU9
	 NjalYdVAl/Gv/03UetHlb0nAtwe06bEWprTf7V7bZSMVRBO2FPBvcqNrhKNV/l5QfkBJU
	 7P/WTzujkinkZ0SDjELioKu3yQxVEFjp1cCSdscSv/IiHS8KEHaXr/ZrGKkvq5EbSCDI1
	 95KiEk4s2vZuADaO5u++NnXN2xsBe0YLIcs8YpAH89aFmj3G1ddFQhiUjMMeq2Zq7Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rWNWv6uH;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0486087A1E
	for <linux-iio@vger.kernel.org>; Mon,  2 Nov 2026 14:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C0486087A1E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=rWNWv6uH
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so25151195e9.0
        for <linux-iio@vger.kernel.org>; Mon, 02 Nov 2026 06:49:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793630956; x=1794235756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K/V5t+jqFiHhP0+zyx64+sk+HwdaCdpfP+GPzqrY/v0=;
        b=rWNWv6uHyaGaK6LrFg8qFru6mVZ4exHOSisVkTk6L20iqAGNIWFp/9ob8AR+oKdbj2
         DdnHefWTPExVwIIb1bI25AgVV80vzO05vepSyXroaQIBDxLpRi0AmQV5fQLV9Kn13lID
         F8iJ7Q3Bsq91cqz/wklKz0yhyddwGLJjNC5q2A0wxE/P+wKC6/ZFIjqXL2gujeKBQUJr
         PESZ6LeheiBy6/CQcm6tBoRVl0ydPrxi0k0eOZeLAThX1esvXm0Ue48Tcs87q6gd0epI
         EBGRIY/whhJvOxKBKTRcJh28zmqlkGnejYhqtD2sYz60Q0ZlyoDnteHYqJIQKvAKVzYa
         OCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793630956; x=1794235756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K/V5t+jqFiHhP0+zyx64+sk+HwdaCdpfP+GPzqrY/v0=;
        b=DG0xHZAahn/Mvtz+bscQORfDyfSEU8pPnX7j8+OCKLTUVq9Li6kUTaoMEIq4ryXRR4
         nW/sz9fVQC2NxNs2I1sRn/Lel4ajE7lg1yPuVeOymvDBex2QvAotNDt/jqyxS3mDPJ/F
         RLQpiyAJ1YH3xbarFxGCQ0ndI3sSrBwmJyFqPm0KehgTAoRmu6OmjlUHuUGZZF10QAL0
         mMklKp8RZBHJiWCOvPz8fOufgZFez3wLazn0KHbMyeFVzZ07QeH+6MDzMmq71X/M/dPx
         zb4qS5N/Zi74jPnmYt4RfUOjX0+MgNlR7vjg3NsS7uMVkSn13bRHcqvI91113t5VFcqw
         k7wA==
X-Gm-Message-State: AFq9FYJcjFLBbdk6VPkJ0E50uLLieYR5RpBrXXVad1M+imSHRKU5DT+K
	9W+MIVRL+SqeD+DZ4WLKDmjeRaPZiQkiAq1FXisxJaxV//SBB2szmeM4or6TcWZrSY8=
X-Gm-Gg: AYBFou2OlMCXFXz5lidhcryiayh5oZUnda4PHnq/JgIVmgX2VGbTVk81AKpKB/Qwurl
	K+jrtwKOfEuuNQFmOlQ8PMDhI3JgmFNlCn0hvTWBpHf31q+LyDc9ClAtrQapXExtEG2USncvDLv
	LvhQ3Xs29jyQFL/NhebwEW+DBR+k8I+aWH+Ur7AXOjuhHxvYW4gRY4L4BcZr+WlbDPsroVmIntM
	KFh7SNDsSv9inBQPhOJc75qkQlIbZtIYRPGGAq01LWNITLwptes/+lKTj/jHBEeQv3cvd5zOCem
	447EGf5O0Ccf0xki3LFsH8M8sK/96yMF9XMF0B30xLmYFylvhG5PnELtaWRiT0A03stTpskpyKJ
	jk+kswKvtOVA8WNt7w7f6Maq8vl0MFABp9PV/COCO4STBrG9ZdyK7u098pzcCbdtjw1gercbyE4
	yjvApuGqkqqwAmEJheE3uB8a8EHSZk6uVSFLcQ03OBrN+ZQWfPuJlSn0e2T3EfkyZ9mcovGfbUe
	b8fe9Xcc/zJ5GzUJTcjd7Ks3NwIOytoV4au1U5Gn+fA94ThL70J5KEb0tU09Y6Hkvv0Ke1T/Y7L
	5Q50ajNr1IgghmiKm/BE6vXtGjbCBdp9/JykJ5OmiWakJ0YqCzfnNrD4jue+ZWPtbtz+2GPm
X-Received: by 2002:a05:600c:34cf:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4ac150b3d01mr246636885e9.2.1793630955558;
        Mon, 02 Nov 2026 06:49:15 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf5b27e46sm447287005e9.3.2026.11.02.06.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 06:49:15 -0800 (PST)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 02 Nov 2026 15:49:05 +0100
Subject: [PATCH v5 2/3] unaligned: introduce be56 unaligned accessors
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
Message-Id: <20261102-topic-sm8x50-iio-max34417-adc-v5-2-0ffa5e5f2d5c@linaro.org>
References: <20261102-topic-sm8x50-iio-max34417-adc-v5-0-0ffa5e5f2d5c@linaro.org>
In-Reply-To: <20261102-topic-sm8x50-iio-max34417-adc-v5-0-0ffa5e5f2d5c@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBq6KLn7W/XNqDRG6ymWAJYw2576T5UyM8w2QGAAVwF
 uECyAhiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCauii5wAKCRB33NvayMhJ0a4YEA
 CW/ceDj2KIYJjKXvikOgSgTOTmfGfSTkfJWIgrntcIlNUe/NS2RvGYiUQWi8X/iNCYMkXiUoN9rj6Q
 r/XJmqJROqvBB9iVvUkdZUcKQTddRZSYB2a/jFkZ9GHSHfagzxGtnupo7hJvxlhYUR6I/t9QYpOyb2
 BWUf4gZ/rfgt5Soj+QASIoUUrNgoJyVHp33lCak6B8qP/jnb9/CHkKSmxEirZqtL9E13Pp+sZvJcZJ
 NpJmEmVzD65Nwf2PPg9IFCDa1rteLed7G/fdckHA2JXvPf2sW3i6HhecjPAp/CdVrq3wvVhSjegmkK
 R9JGwveX5T7kcsh+fLvMwExC72fVopUYZmQnaCowmm/AjtKtc5oBOYSerxl1iA8YIGj+HVCOLP0gXv
 GeJjeJxjF6hlv3BPl64veIX+5f7iWQNhqKBs1v1HX/ypDyRD2NkS3jj6JsQt1/J+r7Vem3IaV4d96K
 KLnraLKIXuzdrnONZhCu9G3/zeHetSQO8C5sOKUHJJkPfjOgwuk2jPbEFsOllQzoiS2mZuC7rePur5
 /r/BGixeyjyqtafe2NeM4/PsvnzqZCBD6BdQ2C4ui6r+N1bsaljLxoCfyag65oeKJAisZPtMflyTM5
 2l+iBqJd43j6QC5BUvpqBNR7GHz5Vapmf2LC26tCDmAMZxVsYaZoP67e3csw==
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

