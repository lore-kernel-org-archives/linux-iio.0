Return-Path: <SRS0=Wx2m=2V=gmail.com=amsfield22@kernel.org>
Date: Sun, 12 Mar 2017 11:33:05 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: simran singhal <singhalsimran0@gmail.com>
Cc: lars@metafoo.de, Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Pete Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: ade7753: replace mlock
 with driver private lock
Message-ID: <20170312183304.GB7728@d830.WORKGROUP>
References: <20170312133250.GA7772@singhal-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170312133250.GA7772@singhal-Inspiron-5558>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Mar 12, 2017 at 07:02:50PM +0530, simran singhal wrote:
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

Hi Simran, This looks good to me.  Let's see what the
reviewers say.  I think the white space stuff is ok,
since it was right where you were editing. 
alisons

> ---
>  drivers/staging/iio/meter/ade7753.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
> index dfd8b71..ca99d82 100644
> --- a/drivers/staging/iio/meter/ade7753.c
> +++ b/drivers/staging/iio/meter/ade7753.c
> @@ -81,12 +81,14 @@
>   * @tx:         transmit buffer
>   * @rx:         receive buffer
>   * @buf_lock:       mutex to protect tx and rx
> + * @lock:	protect sensor state
>   **/
>  struct ade7753_state {
> -	    struct spi_device   *us;
> -		    struct mutex        buf_lock;
> -			    u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
> -				    u8          rx[ADE7753_MAX_RX];
> +	struct spi_device   *us;
> +	struct mutex        buf_lock;
> +	struct mutex        lock;	/* protect sensor state */
> +	u8          tx[ADE7753_MAX_TX] ____cacheline_aligned;
> +	u8          rx[ADE7753_MAX_RX];
>  };
>  
>  static int ade7753_spi_write_reg_8(struct device *dev,
> @@ -484,7 +486,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
>  	if (!val)
>  		return -EINVAL;
>  
> -	mutex_lock(&indio_dev->mlock);
> +	mutex_lock(&st->lock);
>  
>  	t = 27900 / val;
>  	if (t > 0)
> @@ -505,7 +507,7 @@ static ssize_t ade7753_write_frequency(struct device *dev,
>  	ret = ade7753_spi_write_reg_16(dev, ADE7753_MODE, reg);
>  
>  out:
> -	mutex_unlock(&indio_dev->mlock);
> +	mutex_unlock(&st->lock);
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
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20170312133250.GA7772%40singhal-Inspiron-5558.
> For more options, visit https://groups.google.com/d/optout.
