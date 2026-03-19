Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CEE3E9F72;
	Thu, 19 Mar 2026 16:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773938996; cv=none; b=lJytit+RiCxhRDCw+pgP0ZPY7or5W912XNiEeg0UvMKblikzi9YQVkRRpDF6WUFsYN+wrzZoKzXYtiHWuXu9gwyXFxeLBGxpqba60ZBkCZK/UswzMYuYlFva44Len0+axf+AjxdGcLuwulqa56miZPbgVibftMLBGSMJTSur33Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773938996; c=relaxed/simple;
	bh=OFhuQ54VXhEfWoDHGTnof5aCH2ea5vI6aK1ZVUtVPSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIlPQCSk4VYn3VDQ9yWF8kZhlbZk3MynQIkit2YNH8y2nJ/8lNpbxab1hGS2Uia5v5fn+ugZXJkD7XNdvCdfJXAaDoebdszLEvVn5XgP0Cuy1OY7jik6yaVummDCN4iKkCWplE73Z5GhGqQrZovaVi3iD7RXuTYi7p+EVuNRmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgPXdXWP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgPXdXWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21719C19425;
	Thu, 19 Mar 2026 16:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773938996;
	bh=OFhuQ54VXhEfWoDHGTnof5aCH2ea5vI6aK1ZVUtVPSU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GgPXdXWPJrlcMfUbczUuNIilzilEjjvGml2s3oYBDAujA+IvbevN9nvymrKjURyS2
	 vdd4Lngt0fctxegcl0UMNkKWVn9OSHYudiI7yjecJmMt0FpxF8S0ZamuU8WkoKaIAT
	 NB2j0aUN/IWuuGZAVsTes7LJm+yOdskUQRTEyuG/uKtdDdON7efQOIfLkAAwwiiS4C
	 JDkIIkEsiICIQY+NhF28SBKUtLNqSuWvIpHgSwdFSPZwdaUvcK4wRUwMY13H0ncml+
	 GTrd/ighutP1hz1PhAPizp8q6HDjuoyW7x52Mw/WR3QxpcEzbEu3jIICxAsJivhxiX
	 FlJH4h8pQgZYA==
Message-ID: <12a06779-cbbb-4dc2-b564-7b9cdff6796b@kernel.org>
Date: Thu, 19 Mar 2026 17:49:51 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] dt-bindings: iio: adc: xilinx-xadc: convert to YAML
 format
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, saikrishna12468@gmail.com, git@amd.com
References: <20260220053941.611415-1-sai.krishna.potthuri@amd.com>
 <20260220053941.611415-6-sai.krishna.potthuri@amd.com>
 <20260221-dancing-papaya-wolverine-db8afd@quoll>
 <b89933a3-5f25-466c-a2f5-6e231aa12749@amd.com>
 <21d425bc-9406-401b-9817-7255ba3d31fc@baylibre.com>
 <e4c9729f-1785-4d10-a337-37b0d26fe30b@amd.com>
 <f1706ec0-3995-4fdf-a9fb-8e1e688438a7@baylibre.com>
 <05bcc5b7-b3e8-40fb-be70-413c74afcfb1@amd.com>
 <cf749e8c-f141-4367-81ad-827e02273ec5@baylibre.com>
 <6a4e3d95-875f-4c2b-8443-c2f2b19ff166@amd.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <6a4e3d95-875f-4c2b-8443-c2f2b19ff166@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2026 16:49, Sai Krishna Potthuri wrote:
>>>>>>>>
>>>>>>>>> +
>>>>>>>>> +$defs:
>>>>>>>>
>>>>>>>> Why this is a def, not used directly? I see only one usage of this def.
>>>>>>>
>>>>>>> I am getting the below error if i define the patternProperties directly.
>>>>>>> Seems like complex vendor peroperties should be referenced via $ref.
>>>>>>> Please suggest if there is any better way to deal this.
>>>>>>
>>>>>> It is hard to say without seeing the new version of what you wrote.
>>>>>
>>>>> In v1 series, i created $def and referenced this in xlnx,channels to avoid the error that i mentioned.
>>>>
>>>> Is the code below the code that causes the error?
>>>
>>> No, the below code is not creating the error but Krzysztof asked the question on this code,
>>> "Why this is a def, not used directly? I see only one usage of this def."
>>>
>>> I am saying if i don't use the def and use it directly i am seeing the error that i mentioned. So, asking is there any better way to handle this case other than using def.
>>
>> If you could show us the actual code that is causing the error, then
>> we could perhaps spot a mistake or suggest an alternative.

Thanks David, I am surprised how many emails we need to exchange just to
see the actual code.

> 
> Thanks. Here is the code that is causing the error
> ("properties:xlnx,channels:type: 'boolean' was expected").
> 
> xlnx,channels:

Device nodes do not have any prefixes. Just take a look at any DTS or
any binding.

Probably that's the reason, because nothing in this code looks
particularly odd. Anyway, please do not come with odd syntax in the code
without any explanation, just to make it passing the tests, so for
example ignoring the checks we have.


Best regards,
Krzysztof
