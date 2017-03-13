Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36798 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754691AbdCMTxX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 13 Mar 2017 15:53:23 -0400
Date: Mon, 13 Mar 2017 12:53:21 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: simran singhal <singhalsimran0@gmail.com>
Cc: lars@metafoo.de, Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Pete Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH v2] staging: iio: ade7753: replace
 mlock with driver private lock
Message-ID: <20170313195320.GA6705@d830.WORKGROUP>
References: <20170313163107.GA31496@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170313163107.GA31496@singhal-Inspiron-5558>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Mar 13, 2017 at 10:01:07PM +0530, simran singhal wrote:
> The IIO subsystem is redefining iio_dev->mlock to be used by
> the IIO core only for protecting device operating mode changes.
> ie. Changes between INDIO_DIRECT_MODE, INDIO_BUFFER_* modes.
> 
> In this driver, mlock was being used to protect hardware state
> changes.  Replace it with a lock in the devices global data.
> 
> Fix some coding style issues related to white space also.
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
> ---
> 
>  v2:
>    -Removed new lock to reuse the existing lock
Simran,

The good news is that you have 2 patches that have similar
challenges!  I'll suggest picking one, drive it to completion,
then do the other.

This has the nested locking issue that Lars warned about.
Need to refactor to avoid.  Check back on his review comments.

I suggest dropping those whitespace changes - they appear
out of place in this patch since you are no longer actually
touching those lines of code.

alisons


> 
>  drivers/staging/iio/meter/ade7753.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
> index dfd8b71..d88eaa3 100644
> --- a/drivers/staging/iio/meter/ade7753.c
> +++ b/drivers/staging/iio/meter/ade7753.c
> @@ -83,10 +83,10 @@
>   * @buf_lock:       mutex to protect tx and rx
>   **/
>  struct ade7753_state {
> -	    struct spi_device   *us;
> -		    struct mutex        buf_lock;
> -			    u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
> -				    u8          rx[ADE7753_MAX_RX];
> +	struct spi_device   *us;
> +	struct mutex        buf_lock;
> +	u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
> +	u8          rx[ADE7753_MAX_RX];
>  };
>  
>  static int ade7753_spi_write_reg_8(struct device *dev,
> @@ -484,7 +484,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
>  	if (!val)
>  		return -EINVAL;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->buf_lock);
>  
>  	t = 27900 / val;
>  	if (t > 0)
> @@ -505,7 +505,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
>  	ret = ade7753_spi_write_reg_16(dev, ADE7753_MODE, reg);
>  
>  out:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->buf_lock);
>  
>  	return ret ? ret : len;
>  }
> -- 
> 2.7.4
> 
> -- 
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170313163107.GA31496%40singhal-Inspiron-5558.
> For more options, visit https://groups.google.com/d/optout.
