Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4FD280325
	for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2026 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783273832; cv=none; b=VOA2yLaj1q7OO5+AqAhMO76/EZPZ0T0S65jMzqx7Yj8RIUxf6sZPFgPMjcgk72WlmO4kLjkg5ffT61s5HWIkVwv2DManY/dem5RM5s85E1a5oxwalJPt2NSh25EEJAnrer+wc8cnKuFoQHDksoOvHPB5H+cliqIppd9egseS9Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783273832; c=relaxed/simple;
	bh=m8SPoZxEaUPfVjsR9CTuOESEsMJ5AAPAnOq9fWKFa4c=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=KtNAT0LWluqPY5r+O5ysFWQ4VNMiikDgsXX1jAwbNIumlCRU5mtl1xq8EKjAa1IOpH/C/QZfEgMGpP2JlFt7nxC0xIqJfmS1l4Rt2B04vVLBWTiW0hgqEG12a8z/SthfAX+SMSMnDayaIpdRkNaeO+BGF/CLI6kbFOonWUTkHCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pZvHAAY/; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZvHAAY/"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7eb4d8a21a8so1531720a34.2
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 10:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783273830; x=1783878630; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UhydEgvTyE9jxtsn3JWo+B9Yc6rWbTfGUL+Wj0w3oX0=;
        b=pZvHAAY/kG+H69+XiOYyowQBDsMyDRXWfGPsqqHqfSZDVgS/XGbweG5Et9q3K2dZlw
         KAyXbHPiJdo2MGaO/SMgR/cnC0wCQOsnYe75xh+woQsmT1wg0JI1MIDmmrxqEHaxj1yf
         ZI3HyIVDtDh78a6LTGlPYoYued57hA5M4edwVrWFWL0On2TiimUDru25FOoEyNMgWhIk
         LiHbCG4RwzJzFajWhr3+UMd//o/5h5PKAdNk8NZk06I/URH5oP+wlX5WTqxDo4Oq5r0t
         75ypfWZP3T8r4mKRdS7KKrA2qC2gNP8TkyF9ukZosNJOntXmJNkh5zU89uvgWCSA9MKJ
         bq8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783273830; x=1783878630;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UhydEgvTyE9jxtsn3JWo+B9Yc6rWbTfGUL+Wj0w3oX0=;
        b=JRveXR5TXv1CYkuQIIcB8OZOc69grOw94c8JLTg+GE+TByIXGxO99KwD9X5oKqkAZH
         Vvk2VA0DdeK05OQ8A/LHLUCjqdkhYHnCb7PRDjrk6a2nM3tdjKNsoIKYQHfAoOOq+bCQ
         Gp43Fm1/ylXvVd2JJT6NTpK5p3UihdEsvS0061SoK+jnpTVWiU0HUcgsS2fXbnRSZLjz
         ia7Xu0Fd3x8xOlsHR7ilqZZBDst1GYbY4PSdCWMCK7NekgZY6ynqwdt2V+uPf9oSumNU
         Y1npXqtq61/JHiX9R5A9H/G+IE9HbBnKYdtyRs1zvCnHKP+YOB6zwMF/yoywBNgdUM/i
         ZAlg==
X-Forwarded-Encrypted: i=1; AFNElJ9znZhrJCtSUytn82jBsiCNpcuN/BUs2PKD0xI16iH/+mmhXcNSn7Qc0D3MtIAcsEY1Zo7R0pv8fv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC6kz0PklvR6YYFPzRgpnbUMq0QQTW+tjfQ/WFTRdrYaAsYpxI
	nC1EZeQpM8Piai9x4h/y/+1KWnXuluRKcu4zTYuTuKyAfAhi7fjwwmevs7Reoibz
X-Gm-Gg: AfdE7cnK4JVCTZGBVbCFrsyz6g27amnihhczd/Bjm7kl0Z9U+hN0Jx5SPWRUGDsJb7x
	0VNp9Fz+Ijlkd5OHq2fSQbSN2l1daoa0NywLiu47Rh0MNYSwDvqk4pdyXcMjpEIckImQSiWR3x9
	YXHc6cD9bxqWCp6Zr0+sx7CU5IB2Xufaj9j8Iwc3Vx7l1Sc9mUc/5fSXHUIHhoT789qTJW/vZ6Z
	cDXdatoYagt9BPChofGHIeoMgs0dAafxnkVnR3TevaYkzk+SyRzw5TCEk4F0Ph825wcIkWJj9c8
	+PW0GVGLJTPo2F79ND88FP7AAR31vWCuPn/ZBytNw9NoRGUebHdRiIaucXjhYnkDIypsFOz8LGx
	Q3yiJfhyL+nZD9QKMmTNC4mDROD1hp+uf+CE7+P6SHSgpA9Iz0J3161F4wqMsMWvE9IG+71d3IZ
	Hasvg9IPkaNevvHiAOFmi6il27SiSwOAYuX0v2DMA=
X-Received: by 2002:a05:6820:16a3:b0:6a1:363d:bc42 with SMTP id 006d021491bc7-6a32f452236mr3691842eaf.15.1783273830310;
        Sun, 05 Jul 2026 10:50:30 -0700 (PDT)
Received: from localhost (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a32132dae4sm5367475eaf.1.2026.07.05.10.50.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 10:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 05 Jul 2026 12:50:28 -0500
Message-Id: <DJQTTB91CSPU.1LSN2OFIRKGOH@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ade9000: Drop incorrect kerneldoc marker
From: "Maxwell Doose" <m32285159@gmail.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@oss.qualcomm.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Jonathan Cameron" <jic23@kernel.org>, "David
 Lechner" <dlechner@baylibre.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260705172438.119204-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20260705172438.119204-4-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260705172438.119204-4-krzysztof.kozlowski@oss.qualcomm.com>

On Sun Jul 5, 2026 at 12:24 PM CDT
Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com> wrote:

> Top-level comment is not a kerneldoc, so drop marker to fix W=3D1 warning=
:
>
>   drivers/iio/adc/ade9000.c:2 This comment starts with '/**', but isn't a=
 kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/iio/adc/ade9000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Maxwell Doose <m32285159@gmail.com>

--=20
best regards,
max
