Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbeJ2DeD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 23:34:03 -0400
Date: Sun, 28 Oct 2018 18:48:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kelly <martin@martingkelly.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Denis Ciocca <denis.ciocca@st.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/4] iio: magnetometer: add clarifying comment
Message-ID: <20181028184829.2fa0bb09@archlinux>
In-Reply-To: <20181026023812.29720-1-martin@martingkelly.com>
References: <20181026023812.29720-1-martin@martingkelly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 25 Oct 2018 19:38:09 -0700
Martin Kelly <martin@martingkelly.com> wrote:

> From: Martin Kelly <martin@martingkelly.com>
> 
> Add a comment clarifying better when to use <device_name> vs
> <device_name>-magn in compatibility strings.
> 
> Signed-off-by: Martin Kelly <martin@martingkelly.com>
Applied to the togreg branch of iio.git and pushed out as testing.
I'll ideally added acks from Dennis and Rob for relevant patches
before I push it out as non rebasing which will probably be next
weekend given my current habits.

Thanks,

Jonathan

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
