Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DAE2D97AA
	for <linux-iio@vger.kernel.org>; Sun,  5 Jul 2026 17:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783272873; cv=pass; b=M1snlK6jRm3lDt22EZzH/NIusvvk1YsHR4yLe5HicQGvoq2CixrDMe6RbbF+H0EAkbflTagHt1JsV6awLc3BS/ehp8kAIXX9PsSQwftAhC7TBjL+TWYIO5a2MWNLqr4nVKouXAz0UkEhNQImtdLtiIXIqfsxhTQ+59vk8d71Wt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783272873; c=relaxed/simple;
	bh=UrtNMX5adi0fnK8Vp7xyaKLEBGSScUOUlf5PuytNA18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pf+x0w4zlDuxQ4vMypGotOfS/jQaz2vf00/EoqNcmEMJcdqqbMdKg6lGqZYzm/cnLed8DnqsMaYL6k0dHvS/f0ZuJKfaxh11/vPq1N3pZvViQ/r9KSi008g+iiIAbrsxhyyUHf+UKzn0LMymRepIp/aqx7MiOkEHB1oRxhSi6as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J5I2gLqs; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J5I2gLqs"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493bfe9f886so11914125e9.0
        for <linux-iio@vger.kernel.org>; Sun, 05 Jul 2026 10:34:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783272870; cv=none;
        d=google.com; s=arc-20260327;
        b=pVAVX4GFKbZJD8Dacjjpz4aqRiUh3EdYCQwtCv43KwRVatUu+nEg8W9OpsItkoHS4e
         Ave80oOLUYqDtwIN3pOloqRDo5fP7y2VFdPcWzNVj0CDqN66YKz1RcpLH/nph60vRqs+
         YJuWPOrKpzy6LUw/D4mzsPe4PndSxSsTqToHAwULj3qBHv413VJNVuclQqO2XS6LWkII
         Bn6GMAHHHPcMZYplmn0X9i5xznFANP0/Nu6LJKU6voisMIs+VqEGWIwNBmVcHA1PiQ8+
         Rko9T3jn7QuNI4aHx6xptIP4ZylcEKFCYDTb7E15PDfz+2zrraRoF+IGj7MQHv8OGVPM
         J1wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=07LsDhLO2ox6jHTH3Tb9AjqVf6iVJb5spZZoxkWZ3/c=;
        fh=N+svw4l0u9WCqf94W3iGN3hfySONANGxif+zF+KQHNw=;
        b=ROhFeLge8XtkZIqRQNcCs4ufwf3TBzFIjClEWkmvt0s7v7DIfwBjV+FGsAra1Yh2uz
         9ADFR6lbu6UFGzoE75YYlekMsvs+CzoyU6wdFD23KQ6+ACkr/hc2KIzuHxLI68Fkxcfx
         GW43j8PBIFZp6aHuG0RVLtQSpcZdAO7KVTlLqKJ/uNcRdmeRVnd/OxI/7acZ4RxF/Kw2
         n0Df3or5Kk0zcLdLOhSTLiQC6sQ2JyrUZOKECKW8xmh9Qva9vl3ClR4UMnHpWXgLOMn5
         HpBLXJbcxxMDjg13IUdEtO6/lA1EqV3IBUBshtabkzHCd70I3rdBIMwg4tbUdtxjP04G
         Vv4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783272870; x=1783877670; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=07LsDhLO2ox6jHTH3Tb9AjqVf6iVJb5spZZoxkWZ3/c=;
        b=J5I2gLqsItCgRqV8LERBWMGlUwBghWm6Xvsa/BhRCH0X4qCsWIVnot5t6wdiG/v0eL
         84Qg5MLWBadUBBTQwqSOqQVjjZRWNvdtLkFw69Wiy5WW/GVnu46XV5qtnDF/WwbUEfnr
         qVQTboNNJRAIkCCf2EdG34wP+I8uYDTN4IQdk56TUVD9mSTCIK0nAZw9tWHzqKDbNE1y
         EEEN8iMVPjhzBw7Hqsu6y8kLA32ZGHZuEYWQYvfPCzTzNeM05HmPTM5+Mojhu3MFberN
         lynJ6r7XR17SVBlGjAL/p+cESNggTTCYtsCcmbOzRBk9iPeFu4RH0lr38aC4vd4gldAo
         hkUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783272870; x=1783877670;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=07LsDhLO2ox6jHTH3Tb9AjqVf6iVJb5spZZoxkWZ3/c=;
        b=GFik0X16shaaIU0NfYfNe0UGhNgR1UHvx9eqeJ9IBNNo+fl8+RbYOMZ9BPosmn0AZT
         DfhoLiH2w0GE/cEZG6s9SO1nnQ7F5380RGfOyoOiLUp3mePK9S98QHWFhKuMXiULKMeL
         bAm+60Wu9sE8A0+HyPFk5rtOTIqV7pkE4sMrtyDOYw9OTmzz2WoNTsKHPa2MPTcCEiCC
         FwpM+1yZ+6dvaFJrqTYWUedUOVQjgPqUWiiKbj360be3Yct3TH2vr0TjCdPhddBIpzgm
         mTZxTCoqUypiS1loIspFVuFH7IfsGN/1VNK/caW1Pn4lm6A53oY3+XOjZsEVZWF4qmFh
         jQ3A==
X-Forwarded-Encrypted: i=1; AHgh+Rqut5ARAWPHu2ICxsc5x1FTJPDsPJ3DUiOd4okEBJL4xj1Bd3O6EOc2Nr+7k1o5CYldj/wzBMkyOrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzbsi6gVoO8/Uw/G4lw+6Gdn6CLy6cq9k8e1mlywsqPYd2w1bk4
	Y/4k55CJjoVHMuzpcXdQZLLNdYgA5otCa54g7S66DqKsM0Qly11YIvg/SxKaZUlwsL/0s393CvS
	wo5MCddUbstDOLqppnprHc4TI0Cc+l9g=
X-Gm-Gg: AfdE7cm+oEos/0sE+K85Y8PtjdsqPFsmC9ExGckAaHpOTdwfmsRHXYURB9PL7iPssgM
	JEvjt2VTawOtEDFFSxdTVj0SEDElS67F2oGUHIn1lsizBcfxKx6EqxNw+15tJ8xww/h0nYE9e9s
	HHgzpFBXhMLJIzlrus9tbqrFl49mG2Q8/764mJXHRmhMl9H422u2PbYORwjG9HpIGLis9wnE6zB
	waUcC84f/Kox7TzYd/Vt/GZQU4mVRbrC+o04kuSGW9eQREo2O+C5+bG2/f0YcFBaGSITiAqE/Kt
	ZSU9oRWwyG/5ZN8tHb3ujqmhTYGlo1spP6jLHtImjDChucskcbtSl41aTlCSmz9Z8gbMW8qFGon
	Yk3N5++XyZ+M8Wj4oe/Ph46YwA0riYQ/y8pdnI97txvkd6k97Zh+pb7dor5xMd661/PAVeQGQLH
	FuhTX/Y13DHqdSvhvAQoYnl7lq9McO0AVwuEMhGi+azKXzz1hqj/VYkx8au5eKaes=
X-Received: by 2002:a05:600c:8218:b0:493:b730:8d78 with SMTP id
 5b1f17b1804b1-493d11f7e42mr80293005e9.31.1783272869911; Sun, 05 Jul 2026
 10:34:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260705172438.119204-3-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260705172438.119204-3-krzysztof.kozlowski@oss.qualcomm.com>
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sun, 5 Jul 2026 19:34:18 +0200
X-Gm-Features: AVVi8CeYU0rKwQouyMF6XYGyrX4-nceCseSEyEFIgQ1gYDP7XFpNKeSvIGMv6iQ
Message-ID: <CALoEA-zm3W1324Z9Pg8RorskBmN-uYupm3jBgiqkr-UO+fYRsw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: ti-ads131m02: Drop redundant NULL check on devm_clk_get_enabled()
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 5 Jul 2026 at 19:26, Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> devm_clk_get_enabled() does not return NULL (only valid clock or ERR
> pointer), so simplify the code to drop redundant IS_ERR_OR_NULL().
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

LGTM.

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards

CJD
