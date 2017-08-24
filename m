Return-Path: <SRS0=TgUD=72=gmail.com=harinath922@kernel.org>
MIME-Version: 1.0
In-Reply-To: <d2c0cc909ca48d674c1432233ef02c57@posteo.de>
References: <1503245215-12150-1-git-send-email-harinath922@gmail.com>
 <b5ba8c62743486649f99625d7a43e42b@posteo.de> <99ef70c3-64f0-66eb-5c1a-45a034ead5d5@gmail.com>
 <d2c0cc909ca48d674c1432233ef02c57@posteo.de>
From: harinath Nampally <harinath922@gmail.com>
Date: Wed, 23 Aug 2017 22:42:19 -0400
Message-ID: <CAAGUq_pYs58a9p8wY3Qb_pOhRLyVm+JTomzVUxh1pzrOD-aGgA@mail.gmail.com>
Subject: Re: [PATCH v4] iio: accel: mma8452: improvements to handle multiple events
To: Martin Kepplinger <martink@posteo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de, lars@metafoo.de,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Greg KH <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alison Schofield <amsfield22@gmail.com>, linux-iio-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> Am 23.08.2017 02:29 schrieb Harinath Nampally:
> If rising: use transient OR ff_mt device-dependent like before. But now save it in a simple flag,
> whether transient registers are available.
> Ok, is it good idea to add the flag to struct mma_chip_info like below?
>   * @mma_scales:                        scale factors for converting
> register values
>   *                             to m/s^2; 3 modes: 2g, 4g, 8g; 2 integers
>   *                             per mode: m/s^2 and micro m/s^2
> + * @transient_supported:       flag indicating whether chip support transient
> + *                             event, as not all chips support transient event
>   */
>  struct mma_chip_info {
>         u8 chip_id;
>         const struct iio_chan_spec *channels;
>         int num_channels;
>         const int mma_scales[3][2];
> +       bool transient_supported;
>  };
>
> I'd avoid boolean and use int and define EVENT_TYPE_TRANSIENT BIT(1) and
> EVENT_TYPE_FF_MT BIT(0) for example. So something like "supported_event_types"
> can have all types supported.

ok sure, I am thinking to adding 'int supported_event_types'(chip
supported events) and 'int enabled_event_types'(events enabled by this
driver for this chip). So in the probe method based on chip specific
'supported_event_types' and 'enabled_event_types' I can configure the
interrupt register accordingly.

> But this has quite some implications on your implementation, so your complete
> solution would be more interesting to see. Keep it simple and focus on only this one
> issue of enabling freefall (FF_MT registers) for the devices that currently use
> transient registers.

The main motivation of this patch was to add new events like tap and
orientation for fxls8471, So I would like to
make code changes such a way that it fixes the issue of enabling
freefall(FF_MT registers) for the devices
that currently use transient registers and also make the driver
flexible enough to add multiple new events.

Thanks,
Hari

On Wed, Aug 23, 2017 at 12:52 AM, Martin Kepplinger <martink@posteo.de> wrote:
> Am 23.08.2017 02:29 schrieb Harinath Nampally:
>>>
>>>
>>> If rising: use transient OR ff_mt device-dependent like before. But now
>>> save it in a simple flag,
>>> whether transient registers are available.
>>
>> Ok, is it good idea to add the flag to struct mma_chip_info like below?
>>
>>   * @mma_scales:                        scale factors for converting
>> register values
>>   *                             to m/s^2; 3 modes: 2g, 4g, 8g; 2 integers
>>   *                             per mode: m/s^2 and micro m/s^2
>> + * @transient_supported:       flag indicating whether chip support
>> transient
>> + *                             event, as not all chips support transient
>> event
>>   */
>>  struct mma_chip_info {
>>         u8 chip_id;
>>         const struct iio_chan_spec *channels;
>>         int num_channels;
>>         const int mma_scales[3][2];
>> +       bool transient_supported;
>>  };
>>
>
> I'd avoid boolean and use int and define EVENT_TYPE_TRANSIENT BIT(1) and
> EVENT_TYPE_FF_MT BIT(0) for example. So something like
> "supported_event_types"
> can have all types supported.
>
> But this has quite some implications on your implementation, so your
> complete
> solution would be more interesting to see. Keep it simple and focus on only
> this one
> issue of enabling freefall (FF_MT registers) for the devices that currently
> use
> transient registers.
>
> thanks
>
>
>>>
>>> If falling: switch to ff_mt in any case. (fixing freefall for the
>>> transient-devices)
>>
>> ok sure.
>>
>> Thanks,
>>
>> Hari
>>
>> On 08/21/2017 04:47 AM, Martin Kepplinger wrote:
>>>
>>>
>>> If rising: use transient OR ff_mt device-dependent like before. But now
>>> save it in a simple flag,
>>> whether transient registers are available.
>>>
>>> If falling: switch to ff_mt in any case. (fixing freefall for the
>>> transient-devices)
>
>
