Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:36744 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755952AbbI0N4f (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Sep 2015 09:56:35 -0400
Subject: Re: [PATCH] iio: adc: max1363: leave sysfs naming to the core
To: Martin Kepplinger <martink@posteo.de>, lars@metafoo.de,
	knaack.h@gmx.de, pmeerw@pmeerw.net
References: <1443174731-25727-1-git-send-email-martink@posteo.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5607F591.1000005@kernel.org>
Date: Sun, 27 Sep 2015 14:56:33 +0100
MIME-Version: 1.0
In-Reply-To: <1443174731-25727-1-git-send-email-martink@posteo.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/09/15 10:52, Martin Kepplinger wrote:
> This shouldn't actually change anything since the core calls the events
> sysfs folder "events" anyways.
> 
> Signed-off-by: Martin Kepplinger <martink@posteo.de>
Applied. Thanks
> ---
>  drivers/iio/adc/max1363.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 1b3b74b..929508e 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1007,7 +1007,6 @@ static struct attribute *max1363_event_attributes[] = {
>  
>  static struct attribute_group max1363_event_attribute_group = {
>  	.attrs = max1363_event_attributes,
> -	.name = "events",
>  };
>  
>  static int max1363_update_scan_mode(struct iio_dev *indio_dev,
> 

