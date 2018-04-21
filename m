Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751476AbeDUP3x (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 11:29:53 -0400
Date: Sat, 21 Apr 2018 16:29:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: st_accel: Add support for the SMO8840 ACPI
 id
Message-ID: <20180421162948.7db0a404@archlinux>
In-Reply-To: <20180418123318.10948-1-hdegoede@redhat.com>
References: <20180418123318.10948-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 18 Apr 2018 14:33:18 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> The Lenovo Ideapad Miix 320 uses an st accelerometer with an ACPI id
> of SMO8840, add support for this.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/st_accel_i2c.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index 6bdec8c451e0..056dddb27236 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -107,6 +107,7 @@ MODULE_DEVICE_TABLE(of, st_accel_of_match);
>  
>  #ifdef CONFIG_ACPI
>  static const struct acpi_device_id st_accel_acpi_match[] = {
> +	{"SMO8840", LNG2DM},
>  	{"SMO8A90", LNG2DM},
>  	{ },
>  };

