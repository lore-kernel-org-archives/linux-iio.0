Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbeLBDTl (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Dec 2018 22:19:41 -0500
Date: Sat, 1 Dec 2018 16:06:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH] iio: magnetometer: ak8975: Add the "AKM9911" ACPI HID
Message-ID: <20181201160647.7994f730@archlinux>
In-Reply-To: <20181125180240.9885-1-stephan@gerhold.net>
References: <20181125180240.9885-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 25 Nov 2018 19:02:40 +0100
Stephan Gerhold <stephan@gerhold.net> wrote:

> This HID is used on the ASUS MeMO Pad 7 (ME176C) tablet.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Applied to the togreg branch of iio.git and pushed out as
testing because there other thing in that branch that
might break things the autobuilders will fine.

Thanks,

Jonathan

> ---
>  drivers/iio/magnetometer/ak8975.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 42a827a66512..d430b80808ef 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -790,6 +790,7 @@ static const struct acpi_device_id ak_acpi_match[] = {
>  	{"INVN6500", AK8963},
>  	{"AK009911", AK09911},
>  	{"AK09911", AK09911},
> +	{"AKM9911", AK09911},
>  	{"AK09912", AK09912},
>  	{ },
>  };
