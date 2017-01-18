Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:35622 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752030AbdARUiF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2017 15:38:05 -0500
Subject: Re: [PATCH] iio: light: acpi-als: Properly enable on ASUS Zenbooks
To: Josef Gajdusek <atx@atx.name>, linux-iio@vger.kernel.org
References: <20170118161254.GA17344@rick.lan>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, maitysanchayan@gmail.com,
        gregor.boirie@parrot.com, linux-kernel@vger.kernel.org,
        rui.zhang@intel.com, marxin.liska@gmail.com
From: Marek Vasut <marex@denx.de>
Message-ID: <dfdda611-e9ff-4751-7218-b7a83e56c0a3@denx.de>
Date: Wed, 18 Jan 2017 21:26:20 +0100
MIME-Version: 1.0
In-Reply-To: <20170118161254.GA17344@rick.lan>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/18/2017 05:39 PM, Josef Gajdusek wrote:
> ASUS Zenbooks need several special ACPI calls to enable the ALS peripheral.
> Otherwise, reads just return 0.
> 
> Signed-off-by: Josef Gajdusek <atx@atx.name>
> ---
>  drivers/iio/light/acpi-als.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> index f0b47c5..1fe2cd8 100644
> --- a/drivers/iio/light/acpi-als.c
> +++ b/drivers/iio/light/acpi-als.c
> @@ -39,6 +39,9 @@
>  #define ACPI_ALS_DEVICE_NAME		"acpi-als"
>  #define ACPI_ALS_NOTIFY_ILLUMINANCE	0x80
>  
> +#define ACPI_ALS_ASUS_TALS		"\\_SB.PCI0.LPCB.EC0.TALS"
> +#define ACPI_ALS_ASUS_ALSC		"\\_SB.ATKD.ALSC"
> +
>  ACPI_MODULE_NAME("acpi-als");
>  
>  /*
> @@ -180,6 +183,8 @@ static int acpi_als_add(struct acpi_device *device)
>  	struct acpi_als *als;
>  	struct iio_dev *indio_dev;
>  	struct iio_buffer *buffer;
> +	acpi_handle handle_tals, handle_alsc;
> +	acpi_status status_tals, status_alsc;
>  
>  	indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
>  	if (!indio_dev)
> @@ -191,6 +196,18 @@ static int acpi_als_add(struct acpi_device *device)
>  	als->device = device;
>  	mutex_init(&als->lock);
>  
> +	/* ASUS Zenbooks need this to enable ALS */
> +	status_tals = acpi_get_handle(NULL, ACPI_ALS_ASUS_TALS, &handle_tals);
> +	status_alsc = acpi_get_handle(NULL, ACPI_ALS_ASUS_ALSC, &handle_alsc);
> +	/* So far only devices with both have been observed */
> +	if (ACPI_SUCCESS(status_tals) ^ ACPI_SUCCESS(status_alsc))
> +		dev_warn(&device->dev, "Attempting to enable ACPI ALS, but found only one of \""
> +			 ACPI_ALS_ASUS_TALS "\" and \"" ACPI_ALS_ASUS_ALSC "\"");
> +	if (ACPI_SUCCESS(status_tals))
> +		acpi_execute_simple_method(handle_tals, NULL, 1);
> +	if (ACPI_SUCCESS(status_alsc))
> +		acpi_execute_simple_method(handle_alsc, NULL, 1);

Pull the system-specific quirk into a function please, don't pollute
common code with broken-ACPI crap.

Also, handle the failures in sequence, avoid the xor and other such
nonsense.

>  	indio_dev->name = ACPI_ALS_DEVICE_NAME;
>  	indio_dev->dev.parent = &device->dev;
>  	indio_dev->info = &acpi_als_info;
> 


-- 
Best regards,
Marek Vasut
