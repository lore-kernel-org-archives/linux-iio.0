Return-Path: <lars@metafoo.de>
Message-ID: <564DBB91.4010400@metafoo.de>
Date: Thu, 19 Nov 2015 13:07:45 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Dragos Bogdan <dragos.bogdan@analog.com>,
 Jonathan Cameron <jic23@kernel.org>
CC: Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] staging:iio:ad7780: Remove the ad7780_platform_data
References: <1447856194-26450-1-git-send-email-dragos.bogdan@analog.com>
In-Reply-To: <1447856194-26450-1-git-send-email-dragos.bogdan@analog.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 11/18/2015 03:16 PM, Dragos Bogdan wrote:
> The ad7780_platform_data contains just the reference voltage information.
> Since the preferred way of specifying this information is using the Linux
> regulator framework and the ad7780 platform_data is not used by other
> users, it can be completely removed.
> 
> Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>

Looks good, thanks.


Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Just one thing to consider for future patches...

[...]
> -		dev_warn(&spi->dev, "reference voltage unspecified\n");
> +		dev_warn(&spi->dev, "Reference voltage unspecified\n");

Strictly speaking this is a unrelated change and ideally would have been
split into a separate patch.
