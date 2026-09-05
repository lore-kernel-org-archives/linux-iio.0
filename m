Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08709392837;
	Sat,  5 Sep 2026 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788611641; cv=none; b=B9ii//ZDj0bwc/JLpoAfgsMGog6rCzwm7kb6nYL537DCeJg+a7e3JdN5MWHImR933GQ7Z1WfUuvgmMaYOcfqOaWcQ7VafpNOZNTyc/AMD5kRiTihrMRTzWMbrXJr5BRxSO3IAdQeONOifn6ROP3WO1hiat0pBao0ZweFK4hF2UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788611641; c=relaxed/simple;
	bh=J7SMtiKlBBbZWYclvHQTLte3uDjJ0fcR8VtDcDYr970=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLNcqNVNnd4AMM3tsPKsO9zi7tsGDjTGDjHSh3QvMxVAC6lJqNyAicDY8zs4WvEQnlS9q1ziTHBaEl8rZMDNdtlP5/Z0oIyPmSxuw30Zx9lS9VW4dPXkfRVu56TVM1M9rbxJ2t/nz86PwqQbIIU5em826GBdp3WJTxmA1Sms9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l1aYzDlf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l1aYzDlf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280C61F00A3D;
	Sat,  5 Sep 2026 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788611639;
	bh=XgBtZNIDFz3WZ+CFXbgS4Jg3hHYLaVlrTvEDPXGq3UA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=l1aYzDlfPrfIKGZu9mfRkVqWPh5UFihTOkOFXUzNHoDlKMG3pcGpxpYKZYr8LQBEE
	 JWZHKOIHoIaSt99fDvR2Hopj20RfLLhX5mWqTN8mWUlchCjlSRac5v4OCe862nXMEW
	 ytMcVDv+vQR+1MJw5+r7IU3fUMvVYdi438YDELxDUGs4iFW5GIvX0uEG1Tt9m/94yz
	 GUyfCjPdeDQIxEuLBZdClED1DE+m6mHmuT2FQ2dhbgKE7LjuNd3SwcqMOiUbvu83bj
	 YHx9UDNSOQ/4KtXiqCJjsBA4tCFFJpNkUMpQM6AqujAkqPNDnxGwpBoiahxqv4J++x
	 /77z8ydjdZDlg==
Message-ID: <68403ee8-59a9-4f31-8384-99f70b93c3cd@kernel.org>
Date: Sat, 5 Sep 2026 14:33:56 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: axp288: Add TS bias override for Haier HV103H
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vladyslav Ivashchenko <cactucatu4eckuu@gmail.com>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Chen-Yu Tsai <wens@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260904133155.51290-1-cactucatu4eckuu@gmail.com>
 <bdd9e2c0-ce13-422b-90ff-0311cc251b15@kernel.org>
 <20260905024225.468a2959@jic23-huawei>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <20260905024225.468a2959@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Jonathan,

On 5-Sep-26 03:42, Jonathan Cameron wrote:
> On Fri, 4 Sep 2026 21:48:21 +0200
> Hans de Goede <hansg@kernel.org> wrote:
> 
>> Hi,
>>
>> On 4-Sep-26 3:31 PM, Vladyslav Ivashchenko wrote:
>>> The Haier HV103H firmware configures the AXP288 TS pin bias
>>> current to 60 uA. This causes the battery temperature reading to
>>> cross the charging temperature threshold under load, incorrectly
>>> stopping battery charging.
>>>
>>> Setting the TS bias current to 80 uA fixes the temperature
>>> measurement and prevents charging from being incorrectly disabled.
>>>
>>> Add a DMI quirk to use the 80 uA TS bias current on the Haier
>>> HV103H.
>>>
>>> Signed-off-by: Vladyslav Ivashchenko <cactucatu4eckuu@gmail.com>  
>>
>> Thanks, patch looks good to me:
>>
>> Reviewed-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
>>
>> Regards,
>>
>> Hans
>>
> 
> Fixes tag appropriate?  There was the original dance of keeping the firmware
> version, then this table was added to fix that up.  Anyhow, I'm thinking yes
> and tag should be:
> 
> 
> Fixes: 9bcf15f75cac ("iio: adc: axp288: Fix TS-pin handling")
> 
> But bit awkward as anyone trying to just back port to that better have
> been paying attention and picked up the following, so lets have that as well with comment
> Fixes: 048058399f19 ("iio: adc: axp288: Override TS pin bias current for some models") # Add necessary infrastructure
> 
> With those two, applied to the fixes-togreg branch of iio.git
> 
> Shout if you think this should be done differently.

This sounds good to me, thank you for taking care of this.

Regards,

Hans


>>
>>> ---
>>>  drivers/iio/adc/axp288_adc.c | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
>>> index c8283279c47..c98863d612a 100644
>>> --- a/drivers/iio/adc/axp288_adc.c
>>> +++ b/drivers/iio/adc/axp288_adc.c
>>> @@ -207,6 +207,14 @@ static const struct dmi_system_id axp288_adc_ts_bias_override[] = {
>>>  		},
>>>  		.driver_data = (void *)(uintptr_t)AXP288_ADC_TS_BIAS_80UA,
>>>  	},
>>> +	{
>>> +		/* Haier HV103H */
>>> +		.matches = {
>>> +		  DMI_MATCH(DMI_SYS_VENDOR, "Haier"),
>>> +		  DMI_MATCH(DMI_PRODUCT_NAME, "HV103H"),
>>> +		},
>>> +		.driver_data = (void *)(uintptr_t)AXP288_ADC_TS_BIAS_80UA,
>>> +	},
>>>  	{ }
>>>  };
>>>    
>>
> 

