Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32786 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752057AbcJJVlk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Oct 2016 17:41:40 -0400
Date: Mon, 10 Oct 2016 16:41:39 -0500
From: Rob Herring <robh@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/4] iio: accel: Add driver for the MiraMEMS DA311 3-axis
 12-bit digital accelerometer
Message-ID: <20161010214139.GA15600@rob-hp-laptop>
References: <20161008123426.8991-1-hdegoede@redhat.com>
 <20161008123426.8991-4-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161008123426.8991-4-hdegoede@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Oct 08, 2016 at 02:34:25PM +0200, Hans de Goede wrote:
> This driver is based on the DA311 Android driver which can be found here:
> https://git.matricom.net/Firmware/kernel_amlogic_meson-common/tree/1e70113a5befd07debb68f537156def84c5be57a/drivers/amlogic/input/sensor
> the mir3da_* files are the DA311 driver.
> 
> Unfortunately there is no datasheet.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Add proper prefix to patch Subject
> -Use i2c_smbus_read_word_data() instead of i2c_smbus_read_i2c_block_data()
> Changes in v3:
> -Express unit in m/s^2 instead of in "G"
> -Drop le16_to_cpu, i2c_smbus_read_word_data() already does this
> ---
>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/accel/Kconfig                          |  10 +
>  drivers/iio/accel/Makefile                         |   1 +
>  drivers/iio/accel/da311.c                          | 305 +++++++++++++++++++++
>  4 files changed, 317 insertions(+)
>  create mode 100644 drivers/iio/accel/da311.c
