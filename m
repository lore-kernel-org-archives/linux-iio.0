Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0402BEFE5
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776529454; cv=none; b=aF4O2iUV/Y/TwF0JVMem6p6YXE4SvtUD0Ii7a1zcChzdw5vVF1oGWrTFFE/xNQIoCu2S/6+hwPZXXV2lSqtnuMZJBX2nUFORz7qJ7MuuYmJvgltNeFtTzD6BAYtXjcVnxTEbb26Rq+x8/UIp0ge6X8DI4eV/hLh3m/CFrdCCNrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776529454; c=relaxed/simple;
	bh=r3v0eu8jyNJghFoZb8nIZSTQlFmhjMLEDWwjRApN++s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upD5SSj9dShi+LGhEFT4Iisxb9KFQ2nlB3PDuUlOW1oL8aNUpiLxB3RkaykUL1E5PKi6gOM5772kBP5H7jZeNnVgDbpUGloYNep3DovVguThfjNyvfnaGaCeqXlxgLNF3G+izeAqrJlPBJLdv4pviAA8xihLlkb8dktwkcFm3F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=RyqVfkKb; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="RyqVfkKb"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4779b2497b4so1071455b6e.3
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 09:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1776529452; x=1777134252; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I6Sv7AAI94WVTWDfs27d7TPLTcwxc8wbnSfHQgFK/To=;
        b=RyqVfkKbe/TDV1byPQrW3gdtJdmFYgQlxR2peus+0qYWEFoouOa4dQo+aX1MreP80V
         HeGpQHj/5Yb8ofu1iEQuPLQD5sMGaP+Nfq/6VmQf3GB/wpvAtYxc7yqyNLPuYzc0pqHs
         vVjNYv1tNxgJlyS+ashbt2frv7LlGtJnk4hlGoJpjN0+hZ0kD7whpnpKaKgNqXuU84z/
         USwZXUjtefAz+V/HlO8CN/5H1QSm9g5IpBnEhbjkkSSThtJfaAjHpZTecZANYSD5eero
         5aLGJpMtlsLrsAW+y/ly4FFCAwQsTIfo6R7XJUGMmED8L7tFlTF3YShtMfhP/HH+YBrQ
         GFuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776529452; x=1777134252;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I6Sv7AAI94WVTWDfs27d7TPLTcwxc8wbnSfHQgFK/To=;
        b=aOOV3FsXA1JC0EKk4Qu0rQsh6bjMz5i9Hsd9EwAGMSwZfqx+AeJRg+AHgclLqN3KKJ
         8ieB8v5SIcodZ+icL9v7suUEk9URaxCKFMf6C85XPd/fRWUF80R1gzZxJonXYST/6fmc
         ugzcBm1wjmioi1tEbAHbFMRZ6MmjoS+47hGx7TZj/+exCbMLKEgoaJk3o6kjw8V1ozz1
         4nYRv/jHGYdNVM2vGSw1AsYVeaaUEjuYTXSbxbT8vFsmC+4OZPrech3VDyuwiPgQHGcI
         fFAtEj93nBc8ET/EUFowbhZXtETY91Y92ao6ZRFGfHWGwtwvvkPZaGfnF6/rkZGeTFzv
         gbZg==
X-Gm-Message-State: AOJu0YzlVQquKeuGH3s0R8D3QUy/cAjZNOxdD62lCz17K3SZ7HICtcU5
	f5/zswlJjrP792MmAsx15FeOUyVZ0FlvElhcVJhbo9TccDFUKyjpKFk9BOKnA7XDbXA=
X-Gm-Gg: AeBDievYFM0tObns09p5B3/9GZyeZ1BG62FA1hWDii8mPdschRc//Kjt4h0+EgFr75X
	8zDbtuPoyqcKtVjDLm9zijeYbhUYEuysofhnmcVFeWKai87Jo/WVZkD0bdSEgExLzyAFVZPljO/
	nW1NCYW96tlXDEv60xc4RhM0WjpLZwQOEfgM6RuRjX3ignB0LVCPHS6IM9Jlz5uXxBDx+lIVfcb
	nle/jwBmdo5Xocnkuopuu2Tb6kgBZauMPwokM0IuzH/T4NZ/vINloZy0ONSpThzVxTZ8IVL8FRM
	DVN91fkCRtBE+j7F92YqEnTkmXPEzdqXNu0OfsB3MBVehjiEGSu6nlyT+udVjcrNh7WrF0p6IE7
	5STQIzDL5AlBkvf3Wpca1ONmklZhyz9EnwR83/IQ3tUWD2V7F9lqIvxjMLfel0WCKi2Klws+XfG
	lZtb3OqvWqlBhKyMhXBTWj6Oma8FXFic+3D1jxtLrEiLZiltrhrX5KwOLkxgg216nLrqb+J8bQL
	/PB+vdhGU0dzTFsL9+QSb8=
X-Received: by 2002:a05:6808:13d3:b0:46a:7718:c525 with SMTP id 5614622812f47-4799ca3e611mr4248868b6e.32.1776529452361;
        Sat, 18 Apr 2026 09:24:12 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b1f8:aabe:74d7:21ba? ([2600:8803:e7e4:500:b1f8:aabe:74d7:21ba])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42b930afa63sm4097296fac.5.2026.04.18.09.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Apr 2026 09:24:11 -0700 (PDT)
Message-ID: <36e3611d-642e-42de-9a56-cf81c3e06832@baylibre.com>
Date: Sat, 18 Apr 2026 11:24:10 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] Update APDS990x ALS to support device trees
To: Svyatoslav Ryhel <clamor95@gmail.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260418144716.132936-1-clamor95@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260418144716.132936-1-clamor95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/18/26 9:47 AM, Svyatoslav Ryhel wrote:
> Document Avago APDS9900/9901 ALS/Proximity sensor in schema and modernize
> its driver to support OF bindings.
> 
> Svyatoslav Ryhel (5):
>   dt-bindings: iio: light: Document Avago APDS9900/9901 ALS/Proximity
>     sensor
>   misc: apds990x: Use more device managed approach in the probe
>   misc: apds990x: Drop Vled supply
>   misc: apds990x: Convert to use OF bindings
>   misc: apds990x: Drop IRQF_TRIGGER_LOW trigger
> 
>  .../bindings/iio/light/avago,apds9900.yaml    |  83 ++++++++
>  drivers/misc/apds990x.c                       | 197 +++++++++---------

As mentioned in my reply to the dt-bindings patch, there is already an
IIO driver that looks like it could be compatible. I'm guessing that
this misc driver pre-dates the IIO subsystem. I would have a look at it
instead (drivers/iio/light/tsl2772.c).

>  include/linux/platform_data/apds990x.h        |  65 ------
>  3 files changed, 187 insertions(+), 158 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/avago,apds9900.yaml
>  delete mode 100644 include/linux/platform_data/apds990x.h
> 

