Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58412 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbcGXKJn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 06:09:43 -0400
Subject: Re: [PATCH] staging: iio: ad5933: Return correct value for
 AD5933_OUT_RANGE.
To: Phil Turnbull <phil.turnbull@oracle.com>
References: <20160721152313.16832-1-phil.turnbull@oracle.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	"open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
	open list <linux-kernel@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f10316f9-4225-e8e1-1cd5-25ad35421523@kernel.org>
Date: Sun, 24 Jul 2016 11:09:39 +0100
MIME-Version: 1.0
In-Reply-To: <20160721152313.16832-1-phil.turnbull@oracle.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/07/16 16:23, Phil Turnbull wrote:
> The 'break' statement after calling ad5933_cmd only breaks out of the
> 'for' loop, which then unconditionally sets the return value to -EINVAL.
> Move the initialisation of 'ret' so we return the correct value.
> 
> Signed-off-by: Phil Turnbull <phil.turnbull@oracle.com>
As I have nothing in the fixes-togreg branch, I've applied this to
the fixes-togreg-post-rc1 as that's the next one that will go upstream.
I don't tend to send Greg fixes during the merge window as he is
rather busy and won't pick them up until after anyways!

This may be delayed by a few weeks though as I'm travelling.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 9f43976..34a6990 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -419,6 +419,7 @@ static ssize_t ad5933_store(struct device *dev,
>  	mutex_lock(&indio_dev->mlock);
>  	switch ((u32)this_attr->address) {
>  	case AD5933_OUT_RANGE:
> +		ret = -EINVAL;
>  		for (i = 0; i < 4; i++)
>  			if (val == st->range_avail[i]) {
>  				st->ctrl_hb &= ~AD5933_CTRL_RANGE(0x3);
> @@ -426,7 +427,6 @@ static ssize_t ad5933_store(struct device *dev,
>  				ret = ad5933_cmd(st, 0);
>  				break;
>  			}
> -		ret = -EINVAL;
>  		break;
>  	case AD5933_IN_PGA_GAIN:
>  		if (sysfs_streq(buf, "1")) {
> 

