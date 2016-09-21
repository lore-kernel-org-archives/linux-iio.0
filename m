Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35759 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753152AbcIUKqc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Sep 2016 06:46:32 -0400
Received: by mail-lf0-f48.google.com with SMTP id l131so37210607lfl.2
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2016 03:45:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160921080204.28903-1-hdegoede@redhat.com>
References: <20160921080204.28903-1-hdegoede@redhat.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 21 Sep 2016 13:45:36 +0300
Message-ID: <CAEnQRZDZN=VTnaNuDMQAiN054mptTRm_5mFxaHZ1_PWjFt=QKQ@mail.gmail.com>
Subject: Re: [PATCH] Add an IIO driver for the MiraMEMS DA311 3-axis 12-bit
 digital accelerometer
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Hans,

Commit subject should follow Linux kernel convention:

<subsytem tag>: <short description for change>, in our case:

iio: accel: Add support for MiraMEMS DA311 3-axis 12-bit digital accelerometer

If not sure what tag to use, look into git log for previous commits in
your driver
working directory.

On Wed, Sep 21, 2016 at 11:02 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> This driver is based on the DA311 Android driver which can be found here:
> https://git.matricom.net/Firmware/kernel_amlogic_meson-common/tree/1e70113a5befd07debb68f537156def84c5be57a/drivers/amlogic/input/sensor
> the mir3da_* files are the DA311 driver.
>
> Unfortunately there is no datasheet.
>

<snip>

> +static int da311_probe(struct i2c_client *client,
> +                       const struct i2c_device_id *id)
> +{
> +       int ret;
> +       struct iio_dev *indio_dev;
> +       struct da311_data *data;
> +
> +       ret = i2c_smbus_read_byte_data(client, DA311_REG_CHIP_ID);
> +       if (ret != DA311_CHIP_ID)
> +               return (ret < 0) ? ret : -ENODEV;
> +
> +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +       if (!indio_dev) {
> +               dev_err(&client->dev, "iio allocation failed!\n");

No need for this message. If allocation fail you'll get one from the core.

<snip>

Other than that looks good AFAICT. Please run checkpatch.pl and sparse
(make C=2) if you haven't
already done that :).

thanks,
Daniel.
