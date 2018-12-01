Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbeLBDZw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Dec 2018 22:25:52 -0500
Date: Sat, 1 Dec 2018 16:12:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: humidity: hts221: add entry in MAINTAINERS file
Message-ID: <20181201161258.17091479@archlinux>
In-Reply-To: <284ef543279ecc56944011fe1082d9a46f87d9ea.1543222885.git.lorenzo.bianconi@redhat.com>
References: <cover.1543222885.git.lorenzo.bianconi@redhat.com>
        <284ef543279ecc56944011fe1082d9a46f87d9ea.1543222885.git.lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 26 Nov 2018 10:05:55 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Add entry for hts221 temperature/humidity driver in MAINTAINERS file
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Applied.  Thanks,

Jonathan

> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f4d94fb0666d..d904229ceffb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6792,6 +6792,14 @@ L:	linux-input@vger.kernel.org
>  S:	Maintained
>  F:	drivers/input/touchscreen/htcpen.c
>  
> +HTS221 TEMPERATURE-HUMIDITY IIO DRIVER
> +M:	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +W:	http://www.st.com/
> +S:	Maintained
> +F:	drivers/iio/humidity/hts221*
> +F:	Documentation/devicetree/bindings/iio/humidity/hts221.txt
> +
>  HUAWEI ETHERNET DRIVER
>  M:	Aviad Krawczyk <aviad.krawczyk@huawei.com>
>  L:	netdev@vger.kernel.org
