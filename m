Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58806 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752094AbcGXLdx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 07:33:53 -0400
Subject: Re: Fwd: [PATCH] iio: accel: kxcjk-1013: add the "KIOX000A" ACPI id
To: Christophe Chapuis <chris.chapuis@gmail.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <CACA7eURhTD8RzGOoYciOEp_oC2iuy+197gS7M3qnMhAEiH=v8A@mail.gmail.com>
 <CACA7eUSu8yY+0F_Dy+RE5magv+erZRZNO-ydNmvN8c5rT87SfA@mail.gmail.com>
 <4ca42ff1-7222-b0a4-daad-e591bc2892be@kernel.org>
 <1468944695.13661.225.camel@linux.intel.com>
 <CACA7eUT+RVMx7ap0B8eippVZeohG0i0Sdys-WwSNFZvt_LmPBQ@mail.gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <372bd4fc-a591-e2a7-7efb-d949022a8304@kernel.org>
Date: Sun, 24 Jul 2016 12:33:50 +0100
MIME-Version: 1.0
In-Reply-To: <CACA7eUT+RVMx7ap0B8eippVZeohG0i0Sdys-WwSNFZvt_LmPBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/07/16 07:26, Christophe Chapuis wrote:
> Hi,
> 
> On Tue, Jul 19, 2016 at 6:11 PM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
>> On Tue, 2016-07-19 at 16:58 +0100, Jonathan Cameron wrote:
>>> On 19/07/16 11:01, Christophe Chapuis wrote:
>>>>
>>>> On the Cube i9 tablet, the ACPI id for the Kionix kxcj9
>>>> accelerometer
>>>> is "KIOX000A" (as can be seen in the DSDT of the Cube i9 tablet).
>>>> It is the same accelerometer, so only adding the ACPI id is needed.
>>>>
>>>> Signed-off-by: Christophe Chapuis <chris.chapuis@gmail.com>
>> Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the togreg branch of iio.git - initially pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan
>>
>>> Hi Christophe,
>>>
>>> Looks like it made it through fine this time!
>>>
>>> Please cc the original driver author for any patches to a driver.
>>> Here
>>> Srinivas (added)
>>> Can't see why it would be an issue, but best to make sure thy are in
>>> the loop!
>> I don't see any issue with the patch.
> 
> Ok great :)
> 
>>>
>>> Funnily enough, not everyone keeps up with all the mails on the list
>>> ;)
>> We can blame mail filters :)
>>>>
>>>> ---
>>>>  drivers/iio/accel/kxcjk-1013.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/iio/accel/kxcjk-1013.c
>>>> b/drivers/iio/accel/kxcjk-1013.c
>>>> index edec1d0..cf392c7 100644
>>>> --- a/drivers/iio/accel/kxcjk-1013.c
>>>> +++ b/drivers/iio/accel/kxcjk-1013.c
>>>> @@ -1393,6 +1393,7 @@ static const struct acpi_device_id
>>>> kx_acpi_match[] = {
>>>>      {"KXCJ1013", KXCJK1013},
>>>>      {"KXCJ1008", KXCJ91008},
>>>>      {"KXCJ9000", KXCJ91008},
>>>> +    {"KIOX000A", KXCJ91008},
>>>>      {"KXTJ1009", KXTJ21009},
>>>>      {"SMO8500",  KXCJ91008},
>>>>      { },
>>>>

