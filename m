Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta7.messagelabs.com ([216.82.254.108]:29136 "EHLO
	mail1.bemta7.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755441Ab3GVH1P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 22 Jul 2013 03:27:15 -0400
Message-ID: <51ECDEC2.3030706@digi.com>
Date: Mon, 22 Jul 2013 09:26:58 +0200
From: Hector Palacios <hector.palacios@digi.com>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree-discuss@lists.ozlabs.org"
	<devicetree-discuss@lists.ozlabs.org>,
	"marex@denx.de" <marex@denx.de>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"fabio.estevam@freescale.com" <fabio.estevam@freescale.com>
Subject: Re: [PATCH v2 3/5] iio: mxs-lradc: add scale attribute to channels
References: <1374225208-28940-1-git-send-email-hector.palacios@digi.com> <1374225208-28940-4-git-send-email-hector.palacios@digi.com> <51E97201.4010508@free-electrons.com>
In-Reply-To: <51E97201.4010508@free-electrons.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Alexandre,

On 07/19/2013 07:06 PM, Alexandre Belloni wrote:
> Hi Hector,
>
> On 19/07/2013 11:13, Hector Palacios wrote:
>> Some LRADC channels have fixed pre-dividers and all have an optional
>> divider by two which allows a maximum input voltage of VDDIO - 50mV.
>>
>> This patch
>>   - adds the scaling info flag to all channels
>>   - grabs the max reference voltage per channel from DT
>>     (where the fixed pre-dividers apply)
>>   - allows to read the scaling attribute (computed from the Vref)
>>
>> Signed-off-by: Hector Palacios <hector.palacios@digi.com>.
>> ---
>>   drivers/staging/iio/adc/mxs-lradc.c | 81 ++++++++++++++++++++++++-------------
>>   1 file changed, 52 insertions(+), 29 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
>> index 91282dc..99e5790 100644
>> --- a/drivers/staging/iio/adc/mxs-lradc.c
>> +++ b/drivers/staging/iio/adc/mxs-lradc.c
>> @@ -141,6 +141,8 @@ struct mxs_lradc {
>>
>>   	struct completion	completion;
>>
>> +	uint32_t		vref_mv[LRADC_MAX_TOTAL_CHANS];
>> +
>>   	/*
>>   	 * Touchscreen LRADC channels receives a private slot in the CTRL4
>>   	 * register, the slot #7. Therefore only 7 slots instead of 8 in the
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
> You don't need val2 and m in that function, I woud suggest no passing
> those. Also, in my patch, I was passing channel->chan as an int but I
> don't see any drawbacks of passing a pointer to the struct iio_chan_spec.

Ok, I'll remove val2 and m and keep the pointer.

> As a note, I'm waiting for your patch to get included so that we won't
> get any conflicts.

I know, thank you for that.

Best regards,
--
Hector Palacios
