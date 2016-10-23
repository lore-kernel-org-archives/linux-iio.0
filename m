Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60144 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752448AbcJWVZZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 Oct 2016 17:25:25 -0400
Subject: Re: [PATCH 14/28] iio: accel: sca3000_core: avoid potentially
 uninitialized variable
To: Arnd Bergmann <arnd@arndb.de>
References: <20161017220342.1627073-1-arnd@arndb.de>
 <20161017221355.1861551-2-arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Ico Doornekamp <ico@pruts.nl>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ioana Ciornei <ciorneiioana@gmail.com>,
        Luis de Bethencourt <luisbg@osg.samsung.com>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <34705d1a-24d2-e01d-f0b1-086d75a22f8e@kernel.org>
Date: Sun, 23 Oct 2016 22:25:21 +0100
MIME-Version: 1.0
In-Reply-To: <20161017221355.1861551-2-arnd@arndb.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/10/16 23:13, Arnd Bergmann wrote:
> The newly added __sca3000_get_base_freq function handles all valid
> modes of the SCA3000_REG_ADDR_MODE register, but gcc notices
> that any other value (i.e. 0x00) causes the base_freq variable to
> not get initialized:
> 
> drivers/staging/iio/accel/sca3000_core.c: In function 'sca3000_write_raw':
> drivers/staging/iio/accel/sca3000_core.c:527:23: error: 'base_freq' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> 
> This adds explicit error handling for unexpected register values,
> to ensure this cannot happen.
> 
> Fixes: e0f3fc9b47e6 ("iio: accel: sca3000_core: implemented IIO_CHAN_INFO_SAMP_FREQ")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Ico Doornekamp <ico@pruts.nl>
> Cc: Jonathan Cameron <jic23@kernel.org>
> ---
> I submitted this on Sept 22, and Jonathan said he applied it to his
> 'togreg' tree, but it hasn't appeared in linux-next yet, presumably
> since this was not considered material for v4.9.
Yes, it's just gone to Greg near the start of a big pull request for
4.10.
> 
> If we enable the warning again by default, we may want to have the
> fix merged for v4.9 after all.
I have no particular objection to it being merged faster.

Given things have gone horribly wrong if the hardware returns a value
other than those handled, it is more in the category of a nice
tidy up than an true bug fix.  Mind you always nice to handle
possible broken hardware as cleanly as possible.

Still it's risk free and as I'm about to send Greg a pull request for
some fixes, I'll put this in there as well and it'll work it's way
towards mainline.

Jonathan
> 
>  drivers/staging/iio/accel/sca3000_core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index d626125..564b36d 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -468,6 +468,8 @@ static inline int __sca3000_get_base_freq(struct sca3000_state *st,
>  	case SCA3000_MEAS_MODE_OP_2:
>  		*base_freq = info->option_mode_2_freq;
>  		break;
> +	default:
> +		ret = -EINVAL;
>  	}
>  error_ret:
>  	return ret;
> 

