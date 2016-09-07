Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41968 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750957AbcIGTGj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Sep 2016 15:06:39 -0400
Subject: Re: [PATCH v1 2/2] iio:buffer: document iio_buffer_poll() return
 value
To: Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org
References: <cover.1473269007.git.gregor.boirie@parrot.com>
 <631831ba76071da263e7579c20a62ea674e9d092.1473269007.git.gregor.boirie@parrot.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <92d62c4b-8d8a-e047-9458-5cdb7f9af31f@kernel.org>
Date: Wed, 7 Sep 2016 20:06:35 +0100
MIME-Version: 1.0
In-Reply-To: <631831ba76071da263e7579c20a62ea674e9d092.1473269007.git.gregor.boirie@parrot.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/09/16 18:26, Gregor Boirie wrote:
> Add documentation for iio_buffer_poll() POLLERR return value.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
I'd roll this into the previous patch.  No need for a separate one to
document the change.

Jonathan
> ---
>  drivers/iio/industrialio-buffer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index b15b3386..aad5159 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -155,6 +155,7 @@ ssize_t iio_buffer_read_first_n_outer(struct file *filp, char __user *buf,
>   *		a wait queue
>   *
>   * Return: (POLLIN | POLLRDNORM) if data is available for reading
> + *	   POLLERR if device was unregistered in our back
>   *	   or 0 for other cases
>   */
>  unsigned int iio_buffer_poll(struct file *filp,
> 

