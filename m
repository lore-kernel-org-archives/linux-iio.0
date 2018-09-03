Return-Path: <SRS0=5HKA=LR=linaro.org=baolin.wang@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180902095140.70b6fd5e@archlinux>
References: <0adef2f9eafa913eb9f4bc1ed3dc643d09bf02a2.1535434262.git.baolin.wang@linaro.org>
 <20180902095140.70b6fd5e@archlinux>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Mon, 3 Sep 2018 10:20:14 +0800
Message-ID: <CAMz4kuJYWkuQk9et-odco49r2AMeMpyqAPcYDsq72L4Ko41VuQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: adc: sc27xx: Add raw data support
To: Jonathan Cameron <jic23@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, freeman.liu@spreadtrum.com,
	Mark Brown <broonie@kernel.org>, DTML <devicetree@vger.kernel.org>,
	linux-iio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On 2 September 2018 at 16:51, Jonathan Cameron <jic23@kernel.org> wrote:
> On Wed, 29 Aug 2018 14:04:04 +0800
> Baolin Wang <baolin.wang@linaro.org> wrote:
>
>> The headset device will use channel 20 of ADC controller to detect events,
>> but it needs the raw ADC data to do conversion according to its own formula.
>>
>> Thus we should configure the channel mask separately and configure channel
>> 20 as IIO_CHAN_INFO_RAW, as well as adding raw data read support.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> I'm still a little unclear on whether there is fundamentally something different
> about this channel or whether this is just a policy decision for particular
> (possibly all) board.  For now we'll go with this change, but if anyone screams
> we will have to then go the nasty route of supporting both processed and raw
> for channel 20.

Until now, channel 20 is always used for the headset on the SC27xx
series PMICs. Yes, this is a policy decision, but for all the SC27xx
series PMICs.

>
> Applied to the togreg branch of iio.git and pushed out as testing for the
> autobuilders to play with it.

Thanks.

-- 
Baolin Wang
Best Regards
