Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4E368CBB.9000301@analog.com>
Date: Mon, 1 Aug 2011 13:23:39 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>, Drivers <Drivers@analog.com>
Subject: Re: [PATCH] iio: impedance-analyzer: New driver for AD5933/4 Impedance
 Converter, Network Analyzer
References: <1311852772-17988-1-git-send-email-michael.hennerich@analog.com> <4E316C4C.5080008@cam.ac.uk> <4E317DEF.5000104@analog.com> <4E31862D.2060802@cam.ac.uk>
In-Reply-To: <4E31862D.2060802@cam.ac.uk>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 07/28/2011 05:54 PM, Jonathan Cameron wrote:
> On 07/28/11 16:19, Michael Hennerich wrote:
>> On 07/28/2011 04:03 PM, Jonathan Cameron wrote:
>>> On 07/28/11 12:32, michael.hennerich@analog.com wrote:
>>>> From: Michael Hennerich<michael.hennerich@analog.com>
>>>>
>>>> The AD5933 is a high precision impedance converter system solution
>>>> that combines an on-board frequency generator with a 12-bit, 1 MSPS,
>>>> analog-to-digital converter (ADC). The frequency generator allows an
>>>> external complex impedance to be excited with a known frequency.
>>>>
>>>> The response signal from the impedance is sampled by the on-board ADC
>>>> and a discrete Fourier transform (DFT) is processed by an on-chip DSP engine.
>>>> The DFT algorithm returns a real (R) and imaginary (I) data-word at each
>>>> output frequency.
>>>>
>>> Mostly looks good. Couple of nitpicks / queries in line.  I'm particularly
>>> bothered about the SCALE info elements in chan_spec that aren't matched
>>> in the read_raw (or a write_raw if relevant).
>> in0_real_raw and in0_imag_raw only exist as scan elements.
>> They aren't present in indio_dev->channels. I therefore couldn't use
>> scale info elements from channel spec.
> Ah. I hadn't noticed that (obviously).  Why is this the case?  Does it just
> not make sense to read them directly?  If so, set their channel number to -1
> and they won't appear.  Hmm.  Perhaps we need to make that test a little
> more refined to make this work.  iio_device_add_channel_sysfs drops the channel
> immediately if it's number is negative.   Maybe move the magic value into channel2?
>
> That way the only uggliness will come if we have a differential channel that only exists
> for scans.  Or use a negative index (rather than just -1).  That's probably the cleanest
> option, but will require a few abs() insertions in the code and some testing
> to make sure we got them all.
>

Well this works well for channels abs(chan->channel) > 0.
But how about the case where I need no channel sysfs but the scale 
attributes of channel# 0?
Unfortunately there is no -0 :-)

Since the AD5933 is a corner case - I suggest we leave it as is - and I 
add some comments to the source... ?


> Something like:
>
> diff --git a/drivers/staging/iio/industrialio-core.c b/drivers/staging/iio/industrialio-core.c
> index b49db92..aeeb5e6 100644
> --- a/drivers/staging/iio/industrialio-core.c
> +++ b/drivers/staging/iio/industrialio-core.c
> @@ -480,7 +480,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>                          = kasprintf(GFP_KERNEL, "%s_%s%d_%s",
>                                      iio_direction[chan->output],
>                                      iio_chan_type_name_spec_shared[chan->type],
> -                                   chan->channel,
> +                                   (int)abs(chan->channel),
>                                      full_postfix);
>
>          if (name_format == NULL) {
> @@ -489,7 +489,7 @@ int __iio_device_attr_init(struct device_attribute *dev_attr,
>          }
>          dev_attr->attr.name = kasprintf(GFP_KERNEL,
>                                          name_format,
> -                                       chan->channel,
> +                                       (int)abs(chan->channel),
>                                          chan->channel2);
>          if (dev_attr->attr.name == NULL) {
>                  ret = -ENOMEM;
> @@ -585,27 +585,27 @@ static int iio_device_add_channel_sysfs(struct iio_dev *dev_info,
>   {
>          int ret, i;
>
> -       if (chan->channel<  0)
> -               return 0;
> -       if (chan->processed_val)
> -               ret = __iio_add_chan_devattr("input", NULL, chan,
> -&iio_read_channel_info,
> -                                            NULL,
> -                                            0,
> -                                            0,
> -&dev_info->dev,
> -&dev_info->channel_attr_list);
> -       else
> -               ret = __iio_add_chan_devattr("raw", NULL, chan,
> -&iio_read_channel_info,
> -                                            (chan->output ?
> -&iio_write_channel_info : NULL),
> -                                            0,
> -                                            0,
> -&dev_info->dev,
> -&dev_info->channel_attr_list);
> -       if (ret)
> -               goto error_ret;
> +       if (chan->channel>= 0) {
> +               if (chan->processed_val)
> +                       ret = __iio_add_chan_devattr("input", NULL, chan,
> +&iio_read_channel_info,
> +                                                    NULL,
> +                                                    0,
> +                                                    0,
> +&dev_info->dev,
> +&dev_info->channel_attr_list);
> +               else
> +                       ret = __iio_add_chan_devattr("raw", NULL, chan,
> +&iio_read_channel_info,
> +                                                    (chan->output ?
> +&iio_write_channel_info : NULL),
> +                                                    0,
> +                                                    0,
> +&dev_info->dev,
> +&dev_info->channel_attr_list);
> +               if (ret)
> +                       goto error_ret;
> +       }
>
>          for_each_set_bit(i,&chan->info_mask, sizeof(long)*8) {
>                  ret = __iio_add_chan_devattr(iio_chan_info_postfix[i/2],
>
>


-- 
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
