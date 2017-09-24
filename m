Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752499AbdIXNMt (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Sep 2017 09:12:49 -0400
Date: Sun, 24 Sep 2017 14:12:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Harinath Nampally <harinath922@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, amsfield22@gmail.com,
        martink@posteo.de
Subject: Re: [PATCH 2/2] iio: accel: mma8452: Fix code style warning for
 unsigned int declarations
Message-ID: <20170924141244.5ac2d583@archlinux>
In-Reply-To: <1506200190-11115-3-git-send-email-harinath922@gmail.com>
References: <1506200190-11115-1-git-send-email-harinath922@gmail.com>
        <1506200190-11115-3-git-send-email-harinath922@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 23 Sep 2017 16:56:30 -0400
Harinath Nampally <harinath922@gmail.com> wrote:

> Replace 'unsigned' with 'unsigned int'
> to improve code readability.
> 
> Issue found by checkpatch.
> 
> Signed-off-by: Harinath Nampally <harinath922@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/accel/mma8452.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 4a33a26..6194169 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -1088,8 +1088,8 @@ static irqreturn_t mma8452_trigger_handler(int irq, void *p)
>  }
>  
>  static int mma8452_reg_access_dbg(struct iio_dev *indio_dev,
> -				  unsigned reg, unsigned writeval,
> -				  unsigned *readval)
> +				  unsigned int reg, unsigned int writeval,
> +				  unsigned int *readval)
>  {
>  	int ret;
>  	struct mma8452_data *data = iio_priv(indio_dev);

