Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:54663 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045Ab1BVMev (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 22 Feb 2011 07:34:51 -0500
Message-ID: <4D63AD81.5080903@cam.ac.uk>
Date: Tue, 22 Feb 2011 12:35:13 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: Andrew Chew <AChew@nvidia.com>, chinyeow.sim.xt@renesas.com,
	gregkh@suse.de, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH] staging: ak8975: add platform data.
References: <1297764627-21077-1-git-send-email-chinyeow.sim.xt@renesas.com>	<643E69AA4436674C8F39DCC2C05F763816BD96CFB5@HQMAIL03.nvidia.com>	<4D628E66.5090900@cam.ac.uk> <20110222102955.52be2b94@endymion.delvare>
In-Reply-To: <20110222102955.52be2b94@endymion.delvare>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/22/11 09:29, Jean Delvare wrote:
> Hi Jonathan,
> 
> On Mon, 21 Feb 2011 16:10:14 +0000, Jonathan Cameron wrote:
>> On 02/15/11 20:49, Andrew Chew wrote:
>>>> As some of the platform not support irq_to_gpio, we pass gpio port
>>>> by platform data.
>>>
>>> Looks good to me.
>>>
>>> Signed-off-by: Andrew Chew <achew@nvidia.com>
>> Firstly, please cc linux-iio for patches effecting iio drivers.
>>
>> Hmm.. It's a bit of a pain that i2c devices don't take platform resources
>> or we could avoid doing this entirely. I have a vague recollection of this
>> being suggested in the past, but never happening (might have been for spi
>> rather than i2c though...) Jean, can you comment on this?
> 
> I fear I don't have the slightest idea of what you're talking about.
> "Taking platform resources"?
Sorry, I should have written a proper description of what I meant.

Add to i2c_board_info the following
struct resource *resource;

which is defined in ioport.h

I thought this actually allowed for gpio's but right now can't figure out how
to handle them.  What it definitely does handle cleanly is devices with multiple
irq's.

You basically get to query for resources by name so can pass lots of 'platform data'
type stuff without having to define a specific structure for passing it in.

> 
>> Dmitry isn't going to want that header in the linux/input directory.
> 
> And he would be right. Header files containing platform data structures
> for i2c device drivers go to include/linux/i2c.
Cool. I'd kind of assumed they moved out when i2c/chips went away, but never
actually checked!
> 

