Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:60013 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbaFBRsu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Jun 2014 13:48:50 -0400
Message-ID: <538CB96D.2060201@kernel.org>
Date: Mon, 02 Jun 2014 18:50:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jon Brenner <Jon.Brenner@ams.com>,
	Mario Schuknecht <mario.schuknecht@dresearch-fe.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] staging: iio: tsl2x7x_core: fix proximity threshold
References: <9A1AC870E7D6284DB056414587DDA8F701BF67BB@SUX2182.office.amsiag.com>
In-Reply-To: <9A1AC870E7D6284DB056414587DDA8F701BF67BB@SUX2182.office.amsiag.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/06/14 17:08, Jon Brenner wrote:
> Hello Jonathan,
> Looks fine  (these changes should have already been in there as they reflect exactly what I have in my most recent source) - but I'll figure that out later.
Cool - formal acks or even better reviewed-by tags
always welcome.  Anyhow I've applied it now so too late
for this one ;)


>
>
> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]
> Sent: Saturday, May 31, 2014 5:25 AM
> To: Mario Schuknecht; linux-iio@vger.kernel.org; Jon Brenner
> Subject: Re: [PATCH] staging: iio: tsl2x7x_core: fix proximity treshold
>
> On 27/05/14 07:19, Mario Schuknecht wrote:
>> Consider high byte of proximity min and max treshold in function
>> 'tsl2x7x_chip_on'. So far, the high byte was not set.
>>
>> Signed-off-by: Mario Schuknecht <mario.schuknecht@dresearch-fe.de>
> Looks right to me.
>
> Jon, it's your driver so do you have a few mins to check this?  Given timing this won't go in until the merge window has closed now anyway so you have a few weeks.  Looks like stable material though so I'll mark it as such when I apply it.
>
>
>> ---
>>    drivers/staging/iio/light/tsl2x7x_core.c | 8 ++++++--
>>    1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/staging/iio/light/tsl2x7x_core.c
>> b/drivers/staging/iio/light/tsl2x7x_core.c
>> index 9e0f2a9..ab338e3 100644
>> --- a/drivers/staging/iio/light/tsl2x7x_core.c
>> +++ b/drivers/staging/iio/light/tsl2x7x_core.c
>> @@ -667,9 +667,13 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>>    	chip->tsl2x7x_config[TSL2X7X_PRX_COUNT] =
>>    			chip->tsl2x7x_settings.prox_pulse_count;
>>    	chip->tsl2x7x_config[TSL2X7X_PRX_MINTHRESHLO] =
>> -	chip->tsl2x7x_settings.prox_thres_low;
>> +			(chip->tsl2x7x_settings.prox_thres_low) & 0xFF;
>> +	chip->tsl2x7x_config[TSL2X7X_PRX_MINTHRESHHI] =
>> +			(chip->tsl2x7x_settings.prox_thres_low >> 8) & 0xFF;
>>    	chip->tsl2x7x_config[TSL2X7X_PRX_MAXTHRESHLO] =
>> -			chip->tsl2x7x_settings.prox_thres_high;
>> +			(chip->tsl2x7x_settings.prox_thres_high) & 0xFF;
>> +	chip->tsl2x7x_config[TSL2X7X_PRX_MAXTHRESHHI] =
>> +			(chip->tsl2x7x_settings.prox_thres_high >> 8) & 0xFF;
>>
>>    	/* and make sure we're not already on */
>>    	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

