Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58529 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751350Ab3JAPUl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 11:20:41 -0400
Message-ID: <524AF672.6000805@kernel.org>
Date: Tue, 01 Oct 2013 17:21:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lukasz Czerwinski <l.czerwinski@samsung.com>, jic23@cam.ac.uk
CC: denis.ciocca@st.com, linux-iio@vger.kernel.org,
	lee.jones@linaro.org, devicetree@vger.kernel.org
Subject: Re: [RFC v2 PATCH 08/14] iio: iio_magn: Add event ops
References: <1380299538-22047-1-git-send-email-l.czerwinski@samsung.com> <1380299538-22047-9-git-send-email-l.czerwinski@samsung.com>
In-Reply-To: <1380299538-22047-9-git-send-email-l.czerwinski@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/27/13 17:32, Lukasz Czerwinski wrote:
> Signed-off-by: Lukasz Czerwinski <l.czerwinski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Why?  The won't be used by the drivers as none have had the support
added to any of the parts yet.

Hopefully Denis, or someone else with access to a lot of parts
will do some of them (or at least test them for someone else).

> ---
>  drivers/iio/magnetometer/st_magn_core.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
> index 4460075..1e212ad 100644
> --- a/drivers/iio/magnetometer/st_magn_core.c
> +++ b/drivers/iio/magnetometer/st_magn_core.c
> @@ -343,6 +343,10 @@ static const struct iio_info magn_info = {
>  	.attrs = &st_magn_attribute_group,
>  	.read_raw = &st_magn_read_raw,
>  	.write_raw = &st_magn_write_raw,
> +	.read_event_value = &st_sensors_read_event_value,
> +	.write_event_value = &st_sensors_write_event_value,
> +	.read_event_config = &st_sensors_read_event_config,
> +	.write_event_config = &st_sensors_write_event_config,
>  };
>  
>  int st_magn_common_probe(struct iio_dev *indio_dev)
> 
