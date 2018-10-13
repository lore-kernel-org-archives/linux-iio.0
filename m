Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbeJMU4t (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 13 Oct 2018 16:56:49 -0400
Date: Sat, 13 Oct 2018 14:19:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kxcjk1013: Add KIOX0009 ACPI Hardware-ID
Message-ID: <20181013141938.3ed08ad6@archlinux>
In-Reply-To: <20181012101750.29333-1-hdegoede@redhat.com>
References: <20181012101750.29333-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 12 Oct 2018 12:17:50 +0200
Hans de Goede <hdegoede@redhat.com> wrote:

> Add KIOX0009 ACPI HID, this is used e.g. on the Acer One 10.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Applied to the togreg branch of iio.git and pushed out as staging
for the autobuilders to largely ignore.

Unfortunately it's missed the coming merge window so will
have to wait for the next one.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/kxcjk-1013.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index af53a1084ee5..8600e4be88ad 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1489,6 +1489,7 @@ static const struct acpi_device_id kx_acpi_match[] = {
>  	{"KXCJ1013", KXCJK1013},
>  	{"KXCJ1008", KXCJ91008},
>  	{"KXCJ9000", KXCJ91008},
> +	{"KIOX0009", KXTJ21009},
>  	{"KIOX000A", KXCJ91008},
>  	{"KXTJ1009", KXTJ21009},
>  	{"SMO8500",  KXCJ91008},
