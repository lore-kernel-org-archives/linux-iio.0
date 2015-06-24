Return-Path: <tiberiu.a.breana@intel.com>
From: "Breana, Tiberiu A" <tiberiu.a.breana@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Subject: RE: [PATCH] iio: light: STK3310: un-invert proximity values
Date: Wed, 24 Jun 2015 09:41:57 +0000
Message-ID: <4586F61A4A291F4DA44D32824E7C0F402216B6EA@IRSMSX109.ger.corp.intel.com>
References: <1434539393-1451-1-git-send-email-tiberiu.a.breana@intel.com>
 <55868C77.2060407@kernel.org>
In-Reply-To: <55868C77.2060407@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> -----Original Message-----=0A=
> From: Jonathan Cameron [mailto:jic23@kernel.org]=0A=
> Sent: Sunday, June 21, 2015 1:06 PM=0A=
> To: Breana, Tiberiu A; linux-iio@vger.kernel.org=0A=
> Subject: Re: [PATCH] iio: light: STK3310: un-invert proximity values=0A=
> =0A=
> On 17/06/15 12:09, Tiberiu Breana wrote:=0A=
> > In accordance with the recent ABI changes, STK3310's proximity=0A=
> > readings should be un-inversed in order to return low values for=0A=
> > far-away objects and high values for close ones.=0A=
> >=0A=
=0A=
<snip>=0A=
=0A=
> > -/*=0A=
> > - * Maximum PS values with regard to scale. Used to export the 'inverse=
'=0A=
> > - * PS value (high values for far objects, low values for near objects)=
.=0A=
> > - */=0A=
> > +=0A=
> > +/* Estimate maximum proximity values with regard to measurement=0A=
> > +scale. */=0A=
> >  static const int stk3310_ps_max[4] =3D {=0A=
> > -	STK3310_PS_MAX_VAL / 64,=0A=
> > -	STK3310_PS_MAX_VAL / 16,=0A=
> > -	STK3310_PS_MAX_VAL /  4,=0A=
> > -	STK3310_PS_MAX_VAL,=0A=
> > +	STK3310_PS_MAX_VAL / 640,=0A=
> > +	STK3310_PS_MAX_VAL / 160,=0A=
> > +	STK3310_PS_MAX_VAL /  40,=0A=
> > +	STK3310_PS_MAX_VAL /  10=0A=
> >  };=0A=
> What's this change about?  All uses of this array as present in this patc=
h have=0A=
> been removed.  It is used elsewhere for parameter sanity checking, but I=
=0A=
> can't follow why it now needs to be divided by 10.=0A=
=0A=
Indeed, these values are still used in _write_event for setting proximity i=
nterrupt=0A=
threshold values. Truth is, they should have been divided by 10 from the st=
art,=0A=
but since all values were relative to the pre-defined maximum values, it di=
dn't=0A=
really matter. I used the higher max values because the readings would=0A=
sometimes go over the expected range (when I press down on the sensor with=
=0A=
my thumb), so the proximity readings became negative. But that shouldn't ha=
ppen=0A=
in the case of a real device, as the sensor is covered by at least a screen=
 layer.=0A=
=0A=
For the default scale of 0.1 real proximity readings max out at around 6500=
,=0A=
roughly a tenth of the maximum theoretical value, as expected. Now that we'=
re=0A=
using un-inverted measurements, we can't use the same reference values as=
=0A=
before - e.g. if the real maximum value is 6500, we can't allow setting a t=
hreshold=0A=
of 30000 - it will never be reached.=0A=
If you think this change warrants a separate patch, I'll split it.=0A=
=0A=
Regards,=0A=
Tiberiu=
