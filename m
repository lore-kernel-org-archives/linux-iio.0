Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbdKSRDq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Nov 2017 12:03:46 -0500
Date: Sun, 19 Nov 2017 17:03:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kiernan Hager <kah.listaddress@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Marek Vasut <marex@denx.de>, linux-acpi@vger.kernel.org
Subject: Re: [RFC] iio: light: acpi-als: Enable the light sensor on the
 Zenbook UX430UQ
Message-ID: <20171119170341.62e5de3d@archlinux>
In-Reply-To: <20171116032754.20719-1-kah.listaddress@gmail.com>
References: <20171116032754.20719-1-kah.listaddress@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 15 Nov 2017 20:27:54 -0700
Kiernan Hager <kah.listaddress@gmail.com> wrote:

> This makes acpi-als properly enable the light sensor on the Zenbook UX430UQ. I don't know if the checking that I do to make sure that the ACPI method exists is sufficient or if it should disable the sensor when the module is unloaded, so input is appreciated on those matters.

Please wrap descriptions to around 72 characters (leaves room for indentation
in the email thread :)

This seems very much like a board specific hack.  I've cc'd people
who have worked on the driver recently and the acpi list.

> 
> Signed-off-by: Kiernan Hager <kah.listaddress@gmail.com>
> ---
>  drivers/iio/light/acpi-als.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> index c35e2f8df339..8fd66166f19f 100644
> --- a/drivers/iio/light/acpi-als.c
> +++ b/drivers/iio/light/acpi-als.c
> @@ -179,6 +179,10 @@ static int acpi_als_add(struct acpi_device *device)
>  	struct acpi_als *als;
>  	struct iio_dev *indio_dev;
>  	struct iio_buffer *buffer;
> +	unsigned long long temp_val;
> +	acpi_status status;
> +	struct acpi_object_list arg_list;
> +	union acpi_object arg;
>  
>  	indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
>  	if (!indio_dev)
> @@ -203,6 +207,18 @@ static int acpi_als_add(struct acpi_device *device)
>  
>  	iio_device_attach_buffer(indio_dev, buffer);
>  
> +	arg_list.count = 1;
> +	arg_list.pointer = &arg;
> +	arg.type = ACPI_TYPE_INTEGER;
> +	arg.integer.value = 1;
> +
> +	if (acpi_has_method(als->device->handle, "\\_SB.PCI0.LPCB.EC0.ALSC")) {
So this is poking something on
PCI bus 0
LPC bus B
Somethingbus 0
Ambient light controller.

I assume there is a better way of establishing this needs to be set?

> +		status = acpi_evaluate_integer(als->device->handle,
> +					       "\\_SB.PCI0.LPCB.EC0.ALSC",
> +					       &arg_list,
> +					       &temp_val);
> +	}
> +
>  	return devm_iio_device_register(&device->dev, indio_dev);
>  }
>  

