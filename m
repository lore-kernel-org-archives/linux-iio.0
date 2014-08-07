Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:56915 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932217AbaHGRgf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 Aug 2014 13:36:35 -0400
Received: by mail-wi0-f179.google.com with SMTP id f8so5373501wiw.6
        for <linux-iio@vger.kernel.org>; Thu, 07 Aug 2014 10:36:34 -0700 (PDT)
Message-ID: <53E3B921.6050203@parkeon.com>
Date: Thu, 07 Aug 2014 19:36:33 +0200
From: Martin Fuzzey <mfuzzey@parkeon.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org, pmeerw@pmeerw.net
Subject: Re: [PATCH V2 7/8] iio: mma8452: add an attribute to enable the highpass
 filter
References: <20140729090128.4618.92936.stgit@localhost> <20140729090143.4618.9179.stgit@localhost> <53E3A9A3.8030103@kernel.org>
In-Reply-To: <53E3A9A3.8030103@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/08/14 18:30, Jonathan Cameron wrote:
> On 29/07/14 10:01, Martin Fuzzey wrote:
>> The hardware contains a single configurable highpass filter which
>> is normally used for transient detection (event).
>>
>> However it is also possible to enable this filter for normal channel
>> reading. Add a new attribute in_accel_high_pass_filter_en to do this.
>>
>> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> The obvious answer to this would be to set the cuttoff to 0.
> Presumably the complexity here is there  is only one high pass filter
> implementation, both for the data and for the event?
Yes exactly

> If so I would probably still prefer it was done via the 3db point
> setting, just that you have two attributes to access that - one for
> the channel and one for the event.  Setting the channel version to
> non zero would change both.  Setting the event one to any value
> would change both only if the channel version is not zero.
But I don't think that would handle the use case of
* No filter for channel data
* Filter for event

The hardware has
1) A register to set the filter frequency (one of 4 possible values, 
with the allowed set depending on the current sampling frequency)
2) A bit to enable the filter for value readings  (default disabled)
3) A bit to disable the filter for transient detection (default enabled)

My current patchset does not support 3) - the filter is always enabled 
for transient events

> It's a little fiddly, perhaps having an enable on a filter is
> the way to go... Anyone else have any thought on this?
>

