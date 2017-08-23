Return-Path: <SRS0=LOrj=7Z=posteo.de=martink@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Wed, 23 Aug 2017 06:52:17 +0200
From: Martin Kepplinger <martink@posteo.de>
To: Harinath Nampally <harinath922@gmail.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, amsfield22@gmail.com,
 linux-iio-owner@vger.kernel.org
Subject: Re: [PATCH v4] iio: accel: mma8452: improvements to handle multiple
 events
In-Reply-To: <99ef70c3-64f0-66eb-5c1a-45a034ead5d5@gmail.com>
References: <1503245215-12150-1-git-send-email-harinath922@gmail.com>
 <b5ba8c62743486649f99625d7a43e42b@posteo.de>
 <99ef70c3-64f0-66eb-5c1a-45a034ead5d5@gmail.com>
Message-ID: <d2c0cc909ca48d674c1432233ef02c57@posteo.de>
List-ID: <linux-iio@vger.kernel.org>

Am 23.08.2017 02:29 schrieb Harinath Nampally:
>> 
>> If rising: use transient OR ff_mt device-dependent like before. But 
>> now save it in a simple flag,
>> whether transient registers are available.
> Ok, is it good idea to add the flag to struct mma_chip_info like below?
> 
>   * @mma_scales:                        scale factors for converting
> register values
>   *                             to m/s^2; 3 modes: 2g, 4g, 8g; 2 
> integers
>   *                             per mode: m/s^2 and micro m/s^2
> + * @transient_supported:       flag indicating whether chip support 
> transient
> + *                             event, as not all chips support 
> transient event
>   */
>  struct mma_chip_info {
>         u8 chip_id;
>         const struct iio_chan_spec *channels;
>         int num_channels;
>         const int mma_scales[3][2];
> +       bool transient_supported;
>  };
> 

I'd avoid boolean and use int and define EVENT_TYPE_TRANSIENT BIT(1) and
EVENT_TYPE_FF_MT BIT(0) for example. So something like 
"supported_event_types"
can have all types supported.

But this has quite some implications on your implementation, so your 
complete
solution would be more interesting to see. Keep it simple and focus on 
only this one
issue of enabling freefall (FF_MT registers) for the devices that 
currently use
transient registers.

thanks

>> 
>> If falling: switch to ff_mt in any case. (fixing freefall for the 
>> transient-devices)
> ok sure.
> 
> Thanks,
> 
> Hari
> 
> On 08/21/2017 04:47 AM, Martin Kepplinger wrote:
>> 
>> If rising: use transient OR ff_mt device-dependent like before. But 
>> now save it in a simple flag,
>> whether transient registers are available.
>> 
>> If falling: switch to ff_mt in any case. (fixing freefall for the 
>> transient-devices)
