Return-Path: <SRS0=WtBq=NP=redhat.com=lbiancon@kernel.org>
MIME-Version: 1.0
References: <cover.1541341926.git.lorenzo.bianconi@redhat.com>
 <20181104181223.48618c1f@archlinux> <CAJ0CqmVhpw=99YKg8fRFG83H6NcYfcRH9eZxgJh-xCrp5rXfXQ@mail.gmail.com>
 <20181104183413.66b9abf1@archlinux>
In-Reply-To: <20181104183413.66b9abf1@archlinux>
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date: Sun, 4 Nov 2018 20:07:02 +0100
Message-ID: <CAJ0CqmXYazbniu44T2YF1RZJvySHvgWd2rOQZ6gMT1UKY0bCDQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] add i2c controller support to st_lsm6dsx driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

>
> On Sun, 4 Nov 2018 19:27:42 +0100
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
>
> > >
> > > On Sun,  4 Nov 2018 15:38:59 +0100
> > > Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
> > >
> > > > Introduce i2c controller support to st_lsm6dsx driver for lsm6dso sensor.
> > > > Add register map for lis2mdl magnetometer sensor.
> > > > Add hw FIFO support to st_lsm6dsx sensorhub driver.
> > > >
> > > > Lorenzo Bianconi (7):
> > > >   iio: imu: st_lsm6dsx: introduce locked read/write utility routines
> > > >   iio: imu: st_lsm6dsx: reboot memory content after reset
> > > >   iio: imu: st_lsm6dsx: remove static from st_lsm6dsx_set_watermark
> > > >   iio: imu: st_lsm6dsx: introduce ST_LSM6DSX_ID_EXT sensor ids
> > > >   iio: imu: st_lsm6dsx: add i2c embedded controller support
> > > >   iio: imu: st_lsm6dsx: add hw FIFO support to i2c controller
> > > >   dt-bindings: iio: imu: st_lsm6dsx: add support to i2c pullup resistors
> > > >
> > > >  .../bindings/iio/imu/st_lsm6dsx.txt           |   1 +
> > > >  drivers/iio/imu/st_lsm6dsx/Makefile           |   3 +-
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h       | 167 +++-
> > > >  .../iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c    | 169 ++--
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c  | 273 +++++--
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c  | 753 ++++++++++++++++++
> > > >  .../linux/platform_data/st_sensors_pdata.h    |   2 +
> > > >  7 files changed, 1226 insertions(+), 142 deletions(-)
> > > >  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > > >
> > >
> > > Hi Lorenzo,
> > >
> > > Great to see this series.
> >
> > Hi Jonathan,
> >
> > thx a lot for the fast review :) I will fix your comments in a v2
> >
> > >
> > > It seems to have come together fairly nicely given the inherent complexity
> > > of dealing with these slave i2c controllers.   What I would like to
> > > see in this cover letter though is a brief description of what can be
> > > put behind these devices?
> > >
> > > The one thing I want to be careful of is ending up with lots of sort
> > > of replicated drivers where we have a version in each sensor hub
> > > and one for directly connected devices.  Superficially this
> > > device seems to have a very restricted I2C master so that might not
> > > be a significant problem.  What do you think?
> > > This gets particularly interesting if we think about switching in
> > > and out of pass through.  At that point this looks like an i2c offload
> > > engine (sort of) similar to the one Lars did for spi, be it a very
> > > restricted one.
> >
> > I think the main purpose of the i2c controller embedded in lsm6dso is
> > to connect a magnetometer sensor
> > to it and get in this way a 9axis device (please note this is just my opinion).
> > However we can think to connect other devices like temperature or
> > pressure sensors (I tested them in the past :)).
> > I think we will never use it as a 'general purpose' contoller, e.g. to
> >  connect an adc :)
>
> Hmm. Lets keep an eye on what gets added. If it gets silly we can revisit how
> to handle things.  Particularly if we get things that can't be so easily
> probed.  Of course, we may find no one ever adds anything else and that
> would be fine :)
>

Do you have something to point out?
Maybe a future improvement can be a more general way to pass
slave register map. What do you think?

Regards,
Lorenzo

> Jonathan
> >
> > Regards,
> > Lorenzo
> >
> > >
> > > Jonathan
>
