Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:51505 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbbAANsD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 1 Jan 2015 08:48:03 -0500
Message-ID: <54A55005.3080108@gmx.de>
Date: Thu, 01 Jan 2015 14:47:49 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@intel.com>, jic23@kernel.org
CC: lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 04/10] iio: imu: kmx61: Fixup parameters alignment
References: <1419340953-23161-1-git-send-email-daniel.baluta@intel.com> <1419340953-23161-5-git-send-email-daniel.baluta@intel.com>
In-Reply-To: <1419340953-23161-5-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Daniel Baluta schrieb am 23.12.2014 um 14:22:
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Acked-by: Hartmut Knaack <knaack.h@gmx.de>
> ---
>  drivers/iio/imu/kmx61.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index 4fc4f63..2652179 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -926,11 +926,11 @@ static int kmx61_read_event(struct iio_dev *indio_dev,
>  }
>  
>  static int kmx61_write_event(struct iio_dev *indio_dev,
> -			    const struct iio_chan_spec *chan,
> -			    enum iio_event_type type,
> -			    enum iio_event_direction dir,
> -			    enum iio_event_info info,
> -			    int val, int val2)
> +			     const struct iio_chan_spec *chan,
> +			     enum iio_event_type type,
> +			     enum iio_event_direction dir,
> +			     enum iio_event_info info,
> +			     int val, int val2)
>  {
>  	struct kmx61_data *data = kmx61_get_data(indio_dev);
>  
> @@ -962,10 +962,10 @@ static int kmx61_read_event_config(struct iio_dev *indio_dev,
>  }
>  
>  static int kmx61_write_event_config(struct iio_dev *indio_dev,
> -				   const struct iio_chan_spec *chan,
> -				   enum iio_event_type type,
> -				   enum iio_event_direction dir,
> -				   int state)
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    int state)
>  {
>  	struct kmx61_data *data = kmx61_get_data(indio_dev);
>  	int ret = 0;
> 

