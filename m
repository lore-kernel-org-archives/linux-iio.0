Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35196 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077AbbCHUoT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2015 16:44:19 -0400
Received: by wibbs8 with SMTP id bs8so15423573wib.0
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2015 13:44:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <54FC3786.5000000@kernel.org>
References: <1424720154-4762-1-git-send-email-roberta.dobrescu@gmail.com>
	<1424720154-4762-5-git-send-email-roberta.dobrescu@gmail.com>
	<54FC3786.5000000@kernel.org>
Date: Sun, 8 Mar 2015 22:44:18 +0200
Message-ID: <CAEnQRZCZqzencBh8TE0GcFx9Gsqffqad_KQ5CU8dKhC0Us6ybQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] staging: iio: light: isl29018: Use standard sysfs
 attributes for range and scale
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Daniel Baluta <daniel.baluta@intel.com>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Mar 8, 2015 at 1:50 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 23/02/15 19:35, Roberta Dobrescu wrote:
>> This patch refactors the isl29018 driver code in order to use standard
>> sysfs attributes for range and scale.
>>
>> ISL29018 light sensor uses four ranges and four ADC's resolutions
>> which influence the calculated lux.
>>
>> This patch eliminates the resolution (adc bits) and introduces scale.
>> Each range (1k, 4k, 16k or 64k) has a corresponding set of 4 scales
>> (for 16, 12, 8 or 4 bits). Both range and scale can be changed by the
>> user according to the corresponding set of values (exposed by the attributes
>> in_illuminance_range_available and in_illuminance_scale_available).
>>
>> When the range is changed, the set of available scales is set accordingly and
>> by default the scale used is the one for 16 adc bits. Scale can be changed
>> anytime with one of the available values.
> So we have 3 things interacting here.
>
> range - absolutely controlled for the device
> scale - from current range, with the adc resolution confusing things - we could just
>         multiply the output result up and not need to report this to userspace at all
> integration_time - This is the one element that's really being controlled by the adc
>                    resolution. This adc resolution is really effecting our sensitivity
>                    not the accuracy of measurement of the signal.
>
> Hence I'd have your adc resolution controlled by in_illuminance0_integration_time
> and the full scale range controlled by scale.
>
> For the lower adc resolutions simply apply the relevant scaling to get the output
> value to be on the same scale (assuming the range has not changed)
>
> How does that sound?

Sounds good to me. I think it's the cleanest solution, and we also avoid
releasing IIO_CHAN_INFO_RANGE kraken to user space :).

thanks,
daniel.
