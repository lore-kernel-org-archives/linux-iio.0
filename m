Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48499 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdCVUZG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Mar 2017 16:25:06 -0400
Subject: Re: [PATCH v3 1/2] staging: iio: ade7753: Remove trailing whitespaces
To: simran singhal <singhalsimran0@gmail.com>, lars@metafoo.de
References: <1490119436-20042-1-git-send-email-singhalsimran0@gmail.com>
 <1490119436-20042-2-git-send-email-singhalsimran0@gmail.com>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e178a4f4-de4e-315c-c1d6-21c190b0db18@kernel.org>
Date: Wed, 22 Mar 2017 20:25:03 +0000
MIME-Version: 1.0
In-Reply-To: <1490119436-20042-2-git-send-email-singhalsimran0@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/03/17 18:03, simran singhal wrote:
> This patch removes trailing whitespaces in order to follow the Linux
> coding style.
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
Applied and pushed out as testing...

Jonathan
> ---
>  drivers/staging/iio/meter/ade7753.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
> index dfd8b71..b71fbd3 100644
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
> 

