Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2445430594F
	for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789824212; cv=none; b=KEY+NdtQ4ppIANzHhfh8hE6DT9wpsEFdvhVQ8hrf+roIXUoGCzPAWAVRyNap7k3gKF8EeD7Qtguc8mNMs2gLOVM2c4Tx1CproPfr37+4Zi54ncrlox9lL/Ep+xqfu2K9nwFAlsyi6W71FJiFTCwREXGPmPmmfh+whACtJQL0IOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789824212; c=relaxed/simple;
	bh=oqu1ZjNxi0F3UXS+4RXdwI3lwSHWQEMDLX/P/O8dKSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B5m7wokkhoM06elYOu1v26kM11NFh6tnoxrD0BC0iqWSoygW8E4OsBUe5nR/1GOjoB5EU+c+i2kRNH5OiQ4Qo4ovRL6+xCG8Z89sJULuMyMB/7/YNDYs/rJGfdsYPceKStvfZ9aaU9s3maS+EVdVpUh32Y0fHRF+HaRIuaybkHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=pKoIexRi; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pKoIexRi"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f89so957399f8f.3
        for <linux-iio@vger.kernel.org>; Sat, 19 Sep 2026 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1789824206; x=1790429006; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I6FrOEEciDq9ZXU99OtyWWJL3jqDBzGG33W1ecDR5UQ=;
        b=pKoIexRieimSr2isT9jR5N5g+Jq/8mugS7/5F6o75d3c15fMRhPJsCCnInPYowSY7Q
         hiCIRQdcHEmWJdJjrv/7SdlmGVAdO5USuTFKOZl79fO0q10YxY1OBrBH3uVkplD2AY6Q
         XtsU04fk9AaGRbw+bjaZEPWfGbAhieLALL0f13jL7f9yTQcRlR73Sopigvmpyd7J571p
         P17VoP+b1vE4vG/jYay1GKVJXk/3/5MUY/DU/M9unzi22AbQ0+NW+tyxnoe9tkNftbju
         Y1NK2TS51nsDJ7TlPXcT85rGL4Ux0RQ4G5nQjzo1/NyONm3sESoeRupmEQ58vG7cgFrG
         Vk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789824206; x=1790429006;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I6FrOEEciDq9ZXU99OtyWWJL3jqDBzGG33W1ecDR5UQ=;
        b=bYAjzVAvTOR1XKB5VWZ1ZNJCJ8xGLi4HyphqHBzYqXlt1P20GkfwXsdztIpkOUHopG
         12qePXZJyhSaTo2vYZJgfb+FviVfHfMkpf0+k9Q3yoB23JJX0XRG0kJLpMOTB38+hUnA
         AWv8r6l3ilVlhJl5ja1ZUmaemjm0ge9Hm+cJ0+ixhAt60JJj3SXuZc6EDJ74O4jZxGYJ
         SW8C3KPkwiKSRK8WcANdNPWxzdANGxNe160ksdDgdcNkGBc2k/35JBTe77Mxzd6bo6E8
         jLA0YytcB8VZdoF1D2vRESt3dwXnwX/LvFULty7czSqm7FkYQ039heTxwziURRk0hLZg
         vV5A==
X-Forwarded-Encrypted: i=1; AKwUvBzZHPc6yc2lRKuTGITFROEckzQkKUNDwiM3TZsgLmM/w5aSbLWpOp+d+WEnh/3U8dEV1E/8X/fhpIw=@vger.kernel.org
X-Gm-Message-State: AFuF++kdCbGw4d5AbFXHilg5b0YN6lMu8t/6L1WE8+htEzQWZDTxlMqn
	2TgKnZcQ4QgpfhHOsS9x0o3z/RhbEXXoXGmdJCNS5T9F2BNvDoPTPH22+YJC/qBJbnY=
X-Gm-Gg: AYBFou393OoEvf+xzEmeK+r79/dIfcCbjWUHN7HtshJ/spDkQVsr5rsO4hxV8qs7IqE
	WXcIX4XvEvknQBDKBjY5Zar8GOE8FwrNXnIDBR+Qpg6ldzXY6+u+0XdlrGnvBeSEwGpQG1oM0wJ
	TWG7kb3e/fT9ap14//emx0WncabVingv3XNFVaPZD93ARky1AxtNjNIv7QIfnZQFlK0gaJ5glLt
	bcMdlqrZ619vcNKbA25TUHFElc+FMttJP7Kzm8XzLHblKKi+7q2sQJcrYk6TxWcEFmWPyRYn1wq
	q+aej0aL5pJZuWAIeL+XhE/Bb77KwzKM5ekYDH04MuW69/Sw2Gy0BMWv2Nhe29DUky+5k7cw43T
	twJkA8UeeBMDAGeiEDA2HzVcUTrAtjpjEl92Tk/ysZqEIAK4f0uFblfGyZol6PnfMv98DUTFg74
	jnCa03H4DQj8D1kc9xgmhys4dB3W9W/df6DnkcYQVr0OeHXKWai11Kh3E5o03D0vh4YIxriLI1y
	0mC2VcQbzqGZZdXxMwiH+o5h95y3XtF4AfQmcaav0xQDNB54c01Vy1QRgMJ4G4mDtA=
X-Received: by 2002:a05:6000:41c7:b0:486:fcfd:45d4 with SMTP id ffacd0b85a97d-4871e216bcfmr8106032f8f.17.1789824205769;
        Sat, 19 Sep 2026 06:23:25 -0700 (PDT)
Received: from ?IPV6:2a02:2f05:1204:e000:2cf7:c250:64a9:ae77? ([2a02:2f05:1204:e000:2cf7:c250:64a9:ae77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487245a869asm6815705f8f.37.2026.09.19.06.23.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 06:23:25 -0700 (PDT)
Message-ID: <ebbbf57b-9c2a-4b6b-b705-31cd4bd0a617@tuxon.dev>
Date: Sat, 19 Sep 2026 16:23:22 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/17] nvmem: microchip-otpc: nvmem: add emulation mode
 and OTP access validation
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 ehristev@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com, srini@kernel.org, marcelo.schmitt@analog.com,
 radu.sabau@analog.com, joshua.crofts1@gmail.com, jorge.marques@analog.com,
 Jonathan.Santos@analog.com, jishnu.prakash@oss.qualcomm.com,
 antoniu.miclaus@analog.com, duje@dujemihanovic.xyz,
 mazziesaccount@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260806074024.531259-1-varshini.rajendran@microchip.com>
 <20260806074024.531259-11-varshini.rajendran@microchip.com>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260806074024.531259-11-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/6/26 10:40, Varshini Rajendran wrote:
> Add validation of OTP memory accessibility and emulation mode status
> during probe.
> 
> When the boot packet is not configured, emulation mode allows access to
> the other packets. When both are not available an informational message
> is logged to help with debugging.
> 
> Signed-off-by: Varshini Rajendran<varshini.rajendran@microchip.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@tuxon.dev>
