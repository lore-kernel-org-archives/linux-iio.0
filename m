Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266513A7F46
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 18:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786214387; cv=none; b=b6YnENbMeC/uRQg2e3B6Rv+l1iQNyUXC+jBsRkG2/+34HRZZSoO6ZwqsOdjLs9Lr8Jx2hp9Luf/rDlabNe+v/MNDuNDghzLR3rrdSwLUkhtdzYZmHqEeGRLAWsfh34FI6TgMAdK2QpmBlXHBNOA56LwYtqCEl5gEsf0boVOUlwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786214387; c=relaxed/simple;
	bh=11RcXIDIZRJRr+2CsYJckF1zhJr+67XxDlvO8iduTD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GWZqgN6BZ8r6TiVr4qcEdztmcP16WW/ddqSuWF8a62yCkMUJSu8DXRENkb2u3m5pbKbAv0CGd+GRYfrFs126/w2TPtR387ScYv+Eqv0HhjPIT9gpJx3VErSyOmPPYR4QecGOha3sPZGaK7hRuuqZvU8EjmG+di/AjiitMfBh+TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=GSBXI756; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="GSBXI756"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-6ae3faeb9c3so277553eaf.1
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2026 11:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786214385; x=1786819185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qSSU0mdXDr7Kdauu787eIHPF8JBaU64+u/a6lK27OP4=;
        b=GSBXI756LZiNdIrgYAbnvAjDBsRfV38zVus/DZMRFXNiJE0rOOuKxzMjGO5tq+l+Cb
         i6xPZiUQaYqC8+yKqb3WqX3x91K5gO8HUWZ5w7NaK4LPHBfPYJWW19yVKgVeEIMuyU1p
         uXWNvoL6Dm+Jq67qTTWgdnOHg/NxCeVJJNFCfFbwzbXaJBMV/aIzJ026PRY7uPKYXjHb
         RouCyuWGrEB75jn6l5r236M9z5Cw6JT64BXk7p/UfqQaAIlCt9IxgHFL2XrjoSY69diK
         wvbqhJlMg2PFf/UTuLpzGLISQ8//QGSf4QunCb57ImoVE1fUEyEsCbgtL9l/6ownGvRC
         V8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786214385; x=1786819185;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qSSU0mdXDr7Kdauu787eIHPF8JBaU64+u/a6lK27OP4=;
        b=U6gwp6V8bD/AABWwItJg6zQOhpj7mTta7t/jes3zR/rV1Z0q3EmtTS3VrZ/7qKCT7r
         306UIAAyClUKxG1ERaAvZ09jzcHWWFm7cqGXu8/UCPnd64DpjL0tPw/k7nQkcbE7SxiZ
         gLIi6/mBerWo4f2ZjAlZPoKwRpRLB2DdGPusE0sR8IJ1PbuF22UUE7GP6/486c28+6HG
         WRKFXF9qfNVwkYxmFB+rgIhS+Iv2mjp7kiYGED0OvWAxnw2ZsUls/InEUXLWs1nuQIUw
         L4mDQ46lEzLJ3jrYLwBrB1NAYGQWkrhgIX1kvl2NaI4RCFTD5r8CIBry3+S+FkpSF09P
         7tbQ==
X-Forwarded-Encrypted: i=1; AHgh+RrHpCy+tHY/8Y+WoxF1gz0LlNwnGqElRFE3XfqA5XW/pdjaEvcoA0/kV5Wou4irFsk2CyMQv7AlFFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2V0qj2YLYympU165w1WY525dR2xiot1lXYn54kq8Cb1w0evUP
	Pos8bzqG4ktaUMATvzHjSd03Gtfd7UZShrgPbfl9tOf+1yFvucNq0XLy1VZtc7CYhL8=
X-Gm-Gg: AR+sD13boSV5dxjfKyq4kBYx4Yzzt8aiYBtPOnClJDvE2i8dr4XDOgaj6tM4nBMg3cF
	N+IH456rfegrCOTl2u5c0p5FiJPrrq5KNkk0iUGbB8AIUAWywFW7UtxLk/WIfunMOd88H4SFg+P
	/AvH7dhWcXfi56wnUVWQX31P97mujTitpFmetgV1gMsGRVWNZ37l0xAfuVrhPyRrR6SRzLEd9zE
	WvpESy++K+ep0dqF41YKZeY5ZczJHhyrA7H6tpdf2aAbrThHMgG+SLoRc+cn5PtizNr1gp9e2XK
	gTHKF7VX6DdpGZDoRUmsnCyb/b9utOUFHgtR6pSNlSVOV9E5SRqigIowXfzQC50zxWEv6uJS3Sx
	MMjXswL3q6Vpi6XJlG4lew3j0oTxwRhgxkrBou026CdfxxW3ybCkmDhu/FHk9NPhb1HJquJxLgi
	npuByv8LUpQwY0jF/ALnJgoVVxNzcMPqGPrxrSWM4CV8sBiRdl5Wt7W6A4Ju0uN2nTejRNsvtUJ
	QuDzCO3ryjioMga1FleNExasAwk2AQNA+aU6iI=
X-Received: by 2002:a05:6820:820:b0:6aa:e854:d03b with SMTP id 006d021491bc7-6b03505ccf6mr6167181eaf.2.1786214384946;
        Sat, 08 Aug 2026 11:39:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:99c2:f16e:201c:3bb5? ([2600:8803:e7e4:500:99c2:f16e:201c:3bb5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-459f1d793c9sm4702369fac.9.2026.08.08.11.39.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2026 11:39:44 -0700 (PDT)
Message-ID: <d60ccde7-9a9d-44e8-9f6e-1c5e15c3cb65@baylibre.com>
Date: Sat, 8 Aug 2026 13:39:42 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/9] iio: adc: ti-ads1262: support excitation currents
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20260807-ads126x-v3-0-f89925d72792@gmail.com>
 <20260807-ads126x-v3-6-f89925d72792@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260807-ads126x-v3-6-f89925d72792@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/26 10:58 PM, Kurt Borja wrote:
> Support the two IDAC excitation current sources. Each channel can route
> its IDAC1/IDAC2 outputs to a pin via the "excitation-channels" property
> and select a magnitude via "excitation-current-nanoamp".
> 

Reviewed-by: David Lechner <dlechner@baylibre.com>

> @@ -1150,7 +1192,58 @@ static int ads1262_parse_channel_node(struct ads1262 *st,
>  		}
>  	}
>  
> +	if (fwnode_property_present(node, "excitation-channels")) {
> +		count = fwnode_property_count_u32(node, "excitation-channels");
> +		if (count < 0)
> +			return dev_err_probe(dev, count,
> +					     "%s: failed to count excitation-channels\n",
> +					     fwnode_get_name(node));
> +
> +		pins[0] = ADS1262_IDACMUX_NO_CONN;
> +		pins[1] = ADS1262_IDACMUX_NO_CONN;
> +		ret = fwnode_property_read_u32_array(node, "excitation-channels",
> +						     pins, min(count, ARRAY_SIZE(pins)));
> +		if (ret)
> +			return dev_err_probe(dev, ret, "%s: failed to read excitation-channels\n",
> +					     fwnode_get_name(node));
> +		if (pins[0] > ADS1262_IDACMUX_NO_CONN || pins[1] > ADS1262_IDACMUX_NO_CONN)
> +			return dev_err_probe(dev, -EINVAL, "%s: excitation-channels not in range\n",
> +					     fwnode_get_name(node));
> +		chan->idac_mux[0] = pins[0];
> +		chan->idac_mux[1] = pins[1];
> +
> +		mags[0] = 0;
> +		mags[1] = 0;
> +		ret = fwnode_property_read_u32_array(node, "excitation-current-nanoamp",
> +						     mags, min(count, ARRAY_SIZE(mags)));
> +		if (ret == -EOVERFLOW)
> +			return dev_err_probe(dev, ret,
> +					     "%s: excitation-current-nanoamp size mismatch\n",
> +					     fwnode_get_name(node));

I don't think we need a special error message for this case. The error code will already
be printed.

> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "%s: failed to read excitation-current-nanoamp\n",
> +					     fwnode_get_name(node));
> +
