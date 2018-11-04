Return-Path: <SRS0=WtBq=NP=redhat.com=lbiancon@kernel.org>
MIME-Version: 1.0
References: <cover.1541341926.git.lorenzo.bianconi@redhat.com>
 <71f6b6a308a74c863926a9de28cf51d42d26b859.1541341926.git.lorenzo.bianconi@redhat.com>
 <20181104171250.2279744a@archlinux>
In-Reply-To: <20181104171250.2279744a@archlinux>
From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date: Sun, 4 Nov 2018 18:30:07 +0100
Message-ID: <CAJ0CqmVi+iHhHDPuTYJvFJth=nBo6=quuHm6FQNxr369+c6QOw@mail.gmail.com>
Subject: Re: [PATCH 2/7] iio: imu: st_lsm6dsx: reboot memory content after reset
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

>
> On Sun,  4 Nov 2018 15:39:01 +0100
> Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
>
> > Perform a memory content reboot after device reset
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index c8b993bea757..e3ebd04d8078 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -56,6 +56,7 @@
> >  #define ST_LSM6DSX_REG_WHOAMI_ADDR           0x0f
> >  #define ST_LSM6DSX_REG_RESET_ADDR            0x12
> >  #define ST_LSM6DSX_REG_RESET_MASK            BIT(0)
> > +#define ST_LSM6DSX_REG_BOOT_MASK             BIT(7)
> >  #define ST_LSM6DSX_REG_BDU_ADDR                      0x12
> >  #define ST_LSM6DSX_REG_BDU_MASK                      BIT(6)
> >  #define ST_LSM6DSX_REG_INT2_ON_INT1_ADDR     0x13
> > @@ -778,12 +779,21 @@ static int st_lsm6dsx_init_device(struct st_lsm6dsx_hw *hw)
> >       u8 drdy_int_reg;
> >       int err;
> >
> > -     err = regmap_write(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
> > -                        ST_LSM6DSX_REG_RESET_MASK);
> > +     err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
> > +                              ST_LSM6DSX_REG_RESET_MASK,
> > +                              FIELD_PREP(ST_LSM6DSX_REG_RESET_MASK, 1));
> >       if (err < 0)
> >               return err;
> >
> > -     msleep(200);
> > +     msleep(50);
> > +
> > +     err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_RESET_ADDR,
> > +                              ST_LSM6DSX_REG_BOOT_MASK,
> > +                              FIELD_PREP(ST_LSM6DSX_REG_BOOT_MASK, 1));
> > +     if (err < 0)
> > +             return err;
> > +
> > +     msleep(50);
> This change in the timing needs an explanatory comment in the patch
> description.
>
>
> >
> >       /* enable Block Data Update */
> >       err = regmap_update_bits(hw->regmap, ST_LSM6DSX_REG_BDU_ADDR,
>

Hi Jonathan,

This patch reloads the trimming parameters to perform a complete reset
of the device. Full explanation can be read here:
https://www.st.com/resource/en/application_note/dm00517282.pdf, section 5.7.
I will add a proper description in v2, thx

Regards,
Lorenzo
