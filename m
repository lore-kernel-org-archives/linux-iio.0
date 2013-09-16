Return-Path: <lee.jones@linaro.org>
Date: Mon, 16 Sep 2013 08:31:51 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	jic23@cam.ac.uk, arnd@arndb.de, linus.walleij@linaro.org,
	denis.ciocca@st.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH 38/38] iio: magn-core: st: Provide support for the
 LSM303DLH
Message-ID: <20130916073151.GB3999@lee--X1>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-39-git-send-email-lee.jones@linaro.org>
 <5234A28D.1030409@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <5234A28D.1030409@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

On Sat, 14 Sep 2013, Jonathan Cameron wrote:

> On 09/10/13 13:49, Lee Jones wrote:
> > Trivial patch adding the LSM303DLH to the list of already supported
> > Magnetometer Sensors.
> > 
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> err.

?

> > index 12e7e79..b2e2917 100644
> > --- a/drivers/iio/magnetometer/st_magn_core.c
> > +++ b/drivers/iio/magnetometer/st_magn_core.c
> > @@ -151,7 +151,8 @@ static const struct st_sensors st_magn_sensors[] = {
> >  		.wai = ST_MAGN_1_WAI_EXP,
> >  		.sensors_supported = {
> >  			[0] = LSM303DLHC_MAGN_DEV_NAME,
> > -			[1] = LSM303DLM_MAGN_DEV_NAME,
> > +			[1] = LSM303DLH_MAGN_DEV_NAME,
> > +			[0] = LSM303DLM_MAGN_DEV_NAME,
> [2]?

Yes, good spot, thanks.

> >  		},
> >  		.ch = (struct iio_chan_spec *)st_magn_16bit_channels,
> >  		.odr = {
> > 

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
