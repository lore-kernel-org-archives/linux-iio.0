Return-Path: <SRS0=0Pge=ZN=gmail.com=vilhelm.gray@kernel.org>
Date: Tue, 31 Jan 2017 15:03:35 -0500
From: William Breathitt Gray <vilhelm.gray@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linus.walleij@linaro.org, gnurou@gmail.com, linux-gpio@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 5/5] iio: stx104: Add GPIO set_multiple callback function
 support
Message-ID: <20170131200335.GA4355@sophia>
References: <cover.1484838095.git.vilhelm.gray@gmail.com>
 <53039e49d1421a6f070c691988eb22ef0987eba4.1484838095.git.vilhelm.gray@gmail.com>
 <1690f497-7b6a-f82d-b0d9-c395c42e9694@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1690f497-7b6a-f82d-b0d9-c395c42e9694@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Jan 22, 2017 at 01:23:07PM +0000, Jonathan Cameron wrote:
>On 19/01/17 15:06, William Breathitt Gray wrote:
>> The Apex Embedded Systems STX104 series provides a digital output
>> register where 4 lines may be set at a time. This patch add support for
>> the set_multiple callback function, thus allowing multiple digital
>> output lines to be set more efficiently in groups.
>> 
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Hartmut Knaack <knaack.h@gmx.de>
>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>Acked-by: Jonathan Cameron <jic23@kernel.org>

Jonathan Cameron,

Would you pick this patch up in one of your iio.git branches?

Thanks,

William Breathitt Gray
