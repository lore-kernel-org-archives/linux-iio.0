Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48675 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932278AbdCVUnj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 16:43:39 -0400
Subject: Re: [PATCH 2/4] iio: Documentation: Add max961x sysfs documentation
To: jacopo <jacopo@jmondi.org>
References: <1487948756-25172-1-git-send-email-jacopo+renesas@jmondi.org>
 <1487948756-25172-3-git-send-email-jacopo+renesas@jmondi.org>
 <56b35a65-a23d-68ac-17d6-cf46f9352ab7@kernel.org>
 <20170321160911.GE30223@w540>
Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>, geert@linux-m68k.org,
        wsa+renesas@sang-engineering.com, magnus.damm@gmail.com,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, meerw@pmeerw.net, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-iio@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <108fc4a4-8312-fc92-7a61-53616cd743de@kernel.org>
Date: Wed, 22 Mar 2017 20:43:34 +0000
MIME-Version: 1.0
In-Reply-To: <20170321160911.GE30223@w540>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/03/17 16:09, jacopo wrote:
> Hi Jonathan,
> 
> On Sat, Feb 25, 2017 at 03:54:45PM +0000, Jonathan Cameron wrote:
>> On 24/02/17 15:05, Jacopo Mondi wrote:
>>> Add documentation for max961x driver.
>>> The only attribute to document is the current sense shunt resistor
>>> value.
>>>
>>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>> Interestingly generic as it only applies to some of the channels.
>> We might need to have the channel where it is effecting the output specified in the
>> name, even if we end up with several repeats of the same thing for different
>> computed channels.
>>
> 
> Sorry, I'm getting on this a bit late...
> 
> Do you still think we should have an attribute for each of the
> channels this values affects?
> We will end up having 2 distinct processed channels (power and
> current) that depends on this value.
> I can expose them as 2 distinct attributes if you think this is the
> case...
Better to have two attributes exposing the same thing than imply it
is relevant to more of channels than it is...
> 
> A note on the series in general: given the lack of comments, I will
> send v2 exposing two processed channels, with no buffered reads, and
> gain selection performed in kernel space.
> If we will have to add buffered reads to accomodate higher sampling
> frequency we'll do that later on eventually.
Great.

Jonathan
> 
> Thanks
>   j
> 
>> Jonathan
>>> ---
>>>  Documentation/ABI/testing/sysfs-bus-iio-adc-max961x | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-max961x
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-max961x b/Documentation/ABI/testing/sysfs-bus-iio-adc-max961x
>>> new file mode 100644
>>> index 0000000..dbd5e75
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-max961x
>>> @@ -0,0 +1,5 @@
>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_shunt_resistor
>>> +Date:		February 2017
>>> +KernelVersion:	4.10
>>> +Contact:	linux-iio@vger.kernel.org
>>> +Description: 	The value of the shunt resistor in micro Ohms.
>>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

