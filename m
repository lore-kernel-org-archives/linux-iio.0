Return-Path: <lee.jones@linaro.org>
Date: Tue, 16 Aug 2016 13:49:07 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Olof Johansson <olof@lixom.net>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Guenter Roeck <groeck@chromium.org>,
	Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH v4 0/4] Add support for cros-ec-sensors
Message-ID: <20160816124907.GK25844@dell>
References: <1470045278-18161-1-git-send-email-enric.balletbo@collabora.com>
 <b32afa2d-965c-569c-dde1-3611615080d3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <b32afa2d-965c-569c-dde1-3611615080d3@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Mon, 15 Aug 2016, Jonathan Cameron wrote:

> On 01/08/16 10:54, Enric Balletbo i Serra wrote:
> > Hi,
> > 
> > This is the four patchset to add support for the sensors behind the ChromeOS
> > Embedded Controller.
> > 
> > This version has only the patches to support common functions and 3d
> > contiguous sensors like Accelerometers, Gyroscope and Magnetometer that are
> > presented by the ChromeOS EC Sensor hub. The patches were tested on an Oak board.
> > 
> > The code was checked out from the ChromeOS v3.18 tree and forward ported to
> > mainline solving all the conflicts and build issues. I splitted the code in
> > single patches that have sense by themselves in order to avoid the chances
> > to fail.
> > 
> > Note that the patches depends on this [1] to apply and work.
> > 
> > [1] https://lkml.org/lkml/2016/7/1/188
> Given this dependency I'm assuming the best route for these is via
> the MFD tree...
> 
> Lee, shout if you want them to go a different route.

IIO looks like a more suitable route.  Please provide me with a
pull-request base off of an immutable tag.

> > Waiting for your reviews and feedback.
> > 
> > Changes since v3 (requested by Guenter Roeck)
> >   - Convert structure to a simple array
> >   - Remove PM declarations
> >   - Remove unnecessary initializations
> >   - cros_ec_sensors_cmd_read_u16: Conversion should only be done if ret >= 0
> >   - Remove unnecessary else
> >   - Add Reviewed-by tag for two last patches.
> > 
> > Changes since v2 (requested by Guenter Roeck and Jonhatan Cameron)
> >   - Rebased and fix build error.
> >   - Include a list of possible values in the description of location attr.
> >   - Fix some typos.
> >   - Remove id sysfs entry.
> >   - Skip filling by zero structure parameters that already zero'd.
> >   - Order includes alphabetically.
> >   - Propagate error codes.
> > 
> > Changes since v1 (requested by Peter Meerwald-Stadler and Jonhatan Cameron)
> >   - Check kernel-doc documentation and 
> >   - Bring some patches together.
> >   - Fix some spelling mistakes.
> >   - Include ABI documentation.
> >   - Be more careful with buffer sizes (sprintf -> snprintf)
> >   - Add cros_ec_sensors prefix to all function.
> >   - Check return values on some functions.
> > 
> > Best regards,
> > 
> > Enric Balletbo i Serra (3):
> >   iio: cros_ec_sensors_core: Add common functions for the ChromeOS EC
> >     Sensor Hub.
> >   iio: cros_ec_sensors: add ChromeOS EC Contiguous Sensors driver
> >   platform/chrome: cros_ec_dev - Register cros-ec sensors
> > 
> > Vincent Palatin (1):
> >   platform/chrome: Introduce a new function to check EC features.
> > 
> >  Documentation/ABI/testing/sysfs-bus-iio-cros-ec    |  18 +
> >  drivers/iio/common/Kconfig                         |   1 +
> >  drivers/iio/common/Makefile                        |   1 +
> >  drivers/iio/common/cros_ec_sensors/Kconfig         |  22 +
> >  drivers/iio/common/cros_ec_sensors/Makefile        |   6 +
> >  .../iio/common/cros_ec_sensors/cros_ec_sensors.c   | 322 +++++++++++++++
> >  .../common/cros_ec_sensors/cros_ec_sensors_core.c  | 450 +++++++++++++++++++++
> >  .../common/cros_ec_sensors/cros_ec_sensors_core.h  | 175 ++++++++
> >  drivers/platform/chrome/cros_ec_dev.c              | 159 ++++++++
> >  include/linux/mfd/cros_ec.h                        |  10 +
> >  include/linux/mfd/cros_ec_commands.h               | 183 ++++++++-
> >  11 files changed, 1342 insertions(+), 5 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-cros-ec
> >  create mode 100644 drivers/iio/common/cros_ec_sensors/Kconfig
> >  create mode 100644 drivers/iio/common/cros_ec_sensors/Makefile
> >  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> >  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> >  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.h
> > 
> 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
