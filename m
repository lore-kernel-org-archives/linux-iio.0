Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:21842 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750825AbdEIHrC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 May 2017 03:47:02 -0400
Date: Tue, 9 May 2017 10:46:18 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Harinath Nampally <harinath922@gmail.com>
Cc: lars@metafoo.de, devel@driverdev.osuosl.org,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de, jic23@kernel.org
Subject: Re: [PATCH 1/3] staging: iio: meter: Add the comment for mutex
 definition
Message-ID: <20170509074617.x6bdqs7innxhrude@mwanda>
References: <cover.1494293664.git.harinath922@gmail.com>
 <3aa61726d979dbaf85a116341d169a933218904b.1494293664.git.harinath922@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3aa61726d979dbaf85a116341d169a933218904b.1494293664.git.harinath922@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, May 08, 2017 at 10:00:37PM -0400, Harinath Nampally wrote:
> This patch fixes below checkpatch.pl warning:
> CHECK: struct mutex definition without comment
> 
> Signed-off-by: Harinath Nampally <harinath922@gmail.com>
> ---
>  drivers/staging/iio/meter/ade7753.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
> index b71fbd3..cffe6bf 100644
> --- a/drivers/staging/iio/meter/ade7753.c
> +++ b/drivers/staging/iio/meter/ade7753.c
> @@ -78,12 +78,13 @@
>  /**
>   * struct ade7753_state - device instance specific data
>   * @us:         actual spi_device
> + * @buf_lock:       mutex to protect tx and rx
>   * @tx:         transmit buffer
>   * @rx:         receive buffer
> - * @buf_lock:       mutex to protect tx and rx
>   **/
>  struct ade7753_state {
>  	struct spi_device   *us;
> + /* mutex to protect tx and rx */

Not aligned.  We don't need two duplicate comments anyway.

>  	struct mutex        buf_lock;

regards,
dan carpenter

