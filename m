Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout01.posteo.de ([185.67.36.65]:35640 "EHLO mout01.posteo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752094AbcCAJtD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 1 Mar 2016 04:49:03 -0500
Received: from dovecot03.posteo.de (dovecot03.posteo.de [172.16.0.13])
	by mout01.posteo.de (Postfix) with ESMTPS id AC8A320B9A
	for <linux-iio@vger.kernel.org>; Tue,  1 Mar 2016 10:49:00 +0100 (CET)
Subject: Re: extending /sys/.../iio:deviceX/in_accelX_power_mode
To: Daniel Baluta <daniel.baluta@intel.com>
References: <56D559F4.3040606@posteo.de>
 <CAEnQRZCx7nFhJfA31mfdTicCppfh-n7usKucQx1dvjPuFNESsA@mail.gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Matt Ranostaj <mranostay@gmail.com>,
	Haneen Mohammed <hamohammed.sa@gmail.com>,
	Darshana Padmadas <darshanapadmadas@gmail.com>,
	mfuzzey@parkeon.com,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>,
	Cristina Georgiana Opriceana <cristina.opriceana@gmail.com>,
	Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Martin Kepplinger <martink@posteo.de>
Message-ID: <56D56536.9060301@posteo.de>
Date: Tue, 1 Mar 2016 10:47:34 +0100
MIME-Version: 1.0
In-Reply-To: <CAEnQRZCx7nFhJfA31mfdTicCppfh-n7usKucQx1dvjPuFNESsA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 2016-03-01 um 10:38 schrieb Daniel Baluta:
> On Tue, Mar 1, 2016 at 10:59 AM, Martin Kepplinger <martink@posteo.de> wrote:
>> Would it be ok, if adding in_accelX_power_mode to a driver, to extend it
>> so that in_accel_power_mode_available offers:
>>
>> low_noise low_power low_power_low_noise normal
>>
>> if there's a default "normal" mode, plus options to increase or decrease
>> oversampling / power consumption for my device?
>>
>> Specifically I'm unsure about "low_power_low_noise" being enough
>> user-friendly. The chip I work with just happens to offer these 4 modes.
>> Would you leave out "low_power_low_noise" and go with
>>
>> low_noise low_power normal
>>
>> or is it not even desired to add "normal" to the list?
>>
>> Although strictly not necessary, I would add any new addition to the
>> Documentation as well.
> 
> The problem with this is that is not uniform across sensors. What
> chip are you looking at?
> 
> For example INV6500 has:
> * sleep mode
> * standby mode
> * etc.
> 
> Daniel.
> 

I suspect these modes are something else. I'm looking at the mma8452
driver, and it also has "active" "standby" and "sleep" modes, but I'm
talking about different *power* (oversampling) configurations in
"active" mode, which is what said sysfs file is about.

But yes, it should be potenially uniform across sensors, which is why I
would probably only add "normal" to the list. At least I can imagine
that many devices have an oversampling mode called "normal".

A simple user interface is important so right now I think the best is to
leave it as it is, and not to add complexity and every possible option
for the user.
