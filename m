Return-Path: <Hector.Palacios@digi.com>
Message-ID: <51E95EF1.4040503@digi.com>
Date: Fri, 19 Jul 2013 17:44:49 +0200
From: Hector Palacios <hector.palacios@digi.com>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>,
	"alexandre.belloni@free-electrons.com"
	<alexandre.belloni@free-electrons.com>, "jic23@kernel.org"
	<jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Re: [PATCH v2 3/5] iio: mxs-lradc: add scale attribute to channels
References: <1374225208-28940-1-git-send-email-hector.palacios@digi.com> <1374225208-28940-4-git-send-email-hector.palacios@digi.com> <201307191630.17149.marex@denx.de>
In-Reply-To: <201307191630.17149.marex@denx.de>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Dear Marek,

On 07/19/2013 04:30 PM, Marek Vasut wrote:
>> @@ -228,39 +230,12 @@ struct mxs_lradc {
>>   #define LRADC_RESOLUTION			12
>>   #define LRADC_SINGLE_SAMPLE_MASK		((1 << LRADC_RESOLUTION) - 1)
>>
>> -/*
>> - * Raw I/O operations
>> - */
>> -static int mxs_lradc_read_raw(struct iio_dev *iio_dev,
>> +static int mxs_lradc_read_single(struct iio_dev *iio_dev,
>>   			const struct iio_chan_spec *chan,
>>   			int *val, int *val2, long m)
>>   {
>>   	struct mxs_lradc *lradc = iio_priv(iio_dev);
>>   	int ret;
>> -	unsigned long mask;
>> -
>> -	if (m != IIO_CHAN_INFO_RAW)
>> -		return -EINVAL;
>> -
>> -	/* Check for invalid channel */
>> -	if (chan->channel > LRADC_MAX_TOTAL_CHANS)
>> -		return -EINVAL;
>
> This was already resolved, so this patch won't apply I'm afraid.

You mean the 'unsigned long mask', right?  Yeah, I think I had resolved that one 
before submitting, but looks like I didn't.
The other check is not resolved afaik. We agreed to remove it, but on a different patch.

> Otherwise:
>
> Acked-by: Marek Vasut <marex@denx.de>
>
>
> Marek Vasut
>


Best regards,
--
Hector Palacios
