Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10256366802
	for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 20:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769892940; cv=none; b=iwGrXaL/CRYzo4v3iuVEr2kmZedUum8DgfzlSKDarOKDqauooqVLABmYYg2GPNZX6jVEAaAAPJpxK8Z1wAKUBbC0UvznIJhWJM/z6HJNIjudNpod5hnia2fmmutBqYg+TH+kpf1cO0HV8SByMgGItNQn2/jZKd48PbsnJIQNzUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769892940; c=relaxed/simple;
	bh=yNYsa0L/xKSFepadgD0N9FF+ya1AmQo28a/S/dVNtRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dMbMrfWrHCTqN4J24QiZi/MCyuXgFK5u08yecrBsinjZnBN9X5TlPuSUlg+slhCwim2Yebjlbi3xfZdbpoVypn3Inso2JAkiL9sUGIOm4W0F3dKRHwAJb+lbtvZtAx0zrdtvBYRR5u7g1nFhV8RhERgBcABBTz8j9/ofpWzq4Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mw30PvAA; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mw30PvAA"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45efde72438so2183765b6e.3
        for <linux-iio@vger.kernel.org>; Sat, 31 Jan 2026 12:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769892937; x=1770497737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f1fgxA2lt67n8a2OPSV306oPBMCXZ3WraMz8rl9ydMA=;
        b=mw30PvAA/RPiEJdz1BXAT1BW3r5qn6KUcjG4RrqlN6wfVc7ht3/G8mxT15qsRdCn42
         8vYWmAXK3dGXbBVkIiTWcCVsjfq8fl0vOUz0HvuG4t1sGLc3fqUWG5/EJkDysIMpbszi
         txSS06kugGMocmj2EXqCf9kEA61bRvzJkBFtzLi3FsyhaeHDHvCZm6bmS3QmIUX/aZ6Y
         t9wQFUTWLUaf7Qsa8ljwGrn0e9qfFimypqNpP5AA04vjVSgIJNyFOgVlJAEGUsT666Ks
         cRv3lbkmNlP7BLkaay0S6kGz2ntqZ6SQzLy4O3TepyywwWvgPK++e58sx5X8HRSgdb76
         KkXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769892937; x=1770497737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1fgxA2lt67n8a2OPSV306oPBMCXZ3WraMz8rl9ydMA=;
        b=loHwgk18hzVcBCnySpumaWaiHLJ06AkAG5+Tt/cCw9Vg/cT1bSDlCuufZkxUYhqSI8
         oKNTl+0OwXy9ph2u5BOVDGAt9hQLyoE28vAj6eWLX9AK+jpZlEXUa7Y01S4g5sXH6aP/
         iPTkQ4DUvXYr4lANmAEUItezgyE3eBXZlqoPAbyG8scuAqpCaqLOnAtwFEC7Czxyq8+A
         YItS1nBKBU+pF059ZQRM/NNPXwSlN5c8E5AQNWywZrINukq2xX1zgS4JS/QPhLw1Jtt3
         Y9nSw6fb4RrH7d0bYsU9TTanoH6GBM8gW+cc3jt7N6AZAOPKCiqIM63KiwqQ3cDan4pC
         lq4g==
X-Forwarded-Encrypted: i=1; AJvYcCUdewHltpKZ7MLzM/uucDoofkqNNbMyRbIMaFZx1lECgv1NDwGQpq8AwOODWK0K2MsH0Vwd7i3F6oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO3wrUirZDwfjRR+AuxnvVh8J+Iafsfr+LTFZvhWkhj4dbhX28
	AbSz2p17O5RAImTmRbKfdJgroq4pwiksVFINew4Rz0V2VFtYMEg58fklfW3xc6hztI4=
X-Gm-Gg: AZuq6aJeFmeDUHxGVQ4uypo+eg7zlVP3ya0MC+Pl1c6eXZG0vJntYyCdRRV9aGd0d+R
	RLb0enzRhN2Lj8mc5bqk4ifZa1wI7hG4IVLHpOqA06PEy0KGPWaHcQ+9TRBDAFh4X8bsMHLOxFs
	EGdiPKCUsaKMNA8R6NwdRwcHrSUtHuxcEnSfqnTkd3pQtgcRayhoaT46tLZC4uPbqv9RXbF3JQB
	QI5iBbu/JulyJdMfthNyZow2uzE7mM12LPDaOTbm60CbgRIGHumUr7XYBXKzEW4EYpHTRqVUddm
	lqsW7/nrdVDXpTHssiLcVSZEBhogyEL6QNEIbK32FQlehjcdvlo/vzv23KS1naYCFOiLDSDG3rm
	K7ULK4JGxyLjlchuHPEC/uSiXUaAIOuqCaBS8JeOZwFGghOi+YWtDDYeqbeUORpv58zUFBZf08T
	856Rm9kQY5PpRVhmmYPz6tVFupMZQYfrFhnJ+sPHFVdO0m5sqzsfGtlrxQ/FtmcGMN9ZF0uKY=
X-Received: by 2002:a05:6808:1483:b0:45a:76b0:7f6c with SMTP id 5614622812f47-45f3490a356mr3554694b6e.0.1769892937002;
        Sat, 31 Jan 2026 12:55:37 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7? ([2600:8803:e7e4:500:c7ef:51f2:4f7a:6cd7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08f769e8sm6706934b6e.19.2026.01.31.12.55.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Jan 2026 12:55:35 -0800 (PST)
Message-ID: <c9330790-901a-49b4-b33e-f66cd1c2974a@baylibre.com>
Date: Sat, 31 Jan 2026 14:55:33 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] dt-bindings: iio: amplifiers: Add AD8366 support
To: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
References: <20260126-iio-ad8366-update-v2-0-c9a4d31aeb01@analog.com>
 <20260126-iio-ad8366-update-v2-2-c9a4d31aeb01@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260126-iio-ad8366-update-v2-2-c9a4d31aeb01@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/26/26 7:51 AM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add device tree binding documentation for amplifiers and digital
> attenuators. This covers different device variants with similar
> SPI control.
> 

...

> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>

This header isn't needed for this example.

> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      amplifier@0 {
> +        compatible = "adi,ad8366";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +        vcc-supply = <&vcc_3v3>;
> +      };
> +    };
