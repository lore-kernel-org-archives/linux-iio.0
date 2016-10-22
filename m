Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52934 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934263AbcJVObz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 10:31:55 -0400
Subject: Re: [PATCH 0/4] IIO wrapper drivers, dpot-dac and envelope-detector
To: Peter Rosin <peda@axentia.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel@vger.kernel.org
References: <1476955562-13673-1-git-send-email-peda@axentia.se>
 <9b8c0789-566d-67a3-b4f5-dbe4c69f6932@metafoo.de>
 <7472292a-a509-c791-4eff-5a5037ead837@axentia.se>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <78e23544-4db2-d69a-d1e6-64fa36864cb6@kernel.org>
Date: Sat, 22 Oct 2016 15:31:52 +0100
MIME-Version: 1.0
In-Reply-To: <7472292a-a509-c791-4eff-5a5037ead837@axentia.se>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/10/16 15:53, Peter Rosin wrote:
> On 2016-10-20 14:55, Lars-Peter Clausen wrote:
>> On 10/20/2016 11:25 AM, Peter Rosin wrote:
>>> Also, is there some agreed-upon way to dig out the maximum value from
>>> an iio channel? If so, "dpot-dac,max-ohms" can be eliminated from the
>>> dt bindings, which would have been nice...
>>
>> Yes, this is something we could really use. In a sense it exists for the
>> devices with buffer-capable channels where there is the real_bits field
>> which tells us the data width of the channel. But a dedicated mechanism for
>> querying the maximum (and minimum) valid code seems like a useful feature.
>> Not only for in-kernel clients, but also for userspace.
> 
> For the dpot I have, real_bits (if provided) would not be too great since
> the maximum value is 256 (i.e. 257 possible wiper positions). I doesn't
> feel like I'm the most qualified person to add these new min/max attributes
> though, as I'm not familiar with most parts of the iio code. I'll happily
> jump on board if they are somehow magically available, of course :-)
> 
>>> I'm also wondering if I'm somehow abusing the regulator? I only added
>>> it to get rid of a "dpot-dac,max-voltage" thing from the dt bindings.
>>> It feels right though, but maybe I should do more with it than check
>>> its voltage? What?
>>
>> Enable the regulator when it is in use?
> 
> Right, I didn't express myself all that clearly, I do in fact already
> enable the regulator in ->probe and disable it in ->remove. Anything
> else?
Nope.  This is the same thing we do with ADCs that take a reference voltage.
Sometimes we even query the voltage ever time or handle notifiers that
tell use when it changes... (only example I can immediately think of for
that is the sht15 driver in hwmon - my fault a long time ago ;)
> 
>>> There are a couple of things to be said about the envelope detector,
>>> one question is where it should live? I placed it in the adc directory,
>>> but maybe it deserves an iio directory of its own? I'm also a bit
>>> worried that the name is a wee bit too generic. But what is a good
>>> name? I don't want it to be too long like dac-comp-envelope-detector
>>> and something like dac-comp-env-det is just unreadable. Naming is
>>> difficult... And suggestions?
>>
>> Yeah, it is a bit tricky. It is a envelope detector built from discrete
>> components, but of course there are many more ways to build one. If you have
>> a codename for your platform you could use this for the DT compatible
>> string, like 'vendor,foobar-envelope-detector'.
> 
> Good idea! Then the "envelope-detector,inverted" bool can go, and be
> implied by the compatible string. If some way to rebind the irq trigger
> is later discovered that can be added as a channel attr without
> deprecating any dt bindings stuff. While at it, the other properties
> ("envelope-detector,dac-max" and "envelope-detector,comp-interval-ms")
> could also be implied from the compatible string. Would that be better?
> I think so.
> 
> But, the compatible string is one thing and the driver name is another.
> "axentia,tse850-envelope-detector" doesn't seem like the best of driver
> names...
> 
> Are there any existing examples of drivers for (generic) things built
> with discrete components like this that could perhaps provide guidance?
> 
>>> Anyway, despite all the above questions and remarks, this works for
>>> me. Please consider applying.
>>
>> In general this series looks really good, good and clear implementation as
>> well as documentation. A few minor bits here and there, but that is normal.
> 
> Thanks, appreciated!
> 
> Cheers,
> Peter
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

