Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE7340DFB0;
	Sat, 21 Mar 2026 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774087225; cv=none; b=thdG8KffQTnZRJkvkPreMxk5IH7Egqbf3sNVLdS2Ussz33WDuoYDk9YeOwPT4rlDTYgEW6BQLT1AR9lu8JlJOlHqcKHs6SjrgCfizSAUiP8PTYd2P0rIggOC+vH3UDgeZhOchtbebpvJnY+MP0/kvFr21FR4pQYxNhtG6nDmfH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774087225; c=relaxed/simple;
	bh=Kb974ZkNTfjOEet/Vg6UwvvagVCTUeeUHmntE6yBEJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cAusy83iUFDpVm4lPc06EfjINSB69yNER+tFoi8lQVdL1xNHc4fk7xtWMKa1v57KW6OXmNA2nqkx+q3euLJTrAU7CT/ysdIzwAwr81UX5qEwdeLouBKzxVfWWqt/9omzNJidFvXO34uWCRk18Q2MPjYOV0tmhL4G0vSmONjF9Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3MFA5LF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3MFA5LF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1317DC19421;
	Sat, 21 Mar 2026 10:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774087224;
	bh=Kb974ZkNTfjOEet/Vg6UwvvagVCTUeeUHmntE6yBEJE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f3MFA5LFmfYk7WVizXC6/6RI4TRVxI9PwKF64/BEm0bqWFwnI4MfpYHwWymzCAn3H
	 cXCXeebGImPp6U3T1a52risiPVw3iMWAq8PgkjDWMNLRZohnqDAytQwT+rZDUDHNTQ
	 p07OX7wKi+Fsnm3l5E5MqikNO4FjI0OYktBRuwFftFdrDIN946JMk9NdVohVL6tkCb
	 1FT8hq/Q4Fyt4hI/mbQyny+cwScD4GNOVMFSb0LP4NbYjOEabZN9RgWrmgVWR5292i
	 O8zmLsecA+lHa8DPfMptg/OwbNjYbq7qTlm0rRRmesS16+waJuScm20GukF9vvlIk+
	 jWWc3hzqWdP+A==
Message-ID: <66396d68-19e4-45eb-9ffa-af1215c8590e@kernel.org>
Date: Sat, 21 Mar 2026 11:00:20 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: iio: proximity: add ST VL53L1X ToF
 sensor
To: Sirat <email@sirat.me>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org
References: <20260319190738.151614-1-email@sirat.me>
 <20260319190738.151614-2-email@sirat.me>
 <c59cfc77-b49a-48c4-b975-026ccd3be31a@kernel.org>
 <CANn+LW+zdT-kHN-SyHeogEk9FdsaXYkkobia=Tn9-FQmVv2nOw@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CANn+LW+zdT-kHN-SyHeogEk9FdsaXYkkobia=Tn9-FQmVv2nOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/03/2026 14:28, Sirat wrote:
> On Fri, Mar 20, 2026 at 6:52 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On 19/03/2026 20:07, Siratul Islam wrote:
>>>
>>>  properties:
>>>    compatible:
>>> -    const: st,vl53l0x
>>> +    enum:
>>> +      - st,vl53l0x
>>> +      - st,vl53l1x
>>>
>>>    reg:
>>>      maxItems: 1
>>> @@ -21,12 +24,17 @@ properties:
>>>
>>>    reset-gpios:
>>>      maxItems: 1
>>> +    description:
>>> +      Phandle to the XSHUT GPIO. Used for hardware reset.
>>>
>>> -  vdd-supply: true
>>> +  vdd-supply:
>>> +    description:
>>> +      Phandle to the vdd input voltage. This is physically required for operation.
>>
>> Drop the description. Schema tells that.
>>
>>>
>>>  required:
>>>    - compatible
>>>    - reg
>>> +  - vdd-supply
>>
>> That's an ABI break and nothing in commit msg explains why. You need
>> rationale for this, but most likely everything was working fine before,
>> so supply should not be required.
>>
> The vdd-supply is practically required by both the drivers depending
> on this binding,
> But the original driver author did not specify the requirement on the binding.
> The driver works with or without the binding (it falls back to a dummy
> regulator when not specified),
> but specifying it makes the intent clear.

"That's an ABI break and nothing in commit msg explains why. "

Please don't ask me to quote it third time... See also writing-bindings
doc. You must provide rationale for ABI changes.

Best regards,
Krzysztof
