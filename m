Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33530 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbbDRT0d (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2015 15:26:33 -0400
Message-ID: <5532AFE6.5080407@kernel.org>
Date: Sat, 18 Apr 2015 20:26:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Thomas.Betker@rohde-schwarz.com
CC: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
	Michal Simek <michal.simek@xilinx.com>,
	=?windows-1252?Q?S=F6ren_Brinkmann?= <soren.brinkmann@xilinx.com>
Subject: Re: [Patch 0/5] iio: adc: xilinx: Fix some minor issues
References: <1429125111-2926-1-git-send-email-thomas.betker@freenet.de> <552ECFF8.2070501@kernel.org> <OF5342D15E.A4BDD05D-ONC1257E29.00294BA0-C1257E29.002B4FCC@rohde-schwarz.com>
In-Reply-To: <OF5342D15E.A4BDD05D-ONC1257E29.00294BA0-C1257E29.002B4FCC@rohde-schwarz.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 16/04/15 08:53, Thomas.Betker@rohde-schwarz.com wrote:
> Hello Jonathan:
> 
>>> About [5]: This may be a matter of debate on the IIO list, but I 
> didn't 
>>> get the impression that extensions are intended to be used that way.
>>>     .extend_name = "vccint" means that the sysfs node names are 
>>> in_voltage0_vccint_raw/_scale, which is a bit unexpected. I would 
>>> rather see them called just in_voltage0_*, and reserve extensions for 
>>> things like in_voltage0_lowest_* and in_voltage0_highest_* 
> (MIN_VCCINT, 
>>> MAX_VCCINT) -- that's what we do in our project.
>>
>> It was always intended for labelling of channels with well defined
>> purposes.  That is ones that are hard wired to something rather than
>> simply exposed for general purpose use.  I'm guessing vccint is
>> the internal supply voltage, in which case that was pretty much
>> the intended use.
>>
>> The datasheet name is only really there for binding consumers to 
> individual
>> channels.  The thought being that you'd probably be sat there with a 
> circuit
>> diagram in front of you specifying what is connected to which precise 
> pin
>> of the ADC...
>>
>> So I think the original approach is more in keeping with the intent.
> 
> Okay, got it. It means that our application needs to remember that it's 
> sometimes voltage%d_%s instead of just voltage%d, but we can do that.
> 
>> The lowest/highest versions are interesting. Right now, the extended 
> name
>> is the only way to specify them, but somehow it feels like we ought
>> to have something better.... We could treat them as a filter or simply
>> another aspect of the channel (like _scale etc), but that's also a 
> little
>> ugly. Will think about this and see if anyone else has a better 
> suggestion!
> 
> With hwmon, we would have inX_input, inX_lowest, inX_highest (in fact, we 
> had, as Xilinx XADC used to be hwmon -- just to explain where I'm coming 
> from). So it made sense to me to use .extended_name = "lowest" to have 
> in_voltageX_lowest_raw/_scale in addition to in_voltageX_raw/_scale (same 
> index X). I understand that I may have read too much into the IIO code 
> here, though, and if there's a better way to do this, I will gladly use 
> it.
Hmm, we could as new info_mask elements (like _raw, _scale etc).
The nasty corner case is that we might also read them as part of a buffer
read.  To do that they will need to be separate 'channels' in their own
right. 

I'm not entirely sure right now if you can distinguish channels purely on
the basis of extended name (and different scan index values), but that
might work, though would be a bit ugly.  There is certainly no fundamental
reason you can't do this..

Hmm. Lars, any thoughts?


> 
> Best regards,
> Thomas Betker
> 

