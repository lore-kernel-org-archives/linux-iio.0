Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47666 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbcFZQKb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 12:10:31 -0400
Subject: Re: [PATCH v3] iio: stx104: Add GPIO support for the Apex Embedded
 Systems STX104
To: Linus Walleij <linus.walleij@linaro.org>,
	William Breathitt Gray <vilhelm.gray@gmail.com>
References: <20160613130628.GA28944@sophia>
 <CACRpkdZ__YaP24hC9y17tnsXC5HybzmQmHdpTCUYSNWciKg5zA@mail.gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Alexandre Courbot <gnurou@gmail.com>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ba04432f-f6f5-e7ea-0b68-7a415e9af964@kernel.org>
Date: Sun, 26 Jun 2016 17:10:29 +0100
MIME-Version: 1.0
In-Reply-To: <CACRpkdZ__YaP24hC9y17tnsXC5HybzmQmHdpTCUYSNWciKg5zA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 14/06/16 07:53, Linus Walleij wrote:
> On Mon, Jun 13, 2016 at 3:06 PM, William Breathitt Gray
> <vilhelm.gray@gmail.com> wrote:
> 
>> The Apex Embedded Systems STX104 device features eight lines of digital
>> I/O (four digital inputs and four digital outputs). This patch adds GPIO
>> support for these eight lines of digital I/O via GPIOLIB.
>>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Alexandre Courbot <gnurou@gmail.com>
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>> ---
>> Changes in v3:
>>   - Revert v2 change; any arch should be able to select GPIOLIB
>>   - Return -EINVAL when attempting to set a GPIO to a direction it
>>     cannot be
>>   - Call stx104_gpio_set to have an initial value when setting a GPIO to
>>     output direction
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> 
> Yours,
> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

