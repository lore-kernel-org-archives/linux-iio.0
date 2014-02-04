Return-Path: <beomho.seo@samsung.com>
To: undisclosed-recipients: ;
Message-id: <52F08031.50703@samsung.com>
Date: Tue, 04 Feb 2014 14:52:49 +0900
From: Beomho Seo <beomho.seo@samsung.com>
MIME-version: 1.0
Cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
 Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 0/2] iio: ak8975: Fix calculation formula and add device
 name
References: <52E88BFC.6080704@samsung.com>
 <alpine.DEB.2.01.1401290949450.17833@pmeerw.net>
In-reply-to: <alpine.DEB.2.01.1401290949450.17833@pmeerw.net>
Content-type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 01/29/2014 05:53 PM, Peter Meerwald wrote:
> Hello,
> 
>>  Three months ago Lars-Peter revised description of device driver[1].
> 
> me, not Lars-Peter
> 

I'm really sorry, my mistake.

>> Correctly, device's sensitivity is 0.3 uT/LSB typ and One micro tesla equal 0.01 gauss[2].
>> So I have fixed calculation formula,And then add RAW_TO_GAUSS macro.
>> Scale are returned as VAL_INT_PLUS_MICRO.
>> Additionally, I have add device name.
> 
> +#define RAW_TO_GAUSS(asa) ((((asa) + 128) * 3000) / 256)
> 
>   *
>   * Since 1uT = 0.01 gauss, our final scale factor becomes:
>   *
> - * Hadj = H * ((ASA + 128) / 256) * 3/10 * 100
> - * Hadj = H * ((ASA + 128) * 30 / 256
> + * Hadj = H * ((ASA + 128) / 256) * 3/10 * 1/100
> + * Hadj = H * ((ASA + 128) * 0.003) / 256
>   *
>   * Since ASA doesn't change, we cache the resultant scale factor into the
>   * device context in ak8975_setup().
>   */
> -       data->raw_to_gauss[0] = ((data->asa[0] + 128) * 30) >> 8;
> +       data->raw_to_gauss[0] = RAW_TO_GAUSS(data->asa[0]);
> 
> thank you for following up on this; I don't have the hardware, so I didn't 
> dare to change the driver...
> 
> the RAW_TO_GAUSS() macro doesn't match the comment Hadj = H * ... anymore
> 
> maybe put this explanation in the patch comment, not the cover letter?
> 

OK. I will resend explanation in the patch comment.

> regards, p.
> 


-- 
Best Regards,

Beomho Seo, Assistant Engineer
System S/W Lab., Software Center, Samsung Electronics
