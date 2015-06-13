Return-Path: <heiko@sntech.de>
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: rockchip_saradc: add missing MODULE_* data
Date: Sat, 13 Jun 2015 12:13:04 +0200
Message-ID: <1551389.A2qkCOk6hp@diego>
In-Reply-To: <4303804.647s4ZjWfi@phil>
References: <4303804.647s4ZjWfi@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

Am Montag, 25. Mai 2015, 22:36:58 schrieb Heiko Stuebner:
> The module-data is currently missing. This includes the license-information
> which makes the driver taint the kernel and miss symbols when compiled as
> module.
> 
> Fixes: 44d6f2ef94f9 ("iio: adc: add driver for Rockchip saradc")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---

ping on this patch?


Heiko
