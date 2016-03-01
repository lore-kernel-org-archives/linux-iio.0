Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:59241 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852AbcCAKHZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 1 Mar 2016 05:07:25 -0500
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id 293DA20B5B
	for <linux-iio@vger.kernel.org>; Tue,  1 Mar 2016 11:07:21 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Tue, 01 Mar 2016 11:07:21 +0100
From: Martin Kepplinger <martink@posteo.de>
To: Crt Mori <cmo@melexis.com>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matt Ranostaj <mranostay@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Darshana Padmadas <darshanapadmadas@gmail.com>,
	mfuzzey@parkeon.com, octavian.purdila@intel.com,
	Irina Tirdea <irina.tirdea@intel.com>,
	Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: extending =?UTF-8?Q?/sys/=2E=2E=2E/iio=3AdeviceX/in=5FaccelX?=
 =?UTF-8?Q?=5Fpower=5Fmode?=
In-Reply-To: <CAKv63usA1ptpcgtTrFraYct=7ZkOOk99qiXLcp2DetBfGWwtvg@mail.gmail.com>
References: <56D559F4.3040606@posteo.de>
 <CAEnQRZCx7nFhJfA31mfdTicCppfh-n7usKucQx1dvjPuFNESsA@mail.gmail.com>
 <56D56536.9060301@posteo.de>
 <CAKv63usA1ptpcgtTrFraYct=7ZkOOk99qiXLcp2DetBfGWwtvg@mail.gmail.com>
Message-ID: <c074f1b163a5e1d5fb608457a60279f3@posteo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 01.03.2016 10:53 schrieb Crt Mori:
> On 1 March 2016 at 10:47, Martin Kepplinger <martink@posteo.de> wrote:
>> Am 2016-03-01 um 10:38 schrieb Daniel Baluta:
>>> On Tue, Mar 1, 2016 at 10:59 AM, Martin Kepplinger 
>>> <martink@posteo.de> wrote:
>>>> Would it be ok, if adding in_accelX_power_mode to a driver, to 
>>>> extend it
>>>> so that in_accel_power_mode_available offers:
>>>> 
>>>> low_noise low_power low_power_low_noise normal
>>>> 
>>>> if there's a default "normal" mode, plus options to increase or 
>>>> decrease
>>>> oversampling / power consumption for my device?
>>>> 
>>>> Specifically I'm unsure about "low_power_low_noise" being enough
>>>> user-friendly. The chip I work with just happens to offer these 4 
>>>> modes.
>>>> Would you leave out "low_power_low_noise" and go with
>>>> 
>>>> low_noise low_power normal
>>>> 
>>>> or is it not even desired to add "normal" to the list?
>>>> 
>>>> Although strictly not necessary, I would add any new addition to the
>>>> Documentation as well.
>>> 
>>> The problem with this is that is not uniform across sensors. What
>>> chip are you looking at?
>>> 
>>> For example INV6500 has:
>>> * sleep mode
>>> * standby mode
>>> * etc.
>>> 
>>> Daniel.
>>> 
>> 
>> I suspect these modes are something else. I'm looking at the mma8452
>> driver, and it also has "active" "standby" and "sleep" modes, but I'm
>> talking about different *power* (oversampling) configurations in
>> "active" mode, which is what said sysfs file is about.
>> 
>> But yes, it should be potenially uniform across sensors, which is why 
>> I
>> would probably only add "normal" to the list. At least I can imagine
>> that many devices have an oversampling mode called "normal".
> 
> If that is oversampling option then why don't you just use that as a
> setup? Power mode does not sound like oversampling to me... Maybe you
> should use a sampling_frequency parameter instead?
> 

well, it doesn't affect the sampling frequency. Oversampling is a way 
chips get
more accurate values and use more power. But it's fine. It comes down to
trying patches and see what happens anyways :)

>> 
>> A simple user interface is important so right now I think the best is 
>> to
>> leave it as it is, and not to add complexity and every possible option
>> for the user.
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio" 
>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
