Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-we0-f169.google.com ([74.125.82.169]:40827 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779AbbCHUgi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 8 Mar 2015 16:36:38 -0400
Received: by wevk48 with SMTP id k48so26701777wev.7
        for <linux-iio@vger.kernel.org>; Sun, 08 Mar 2015 13:36:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <54FC35A0.6000901@kernel.org>
References: <1424720154-4762-1-git-send-email-roberta.dobrescu@gmail.com>
	<1424720154-4762-3-git-send-email-roberta.dobrescu@gmail.com>
	<54FC35A0.6000901@kernel.org>
Date: Sun, 8 Mar 2015 22:36:37 +0200
Message-ID: <CAEnQRZAqJxgqvORnXBcVyHq0kExyoqq-NvLBw+sxHmku2CdkfQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] iio: Introduce IIO_CHAN_INFO_RANGE
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

On Sun, Mar 8, 2015 at 1:42 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 23/02/15 19:35, Roberta Dobrescu wrote:
>> Some ambient light sensors have hardware dependent ranges and
>> resolutions. In this case user won't be able to calculate illuminance
>> (lux) using only scale attribute.
>>
>> For instance, a device that uses a Full Scale Range is the
>> light sensor ISL29018. In this case, IIO_CHAN_INFO_RANGE is
>> needed since the number of ADC bits can be 4, 8, 12 or 16 and
>> using just scales would result in too similar values for different
>> ranges and resolutions.
> This is always an interesting corner.  The big question is what is
> to be gained by ever running these sensors in their lower resolutions?

I think the big answer here is power consumption.

>
> The reason I've always resisted range is that it's too easy
> for people to be lazy and go with which ever of scale / range
> is presented in the datasheet.  Most of the time they are really
> the same thing.
>
> The exception as you've noted here is in variable resolution devices.
> There is no way that any generic code is ever going to know the right
> option for the combinations of scaling and adc resolution vs time
> requirements.  So we are dealing here with parameters that might
> be hand tweaked for a particular board.
>
> Anyhow, I'd like more opinions on this before I take it.
>
> Lars, Peter, Hartmut - what you guys think on this?

Thanks for your answer Jonathan!

Daniel.
