Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60332 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752207AbdETQf2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 May 2017 12:35:28 -0400
Subject: Re: [PATCH 3/4] iio: hi8435: make in_voltage_sensing_mode_available
 visible
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Matt Ranostay <mranostay@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff White <Jeff.White@zii.aero>,
        Chris Healy <Chris.Healy@zii.aero>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
References: <20170519144802.14427-1-nikita.yoush@cogentembedded.com>
 <20170519144802.14427-3-nikita.yoush@cogentembedded.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <47c8c1b6-71c4-0cde-ac68-49251b18a376@kernel.org>
Date: Sat, 20 May 2017 17:35:26 +0100
MIME-Version: 1.0
In-Reply-To: <20170519144802.14427-3-nikita.yoush@cogentembedded.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/05/17 15:48, Nikita Yushchenko wrote:
> Possible values of sensing_mode are encoded with strings and actual
> atrings used are not obvious.
strings <fixed>
> 
> Provide a hint by enabling in_voltage_sensing_mode_available attribute.
> 
> Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks,

Jonathan
> ---
>   drivers/iio/adc/hi8435.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
> index 45a92e3e8f2b..d09cb6ff8044 100644
> --- a/drivers/iio/adc/hi8435.c
> +++ b/drivers/iio/adc/hi8435.c
> @@ -356,6 +356,7 @@ static const struct iio_enum hi8435_sensing_mode = {
>   
>   static const struct iio_chan_spec_ext_info hi8435_ext_info[] = {
>   	IIO_ENUM("sensing_mode", IIO_SEPARATE, &hi8435_sensing_mode),
> +	IIO_ENUM_AVAILABLE("sensing_mode", &hi8435_sensing_mode),
>   	{},
>   };
>   
> 

