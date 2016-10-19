Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1050.oracle.com ([156.151.31.82]:51979 "EHLO
        userp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941907AbcJSOtc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2016 10:49:32 -0400
Date: Wed, 19 Oct 2016 14:33:46 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Brian Masney <masneyb@onstation.org>
Cc: jic23@kernel.org, devel@driverdev.osuosl.org, lars@metafoo.de,
        linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH 6/7] iio: light: tsl2583: add locking to sysfs *_store()
 functions
Message-ID: <20161019113345.GJ4469@mwanda>
References: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
 <1476873130-24926-6-git-send-email-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476873130-24926-6-git-send-email-masneyb@onstation.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Oct 19, 2016 at 06:32:09AM -0400, Brian Masney wrote:
> @@ -778,6 +796,8 @@ static ssize_t illuminance0_lux_table_store(struct device *dev,
>  		goto luxable_store_done;
>  	}
>  
> +	mutex_lock(&chip->als_mutex);
> +
>  	if (chip->taos_chip_status == TSL258X_CHIP_WORKING) {
>  		ret = taos_chip_off(indio_dev);
>  		if (ret < 0)
> @@ -794,6 +814,8 @@ static ssize_t illuminance0_lux_table_store(struct device *dev,
>  
>  	ret = len;
>  
> +	mutex_unlock(&chip->als_mutex);
> +
>  luxable_store_done:
>  	return ret;
>  }


HAHAHHA HAHAHAH HAH AHHA HAHHAH AH HAHAHHAHAH AHHAHHAHAHHA HAHA HAHAHAH.

*wipes tear from eye*.  *continues laughing*.

HAHAHAHAHHAHAHA HAHA HAHAHAHA HAHAHA HAHAHAH AHAHAHAHA AHHAHAH.

This patch introduces a return with lock held bug.  All those do nothing
gotos, and we still missed when we actually had to do a "goto unlock".
If every function is special and complicated that reall means that no
functions are special.

Don't do do-nothing gotos.

regards,
dan carpenter

