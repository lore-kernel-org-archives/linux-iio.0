Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:46626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbeHRT7J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Aug 2018 15:59:09 -0400
Date: Sat, 18 Aug 2018 17:50:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Himanshu Jha <himanshujha199640@gmail.com>
Cc: David Frey <dpfrey@gmail.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@gmail.com>,
        matt.ranostay@konsulko.com
Subject: Re: Buffert trigger and Power management support for BME680 ?
Message-ID: <20180818175044.16820c0f@archlinux>
In-Reply-To: <20180804143619.GA663@himanshu-Vostro-3559>
References: <20180730121241.GA4362@himanshu-Vostro-3559>
        <20180730140746.0000337a@huawei.com>
        <5b6c4b53-7141-93a5-b307-b7d91f8bea7f@gmail.com>
        <20180804143619.GA663@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 4 Aug 2018 20:06:20 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> On Fri, Aug 03, 2018 at 09:14:27AM -0700, David Frey wrote:
> > On 7/30/2018 6:07 AM, Jonathan Cameron wrote: =20
> > > On Mon, 30 Jul 2018 17:42:41 +0530
> > > Himanshu Jha <himanshujha199640@gmail.com> wrote:
> > >  =20
> > > > Hi,
> > > >=20
> > > > The initial minimal driver has been recently merged[1] and irrespec=
tive
> > > > of the ending week of Google Summer of Code'18, I would like to ext=
end this
> > > > driver and work on it.
> > > >=20
> > > > I have a few queries for the community:
> > > >=20
> > > > 1. Buffered Trigger Support:
> > > > ----------------------------
> > > >=20
> > > > Is it worth to add buffer support for this device ?
> > > > The device has 1Hz Forced mode which we need to enable everytime
> > > > we need a reading.
> > > >=20
> > > > Bosch provides[1] BSEC: Bosch Software Environmental Cluster binari=
es for
> > > > different platforms, and the software has various modes:
> > > >=20
> > > > 	* Ultra-low power mode.
> > > > 	* Ultra-low power mode.
> > > > 	* Continuous mode.
> > > >=20
> > > > According to datasheet "1.2 Gas sensor specification"
> > > >=20
> > > > Response time		Continuous mode		0.75s
> > > >=20
> > > > Now, these details are worth noting and confusing at the same to me!
> > > > Since, we only have 1Hz mode, so would it be a problem when adding =
this
> > > > interface to get continuous measurements ?
> > > > What other factors/caveats should I look for before proceeding furt=
her ? =20
> > >=20
> > > Technically there is no problem with adding buffered mode, but there =
may
> > > be no real usecases at these very low rates.
> > >=20
> > > The main convenience is that you could read out the various channels =
in one
> > > pass (I think - haven't checked the datasheet). =20
> >=20
> > I think that buffered mode is essential because it will allow TPHG to be
> > done all at once.  If you measure TPHG with the current driver, you are
> > doing 4 measurements.  This is bad because it takes longer, uses more p=
ower,
> > the values all have slightly different timestamps. =20
>=20
> Agreed! The buffer mode can be thought of as while(1) {} of what Bosch do=
es
> in their userspace driver. But we need remember that every time we need to
> set FORCED mode to trigger measurement. And due to this discussion I was
> temped to download BSEC and look upon the code. Seems like we have a lot
> interesting things buried there unlike datasheet.
>=20
> For instance:
>=20
> At example/bsec_integration.c
>=20
> <snip>
>     /* When the measurement is completed and data is ready for reading, t=
he sensor must be in BME680_SLEEP_MODE.
>      * Read operation mode to check whether measurement is completely don=
e and wait until the sensor is no more
>      * in BME680_FORCED_MODE. */
>     while (bme680_g.power_mode =3D=3D BME680_FORCED_MODE)
>     {
>         /* sleep for 5 ms */
>         sleep(5);
>         bme680_status =3D bme680_get_sensor_mode(&bme680_g);
>     }
> </snip>
>=20
> And many more interesting stuff...
>=20
> I mean they also have:
>=20
> <snip>
>=20
> typedef	enum {
> ...  =20
>    /**
>      * @brief Sensor heat compensated humidity [%]
>      *
>      * Relative measured by BME680 which is compensated for the influence=
 of sensor (heater) in %.
>      *
>      * It converts the ::BSEC_INPUT_HUMIDITY from temperature ::BSEC_INPU=
T_TEMPERATURE to temperature
>      * ::BSEC_OUTPUT_SENSOR_HEAT_COMPENSATED_TEMPERATURE.
>      *
>      * @note IAQ solution: If ::BSEC_INPUT_HEATSOURCE is used for device =
specific temperature compensation, it will be
>      * effective for ::BSEC_OUTPUT_SENSOR_HEAT_COMPENSATED_HUMIDITY too.
>      */
>     BSEC_OUTPUT_SENSOR_HEAT_COMPENSATED_HUMIDITY =3D 15,
> ...
> } bsec_virtual_sensor_t;
>=20
> </snip>
>=20
> Their design for high precision readings is just flawless!
>=20
> I need some time to get ideas so as to start with buffer support.
>=20
> But what kind of buffer support should be used ?
> sysfs trigger using scan_elements ?
>=20
> There are no interrupt supported by the sensor! And I don't know
> how hrtimer would work.

Is it possible to poll for new data?  I.e. is there an explicit
way of telling you are looking at a complete set of different data
from what you got on the previous reading?

It is unusual, but we do have a few other drivers where this is
necessary and some interesting dances to ensure they lock as closely
as possible with the actual sampling frequencies.

>=20
> Another question arises, say for eg., we use sysfs trigger and buffer
> capture comes in action:
>=20
> * Would I enable FORCED mode everytime in the trigger interrupt handler ?
> * Also check for config setting(such as oversampling) and set
>   them accordingly in the interrupt handler ?
>=20
> If no, then other suggestion ?
> If yes, isn't that bad to do all that in "bottom half" ?

The bottom half in this case is an interrupt thread so you can do what
ever you like in it.

>=20
> I thought of preenable, but it works only 'once' prior to enabling but
> we need to set mode every time!

Sounds like that might be necessary. I haven't read the datasheet
for a while and as you say it isn't always that informative!

>=20
> > > > 2. Power Management:
> > > > -------------------
> > > >=20
> > > > 3.1 Sensor modes
> > > >=20
> > > > 	Forced mode:
> > > > 		* Single TPHG cycle is performed
> > > > 		* Sensor *automatically* returns to sleep mode afterwards
> > > > 		* Gas sensor heater only operates during gas measurement
> > > > 	Sleep mode:
> > > > 		* No measurements are performed
> > > > 		* Minimal power consumption
> > > >=20
> > > > So, in my opinion this device is already power managed.
> > > > Comments ? =20
> > >=20
> > > It seems like there is little purpose in sleep mode, are there power
> > > numbers to indicate what 'minimal' means here? =20
> >=20
> > From the datasheet on page 3:
> >   Current consumption
> >     2.1 =CE=BCA at 1 Hz humidity and temperature
> >     3.1 =CE=BCA at 1 Hz pressure and temperature
> >     3.7 =CE=BCA at 1 Hz humidity, pressure and temperature
> >     0.09=E2=80=9212 mA for p/h/T/gas depending on operation mode
> >     0.15 =CE=BCA in sleep mode
> >=20
> > My interpretation of this is that you will consume 2.1 =CE=BCA on avera=
ge if you
> > are reading the humidity and temperature once per second.  The datasheet
> > goes into some more detail in Table 2 on page 8 where it describes the
> > average supply current of the gas sensor as follows:
> >   Ultra-low power mode 0.09 ma with response time of 92 s
> >   Low power mode 0.9 mA with a response time of 1.4 s
> >   Continuous mode 12 mA with a response time of 0.75 s
> >=20
> > I don't think there are actually different modes at all.  I believe what
> > they call modes are just different settings corresponding to enum value=
s in
> > the BSEC library.  Maybe I'm wrong though.  Please correct me if you se=
e any
> > evidence of explicit mode settings.  I'm also skeptical of the current
> > consumption numbers.  It seems weird to me that continuous mode consume=
s >
> > 10x the current of low power mode and only produces roughly twice as ma=
ny
> > readings. =20
>=20
> Yes, corrcect! Please don't get confused between only two modes of sensor
> and "modes of BSEC". BSEC is different story ...
>=20
> BSEC =3D Userspace Bosch driver API + IAQ alogithms + very smart subrouti=
nes ;)
>=20
> > It's nice to see this driver progressing.  Keep up the good work! =20
>=20
> Thanks! Would need your help with its development.
>=20

Indeed good to see this continue to move forwards.

Jonathan
