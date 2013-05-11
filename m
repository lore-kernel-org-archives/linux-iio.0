Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51746 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072Ab3EKOWy (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 11 May 2013 10:22:54 -0400
Message-ID: <518E543C.30401@kernel.org>
Date: Sat, 11 May 2013 15:22:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: linux-iio@vger.kernel.org, denis.ciocca@gmail.com
Subject: Re: [PATCH] iio:common: added disable function after read info raw
 data
References: <1368106549-6352-1-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1368106549-6352-1-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/09/2013 02:35 PM, Denis CIOCCA wrote:
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
Applied to fixes-togreg branch of iio.git
> ---
>  drivers/iio/common/st_sensors/st_sensors_core.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
> index bd33473..ed9bc8a 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_core.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_core.c
> @@ -312,6 +312,8 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
>  			goto read_error;
>  
>  		*val = *val >> ch->scan_type.shift;
> +
> +		err = st_sensors_set_enable(indio_dev, false);
>  	}
>  	mutex_unlock(&indio_dev->mlock);
>  
> 
