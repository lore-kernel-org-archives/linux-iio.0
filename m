Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC5E3F23D9;
	Mon,  2 Mar 2026 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772459966; cv=none; b=V/CfgdApVgrqC8bSKU32K+Cf59DaOg/1cWihSgHEKVBlkwbJJC2wzcm7/i7PsNuduuvDe3woloJyjbTYo3gopyRKnvFa2gtBk/OE0C9ZghIWqLDDY8sL7MQlq/VckBbkCCRtoY241eAS6rjYTn53QAWYDWgMYtQePaWJwys4io8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772459966; c=relaxed/simple;
	bh=viU66Yyaj99zg2CuwP4OxpKVWBfUfWva6xshngJ9Jv0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUCcDnGSV1lZ0cddWvP0T0Gkr1PgMZM+CsyLDn2M5eWqKVTow9qaxjkypDpfzwTuBssnLgat41u9dsqNYbnPf6YcDEtBe4jjjEWx8b+ljLxUo+C2aFjTIXXU6heWZC+GrLA137DDiWsLUOSn4tIgzlk7LxbbG3P9Nmazp+YU9uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZsGoKkT8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZsGoKkT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA973C2BC87;
	Mon,  2 Mar 2026 13:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772459966;
	bh=viU66Yyaj99zg2CuwP4OxpKVWBfUfWva6xshngJ9Jv0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ZsGoKkT8vtmA9t5JzutKLMdYVu6V8t4mPz0rxKLrPB7CPrVwXo5DZuKKhm3VOMxV9
	 QLaNZh4MYEUrUOuePyKB1g3FlsYe/W1xY5tiseoorjkLCzQc/f3jicPxR9A+hEBa4x
	 5LnZ4evaLzgv5N8MHNR4Vkh3UXaQru0ksBWedZLMIxo3c0EE/B+VRBe2O151cNAGiF
	 tKecTw310DbF4bwcV8LVEc0l+dg1Wh6s/zF5JSGHyrL4Yyif4QFrNGajG3yXBiaVBD
	 3POpmrekZYBVxljx4N9q7BJMQg8U0WxkJmX57ayU3k2Bbmxg4j9cTB3efvgWIXlrdJ
	 1A2PjX3qAGU9w==
Message-ID: <49b3a87d-7ea0-4da1-871e-35ddf5d5b454@kernel.org>
Date: Mon, 2 Mar 2026 14:59:21 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] dt-bindings: iio: adc: amlogic,meson-saradc: add
 S4 compatible
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Nick Xie <nick@khadas.com>, neil.armstrong@linaro.org,
 khilman@baylibre.com, jbrunet@baylibre.com, krzk+dt@kernel.org,
 jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, xieqinick@gmail.com
References: <20260228065840.702651-1-nick@khadas.com>
 <20260228065840.702651-2-nick@khadas.com>
 <20260228-quirky-lemon-reindeer-1045f6@quoll>
 <CAFBinCAkxO4HoN0Cw0Fc2B3KRLLJqso1p5+qjNN_E0c26VOf2g@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CAFBinCAkxO4HoN0Cw0Fc2B3KRLLJqso1p5+qjNN_E0c26VOf2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 02/03/2026 12:58, Martin Blumenstingl wrote:
> Hi Krzysztof,
> 
> On Sat, Feb 28, 2026 at 12:18 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>>
>> On Sat, Feb 28, 2026 at 02:58:37PM +0800, Nick Xie wrote:
>>> Add the compatible string for the SARADC (Successive Approximation
>>> Register ADC) IP block found in the Amlogic Meson S4 SoC.
>>
>> ... which is fully compatible with g12a?
>>
>> Write proper explanations.
> Would you be fine with:
> "There are no known differences between the SARADC on S4 and the one
> on G12A. In the past differences between SARADC on the different SoCs
> generations have been uncovered late, meaning that a dedicated
> compatible string has proven to be useful."

No, last sentence is redundant. You do not need to explain in the commit
msg rules of bindings, because they are obvious/known. You need to
explain the hardware, e.g. in this case the compatibility between devices.

> 
> Do you also require Nick to add amlogic,meson-g12a-saradc as fallback
> compatible string for amlogic,meson-s4-saradc?
> 
>>>
>>> Signed-off-by: Nick Xie <nick@khadas.com>
>>> ---
>>>  .../devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml        | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
>>> index bb9825e7346dd..5496a0dc714aa 100644
>>> --- a/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
>>> +++ b/Documentation/devicetree/bindings/iio/adc/amlogic,meson-saradc.yaml
>>> @@ -27,6 +27,7 @@ properties:
>>>                - amlogic,meson-gxm-saradc
>>>                - amlogic,meson-axg-saradc
>>>                - amlogic,meson-g12a-saradc
>>> +              - amlogic,meson-s4-saradc
>>
>> If this is compatible with other device, you need proper fallback.
>>
>>>            - const: amlogic,meson-saradc
>>
>> And this one is now kind of fake - how does this device use it?
> As you have noticed later, it is currently not used.
> Can you please confirm that my understanding of the next steps is correct:
> - you're expecting Nick to omit the amlogic,meson-saradc fallback
> compatible string for amlogic,meson-s4-saradc

Not omit but replace with proper fallback to specific compatible.

> - and you would like to see amlogic,meson-saradc removed (from the
> bindings and .dts files that are already upstream) - I will take care
> of this once S4 support lands upstream

This no. It's an ABI, you cannot change it. Not worth it, either.

Best regards,
Krzysztof
