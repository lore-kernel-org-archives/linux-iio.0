Return-Path: <heiko@sntech.de>
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] iio: adc: rockchip_saradc: add missing MODULE_* data
Date: Sat, 11 Jul 2015 20:59:31 +0200
Message-ID: <79826456.QduC5uXeBP@diego>
In-Reply-To: <55A1533A.2080507@kernel.org>
References: <8215730.uluDfnE1h7@diego> <55A1533A.2080507@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

Am Samstag, 11. Juli 2015, 18:32:42 schrieb Jonathan Cameron:
> On 08/07/15 15:17, Heiko Stuebner wrote:
> > The module-data is currently missing. This includes the
> > license-information
> > which makes the driver taint the kernel and miss symbols when compiled as
> > module.
> > 
> > Fixes: 44d6f2ef94f9 ("iio: adc: add driver for Rockchip saradc")
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> Sorry Heiko,
> 
> Not entirely sure why I haven't picked this up before.
> 
> Anyhow, now applied to the fixes-for-4.2 branch of iio.git
> and marked for stable.  I need to catch up with a bit of a
> backlog, but should get a pull request out to Greg sometime
> early next week.

really no problem. I track my patches and generally simply keep pestering 
people for as long as it takes ;-)

Heiko
