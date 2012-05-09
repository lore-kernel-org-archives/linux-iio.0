Return-Path: <sameo@linux.intel.com>
Date: Wed, 9 May 2012 16:42:18 +0200
From: Samuel Ortiz <sameo@linux.intel.com>
To: Johan Hovold <jhovold@gmail.com>
Cc: Rob Landley <rob@landley.net>, Richard Purdie <rpurdie@rpsys.net>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mfd: add LM3533 lighting-power core driver
Message-ID: <20120509144218.GI1794@sortiz-mobl>
References: <1334935826-12527-1-git-send-email-jhovold@gmail.com>
 <1336040799-18433-1-git-send-email-jhovold@gmail.com>
 <1336040799-18433-2-git-send-email-jhovold@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1336040799-18433-2-git-send-email-jhovold@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hi Johan

On Thu, May 03, 2012 at 12:26:36PM +0200, Johan Hovold wrote:
> Add support for National Semiconductor / TI LM3533 lighting power chips.
> 
> This is the core driver which provides register access over I2C and
> registers the ambient-light-sensor, LED and backlight sub-drivers.
> 
> Signed-off-by: Johan Hovold <jhovold@gmail.com>
> ---
> 
> v2:
>  - add sysfs-ABI documentation
>  - merge i2c implementation with core
>  - use regmap and kill custom debugfs interface
> 
> 
>  .../ABI/testing/sysfs-bus-i2c-devices-lm3533       |   38 +
>  drivers/mfd/Kconfig                                |   13 +
>  drivers/mfd/Makefile                               |    1 +
>  drivers/mfd/lm3533-core.c                          |  717 ++++++++++++++++++++
>  drivers/mfd/lm3533-ctrlbank.c                      |  134 ++++
>  include/linux/mfd/lm3533.h                         |   89 +++
>  6 files changed, 992 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-i2c-devices-lm3533
>  create mode 100644 drivers/mfd/lm3533-core.c
>  create mode 100644 drivers/mfd/lm3533-ctrlbank.c
>  create mode 100644 include/linux/mfd/lm3533.h
Patch applied to my for-next branch, thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
