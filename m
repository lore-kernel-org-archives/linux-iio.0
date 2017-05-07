Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57535 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754400AbdEGWGG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 18:06:06 -0400
Subject: Re: [PATCH 2/2] [PATCH 2/2] iio: adc: sun4i-gpadc-iio: Fix module
 autoload when OF devices are registered
To: Chen-Yu Tsai <wens@csie.org>,
        Eduardo Molinas <edu.molinas@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, knaack.h@gmx.de,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20170501224559.21028-1-edu.molinas@gmail.com>
 <20170501224559.21028-2-edu.molinas@gmail.com>
 <CAGb2v66_F4yHzQaOtO+-yH7d36kx_ahDCTyXkpTKkzGxQ-bYeA@mail.gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ce97e18f-aeb6-79c3-1fa3-048674769361@kernel.org>
Date: Sun, 7 May 2017 14:46:28 +0100
MIME-Version: 1.0
In-Reply-To: <CAGb2v66_F4yHzQaOtO+-yH7d36kx_ahDCTyXkpTKkzGxQ-bYeA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/05/17 03:09, Chen-Yu Tsai wrote:
> On Tue, May 2, 2017 at 6:45 AM, Eduardo Molinas <edu.molinas@gmail.com> wrote:
>> If the driver is built as a module, it won't be autloaded if the devices
>> are registered via OF code because the OF device table
>> entries are not exported as aliases
>>
>> Before the patch:
>> $ modinfo drivers/iio/adc/sun4i-gpadc-iio.ko | grep alias
>> alias:          platform:sun6i-a31-gpadc-iio
>> alias:          platform:sun5i-a13-gpadc-iio
>> alias:          platform:sun4i-a10-gpadc-iio
>>
>> After the patch:
>> $ modinfo drivers/iio/adc/sun4i-gpadc-iio.ko | grep alias
>> alias:          of:N*T*Callwinner,sun8i-a33-thsC*
>> alias:          of:N*T*Callwinner,sun8i-a33-ths
>> alias:          platform:sun6i-a31-gpadc-iio
>> alias:          platform:sun5i-a13-gpadc-iio
>> alias:          platform:sun4i-a10-gpadc-iio
>>
>> Signed-off-by: Eduardo Molinas <edu.molinas@gmail.com>
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> 
> Can we merge this as a fix for 4.12?
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

