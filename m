Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:36660 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752088AbaJCNuR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 3 Oct 2014 09:50:17 -0400
From: Denis CIOCCA <denis.ciocca@st.com>
To: Robin van der Gracht <robin@protonic.nl>,
	"jic23@kernel.org" <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Fri, 3 Oct 2014 15:50:02 +0200
Subject: Re: [PATCH] iio: st_sensors: Fix buffer copy
Message-ID: <542EA98A.4070906@st.com>
References: <1411995607-22198-1-git-send-email-robin@protonic.nl>
In-Reply-To: <1411995607-22198-1-git-send-email-robin@protonic.nl>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Acked-by: Denis Ciocca <denis.ciocca@st.com>

Thanks!

Denis

On 09/29/14 15:00, Robin van der Gracht wrote:
> Use byte_for_channel as iterator to properly initialize the buffer.
>
> Signed-off-by: Robin van der Gracht <robin@protonic.nl>
> ---
>   drivers/iio/common/st_sensors/st_sensors_buffer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> index 1665c8e..e18bc67 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -71,7 +71,7 @@ int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
>   				goto st_sensors_free_memory;
>   			}
>   
> -			for (i = 0; i < n * num_data_channels; i++) {
> +			for (i = 0; i < n * byte_for_channel; i++) {
>   				if (i < n)
>   					buf[i] = rx_array[i];
>   				else
