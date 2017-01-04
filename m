Return-Path: <SRS0=Wv9Z=YS=intel.com=hongyan.song@kernel.org>
From: "Song, Hongyan" <hongyan.song@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>
CC: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "jikos@kernel.org"
	<jikos@kernel.org>, "jic23@kernel.org" <jic23@kernel.org>, "Pandruvada,
 Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: [PATCH 1/2] iio: Add support for linear accel
Date: Wed, 4 Jan 2017 02:28:23 +0000
Message-ID: <AE3E3DFA698D6144A7445C92D1D41E2F10BDBE64@SHSMSX103.ccr.corp.intel.com>
References: <1483456430-6980-1-git-send-email-hongyan.song@intel.com>
 <alpine.DEB.2.02.1701030821450.18919@pmeerw.net>
 <AE3E3DFA698D6144A7445C92D1D41E2F10BDBD57@SHSMSX103.ccr.corp.intel.com>
 <alpine.DEB.2.02.1701030851430.18919@pmeerw.net>
 <be267c7a-9ec3-d86e-2a32-2faef3e0650f@metafoo.de>
In-Reply-To: <be267c7a-9ec3-d86e-2a32-2faef3e0650f@metafoo.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Lars & Peter,

-----Original Message-----
From: Lars-Peter Clausen [mailto:lars@metafoo.de]=20
Sent: Tuesday, January 3, 2017 5:49 PM
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>; Song, Hongyan <hongyan.song=
@intel.com>
Cc: linux-input@vger.kernel.org; linux-iio@vger.kernel.org; jikos@kernel.or=
g; jic23@kernel.org; Pandruvada, Srinivas <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH 1/2] iio: Add support for linear accel

On 01/03/2017 09:04 AM, Peter Meerwald-Stadler wrote:
> Hi,
>=20
>> 	 I checked and find that iio device name is usually named to be with un=
derline if it has more than one word, so I assigned to be " linear_accel_3d=
".
>>  I think the device property node named to be "in_linear_accel_x_raw" is=
 better than " in_linearaccel_x_raw" Just follow the former coding style.
>> "linearaccel" is only a name which specify IIO type=20
>> [IIO_LINEAR_ACCEL] I name [IIO_LINEAR_ACCEL] to be "linearaccel" just fo=
llow the history code style in " iio_chan_type_name_spec[]" which do not ha=
ve any underline.
>=20
>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_linear_accel_x_raw
>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_linear_accel_y_raw
>>> +What:		/sys/bus/iio/devices/iio:deviceX/in_linear_accel_z_raw
>>
>> I think this would be in_linearaccel_x_raw, etc.?
>=20
>>> @@ -82,6 +82,7 @@ struct bus_type iio_bus_type =3D {
>>>  	[IIO_UVINDEX] =3D "uvindex",
>>>  	[IIO_ELECTRICALCONDUCTIVITY] =3D "electricalconductivity",
>>>  	[IIO_GRAVITY]  =3D "gravity",
>>> +	[IIO_LINEAR_ACCEL] =3D "linearaccel",
>>>  };
>=20
>=20
> >linearaccel vs. linear_accel is a matter of taste, I have no=20
> >preference; nevertheless, the documentation should match what IIO=20
>> outputs

>We use underscores as the field separator in the channel name. Having a un=
derscore as part of a field adds ambiguity and makes it a lot  >
>harder to machine parse it. It's already complicated enough as it is. We s=
hould avoid adding types with underscores in them.

Thanks for your advice, I will update the patch.

BR
Song Hongyan
