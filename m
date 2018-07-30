Return-Path: <SRS0=z2T3=KO=huawei.com=jonathan.cameron@kernel.org>
Date: Mon, 30 Jul 2018 14:07:46 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Himanshu Jha <himanshujha199640@gmail.com>
CC: <jic23@kernel.org>, <linux-iio@vger.kernel.org>, Daniel Baluta
	<daniel.baluta@gmail.com>, <matt.ranostay@konsulko.com>
Subject: Re: Buffert trigger and Power management support for BME680 ?
Message-ID: <20180730140746.0000337a@huawei.com>
In-Reply-To: <20180730121241.GA4362@himanshu-Vostro-3559>
References: <20180730121241.GA4362@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
List-ID: <linux-iio@vger.kernel.org>

On Mon, 30 Jul 2018 17:42:41 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Hi,
>=20
> The initial minimal driver has been recently merged[1] and irrespective
> of the ending week of Google Summer of Code'18, I would like to extend th=
is
> driver and work on it.
>=20
> I have a few queries for the community:
>=20
> 1. Buffered Trigger Support:
> ----------------------------
>=20
> Is it worth to add buffer support for this device ?
> The device has 1Hz Forced mode which we need to enable everytime
> we need a reading.
>=20
> Bosch provides[1] BSEC: Bosch Software Environmental Cluster binaries for
> different platforms, and the software has various modes:
>=20
> 	* Ultra-low power mode.
> 	* Ultra-low power mode.
> 	* Continuous mode.
>=20
> According to datasheet "1.2 Gas sensor specification"
>=20
> Response time		Continuous mode		0.75s
>=20
> Now, these details are worth noting and confusing at the same to me!
> Since, we only have 1Hz mode, so would it be a problem when adding this
> interface to get continuous measurements ?
> What other factors/caveats should I look for before proceeding further ?

Technically there is no problem with adding buffered mode, but there may
be no real usecases at these very low rates.

The main convenience is that you could read out the various channels in one
pass (I think - haven't checked the datasheet).

>=20
> 2. Power Management:
> -------------------
>=20
> 3.1 Sensor modes
>=20
> 	Forced mode:
> 		* Single TPHG cycle is performed
> 		* Sensor *automatically* returns to sleep mode afterwards
> 		* Gas sensor heater only operates during gas measurement
> 	Sleep mode:
> 		* No measurements are performed
> 		* Minimal power consumption
>=20
> So, in my opinion this device is already power managed.
> Comments ?

It seems like there is little purpose in sleep mode, are there power
numbers to indicate what 'minimal' means here?

>=20
> 3. Adding more sysfs interface:
> -------------------------------
>=20
> Currently in the driver I have supplied default values to the sensor
> at probe which are:
>=20
>         data->heater_temp =3D 320; /* degree Celsius */
>         data->heater_dur =3D 150;  /* milliseconds */
>=20
> Now, these values are:
>=20
> 1. Target heater temperature for the heater plate to be supplied for the
>    sensor. This value can be supplied by the user and value should lie
>    typically between 200 =B0C and 400 =B0C.
> 2. Target heater duration time for which heater plate would be heated
>    before initiating gas sensing measurements. Value lying between
>    200-4032ms.
>=20
> But there is a caveat!
> If the sensor doesn't get the right combination of above two values, if
> will likely abort since:
> [ comment from the current code ]
>        =20
> 	/*
>          * occurs if either the gas heating duration was insuffient
>          * to reach the target heater temperature or the target
>          * heater temperature was too high for the heater sink to
>          * reach.
>          */
>=20
> So, what should be the appropriate channel types for these two
> interfaces ?

Hmm. I guess this issue here is that the temperature rise time is
dependent on the environment (moisture / temperature etc) so we can't
do the obvious and just put in reasonable defaults (assuming the temperature
is the only controlled channel).=20

I wonder if we can get 'close' enough and retry a few times if we get
an abort?

> I had the same question on my RFC patch and Matt Ranostay suggested[2]
>=20
> 	"Just use IIO_TEMP and signal it is an output channel."
>=20
> Now, I clearly doesn't understand the rationale behind the channel type?
> And what does direction(input/output) signify ?

input is something you read, output is something that is forced.  So
in this case you are literally setting the temperature of the plate.

It's not a perfect interface for this, but it is compliant with the ABI
and reasonably obvious what it is doing to anyone who is familiar with
this sort of sensor.



>=20
> Isn't it that channel type is based on the "what measurement the channel
> is actually producing" ?
>=20
> Anyway, digging further I found that Matt had a slighlty similar situation
> in 'TI HDC100x temperature + humidity sensors' driver, where it was
> required to enable heater to drive condensation off the sensor. And Matt
> used:
>=20
>                 .type =3D IIO_CURRENT,
>                 .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),
>                 .extend_name =3D "heater",
>                 .output =3D 1,
>                 .scan_index =3D -1,
>=20
> IIO_CURRENT ? And .output =3D 1, ? Please shed some insight on this.
> And why was extended_name necessary here and creating a new ABI. We
> already had an ABI to handle such situation:

In this case it is a rather more stupid device and all you control is
the current output that feeds the heater.

>=20
> Documentation/ABI/testing/sysfs-bus-iio
>=20
> What:           /sys/bus/iio/devices/iio:deviceX/heater_enable
> KernelVersion:  4.1.0
> Contact:        linux-iio@vger.kernel.org
> Description:
>                 '1' (enable) or '0' (disable) specifying the enable
>                 of heater function. Same reading values apply
>                 This ABI is especially applicable for humidity sensors
>                 to heatup the device and get rid of any condensation
>                 in some humidity environment
>=20
> Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x
>=20
> What:           /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw
> What:           /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_a=
vailable
> KernelVersion:  4.3=20
> Contact:        linux-iio@vger.kernel.org
> Description:
>                 Controls the heater device within the humidity sensor to =
get=20
>                 rid of excess condensation.
>=20
>                 Valid control values are 0 =3D OFF, and 1 =3D ON.=20
>=20
> Was this necessary ?

That does seem like somewhat of a mess.  We shouldn't have ended up with bo=
th
ABIs, but now we are stuck with them.

> Just curious about these information. It will help me decide how should
> I proceed further.

The heater enable doesn't make sense here as you have a range of values
rather than a boolean.  Hence the second one would be valid if you were con=
trolling
the current.  As it is a target temperature, it'll need to be a temperature
channel with more docs added to explain what it is.

>=20
> 4. Algorith behind Compensation functions:
> ------------------------------------------
>=20
> Jonathan suggested[3] to reverse engineer the compensation function and
> document the equation/algorithm.
>=20
> But the compensation are really complex calculations, and I will try to
> decipher if possible.

This is more for interest of anyone coming along later than anything else ;)

>=20
> As a better solution, I contacted Bosch Sensortec again for the
> algorithm and let's hope they reply back soon. I don't have a direct
> contact to Bosch developers but to someone at their office. So, it takes
> a while to get constructive feedback.

That would be great if they'll provide the info!  Maybe we can even
persuade them to put it in an updated data sheet or an app note or similar!
>=20
>=20
> Thanks Jonathan, Daniel, Matt, Andy, David and all the reviewers. It was
> truly a great experience and would need your patience and help for some
> more time :)

You are welcome and hope you stay around the kernel in the future!

Jonathan
>=20
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/=
?h=3Dtesting&id=3D1b3bd8592780c87c5eddabbe98666b086bbaee36
> [2] https://marc.info/?l=3Dlinux-iio&m=3D152968608230844&w=3D2
> [3] https://marc.info/?l=3Dlinux-iio&m=3D153277443604044&w=3D2
