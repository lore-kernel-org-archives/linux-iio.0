Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33732 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751609AbcJJVlP (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Oct 2016 17:41:15 -0400
Date: Mon, 10 Oct 2016 16:41:13 -0500
From: Rob Herring <robh@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/4] iio: accel: Add driver for dmard10 3-axis
 Accelerometer
Message-ID: <20161010214113.GA15075@rob-hp-laptop>
References: <20161008123426.8991-1-hdegoede@redhat.com>
 <20161008123426.8991-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161008123426.8991-3-hdegoede@redhat.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Oct 08, 2016 at 02:34:24PM +0200, Hans de Goede wrote:
> Add a driver for the Domintech ARD10 3-axis Accelerometer, based on the
> android driver found here: https://github.com/domintech/dmard10
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -prefix all defines with DMARD10_ and uppercase them all
> -Cleanup typography of some comments
> -Use defines for offsets in databuffer
> -Use i2c_smbus_write_byte_data() where applicable
> -Reduce unnecessarily large buffer size in dmard10_shutdown()
> -Use __le16 buffer in dmard10_read_raw()
> Changes in v3:
> -Express unit in m/s^2 instead of in "G"
> ---
>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/accel/Kconfig                          |  10 +
>  drivers/iio/accel/Makefile                         |   1 +
>  drivers/iio/accel/dmard10.c                        | 266 +++++++++++++++++++++
>  4 files changed, 278 insertions(+)
>  create mode 100644 drivers/iio/accel/dmard10.c
