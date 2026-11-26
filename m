Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795695226;
	b=jtLsjk2QaHN6AAv2N6iPSLzO+mDq/fFlE4cgSfCG8JtDG5SvEmw9lzCf1VvfdJ1T7mOa
	 mO2JLbWZinvza674ppvQWMMUycDURcuztni2SSg4PocGoOjYrg6IHv1Fr2EcMZMhTpVSJ
	 yXxzYUxHi2PCgLr2nZe4StgqyuPtuN8Xv29sb8tbAI+XuQjq2hbxBVTFtUiLvvE+WjkR2
	 eoepr6wTdV6me0QtWbLwo2NUray96dH8wPF+OH3K6SQrqfLxmgexDRSSZq1Q+U2BMAHcM
	 yVToR03vda0aHOvia8q3ZahqGwFVfDhxCPYxxuKOcxyHIpkPyvZ2nrCaD+UQugUYYyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695226;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tcANGGo5MkDIwyhgXmQGaJsdJHZsNNGXY83sETzkkmo=;
	b=FtrJkDeIL2Knvw6vEXXxsHgYUbgO3jK0i1w56sNvxu9BhJ/sx2fRuHMrmRslmr1mPA1Z
	 jVb/74xnZ0oOB1M4wXc3r5w9oezpLNsT2R9/g9kwDfTONQISFOnxn4SE2l+PrEkzyEKXW
	 iUaVqKNwDwEfQ1tBecRr1yK9b1Iw0IKEiJK5syjAxJhLQM2aD7Ql/Kn3r151VvVayV4vA
	 YCUYBpaIAZwqKl7IPwRvV5XpqxybiNRYdHD4m5hECiFSxNFihzyODtAmKe9kLzHG7A5JD
	 UUfgee+Nc6tCL80n4gLH6lOY7fIApFdQppKEC0jth4pElw1Z/HO6hCOe2VWZDE3NptQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q2IUb0vz;
	arc=none smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7887606A323
	for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 12:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7887606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q2IUb0vz
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3ae1fd4252fso67501771fa.0
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 04:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795695224; x=1796300024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tcANGGo5MkDIwyhgXmQGaJsdJHZsNNGXY83sETzkkmo=;
        b=Q2IUb0vzzkjcBHWyx3EtI9HxLkJdeCdgJll0PJCmbxclaXehtBoAXJ0PAQ+9B7WIlz
         +zPZ9qRHGZpL9k8+WqJ9ZPPTbcCxgq1neJvUcJqMu+NnPu5zIOwtv+poaop4ReOLWRWB
         FfumIHkeOqPgvROkY+4NzVerGHur1jkHhonog2wv0kDeHMl9Ven+tUMyKejax2izf/1w
         Li4z3N39BNlX78yd2MR9L78lk2z6FHgRH41jpzxCXY7M1CRbql+9WwXs4v+IcJS8RgOW
         AAJnXnCkcCvsFuAYhFWA0gKTXoE5ZI/RgiBKljbmGjlWE7ooQO/UC7CmiiPv2P94qwYz
         HJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795695224; x=1796300024;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tcANGGo5MkDIwyhgXmQGaJsdJHZsNNGXY83sETzkkmo=;
        b=ZnSj+8pmC2MRI69bzNoHzYQBj9BI1vxLVz/o2+ESZFWr7/RP6jlqkDZnULrnDW8QSA
         rzPeGlCnX7qK0Ic5GmdMhTRJFeRSebLLHeIyfzAk9EefGh6a137vZTyrKVJ4svQ87Sk8
         HdpGggB398k1SzMrU398ZhXFF8NEs+WiHpCQXcwb4wwMI7+t64thmmNePozl04wUr55L
         xBCVvNhXIqiSykcv/Kt0Q7mHvLUWc8pRY2ic92HC+Cs01wQbC56Y6d3h8eGQa9VtAKOD
         01fIedkn7s9+xUs4i3nBvRkMutHjWIx8sPubZYV/lB/EDLAHwpaYu4fAcchQBp6OakvZ
         bXVw==
X-Gm-Message-State: APuU4Z+ACgJYXY92gwmuOsl8T1riPg16iz03tV+AiWS/yjtxIJDEA8TH
	KW5qNNjtBwq8bJSSLSzz4CFBFf6ubv8mYqLmgZJgj7mOnNDB0ZxmzXBb
X-Gm-Gg: AZFdTZfgf21oCToaDoQ+ISc8h+HwhDiTHMwJ3I9HfTMvgroDV5qMnQfEQsdqwstZYBv
	BkA/eHX1PlTNiRHF7DkQm0OWPrbDj4lvWzvOAzrXZK67/vPBGbvHnznhAinSxc7sp9q68+/7+3Z
	gT8fw7rzvlDt28qiF96x5n2TKO7Ap8LUuNX5MXHEjx6NzQn6SzXUV3XmCbErBQcsZsLyh6XvlzE
	syXxLuMJ6t3LQ5m7RrxqoWEEMmSjEvAn/NHZ/zTMzI3ZN4EfnU+sb4bYYXtoOHVOH4SxPIB8bbr
	yXB5hslyjshU/OJCSzQhD0LsWAMFS9PNLBEeQItHJPzeWc3sZgppAyYHjIrfzGYcVczbxKVhfrb
	OfmBP7AgDGr1LFtaLGMxgxcz6dP03knSuTppg3i0NIuMDDUTxnwl2kxNQc93cdMG5giGboP1DuQ
	jo1moyZpWyzX40WqUDmzCzdRAI98+pfKXkYQ++OW2LvxR6su8DA2LfKK/nFO2tM6aBsg4OcT9Ch
	J5gNoDsfrBl2GadyluHcpF+JRkDS2fqNwJqKqNJ3QZmW2UvfU1r6L+rEhOU4G+el63WyvbAbCbP
	zTZ1hsTsPVhlaq0ko2aiisgc/+K5r2X1QVgkFMFd0rjG/HRX7srmz/pPpruGsAS9dD7VbqAljPZ
	5noYw74sT5cx/SgQbe1RmIpbsfrn9rSd/DS+I
X-Received: by 2002:a05:651c:31c5:b0:3ae:25db:8a10 with SMTP id 38308e7fff4ca-3ae7f9f4fc4mr54946551fa.18.1795695223962;
        Thu, 26 Nov 2026 04:13:43 -0800 (PST)
Received: from yantra.. (nekmmqtmzjx8yvukhae-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:68b4:f70:61d8:6e86])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae8044e8e0sm56541791fa.5.2026.11.26.04.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 04:13:43 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v2 3/7] iio: pressure: dps310: use min() instead of min_t()
Date: Thu, 26 Nov 2026 14:13:26 +0200
Message-ID: <20261126121331.10438-4-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261126121331.10438-1-zoone.rupert@gmail.com>
References: <20261126121331.10438-1-zoone.rupert@gmail.com>
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

min() accepts s64 and int, both signed, so min_t() and the cast are
not needed.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index abf1652980ea..493eb56bde98 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -848,7 +848,7 @@ static int dps310_calculate_pressure(struct dps310_data *data, int *val)
 	if (pressure < 0)
 		return -ERANGE;
 
-	*val = (int)min_t(s64, pressure, INT_MAX);
+	*val = min(pressure, INT_MAX);
 
 	return 0;
 }
-- 
2.43.0

