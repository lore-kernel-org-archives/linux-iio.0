Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbeJ2Daj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 23:30:39 -0400
Date: Sun, 28 Oct 2018 18:45:05 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Denis CIOCCA <denis.ciocca@st.com>
Cc: Martin Kelly <martin@martingkelly.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/4] iio: magnetometer: add clarifying comment
Message-ID: <20181028184505.5c6cb5fe@archlinux>
In-Reply-To: <405cfbe9c82c430682409372aaea4f21@SFHDAG2NODE1.st.com>
References: <20181026023812.29720-1-martin@martingkelly.com>
        <405cfbe9c82c430682409372aaea4f21@SFHDAG2NODE1.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 26 Oct 2018 18:24:41 +0000
Denis CIOCCA <denis.ciocca@st.com> wrote:

> Hi Martin,
> 
> All the series [v2 / 4 patches] looks good to me. Thanks
> 

Formal Acked-by / Reviewed-by?

Thanks,

Jonathan

> Denis
> 
> 
> -----Original Message-----
> From: Martin Kelly <martin@martingkelly.com> 
> Sent: Thursday, October 25, 2018 7:38 PM
> To: linux-iio@vger.kernel.org; devicetree@vger.kernel.org
> Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>; Denis CIOCCA <denis.ciocca@st.com>; Jonathan Cameron <jic23@kernel.org>; Rob Herring <robh+dt@kernel.org>; Martin Kelly <martin@martingkelly.com>
> Subject: [PATCH v2 1/4] iio: magnetometer: add clarifying comment
> 
> From: Martin Kelly <martin@martingkelly.com>
> 
> Add a comment clarifying better when to use <device_name> vs <device_name>-magn in compatibility strings.
> 
> Signed-off-by: Martin Kelly <martin@martingkelly.com>
> ---
>  drivers/iio/magnetometer/st_magn_spi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetometer/st_magn_spi.c
> index 7b7cd08fcc32..15bb09267098 100644
> --- a/drivers/iio/magnetometer/st_magn_spi.c
> +++ b/drivers/iio/magnetometer/st_magn_spi.c
> @@ -23,6 +23,8 @@
>   * For new single-chip sensors use <device_name> as compatible string.
>   * For old single-chip devices keep <device_name>-magn to maintain
>   * compatibility
> + * For multi-chip devices, use <device_name>-magn to distinguish which
> + * capability is being used
>   */
>  static const struct of_device_id st_magn_of_match[] = {
>  	{
> --
> 2.11.0
> 
