Return-Path: <SRS0=0nC8=M5=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH v2] staging: iio: ad7816: Switch to the gpio descriptor
 interface
To: Nishad Kamdar <nishadkamdar@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
 outreachy-kernel@googlegroups.com
References: <20181017144716.GA11485@nishad>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5b077abc-e3c2-6183-4341-627d6edf09ee@metafoo.de>
Date: Wed, 17 Oct 2018 16:49:42 +0200
MIME-Version: 1.0
In-Reply-To: <20181017144716.GA11485@nishad>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 10/17/2018 04:47 PM, Nishad Kamdar wrote:
> Use the gpiod interface for rdwr_pin, convert_pin and busy_pin
> instead of the deprecated old non-descriptor interface.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
> Changes in v2:
>  - Correct the error messages as pin number being showed
>    has now been replaced by error code.
> ---
>  drivers/staging/iio/adc/ad7816.c | 80 ++++++++++++++------------------
>  1 file changed, 34 insertions(+), 46 deletions(-)
> 
