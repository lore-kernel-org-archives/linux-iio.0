Return-Path: <lars@metafoo.de>
Message-ID: <4FD5D83E.3040504@metafoo.de>
Date: Mon, 11 Jun 2012 13:36:30 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
CC: michael.hennerich@analog.com,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "jic23@kernel.org" <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "device-drivers-devel@blackfin.uclinux.org" <device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] iio: ad9523: Fix argument type mismatch
References: <1339401064-5218-1-git-send-email-michael.hennerich@analog.com> <CAM=Q2ctNYnq9S9fr4K6sh+k3311nMON8Yho+-vAdd3dSdOXRHg@mail.gmail.com> <4FD5B743.7070500@analog.com> <CAM=Q2csVnSs_gicDyMdKZYPNf6qC8FYD1sOcBBJ+5tSEScpu8Q@mail.gmail.com>
In-Reply-To: <CAM=Q2csVnSs_gicDyMdKZYPNf6qC8FYD1sOcBBJ+5tSEScpu8Q@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/11/2012 01:17 PM, Shubhrajyoti Datta wrote:
> Hi Michael,
> 
> On Mon, Jun 11, 2012 at 2:45 PM, Michael Hennerich
> <michael.hennerich@analog.com> wrote:
> [..]
>>>>  static int ad9523_vco_out_map(struct iio_dev *indio_dev,
>>>> -                             unsigned ch, bool out)
>>>> +                             unsigned ch, unsigned out)
>>>
>>> Unsigned defaults to unsigned int right shouldnt it be a char?
>>> Or am I missing something.
>>>
>> Hi Shubhrajyoti,
>>
>> can you explain why this matters?
>> If you take a closer look at the disassembly -
>> you will notice that 'unsigned int' will generate nicer code.
>>
> 
> What I was thinking is that
> 
> 
> +       }
> +
> +       st->vco_out_map[ch] = out;
> +
> +       return ret;
> +}
> Here
> 
> and
> +struct ad9523_state {
> +       struct spi_device               *spi;
> +       struct regulator                *reg;
> +       struct ad9523_platform_data     *pdata;
> +       struct iio_chan_spec            ad9523_channels[AD9523_NUM_CHAN];
> +
> +       unsigned long           vcxo_freq;
> +       unsigned long           vco_freq;
> +       unsigned long           vco_out_freq[AD9523_NUM_CLK_SRC];
> +       unsigned char           vco_out_map[AD9523_NUM_CHAN_ALT_CLK_SRC];
> 
> So that may not work well with all the endianness etc,

The code is fine as it is, the assignment does an implicit type cast.
