Return-Path: <lars@metafoo.de>
Message-ID: <564C5517.6020101@metafoo.de>
Date: Wed, 18 Nov 2015 11:38:15 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Dragos Bogdan <dragos.bogdan@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] staging:iio:ad7780: Switch to the gpio descriptor
 interface
References: <1447842934-5355-1-git-send-email-dragos.bogdan@analog.com>
In-Reply-To: <1447842934-5355-1-git-send-email-dragos.bogdan@analog.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 11/18/2015 11:35 AM, Dragos Bogdan wrote:
> Use the gpiod interface for the powerdown_gpio instead of the deprecated
> old non-descriptor interface.
> 
> The powerdown pin can be tied high, so the gpio is optional.
> Remove the gpio_pdrst platform_data member since the new interface is
> used.
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>

Thanks, good job.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
