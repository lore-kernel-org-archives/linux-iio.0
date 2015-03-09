Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:35215 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbbCII5l (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 04:57:41 -0400
Received: by wesw55 with SMTP id w55so9675501wes.2
        for <linux-iio@vger.kernel.org>; Mon, 09 Mar 2015 01:57:40 -0700 (PDT)
Message-ID: <54FD6081.6000001@gmail.com>
Date: Mon, 09 Mar 2015 10:57:37 +0200
From: Roberta Dobrescu <roberta.dobrescu@gmail.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
CC: daniel.baluta@intel.com, octavian.purdila@intel.com,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH 4/4] staging: iio: light: isl29018: Use standard sysfs
 attributes for range and scale
References: <1424720154-4762-1-git-send-email-roberta.dobrescu@gmail.com> <1424720154-4762-5-git-send-email-roberta.dobrescu@gmail.com> <54FC3786.5000000@kernel.org>
In-Reply-To: <54FC3786.5000000@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08.03.2015 13:50, Jonathan Cameron wrote:
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
>          multiply the output result up and not need to report this to userspace at all
> integration_time - This is the one element that's really being controlled by the adc
>                     resolution. This adc resolution is really effecting our sensitivity
>                     not the accuracy of measurement of the signal.
>
> Hence I'd have your adc resolution controlled by in_illuminance0_integration_time
> and the full scale range controlled by scale.
>
> For the lower adc resolutions simply apply the relevant scaling to get the output
> value to be on the same scale (assuming the range has not changed)
>
> How does that sound?

Sounds good :D.

Thanks for reviewing this.

Roberta
