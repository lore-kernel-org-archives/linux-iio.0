Return-Path: <SRS0=75sL=NL=gmail.com=nishadkamdar@kernel.org>
Date: Wed, 31 Oct 2018 21:24:16 +0530
From: Nishad Kamdar <nishadkamdar@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Slawomir Stepien <sst@poczta.fm>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/3] staging: iio: ad2s1210: Switch to the gpio descriptor
 interface.
Message-ID: <cover.1541000375.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-iio@vger.kernel.org>

Use the gpiod interface instead of the deprecated old non-descriptor

Changes in v7:
 - Adds a level of indirection to read and write
   the gpio_desc to make the code simpler.
 - Drop gpioin flag which decides how the GPIOs
   are controlled as the GPIOs must be outputs
   for the host as per the datasheet.
Changes in v6:
 - Split device tree table addition and device tree support 
   addition in two patches.
 - Replace platform data with device tree support.
 - Rename boolean property.
Changes in v5:
 - Add device tree support.
 - Add device tree table for matching vendor ID.
 - Add Support for retrieving platform data from device tree.
Changes in v4:
 - Add spaces after { and before } in gpios[]
   initialization.
 - Check the correct pointer for error.
 - Align the dev_err msg to existing format in the code.
Changes in v3:
 - Use a pointer to pointer for gpio_desc in
   struct ad2s1210_gpio as it will be used to
   modify a pointer.
 - Use dot notation to initialize the structure.
 - Use a pointer variable to avoid writing gpios[i].
Changes in v2:
 - Use the spi_device struct embedded in st instead
   of passing it as an argument to ad2s1210_setup_gpios().
 - Use an array of structs to reduce redundant code in
   in ad2s1210_setup_gpios().
 - Remove ad2s1210_free_gpios() as devm API is being used.

Nishad Kamdar (3):
  staging: iio: ad2s1210: Switch to the gpio descriptor interface
  staging: iio: ad2s1210: Drop the gpioin flag.
  staging: iio: ad2s1210: Add device tree table.

 drivers/staging/iio/resolver/ad2s1210.c | 132 +++++++++++-------------
 drivers/staging/iio/resolver/ad2s1210.h |  20 ----
 2 files changed, 62 insertions(+), 90 deletions(-)

-- 
2.17.1
