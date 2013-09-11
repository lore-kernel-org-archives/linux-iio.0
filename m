Return-Path: <lee.jones@linaro.org>
Date: Wed, 11 Sep 2013 08:10:53 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk, arnd@arndb.de, linus.walleij@linaro.org,
	denis.ciocca@st.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 27/38] iio: pressure-core: st: Give some indication if
 device probing was successful
Message-ID: <20130911071053.GD11227@lee--X1>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-28-git-send-email-lee.jones@linaro.org>
 <43055af7-991f-4122-b308-a3dcddbbb72a@email.android.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <43055af7-991f-4122-b308-a3dcddbbb72a@email.android.com>
List-ID: <linux-iio@vger.kernel.org>

On Tue, 10 Sep 2013, Jonathan Cameron wrote:
> Lee Jones <lee.jones@linaro.org> wrote:
> >At the moment the driver is silent in some error cases and if
> >successful.
> >Prior to this patch there was no clear way to know if the driver
> >succeeded
> >or not without looking deep into sysfs.
> >
> >Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >---
> > drivers/iio/pressure/st_pressure_core.c | 3 +++
> > 1 file changed, 3 insertions(+)
> >
> >diff --git a/drivers/iio/pressure/st_pressure_core.c
> >b/drivers/iio/pressure/st_pressure_core.c
> >index 6ffd949..34b3fb1 100644
> >--- a/drivers/iio/pressure/st_pressure_core.c
> >+++ b/drivers/iio/pressure/st_pressure_core.c
> >@@ -280,6 +280,9 @@ int st_press_common_probe(struct iio_dev
> >*indio_dev,
> > 	if (err && irq > 0)
> > 		goto st_press_device_register_error;
> > 
> >+	if (!err)
> >+		dev_info(&indio_dev->dev, "Successfully registered\n");
> >+
> Not keen. That to my mind is pointless noise.

I think it needs to be somewhere. IIO provides no indication whether
these chips are probed/registered/whathaveyou, or even if the
subsystem is in use. 

One line per hardware component is not noise, IMO it's indicative of
key functionality which is now available:

Bootlog:
<snip>
iio iio: lsm303dlh_accel: Successfully registered
iio iio: l3g4200d_gyro: Successfully registered
iio iio: lps001wp_press: Successfully registered
iio iio: lsm303dlhc_magn: Successfully registered
<snip>

> If this made sense then it would be in the driver core not here.

Also fine. Just anything but silence/NULL reporting.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
