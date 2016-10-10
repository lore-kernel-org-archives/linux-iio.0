Return-Path: <robherring2@gmail.com>
Date: Mon, 10 Oct 2016 16:44:04 -0500
From: Rob Herring <robh@kernel.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2] iio: accel: Add driver for the MiraMEMS DA280 3-axis
 14-bit digital accelerometer
Message-ID: <20161010214404.GA16737@rob-hp-laptop>
References: <20161008181527.6646-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161008181527.6646-1-hdegoede@redhat.com>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Oct 08, 2016 at 08:15:27PM +0200, Hans de Goede wrote:
> Add an iio driver for the MiraMEMS DA280 3-axis 14-bit accelerometer, as
> well as for the DA226 which is a fully compatible 2-axis version.
> 
> Datasheets for the DA280 and DA226 can be found at the manufacturers site:
> http://www.miramems.com/en/products.asp?list=1
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Drop le16_to_cpu, i2c_smbus_read_word_data() already does this
> ---
>  .../devicetree/bindings/i2c/trivial-devices.txt    |   2 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/accel/Kconfig                          |  10 ++
>  drivers/iio/accel/Makefile                         |   1 +
>  drivers/iio/accel/da280.c                          | 183 +++++++++++++++++++++
>  4 files changed, 196 insertions(+)
>  create mode 100644 drivers/iio/accel/da280.c
