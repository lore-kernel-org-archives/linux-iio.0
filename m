Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.22]:64163 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751115AbbGMSsp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 13 Jul 2015 14:48:45 -0400
Message-ID: <55A40800.1080805@gmx.de>
Date: Mon, 13 Jul 2015 20:48:32 +0200
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Cristina Opriceana <cristina.opriceana@gmail.com>, jic23@kernel.org
CC: lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, daniel.baluta@intel.com,
	octavian.purdila@intel.com
Subject: Re: [PATCH 2/3] tools: iio: Remove unnecessary braces
References: <cover.1436789446.git.cristina.opriceana@gmail.com> <45661e14b247cebfc130518e0c1c44fcec339f0d.1436789446.git.cristina.opriceana@gmail.com>
In-Reply-To: <45661e14b247cebfc130518e0c1c44fcec339f0d.1436789446.git.cristina.opriceana@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Cristina Opriceana schrieb am 13.07.2015 um 15:17:
> Single statement blocks don’t need braces.
> Found with checkpatch.pl.
> 
> Signed-off-by: Cristina Opriceana <cristina.opriceana@gmail.com>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---

Oops, that slipped through my hands. Thanks for taking care of this.

>  tools/iio/iio_event_monitor.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 703f4cb..9ee1959 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -262,9 +262,8 @@ int main(int argc, char **argv)
>  		printf("Found IIO device with name %s with device number %d\n",
>  		       device_name, dev_num);
>  		ret =sprintf(&chrdev_name, "/dev/iio:device%d", dev_num);
> -		if (ret < 0) {
> +		if (ret < 0)
>  			return -ENOMEM;
> -		}
>  	} else {
>  		/*
>  		 * If we can't find an IIO device by name assume device_name is
> 

