Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 737AC2135AD
	for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 19:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775934544; cv=none; b=olMSrY3snEhCM4410t+uvskw/5EL5CyaCx4RiVInZ/YahJx2qsHnt7Wf30oMrxA7jeWifnsxUed+uUxkUv5Uq2unZS2KNtSOAIKYr11qhkCguPWoCBXg10ZO2HIZ8r3Y3JIGuUGOcXxuRuDS8fy59785OJvd8Rj8CLJ7OznV4Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775934544; c=relaxed/simple;
	bh=GaqiYCRODZ244NhliFDDI5/uKWNx6Zw+ryBpn5Lzn88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMurzqJ8y12fdpIzLbyvJHg2ODOCDyop4agn+D1k3aOU11kgmJZYywQbLLQE+YUk47eYmWHoaW5IcF0a81bGDTO+H8e/0t6tqciZTfeVVcrwiKk3/QWBUWmfa4yLgRwQ76Vs2N9G1FRjpN8/Ql3KPO6KtNLUEDiofQnoqvcDAiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=FG7eOP6Y; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="FG7eOP6Y"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-68beff25252so720546eaf.0
        for <linux-iio@vger.kernel.org>; Sat, 11 Apr 2026 12:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775934541; x=1776539341; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NUa98CfZyPwdTLM0QyGm53BD0k9kVlpXi2OBQuDga70=;
        b=FG7eOP6YtzJWyu4I/c2M26nGEcJSjN8OtIInpCvWMYlXumiXBiR9S8OOM5KUhPbBUB
         KqVQqIl2CIehH7cHHxQNy1XTi2FYdHHZVO8koAzHjY/tlpfcriqpvYg//yv5tjU3NmGv
         z5UJ3Gx5Q/EQXoHvNzIuqKoTQ8c1uzbKD3lQ5rX2NjdHn4jNxUD9PhenwPetA/XepOg3
         4OO26b3CLiXMSG6xoHZX5LURY+aqywpceoSLfQ2n8Gc/qAvl+q+49+opwO0X5rPgrtXp
         fjOMHnD4q8vOmuSkJQsWdfo74qM05Gw4AvILD8Hej1x0Pnlenuq04IrddmC5PG4wUicw
         Lzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775934541; x=1776539341;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NUa98CfZyPwdTLM0QyGm53BD0k9kVlpXi2OBQuDga70=;
        b=dE5m27InUUgzwz0b+DE8G19RmLnbIpblQ8YKZAJ3tCzNJ67XqRNFhQ63HlR9+JtvsG
         gw3+pvWIPPKYoPW/HyA7xy7O6u/Rp3k78YaXsGtYKeEp4LJC6eAaQrv7M3ZamM9GZMor
         SDcnZT7XPUliOo+tkgx1pvzOXIQcae6f9GjZxePdLOnFKlr2onjLcdpveTI6hPjYM1OT
         jB0p1d3IiQsbRYHYdgSJopnPI0tKj6qwXDu176LwoI6fpalQ8P0ear0zdVcERsDoL9kP
         pWVBhszTiGyAMGNQUheGWul/A5UrFlNyo7xntAcC1gp+kCVMF32xdB0PrhQc/AWeK82N
         20Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXp01tbckzTvvSeau/k+mB2s++kq/OnlhbBVUSz10jcGJFPlWgz36nT64XvzJEqejIBwyRBRT18FoU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymbc/UoU7/vEChzuEwWoVlRjeYt2V2CEUB3qeGO2nJSRFeOUq3
	fUdKKUPPxUpl1qoy0f5i4bB9vHf0WAerlvVcI6AmzT/84tFmoIdOB3KiqkXV+kgrK8M=
X-Gm-Gg: AeBDievSnWoee9a34GAd07pDhmlTkVEf18MKC13CIKQiGhok1l1m6d6sQgQFIhccind
	wTNCB2NlhP2RA+cLTBjGKEko8u7Yg94/6pGY1BHjUpj1sZ03HG+VYt9SfxLsNb8GIzCopqiuGa2
	926C+cSQZ+wg7Y3v/HxhtulXrMdEKZKed2VdBLzP2SJ3/21BJSGM+hNPuCc0j57wcXD2jl1OUIt
	QNzWkxPtuNAAIsBpML4UulS56uDd08VrrSZGogiGlU121RWhhseB8zDJB/SxnwnCrG6NTMzTHTo
	5PU8qoQky6HckRLvGcy4E/DaEYEgSH1gaUQt7uEGbBi2OLcSmedXaQw0TL149XY5zPJoVjkGKcc
	eTBLHrp70r9amh442Bi/45o28a+l/ldFuzQWvNXcdNNysoOGOhx3Za53oVxTmrLGAbmFaWG32PV
	4mVTz6eXi8YAvPgj8QM7i7FjGmSkIz6xRtLjxqLT91VatA+6mnFP6gYfB/qM/SGFhROfRHxi0+7
	w==
X-Received: by 2002:a05:6820:f001:b0:68d:dfd2:8db3 with SMTP id 006d021491bc7-68ddfd2906emr990879eaf.8.1775934541346;
        Sat, 11 Apr 2026 12:09:01 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:d2e5:c81c:5b23:fe55? ([2600:8803:e7e4:500:d2e5:c81c:5b23:fe55])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-68bcb67e49bsm3509908eaf.14.2026.04.11.12.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Apr 2026 12:09:00 -0700 (PDT)
Message-ID: <cf4ac074-9098-45f5-9cd6-0eeea0b41179@baylibre.com>
Date: Sat, 11 Apr 2026 14:08:59 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] dt-bindings: iio: adc: ad4130: Add new supported
 parts
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <cover.1774996100.git.Jonathan.Santos@analog.com>
 <7bf387e8ad20e2f2bb14534fb03608bbadfa47d2.1774996100.git.Jonathan.Santos@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <7bf387e8ad20e2f2bb14534fb03608bbadfa47d2.1774996100.git.Jonathan.Santos@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/26 6:58 AM, Jonathan Santos wrote:
> Extend driver support for AD4129-4/8, AD4130-4, and AD4131-4/8 ADC
> variants.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> Changes in v3:
> * None.
> 
> Changes in v2:
> * None.
> ---
>  .../devicetree/bindings/iio/adc/adi,ad4130.yaml   | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> index fcc00e5cfd54..f4cad68fa04d 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> @@ -5,19 +5,30 @@
>  $id: http://devicetree.org/schemas/iio/adc/adi,ad4130.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Analog Devices AD4130 ADC device driver
> +title: Analog Devices AD4130 family ADC device driver

I'm surprised that on one said anything about the word "driver"
in a devicetree binding. :-)

