Return-Path: <SRS0=ynxh=KS=pmeerw.net=pmeerw@kernel.org>
Date: Fri, 3 Aug 2018 13:38:17 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Parthiban Nallathambi <pn@denx.de>
cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de, robh+dt@kernel.org,
    linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
    mark.rutland@arm.com, devicetree@vger.kernel.org, matthias.bgg@gmail.com,
    wd@denx.de, sbabic@denx.de, hs@denx.de
Subject: Re: [PATCH v4 1/3] iio: Add modifier for white light
In-Reply-To: <fb30878f-0163-306a-e933-d9fecc996acb@denx.de>
Message-ID: <alpine.DEB.2.21.1808031323150.13492@vps.pmeerw.net>
References: <20180802182729.2061830-1-pn@denx.de> <alpine.DEB.2.21.1808022117460.25216@vps.pmeerw.net> <fb30878f-0163-306a-e933-d9fecc996acb@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>

Hello,

> > it is not clear to me why 'white' is needed;
> > isn't that the default, i.e. unfiltered light?
> 
> Yes, it is. But devices like vcnl4035 veml7700, White LED data one
> register and all other sources of light (like fluorescent,
> incandescent ,sunlight) in separate register.
> 
> So in such cases this WHITE modifier is needed. Should it needs to
> come under IIO_MOD_LIGHT_CLEAR?

it is a mess already :), there is 
_intensity
_intensity_ir
_intensity_both
_intensity_uv
_intensity_red
_intensity_green
_intensity_blue
_intensity_clear

I think that ir, uv, red, green, blue are filters for particular ranges 
of the spectrum

_intensity_clear might be unfiltered and _intensity might relate to the 
human eye photopic curve, I think the proposed white might be the same as 
clear?

'both' means ir + _intensity (not clearly specified)

regards, p.

> > > +KernelVersion:	4.18
> > > +Contact:	linux-iio@vger.kernel.org
> > > +Description:
> > > +		Modifier white indicates that measurements contain white LED
> > > +		component.
> > > +
> > >   What:		/sys/.../iio:deviceX/in_intensity_red_integration_time
> > >   What:
> > > /sys/.../iio:deviceX/in_intensity_green_integration_time
> > >   What:
> > > /sys/.../iio:deviceX/in_intensity_blue_integration_time
> > > diff --git a/drivers/iio/industrialio-core.c
> > > b/drivers/iio/industrialio-core.c
> > > index 19bdf3d2962a..cb939b9fad16 100644
> > > --- a/drivers/iio/industrialio-core.c
> > > +++ b/drivers/iio/industrialio-core.c
> > > @@ -108,6 +108,7 @@ static const char * const iio_modifier_names[] = {
> > >   	[IIO_MOD_LIGHT_GREEN] = "green",
> > >   	[IIO_MOD_LIGHT_BLUE] = "blue",
> > >   	[IIO_MOD_LIGHT_UV] = "uv",
> > > +	[IIO_MOD_LIGHT_WHITE] = "white",
> > >   	[IIO_MOD_QUATERNION] = "quaternion",
> > >   	[IIO_MOD_TEMP_AMBIENT] = "ambient",
> > >   	[IIO_MOD_TEMP_OBJECT] = "object",
> > > diff --git a/include/uapi/linux/iio/types.h
> > > b/include/uapi/linux/iio/types.h
> > > index 4213cdf88e3c..de87a6c7e6de 100644
> > > --- a/include/uapi/linux/iio/types.h
> > > +++ b/include/uapi/linux/iio/types.h
> > > @@ -84,6 +84,7 @@ enum iio_modifier {
> > >   	IIO_MOD_CO2,
> > >   	IIO_MOD_VOC,
> > >   	IIO_MOD_LIGHT_UV,
> > > +	IIO_MOD_LIGHT_WHITE,
> > >   };
> > >     enum iio_event_type {
> > > diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> > > index b61245e1181d..a2f9c62a79dd 100644
> > > --- a/tools/iio/iio_event_monitor.c
> > > +++ b/tools/iio/iio_event_monitor.c
> > > @@ -96,6 +96,7 @@ static const char * const iio_modifier_names[] = {
> > >   	[IIO_MOD_LIGHT_GREEN] = "green",
> > >   	[IIO_MOD_LIGHT_BLUE] = "blue",
> > >   	[IIO_MOD_LIGHT_UV] = "uv",
> > > +	[IIO_MOD_LIGHT_WHITE] = "white",
> > >   	[IIO_MOD_QUATERNION] = "quaternion",
> > >   	[IIO_MOD_TEMP_AMBIENT] = "ambient",
> > >   	[IIO_MOD_TEMP_OBJECT] = "object",
> > > @@ -178,6 +179,7 @@ static bool event_is_known(struct iio_event_data
> > > *event)
> > >   	case IIO_MOD_LIGHT_GREEN:
> > >   	case IIO_MOD_LIGHT_BLUE:
> > >   	case IIO_MOD_LIGHT_UV:
> > > +	case IIO_MOD_LIGHT_WHITE:
> > >   	case IIO_MOD_QUATERNION:
> > >   	case IIO_MOD_TEMP_AMBIENT:
> > >   	case IIO_MOD_TEMP_OBJECT:
> > > 
> > 
> 
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
