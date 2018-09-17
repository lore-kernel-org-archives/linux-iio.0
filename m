Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43000 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbeIQNEt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 Sep 2018 09:04:49 -0400
Date: Mon, 17 Sep 2018 15:38:29 +0800
From: Song Qiang <songqiang1304521@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com,
        andriy.shevchenko@linux.intel.com, matt.ranostay@konsulko.com,
        tglx@linutronix.de, ak@it-klinger.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        himanshujha199640@gmail.com
Subject: Re: [PATCH v5] iio: proximity: Add driver support for ST's VL53L0X
 ToF ranging sensor.
Message-ID: <20180917073829.GA25896@Eros>
References: <20180915095752.8116-1-songqiang.1304521@gmail.com>
 <20180917061933.GA15262@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180917061933.GA15262@bogus>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Sep 17, 2018 at 02:19:33AM -0400, Rob Herring wrote:
> On Sat, Sep 15, 2018 at 05:57:52PM +0800, Song Qiang wrote:
> > This driver was originally written by ST in 2016 as a misc input device
> > driver, and hasn't been maintained for a long time. I grabbed some code
> > from it's API and reformed it into an iio proximity device driver.
> > This version of driver uses i2c bus to talk to the sensor and
> > polling for measuring completes, so no irq line is needed.
> > This version of driver supports only one-shot mode, and it can be
> > tested with reading from
> > /sys/bus/iio/devices/iio:deviceX/in_distance_raw
> > 
> > Signed-off-by: Song Qiang <songqiang.1304521@gmail.com>
> 
> checkpatch.pl complains that the author and signoff emails don't match. 
> I think gmail ignores '.' in email names, but better to be consistent 
> IMO.
> 

Hi Rob,

This isn't the first time I've seen this '.' issue, but in most case it
was fine. 
The thing interesting is after I saw your email, I tried to access my
account with songqiang1304521@gmail.com(just without '.'), and it
succeeded! So maybe google just removed the '.' in my account everytime
I logged in. I think I'll send next version of my patch with my email
account without '.'.

yours,
Song Qiang

> > ---
> > Changes in v5:
> > 	- Correct some spell problems.
> > 	- Change tries-- to --tries to fix the count error.
> > 	- Add MODULE_DEVICE_TABLE().
> > 	- Add some comments.
> > 
> > Changes in v4:
> > 	- Add datasheet link, default i2c address and TODO list.
> > 	- Make capitalization of defines consistent.
> > 	- Replace i2c_transfer() with i2c_smbus_read_i2c_block_data().
> > 	- Remove IIO_CHAN_SOFT_TIMESTAMP() since no buffer/trigger
> > 	  support.
> > 	- Add information to MAINTAINERS.
> > 
> > Changes in v3:
> > 	- Recover ST's copyright.
> > 	- Clean up indio_dev member in vl53l0x_data struct since it's
> > 	  useless now.
> > 	- Replace __le16_to_cpu() with le16_to_cpu().
> > 	- Remove the iio_device_{claim|release}_direct_mode() since it's
> > 	  only needed when we use buffered mode.
> > 	- Clean up some coding style problems.
> > 
> > Changes in v2:
> > 	- Clean up the register table.
> > 	- Sort header files declarations.
> > 	- Replace some bit definations with GENMASK() and BIT().
> > 	- Clean up some code and comments that's useless for now.
> > 	- Change the order of some the definations of some variables to reversed
> > 	  xmas tree order.
> > 	- Using do...while() rather while and check.
> > 	- Replace pr_err() with dev_err().
> > 	- Remove device id declaration since we recommend to use DT.
> > 	- Remove .owner = THIS_MODULE.
> > 	- Replace probe() with probe_new() hook.
> > 	- Remove IIO_BUFFER and IIO_TRIGGERED_BUFFER dependences.
> > 	- Change the driver module name to vl53l0x-i2c.
> > 	- Align all the parameters if they are in the same function with open
> > 	  parentheses.
> > 	- Replace iio_device_register() with devm_iio_device_register
> > 	  for better resource management.
> > 	- Remove the vl53l0x_remove() since it's not needed.
> > 	- Remove dev_set_drvdata() since it's already setted above.
> > 
> >  .../bindings/iio/proximity/vl53l0x.txt        |  12 ++
> >  MAINTAINERS                                   |   7 +
> 
> Otherwise,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
> >  drivers/iio/proximity/Kconfig                 |  11 ++
> >  drivers/iio/proximity/Makefile                |   2 +
> >  drivers/iio/proximity/vl53l0x-i2c.c           | 180 ++++++++++++++++++
> >  5 files changed, 212 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/proximity/vl53l0x.txt
> >  create mode 100644 drivers/iio/proximity/vl53l0x-i2c.c
