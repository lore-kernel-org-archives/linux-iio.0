Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5515E349CFE
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 19:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782157447; cv=none; b=ZQ41GaLTmxcu28zBPT/EJap+/aK7zb2rv23zt4gz1wD64ma6snMcZEZKtOaTxgekC+K9cIMj1U4Ah/eXHupNPZdlFyS9xV2tIo2lZdYUyMZhz2wIH7BQ1X0ABZg2WX+HBtZWmFQYEuioWxuwXE5eqrkULSO5tI24gJDbNcU06Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782157447; c=relaxed/simple;
	bh=TptxrxtfJDI5ow9MorrAqtjc1IA8BO4i9BvtrQy1U2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=skJt1muSdYjwa6eJDA2DruXpvTUwAZbWDLSXG3pslxxTOXxGsq8DtbKh4TBWvmta0EQXR7icF12gttUU/zUki+40v5HAGUOAJQRRNUZgi5OD4/9indPTMSn6NVxc4DXOExlwXkSeLPnEu8WsIEYLmRA3iH7nUWq5dVjI9ydMX3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=UARiWpDK; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="UARiWpDK"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-69d7cdd3b8eso2041406eaf.2
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 12:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1782157445; x=1782762245; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hlALyJbt2TnvwNlzlsye6XsRVOhuhk64FjUlN2vstwA=;
        b=UARiWpDKNUsYko3l+DoVUCj3aJYqLApGdfvvH/H7X5ePkMsRg67zY6GQuNciq9coKM
         6VFoIp9zbvZQUag07q3NIwTu+uOiFGG8phqGq3lCnb0NNcta5meoT4PdPcFucEwcl21T
         C1YX8c0TaoLQQsywUeB2v6BfOKA3ci0lVXhtVrr0x/KskA29LXW8boC/ZdTY82aZn+7t
         GyuzKplkstfLXDTybkcjzdPS+EvnmJ5hByJ6PCRghgkM5+Yfr1QTcQBb/kMx313Pg41U
         Fm2MwyZZcHAG3D+NMJeQGwInEOdk4wGQ2B9AgG4sPiMhQohoKJwd2z3UrIQmSSRDKlsU
         odGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782157445; x=1782762245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hlALyJbt2TnvwNlzlsye6XsRVOhuhk64FjUlN2vstwA=;
        b=S9QDaXoC+/ZEptskk/hAeoHBvkTsjMMWBUnwZp2b/CcChkmpB9wP93KCCw9KlAOXfr
         A2K3xKCGG9vFyU5asDqZieFp3jaL6BlJN/lDDsopy93/u/8KXDBaUvG8+pXoEL+CoaH7
         3PbnYdnxcQhPOD7qvDb1I4cVxpd9pb0k8X5YAsGsgYeDVD3hsb9Qegwrq0Ct3ti27Wg8
         q41HyBtLElpeihzDXdacUA31uRvgM2nZba5XA+8z4MNgd7FXvJNIgbJjh987Ti1UhfKb
         PwXhEAtMCPnA4hTGMmEUVgxlR0AZQhslWrlblkQTLBqrPfyhm3nwetCJTOtBmfjHLTiF
         bzqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+AXkfTfPEWSb+z6wjJ/NNTmz807qDcdYHTFwYIn0wvvxJ98sjMThPohqsHdZlm45DbvIkJVCB8unk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMT0P47cht5x8tV8FtjWxwqrh/9u0kAfaZ7LK1/pIfLwwlsSOi
	Et3oISzs0L12zNSBYpgi1k1/RMuC03HmQpHt2hwQCfrFBmNHtN1OhHX/y/BNBJvgy3Y=
X-Gm-Gg: AfdE7ckM7l7j8c0Qe0NR9LocEn78bmV5HxweX9ZBhm3zh0K69cjlbwqytHsVaFVU3r4
	MAfuVxXRtGZcg/18vAxCadxYON7reEtv9Y00JVZ6IZvsZK8xp5eN7cf5uvAjdDx5Psd90MBwqEs
	RoaMqWzrKg6/kioZIP2AjYvZfA3HWjE3NLqbFEQx4AJZYcK1UI25MBJB2k/tIkoyzozhhwj88Dz
	JW9yAumBag72ZViVNjPkwpVHU/aLqPCxPGR/VnvvTh52hUTpDxe78pkSMhZqyr9zU0/fIhf+iim
	zoT3rMrdys6d9ocAv6S2fRT/QvJ7AuZpwANn6Ia/ciZjP0t884tU47D4/o9jn2mca3MLjRtYjlb
	576B01+RPvllPXkf1KWQsAm0ovmW7sbnrPg9l9IyXN4zF9d1G5fd7gm1V5tkEIO5iQRZz7UlMpr
	LaOfggh7BwL1f430NYHUCiXeK5X+ZoFxw1kRiHv+Yzm7fjs/k+uYhhzpyqucWJyNQ=
X-Received: by 2002:a05:6820:198f:b0:694:6acf:a420 with SMTP id 006d021491bc7-6a0d88787fcmr13052242eaf.15.1782157445333;
        Mon, 22 Jun 2026 12:44:05 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6526:8577:6be9:cb7b? ([2600:8803:e7e4:500:6526:8577:6be9:cb7b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472f0475e3sm6668016fac.16.2026.06.22.12.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2026 12:44:04 -0700 (PDT)
Message-ID: <de5dc05e-f2d5-4a09-a4fe-9d78c77c0649@baylibre.com>
Date: Mon, 22 Jun 2026 14:44:04 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 3/3] dt-bindings: iio: adc: Add burn-out current
 properties
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260622-new-channel-props-v2-0-aafd5369f253@gmail.com>
 <20260622-new-channel-props-v2-3-aafd5369f253@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260622-new-channel-props-v2-3-aafd5369f253@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/26 2:30 PM, Kurt Borja wrote:
> Some ADCs incorporate burn-out current sources that provide current to
> the channel's input pins for open-circuit or short-circuit detection.
> 
> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
> ---
>  Documentation/devicetree/bindings/iio/adc/adc.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> index 160a8cfa9842a86..9240f569d4ab7af 100644
> --- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
> @@ -105,6 +105,12 @@ properties:
>        This array describes the current configuration of the excitation current
>        sources or the single matched current for all sources.
>  
> +  burn-out-current-microamp:

This also needs to be nanoamp.

> +    maxItems: 1
> +    description:
> +      Burn-out current sources provide current to the channel's input pins for
> +      open-circuit or short-circuit detection.
> +
>  anyOf:
>    - oneOf:
>        - required:
> 

