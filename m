Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38286 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752749AbbHaQYX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2015 12:24:23 -0400
Subject: Re: Adding MAX1363 to BBB
To: Greg Wilson-Lindberg <GWilson@sakuraus.com>,
	Michael Welling <mwelling@ieee.org>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4699@sfamail.SAKURAUS.LOCAL>
 <20150824165433.GA3398@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD498E@sfamail.SAKURAUS.LOCAL>
 <20150827191616.GA8285@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD49A5@sfamail.SAKURAUS.LOCAL>
 <20150827204225.GA3789@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD49AB@sfamail.SAKURAUS.LOCAL>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD49B7@sfamail.SAKURAUS.LOCAL>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4A61@sfamail.SAKURAUS.LOCAL>
 <20150829003143.GA21865@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4AB2@sfamail.SAKURAUS.LOCAL>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55E47FB5.7030401@kernel.org>
Date: Mon, 31 Aug 2015 17:24:21 +0100
MIME-Version: 1.0
In-Reply-To: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4AB2@sfamail.SAKURAUS.LOCAL>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/08/15 17:01, Greg Wilson-Lindberg wrote:
>  
> 
>> -----Original Message-----
>> From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf 
>> Of Michael Welling
>> Sent: Friday, August 28, 2015 5:32 PM
>> To: Greg Wilson-Lindberg
>> Cc: linux-iio@vger.kernel.org
>> Subject: Re: Adding MAX1363 to BBB
>>
>> On Fri, Aug 28, 2015 at 04:56:20PM -0700, Greg Wilson-Lindberg wrote:
>>>
>>> I've got the system running, but I get an invalid argument 
>> error on the call to iio_buffer_refill().  I'm basically 
>> using the same code as for the tsadc, just added in a fourth 
>> channel, and none of the setup calls are returning errors, 
>> but the first iio_buffer_refill() call returns an error.  
>> I've dumped out the parameter that is being passed to the 
>> iio_buffer_refill() call and it is the same as the value that 
>> was returned from the iio_device_create_buffer() call.
>>>
>>> I've looked at the libiio source and I don't see anything 
>> obvious that should return invalid argument for the 
>> iio_buffer_refill() call.
>>>
>>
>> I believe that you need to register an interrupt for buffered 
>> access to work.
>>
>> Do you have an interrupt connected and registered?
>>
> 
> Nope, no interrupt.  So I guess I would need to ask, how would I register the interrupt in the Device Tree?
The max1363 (and similar) don't have a dataready interrupt as they
are clocked of the actual clock cycles of the i2c transfers.  So
they only read on demand.

> 
> Or, alternatively, can I just get individual readings through IIO?
Either via sysfs, or by adding a sysfs trigger and poking that.
To add a sysfs trigger you'll need to probe the module, then poke
a number into the add_trigger attribute to create a trigger which can
then be associated with the max1363 (as normal).

Then to 'fire' the trigger write to the trigger_now attribute of the
relevant trigger.

Ideally Daniel will be back soonish with a final version of the
high resolution timer trigger that would also work well here.
(it's rather tied up with some configfs support which wis
trickier!).

Jonathan
>  --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

