Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from netconsequence.de ([85.214.40.104]:51683 "EHLO
	mx.netconsequence.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238Ab2JWI5P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 23 Oct 2012 04:57:15 -0400
Subject: Re: i.MX28 die temperature
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Peter Turczak <pt@netconsequence.de>
In-Reply-To: <201206271400.11727.marex@denx.de>
Date: Tue, 23 Oct 2012 10:48:32 +0200
Cc: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Message-Id: <6E339FB7-3B7F-4D90-A472-D375F36755F1@netconsequence.de>
References: <330B740BA662BF4E8386F534DF556ED819731A@AEDCEXC09.aei.com> <201206262102.15698.marek.vasut@gmail.com> <4FEAB48B.4010108@cam.ac.uk> <201206271400.11727.marex@denx.de>
To: Marek Vasut <marex@denx.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Marek,
hi Jonathan,

while trying to implement a battery charger driver for the mx28 platform I came across your posts. Sorry to stir up an old thread but it was running the same way.

On Jun 27, 2012, at 2:00 PM, Marek Vasut wrote:
Dear Jonathan Cameron,
> 
>> On 6/26/2012 8:02 PM, Marek Vasut wrote:
>>> Dear Juergen Beisert,
>>>> I tried a little bit with your driver. The disadvantage I see is, its
>>>> claims all the free AD channels. But a few of them can also act as a
>>>> touchscreen controller. Shouldn't be the driver handle the channel usage
>>>> dynamically?
>>> 
>>> I wonder, I'd rather see this driver behave as a composite driver, what
>>> do you think?
>> 
>> Alternative (though it's still in development) would be to use IIO
>> as the ADC layer and sit the other parts on top.
I am currently trying to go this route, the idea is to use the consumer api to get the required battery management data to the battery driver. As a foundation I used the driver provided by Freescale which uses the lradc directly which I found rather bad in the system context.

Maybe one could map all the driver muxing and use specific parameters in explicitly named iio channels? But this could lead to permanent reconfiguring of the LRADC and maybe quite difficult handling of the measurements that arrive asynchronously.

Also I don't seem to quite get the usage of iio_map_array_register() which seems to enable the consumer api access to the device. I found only one use of it in an example in 
max1363.c which confused me even more. How do I correctly provide the iio_map struct? What is the consumer_dev_name used for and which "namespace" should used there, is it the name used in a platform_driver struct or the instances name (given there can only be one internal mxs battery charger at a time)?

Best regards,
  Peter