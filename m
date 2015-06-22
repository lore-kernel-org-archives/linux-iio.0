Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:35994 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751275AbbFVFle (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jun 2015 01:41:34 -0400
Received: by iecvh10 with SMTP id vh10so11707181iec.3
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2015 22:41:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5583CE90.4050203@metafoo.de>
References: <CAM=Q2cucHAsMEYb-YtB2oU9d7wHk-KD+XVCMtuNMbaBqqn4+Cw@mail.gmail.com>
	<5582E038.3090207@metafoo.de>
	<CAM=Q2cv5r=F25uFpZXUQh1vj3Dd+a91hJoQ2A+oBdPhTMts+qg@mail.gmail.com>
	<5583CE90.4050203@metafoo.de>
Date: Mon, 22 Jun 2015 11:11:33 +0530
Message-ID: <CAM=Q2cvneOejLweA9DB=T_UCsXoXqrk9DZjC=qRvH2NbCmQgEA@mail.gmail.com>
Subject: Re: JESD204B support
From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Jun 19, 2015 at 1:40 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 06/19/2015 08:45 AM, Shubhrajyoti Datta wrote:
>>
>> On Thu, Jun 18, 2015 at 8:44 PM, Lars-Peter Clausen <lars@metafoo.de>
>> wrote:
>>>
>>> On 06/18/2015 02:46 PM, Shubhrajyoti Datta wrote:
>>>>
>>>>
>>>> Hi ,
>>>>
>>>> I was wondering if there is any plans or existing support for JESD204B.
>>>> I was thinking of IIO. However any other ideas may be welcome.
>>>
>>>
>>>
>>> Yes, IIO is the way to go. We have some out-of-tree drivers for JESD204B
>>> chips.
>>
>>
>> Great.
>>
>>> They are not quite ready yet,  but we'll get there
>>
>> May be sharing early could get some alignment.
>
>
> It mostly all at
> https://github.com/analogdevicesinc/linux/blob/xcomm_zynq/drivers/iio/adc/
>
> E.g.
> https://github.com/analogdevicesinc/linux/blob/xcomm_zynq/drivers/iio/adc/cf_axi_jesd204b_v51.c
> and
> https://github.com/analogdevicesinc/linux/blob/xcomm_zynq/drivers/iio/adc/cf_axi_adc_core.c
>
> But it is nothing you'd want to copy infrastructure wise. The drivers have a
> lot of built-in assumptions about the underlying topology and will really
> only work with a certain JESD converter and JESD host controller
> combination.

OK still good stuff.

>
>>
>>
>> The thing is the data rate change and the related clock tree
>> dependencies that it may bring.
>> That part looked tricky to me. So thought of talking to the community
>> before sketching something
>> not compatible. :-)
>
>
> Yeah, I think that's one of the parts we haven't really figured out yet. The
> JESD transceiver that we are using on the host system unfortunately is not
> re-programmable at runtime.
>
> But otherwise we are using the normal clock framework to model the various
> clock relationships and use it to enable/disable and setup the clocks as
> required.

Thanks for the  heads up.
>
> - Lars
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-iio" in
