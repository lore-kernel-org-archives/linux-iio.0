Return-Path: <amsfield22@gmail.com>
Date: Mon, 13 Jun 2016 15:25:04 -0700
From: Alison Schofield <amsfield22@gmail.com>
To: Matt Ranostay <mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH 0/2] iio: humidity: sht31: add Sensirion SHT31 support
Message-ID: <20160613222502.GA4376@d830.WORKGROUP>
References: <1465708397-19649-1-git-send-email-mranostay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465708397-19649-1-git-send-email-mranostay@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Sat, Jun 11, 2016 at 10:13:15PM -0700, Matt Ranostay wrote:
> Add support for the humidity and temperature functionally for the SHT31
> chipset. In addition add support for using using software triggers.

Now that I'm hwmon-aware ;)  I see this same driver under review in hwmon.
Can support exist in 2 places?

alisons

> 
> Matt Ranostay (2):
>   devicetree: add Sensirion AG vendor id
>   iio: humidity: sht31: add Sensirion SHT31 support
> 
>  .../devicetree/bindings/i2c/trivial-devices.txt    |   1 +
>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>  drivers/iio/humidity/Kconfig                       |  11 +
>  drivers/iio/humidity/Makefile                      |   1 +
>  drivers/iio/humidity/sht31.c                       | 416 +++++++++++++++++++++
>  5 files changed, 430 insertions(+)
>  create mode 100644 drivers/iio/humidity/sht31.c
> 
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
