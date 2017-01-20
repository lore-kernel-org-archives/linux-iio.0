Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33176 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751038AbdATCxk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 21:53:40 -0500
Received: by mail-vk0-f44.google.com with SMTP id k127so43550186vke.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Jan 2017 18:53:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170119190134.GA14027@rick.lan>
References: <20170119190134.GA14027@rick.lan>
From: Matt Ranostay <matt.ranostay@konsulko.com>
Date: Thu, 19 Jan 2017 18:53:28 -0800
Message-ID: <CAJCx=gnzm5gQ4RPeyR0mDovTMd=4BDqpL3YR3xUhgRb5jd9xxg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: light: acpi-als: Properly enable on ASUS Zenbooks
To: Josef Gajdusek <atx@atx.name>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        maitysanchayan@gmail.com, gregor.boirie@parrot.com,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        marxin.liska@gmail.com, marex@denx.de
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, Jan 19, 2017 at 11:01 AM, Josef Gajdusek <atx@atx.name> wrote:
> ASUS Zenbooks need several special ACPI calls to enable the ALS peripheral.
> Otherwise, reads just return 0.
>
> Signed-off-by: Josef Gajdusek <atx@atx.name>
> ---
>  drivers/iio/light/acpi-als.c | 60 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 60 insertions(+)
>
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> index f0b47c5..43417c9 100644
> --- a/drivers/iio/light/acpi-als.c
> +++ b/drivers/iio/light/acpi-als.c
> @@ -30,6 +30,7 @@
>  #include <linux/acpi.h>
>  #include <linux/err.h>
>  #include <linux/mutex.h>
> +#include <linux/dmi.h>
>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/buffer.h>
> @@ -39,6 +40,9 @@
>  #define ACPI_ALS_DEVICE_NAME           "acpi-als"
>  #define ACPI_ALS_NOTIFY_ILLUMINANCE    0x80
>
> +#define ACPI_ALS_ASUS_TALS             "\\_SB.PCI0.LPCB.EC0.TALS"
> +#define ACPI_ALS_ASUS_ALSC             "\\_SB.ATKD.ALSC"

Not sure I like these one off defines... this could easily get out of hand.
Also too lazy to pop out the ACPI spec what does TALS and ALSC mean?

> +
>  ACPI_MODULE_NAME("acpi-als");
>
>  /*
> @@ -170,6 +174,46 @@ static int acpi_als_read_raw(struct iio_dev *indio_dev,
>         return IIO_VAL_INT;
>  }
>
> +static int acpi_als_quirk_asus_zenbook_add(struct acpi_als *als)
> +{
> +       acpi_status status;
> +
> +       status = acpi_execute_simple_method(NULL, ACPI_ALS_ASUS_TALS, 1);
> +       if (ACPI_FAILURE(status)) {
> +               ACPI_EXCEPTION((AE_INFO, status, "Error enabling ALS by %s",
> +                               ACPI_ALS_ASUS_TALS));
> +               return -EIO;
> +       }
> +       status = acpi_execute_simple_method(NULL, ACPI_ALS_ASUS_ALSC, 1);
> +       if (ACPI_FAILURE(status)) {
> +               ACPI_EXCEPTION((AE_INFO, status, "Error enabling ALS by %s",
> +                               ACPI_ALS_ASUS_ALSC));
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
> +struct quirk_entry {
> +       int (*add)(struct acpi_als *als);

Maybe put the defines above in here.

     .tals  = "\\_SB.PCI0.LPCB.EC0.TALS",
     .alsc = ""\\_SB.ATKD.ALSC"
.

> +};
> +
> +static struct quirk_entry acpi_als_quirk_asus_zenbook = {
> +       .add = acpi_als_quirk_asus_zenbook_add
> +};
> +
> +static const struct dmi_system_id acpi_als_quirks[] = {
> +       {
> +               .ident = "ASUSTeK COMPUTER INC. UX",
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +                       DMI_MATCH(DMI_PRODUCT_NAME, "UX"),

Really is the DMI_PRODUCT_NAME only two characters? You are likely
going to need another DMI property to match on.


Thanks,

Matt

> +               },
> +               .driver_data = &acpi_als_quirk_asus_zenbook,
> +       },
> +       {},
> +};
> +
>  static const struct iio_info acpi_als_info = {
>         .driver_module          = THIS_MODULE,
>         .read_raw               = acpi_als_read_raw,
> @@ -180,6 +224,9 @@ static int acpi_als_add(struct acpi_device *device)
>         struct acpi_als *als;
>         struct iio_dev *indio_dev;
>         struct iio_buffer *buffer;
> +       const struct dmi_system_id *dmiid;
> +       struct quirk_entry *quirk;
> +       int ret;
>
>         indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
>         if (!indio_dev)
> @@ -191,6 +238,19 @@ static int acpi_als_add(struct acpi_device *device)
>         als->device = device;
>         mutex_init(&als->lock);
>
> +       dmiid = dmi_first_match(acpi_als_quirks);
> +       if (dmiid) {
> +               dev_dbg(&device->dev, "Detected quirk for %s\n", dmiid->ident);
> +               quirk = dmiid->driver_data;
> +               ret = quirk->add(als);
> +               if (ret) {
> +                       dev_err(&device->dev,
> +                               "Executing quirk for %s failed - %d",
> +                               dmiid->ident, ret);
> +                       return ret;
> +               }
> +       }
> +
>         indio_dev->name = ACPI_ALS_DEVICE_NAME;
>         indio_dev->dev.parent = &device->dev;
>         indio_dev->info = &acpi_als_info;
> --
> 2.10.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
