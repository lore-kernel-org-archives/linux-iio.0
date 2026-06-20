Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081F1184540
	for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781970912; cv=none; b=uJDyACpETqeCNRTz2SknHPdYsjDNkXrnTDJ3JfKQDCYitNv70+nicjMPY30fmZqk2dBU7+1Xc+EnlEA6EdMXDVRpAGwFiRgUOxn+e7QBrctElj0MhZWao9eHF8qaO1TMGWYx4fM2mEDuREV9kgVidf6n21/bxJoYLdZONG9ca6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781970912; c=relaxed/simple;
	bh=0lKUIQs4DLFpG6UCv+ZxvYRPrJFW3LayDbvZZjnGGfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EtZY15TtRac23Oh67S10XCa/unZpgv+MH/Qx+GhTQPwpq2V06/mlccacLBiqrpgTOfCEodl2F5LpTlMg+5VjCH6uXY+7LaVkynW3wk0hEIOYYAdUrUn+frzhEwJXddwWnhivUZcREQQuRa496MvdCSNMLOa/sWWi6aflFoGddlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=FSXZ2moA; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="FSXZ2moA"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e93b04a142so483771a34.1
        for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 08:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781970908; x=1782575708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fx7vYMUQVtCy9nnWfrav0HhwbfUcy6nnm5W3QuvNFk=;
        b=FSXZ2moAP4pTCO8QBDbU4XlN6f3VjKikNdemewpi9BelC+eW+FcHkRzvziNuawX+AH
         OcWCQpeD8byjKsx5j0+5ChOidK1kk/X7S5D4Fmupnp58wBBuXv1FwGWGkyVNDt2XlDrE
         FWRcuI25zBmkPQ5Dz+4INGaUANk9J8WxiUXXBMV9TDZrdMLhqH8NssNOe/NZsF4foHHh
         ZA6q3Nam4jhqO3/iTwzdswwLG1k46dwfJa3evqOu3z11TSMO5huk9sLlzrLKeTFZrQus
         9acYeVxfzkpTPOdF5aptlWY/uuLyId01NAnxaKREWVjsPhu9CEyL+6KbN0msBpypWdTh
         +mBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781970908; x=1782575708;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/fx7vYMUQVtCy9nnWfrav0HhwbfUcy6nnm5W3QuvNFk=;
        b=Uk0QNAhAgsiO9CIF489KqZmZa0Q++h6C6uBapruOpnRrvD17ZU2p59FwLulDqLp0xH
         LpJLGAsvp1BTuvWg638/RQBsc6B2ImBtM2HyWsCbP8pTEfijW5NpnrhDu5fewxdCoWpU
         +08qBtzot2xH2EPlbcPO/e+1rZDFmf4zWyosD4wP3wniQONxSJON5gcAvR3U0a6Jzkzi
         vccvrRLLpCzhoVzvxtmqt1DKRX3m7kXITa8rmy+E09oNV7bT79jGeb4XyaHDEYmtegVw
         7VWGco59Lb0CGHmhRwEsYvZ1FDWbY/ZYqLXkmPMth+bXOEYFqdfuEsNuOrQqAr3OvtfR
         4EYQ==
X-Forwarded-Encrypted: i=1; AFNElJ/TZ++VHwSN0lZY3ywDbKZwwehzPwxnIzZ4rQWb7Ybiw3tkzDQjGobV8T4FfDlnZH81U5w+bRDZ4Fc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlCrlj3OC5fDR5Vj2bZjqSPoDtDsc1d7/SD6B9eUYYitLSK5kZ
	tp0yJrc4EO57+mZo8E9Kgro9k29tbJ6FkMf0jkeds4Lv3ptSbZBVabVnfo6G1Zg/aIuydKsYxmY
	R+hsmlzs=
X-Gm-Gg: AfdE7cnWp/9Y+/AmwfyeZ1JTJy6eJdmWHz3LlM3sCUJd4sIhPeMa/cIslDyZS8snQEW
	IutPq5SPgW3SBZ0dVfo4h9EToxps/1vDrLmJ1bXuCyZnq9K4uPeKseGseoKMgro+xnYRFCFSr/d
	6ygB8D4zvpv+gnrxhADvrLu/dSIPfYpdzd23nZ+6bp0RMXQdxoy6wrId8OXxAwloG+W4h2wJ/fe
	3LG/1jZKYCRNv4i8Ll65cuO6SnZuWnKD05rafLQheBsO0pm2ebAckVfyfGDgEnsSip8N12rX3+p
	4sUdYd+rYt+uo9N9uwCda8GcqGJ3NNzMKbgaHsuzvR3Dg0EHQU/YYiDpNW0bKVKMq6zFIF03yLf
	/xlfvGfSVhogr7Z6X5mPr1SgMX4t5m5lrUOU0D0Ibk9/6jnWuqKyL/o3tqbIHe+2hGpFWK2wGOc
	o7KLSXfHo/o99B39tV1a696OBkuZfewXM75qi3uXJ0lJQAHNobIk0n9yng9TfWakc=
X-Received: by 2002:a05:6830:6313:b0:7e6:c752:3f0c with SMTP id 46e09a7af769-7e92d917c2emr7106818a34.24.1781970907729;
        Sat, 20 Jun 2026 08:55:07 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:3ad0:4082:8242:2d72? ([2600:8803:e7e4:500:3ad0:4082:8242:2d72])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e944007d74sm1994044a34.5.2026.06.20.08.55.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2026 08:55:07 -0700 (PDT)
Message-ID: <1d4092c4-5d28-4f92-96a5-c337bfd27093@baylibre.com>
Date: Sat, 20 Jun 2026 10:55:06 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/3] dt-bindings: iio: adc: Add excitation current
 sources properties
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260618-new-channel-props-v1-0-963c1b5cf40a@gmail.com>
 <20260618-new-channel-props-v1-2-963c1b5cf40a@gmail.com>
 <073b0a89-65af-4a21-837d-851d35e3e294@baylibre.com>
 <DJD6EB7J90AR.20Z61X02BHAZT@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <DJD6EB7J90AR.20Z61X02BHAZT@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/26 11:44 AM, Kurt Borja wrote:
> On Fri Jun 19, 2026 at 9:27 AM -05, David Lechner wrote:
>> On 6/18/26 7:33 PM, Kurt Borja wrote:
>>> Some ADCs incorporate current sources that provide excitation current to
>>> resistive temperature devices (RTDs), thermistors diodes and other
>>> resistive sensors that require constant current biasing.
>>>
>>> The maxItems constraint of 16 is arbitrary but should be big enough for
>>> most devices.
>>
>> I wouldn't put an arbitrary limit here. The bindings that include it
>> can extend it to add a limit that makes sense instead.
> 
> I agree.
> 
> This was partly a misunderstanding. I thought -microamp properties fall
> back to uint32 not uint32-array but it's the other way around right?
> 
Standard units are uint32-array. Defined in [1].

[1]: https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

