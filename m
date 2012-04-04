Return-Path: <jic23@cam.ac.uk>
References: <B4B07CCC7B7A084E989CF9386538EA1D0120B3B3@exchsrvr.taosinc.com> <4F7C08C3.7090603@cam.ac.uk> <B4B07CCC7B7A084E989CF9386538EA1D0120B931@exchsrvr.taosinc.com>
In-Reply-To: <B4B07CCC7B7A084E989CF9386538EA1D0120B931@exchsrvr.taosinc.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: RE: Proposed addition to 'IIO interface' for color light sensing devices
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Wed, 04 Apr 2012 17:17:04 +0100
To: Jon Brenner <jbrenner@TAOSinc.com>,Jon Brenner <jbrenner@TAOSinc.com>
CC: jic23@kernel.org,gregkh@linuxfoundation.org,linux-iio@vger.kernel.org,linux-kernel@vger.kernel.org,jic23@kernel.org,gregkh@linuxfoundation.org,linux-iio@vger.kernel.org,linux-kernel@vger.kernel.org
Message-ID: <dc98342b-23cd-49c3-8615-e867a148121b@email.android.com>
List-ID: <linux-iio@vger.kernel.org>



Jon Brenner <jbrenner@TAOSinc.com> wrote:

>Replies in-line,
>
>
>> -----=
Original Message-----
>> From: Jonathan Cameron [mailto:jic23@cam.ac.uk]
>>=
 Sent: Wednesday, April 04, 2012 3:40 AM
>> To: Jon Brenner
>> Cc: jic23@ke=
rnel.org; gregkh@linuxfoundation.org;
>linux-iio@vger.kernel.org;
>> linux-=
kernel@vger.kernel.org
>> Subject: Re: Proposed addition to 'IIO interface'=
 for color light
>sensing devices
>> 
>> Not sure who else would be interes=
ted in this discussion so if anyone
>can cc any
>> interested parties that =
would be great! (
>> > I would like to propose the following addition to th=
e 'IIO device
>> > interface' for color light sensing devices to accommodat=
e CCT (AKA
>> > color
>> > temperature) and access to the raw RGB channel d=
ata for user
>analysis.
>> >
>> > IIO channel type name: CCT
>> >
>> > The =
CCT ABI should be documented similar to as follows:
>> > In sys-bus-iio-lig=
ht:
>> > What:		/sys/bus/iio/devices/device[n]/cct[_input|_raw]
>> > Kernel=
Version:	3.3.0
>> > Contact:	linux-iio@vger.kernel.org
>> > Description:
>>=
 > 		This should return the correlated color temperature from
>the
>> RGBC
=
>> > color sensor
>> > 		expressed as SI unit (degree kelvin).
>> > 		If it=
 comes back in SI units, it should also
>include_input else it
>> > 		shoul=
d include _raw to signify it is not in SI units.
>> Works for me though the=
 formatting of the above is somewhat different
>from
>> our current docs...=

>> >
>> > IIO modifiers:
>> > IIO_MOD_LIGHT_RED
>> > IIO_MOD_LIGHT_GREEN
>=
> > IIO_MOD_LIGHT_BLUE
>> So these modifiers apply to intensity channels?  =
 Colour temp is
>built
>from
>> multiple raw sensors I believe (like illumi=
nance is often done?)
>Hence
>it's another
>> 'virtual' channel we compute?=

>Yes.
>At channel 0 - correct?
Yup. It is the first illuminance channel.
>=

>So we now have illuminance0_input and in_cct0 - correct?
Should be in_ill=
uminance0_input and in_cct0_input
Otherwise yes.  Maybe don't skimp on char=
s and have in_colourtemp_input 
>
>Clear uses chan 0 and as before, chan 1 =
- so as before intensityN_raw
>mapped to both - correct?
Don't necessarily =
need indexes if using modifiers. We don't bother for inertial sensors... ev=
ent codes include modifiers so they are optional.  Channel can have index o=
r modifier or both...
>
>Red is channel 1 - so we have in_intensity1_red_ra=
w -  correct?
>
>Green =3D intensity2_green_raw.. and so on correct?
>> >
>=
> > The 'clear' and IR channels are already covered by the use of
>> > IIO_=
LIGHT and IIO ILLUMINANCE (and respective modifiers).
>> > The RGB modifier=
s will help to express the relative frequencies to
>> > their respective ch=
annel, and appear to fit well with the overall
>convention.
>> >
>> > And l=
ast but not least, the textual modifier names "red", "green",
>and
>> > "bl=
ue" be accommodated within 'industrialio-core'.
>> Fine with me.
>> 
>
>Pro=
ximity remains at channel 0 correct?
Yes
>
>
>> >
>> > Channel specific int=
errupt event / sources are not presented at
>this
>> > time.
>> >
>> > Any =
thoughts or comments are welcomed.
>> >
>> > Jon Brenner
>> >
>> > --
>> > =
To unsubscribe from this list: send the line "unsubscribe
>linux-iio"
>> > =
in the body of a message to majordomo@vger.kernel.org More
>majordomo
>> > =
info at  http://vger.kernel.org/majordomo-info.html
>
>--
>To unsubscribe f=
rom this list: send the line "unsubscribe linux-iio" in
>the body of a mess=
age to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kerne=
l.org/majordomo-info.html

-- 
Sent from my Android phone with K-9 Mail. Pl=
ease excuse my brevity.
