Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44471 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbcC1Jnl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 05:43:41 -0400
Subject: Re: [PATCH] iio: tools: generic_buffer: auto-enable channels
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>
References: <1458812636-20904-1-git-send-email-linus.walleij@linaro.org>
 <CAEnQRZBah4zvvu00Onj-R1Q5DUiY-snz_w1SWR2jV_g5RCv39g@mail.gmail.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F8FCCA.5050601@kernel.org>
Date: Mon, 28 Mar 2016 10:43:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZBah4zvvu00Onj-R1Q5DUiY-snz_w1SWR2jV_g5RCv39g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/03/16 09:56, Daniel Baluta wrote:
> On Thu, Mar 24, 2016 at 11:43 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> If no channels are enabled when we run generic_buffer on a
>> device, well then just enable all of them, run the sampling
>> and disable them all again afterwards.
>>
>> This is extremely useful when I'm low-level testing my
>> sensors with interrupts and triggers, sample session:
>>
>> root@Ux500:/ lsiio
>> Device 000: lsm303dlh_accel
>> Device 001: lis331dl_accel
>> Device 002: l3g4200d
>> Device 003: lsm303dlh_magn
>> Device 004: lps001wp
>> Trigger 000: lsm303dlh_accel-trigger
>> Trigger 001: lis331dl_accel-trigger
>> Trigger 002: l3g4200d-trigger
>>
>> root@Ux500:/ generic_buffer -c 10 -n l3g4200d
>> iio device number being used is 2
>> iio trigger number being used is 2
>> No channels are enabled, enabling all channels
>> Enabling: in_anglvel_x_en
>> Enabling: in_anglvel_y_en
>> Enabling: in_anglvel_z_en
>> Enabling: in_timestamp_en
>> /sys/bus/iio/devices/iio:device2 l3g4200d-trigger
>> -3.593664 -0.713133 4.870143 946684863662292480
>> 3.225546 0.867357 -4.945878 946684863671875000
>> -0.676413 0.127296 0.106641 946684863681488037
>> -0.661113 0.110160 0.128826 946684863690673828
>> -0.664173 0.113067 0.123471 946684863700683593
>> -0.664938 0.109395 0.124848 946684863710144042
>> -0.664173 0.110619 0.130203 946684863719512939
>> -0.666162 0.111231 0.132651 946684863729125976
>> -0.668610 0.111690 0.130662 946684863738739013
>> -0.660501 0.110466 0.131733 946684863748565673
>> Disabling: in_anglvel_x_en
>> Disabling: in_anglvel_y_en
>> Disabling: in_anglvel_z_en
>> Disabling: in_timestamp_en
>>
>> Pure awesomeness. If some channels have been enabled through
>> scripts or manual interaction, nothing happens.
>>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Indeed. This is very useful!
> 
> Acked-by: Daniel Baluta <daniel.baluta@intel.com>
> 
> https://imgflip.com/i/11cof2  :)
It's extremely useful on devices where all the channels can be enabled.
Unfortunately the possible channel sets are not exported and for
quite a lot of devices you cannot configure reading all channels at once.

Look at the more complex available_scan_mask options that exist or
anything with the onehot callback used.

How about doing it on a parameter so -a (if not used - can't remember)
for enable all channels?  Then it won't do weird things unless someone
foolishly enables it on a device where you can't have buffered access
to all channels at once.

Jonathan

> 
> thanks,
> Daniel.
> 

