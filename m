Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58535 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752035AbcGXKcN (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jul 2016 06:32:13 -0400
Subject: Re: [PATCH 2/5] mfd: sunxi-gpadc-mfd: add buffer structure
To: Quentin Schulz <quentin.schulz@free-electrons.com>,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com, wens@csie.org,
	dmitry.torokhov@gmail.com, lee.jones@linaro.org
References: <1469003351-15263-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469003351-15263-3-git-send-email-quentin.schulz@free-electrons.com>
Cc: antoine.tenart@free-electrons.com,
	thomas.petazzoni@free-electrons.com, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-input@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <8e64fb86-d59c-c641-ded4-6c9f372e2a56@kernel.org>
Date: Sun, 24 Jul 2016 11:32:09 +0100
MIME-Version: 1.0
In-Reply-To: <1469003351-15263-3-git-send-email-quentin.schulz@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/07/16 09:29, Quentin Schulz wrote:
> This adds a buffer structure for files including the sunxi-gpadc-mfd
> header. This structure has a buffer of 32 u32 values to store data from the
> FIFO of the GPADC of Allwinner SoCs. A buff_size is provided in case the
> buffer is not full.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
I'd roll this into the first patch that uses it.
Easier to see what is for when reviewing then!

Jonathan
> ---
>  include/linux/mfd/sunxi-gpadc-mfd.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/mfd/sunxi-gpadc-mfd.h b/include/linux/mfd/sunxi-gpadc-mfd.h
> index 7155845..f658299 100644
> --- a/include/linux/mfd/sunxi-gpadc-mfd.h
> +++ b/include/linux/mfd/sunxi-gpadc-mfd.h
> @@ -20,4 +20,9 @@ struct sunxi_gpadc_mfd_dev {
>  	void __iomem			*regs;
>  };
>  
> +struct sunxi_gpadc_buffer {
> +	u32				buffer[32];
> +	unsigned int			buff_size;
> +};
> +
>  #endif
> 

