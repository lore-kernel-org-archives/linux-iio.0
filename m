Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF85298CC4;
	Thu, 14 May 2026 12:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778763279; cv=none; b=dD7whZ6AH8rikRaB06xshaUiXfy3tcs9TisuKUtxbsOY1zP1Me3NlAe0T7aJ084m9eLScFXNJWP3uPsEWZ8oXavaFfmGNi6cmKHhUB/As5gbgiu2JyTbZ/7HWTN/hl696NM1mHAs1twwPrPI3c25e0gv4NtQRe1Ddnjdikrc8pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778763279; c=relaxed/simple;
	bh=lSk3G+QHk1Ze3TYsR9oWBIFR2A3P/FtUa3w/uYn9mCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GDRdFKFZMcwNfAg52nxQIN35q7aE2PFBj8L6h+T/+IxCwUkgWczUJXnmAfnix+mFMQU0NCzXXpSThLyJS8vTjGvzUl0Pyp8hlOedkIsCodl0CA7OJztDxm8ppvqIlNxLD5f0xi6+GcsQFbSip1VIsqNkX9J4NVXsOafKnMymhOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47C5C2BCB3;
	Thu, 14 May 2026 12:54:35 +0000 (UTC)
Message-ID: <f9050955-72fd-4e4a-aa0a-f699142fc146@linux-m68k.org>
Date: Thu, 14 May 2026 22:54:32 +1000
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] m68k: mcf5441x: setup DAC clock name as per
 driver name
To: Geert Uytterhoeven <geert@linux-m68k.org>, Steven King
 <sfking@fdwdc.com>, Arnd Bergmann <arnd@arndb.de>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Greg Ungerer <gerg@uclinux.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
References: <20260513-wip-stmark2-dac-v2-0-fcdae50cf51a@baylibre.com>
 <20260513-wip-stmark2-dac-v2-3-fcdae50cf51a@baylibre.com>
 <734e2323-78dc-43c7-b5fc-0a35cc72e035@linux-m68k.org>
 <ugda72734f6vn67jp6cz6hpkif55a5m4yey3yo2dswicqbyrdx@zk4lhc7k4dxu>
Content-Language: en-US
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <ugda72734f6vn67jp6cz6hpkif55a5m4yey3yo2dswicqbyrdx@zk4lhc7k4dxu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Angelo,

On 14/5/26 17:05, Angelo Dureghello wrote:
> Hi Greg,
> 
> On 14.05.2026 11:27, Greg Ungerer wrote:
>> Hi Angelo,
>>
>> On 13/5/26 19:14, Angelo Dureghello wrote:
>>> From: Angelo Dureghello <adureghello@baylibre.com>
>>>
>>> Later in this patchset, the mcf54415 DAC driver is added.
>>> Considering some other different ColdFire cpu DACs exists, the DAC driver
>>> is named as "mcf54415_dac", related to the mcf5441x family SoCs with
>>> DACs (mcf54415/6/7/8).
>>>
>>> So updating DAC clock names to bind with proper driver name.
>>
>> I am not sure I like naming the clocks here with a prefix for the
>> specific SoC part number this is in. It might be unlikely now, but
>> what if another ColdFire family SoC member uses this same hardware block?
>> That is very common amongst other hardware blocks within the ColdFire
>> family. Can we come up with a name more specific to just this type
>> of DAC hardware block?
>>
> 
> from a brief study, this 12bit DAC, and DAC module in general, is only on
> this mcf45441x family. There are some ColdFire with ADC only, as those
> mcf5249/53/82.
> The mcf51mm/ag/je are the opnly to have a 5bit dacs, but these are mcus.
> So, if i don't miss any existing model, the name may be correct,
> unless we want rename it to a more generic mcf_dac.

Yes, I would suggest just leaving it as is, "mcfdac".
That is not currently used by any other ColdFire variants supported by
the kernel.

Regards
Greg



>> Regards
>> Greg
>>
>>
> 
> Regards,
> angelo
>>
>>
>>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
>>> ---
>>>    arch/m68k/coldfire/m5441x.c | 8 ++++----
>>>    1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/m68k/coldfire/m5441x.c b/arch/m68k/coldfire/m5441x.c
>>> index 5b5e09ecf487..b724d7fc1a08 100644
>>> --- a/arch/m68k/coldfire/m5441x.c
>>> +++ b/arch/m68k/coldfire/m5441x.c
>>> @@ -43,8 +43,8 @@ DEFINE_CLK(0, "mcfpit.2", 34, MCF_BUSCLK);
>>>    DEFINE_CLK(0, "mcfpit.3", 35, MCF_BUSCLK);
>>>    DEFINE_CLK(0, "mcfeport.0", 36, MCF_CLK);
>>>    DEFINE_CLK(0, "mcfadc.0", 37, MCF_CLK);
>>> -DEFINE_CLK(0, "mcfdac.0", 38, MCF_CLK);
>>> -DEFINE_CLK(0, "mcfdac.1", 39, MCF_CLK);
>>> +DEFINE_CLK(0, "mcf54415_dac.0", 38, MCF_CLK);
>>> +DEFINE_CLK(0, "mcf54415_dac.1", 39, MCF_CLK);
>>>    DEFINE_CLK(0, "mcfrtc.0", 42, MCF_CLK);
>>>    DEFINE_CLK(0, "mcfsim.0", 43, MCF_CLK);
>>>    DEFINE_CLK(0, "mcfusb-otg.0", 44, MCF_CLK);
>>> @@ -106,8 +106,8 @@ static struct clk_lookup m5411x_clk_lookup[] = {
>>>    	CLKDEV_INIT("mcfpit.3", NULL, &__clk_0_35),
>>>    	CLKDEV_INIT("mcfeport.0", NULL, &__clk_0_36),
>>>    	CLKDEV_INIT("mcfadc.0", NULL, &__clk_0_37),
>>> -	CLKDEV_INIT("mcfdac.0", NULL, &__clk_0_38),
>>> -	CLKDEV_INIT("mcfdac.1", NULL, &__clk_0_39),
>>> +	CLKDEV_INIT("mcf54415_dac.0", NULL, &__clk_0_38),
>>> +	CLKDEV_INIT("mcf54415_dac.1", NULL, &__clk_0_39),
>>>    	CLKDEV_INIT("mcfrtc.0", NULL, &__clk_0_42),
>>>    	CLKDEV_INIT("mcfsim.0", NULL, &__clk_0_43),
>>>    	CLKDEV_INIT("mcfusb-otg.0", NULL, &__clk_0_44),
>>>
>>

