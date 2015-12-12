Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56999 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbbLLRXt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 12 Dec 2015 12:23:49 -0500
Subject: Re: [PATCH] iio/inkern.c Use list_for_each_entry_safe
To: Anshul Garg <aksgarg1989@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <1449596756-18133-1-git-send-email-aksgarg1989@gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <566C5823.3040209@kernel.org>
Date: Sat, 12 Dec 2015 17:23:47 +0000
MIME-Version: 1.0
In-Reply-To: <1449596756-18133-1-git-send-email-aksgarg1989@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/12/15 17:45, Anshul Garg wrote:
> Use list_for_each_entry_safe instead of list_for_each_safe
> and list_entry call.
> 
> Signed-off-by: Anshul Garg <aksgarg1989@gmail.com>
Applied to the togreg branch of iio.git - initially pushed out
as testing for the autobuilder to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/inkern.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index c8bad3c..f764eb6 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -61,12 +61,10 @@ EXPORT_SYMBOL_GPL(iio_map_array_register);
>  int iio_map_array_unregister(struct iio_dev *indio_dev)
>  {
>  	int ret = -ENODEV;
> -	struct iio_map_internal *mapi;
> -	struct list_head *pos, *tmp;
> +	struct iio_map_internal *mapi, *next;
>  
>  	mutex_lock(&iio_map_list_lock);
> -	list_for_each_safe(pos, tmp, &iio_map_list) {
> -		mapi = list_entry(pos, struct iio_map_internal, l);
> +	list_for_each_entry_safe(mapi, next, &iio_map_list, l) {
>  		if (indio_dev == mapi->indio_dev) {
>  			list_del(&mapi->l);
>  			kfree(mapi);
> 

