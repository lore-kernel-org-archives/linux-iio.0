Return-Path: <jic23@kernel.org>
Message-ID: <4FB1430D.4060005@kernel.org>
Date: Mon, 14 May 2012 18:38:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jon Brenner <jbrenner@TAOSinc.com>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 linux-iio <linux-iio@vger.kernel.org>,
 Alan Cox <alan@lxorguk.ukuu.org.uk>, samu.p.onkalo@nokia.com,
 daniel@caiaq.de, giometti@linux.it, khali@linux-fr.org,
 amit.kucheria@verdurent.com, Laxman Dewangan <ldewangan@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V1] RFC - Proposed IIO Documentation patch to add CCT
 and RGBC data
References: <1335907654.766.24.camel@jonz-ub2> <4FA0F2A7.1040003@cam.ac.uk> <4FACC464.9010404@kernel.org> <B4B07CCC7B7A084E989CF9386538EA1D013EC04D@exchsrvr.taosinc.com>
In-Reply-To: <B4B07CCC7B7A084E989CF9386538EA1D013EC04D@exchsrvr.taosinc.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 05/14/2012 05:02 PM, Jon Brenner wrote:
> In line..
>=20
> -----Original Message-----
> From: Jonathan Cameron [mailto:jic23@kernel.org]=20
> Sent: Friday, May 11, 2012 2:49 AM
> To: Jonathan Cameron
> Cc: Jon Brenner; linux-iio; Alan Cox; samu.p.onkalo@nokia.com; daniel@c=
aiaq.de; giometti@linux.it; khali@linux-fr.org; amit.kucheria@verdurent.c=
om; Laxman Dewangan; Greg Kroah-Hartman
> Subject: Re: [PATCH V1] RFC - Proposed IIO Documentation patch to add C=
CT and RGBC data
>=20
> On 5/2/2012 9:39 AM, Jonathan Cameron wrote:
>> Added cc's
>>
>> Jon, remember to wrap emails at 80 chars please!
>>> Request for Comments -
>>>
>>> Documentation patch to add Correlated Color Temperature (CCT) and=20
>>> RGBC
>>> (red/green/blue/clear) data.
>>>
>>> The addition of CCT and RGBC is afforded by utilizing a 'real channel=
'
>>> type of IIO_CCT, and 4 modifiers of IIO_MOD_LIGHT_CLEAR,=20
>>> IIO_MOD_LIGHT_RED, IIO_MOD_LIGHT_GREEN, and IIO_MOD_LIGHT_BLUE, found=
=20
>>> in types.h.
> If we were to apply this to the existing sensors, how do we distinguish=
 between 'clear' vs the visable+infrared option that is there already?
> I note below that you have distinguished this by saying it is on a colo=
ur sensor only.  That seems a little bit inconsistent given a single wide=
 band sensor might be measuring the same thing...
>=20
> I'm fine with the colour ones btw but one query below..
>>> A trivial addition to industrialio-core.c is required.
>>>
>>> in_cct0_input will return typically return the color temperature=20
>>> expressed in kelvins.
>>>
>>> IIO_MODIFIERs are respective of the associated light frequencies for=20
>>> each of the channels.
>>>
>>>
>>>
>>>
>>>
>>>
>>> Signed-off-by: Jon Brenner<jbrenner@taosinc.com>
>>> ---
>>> .../staging/iio/Documentation/sysfs-bus-iio-light | 46
>>> ++++++++++++++++++++
>>> 1 files changed, 46 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-light
>>> b/drivers/staging/iio/Documentation/sysfs-bus-iio-light
>>> index 715c74d..bd42baf 100644
>>> --- a/drivers/staging/iio/Documentation/sysfs-bus-iio-light
>>> +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-light
>>> @@ -34,6 +34,15 @@ Description:
>>> it comes back in SI units, it should also include _input else it=20
>>> should include _raw to signify it is not in SI units.
>>>
>>> +What: /sys/bus/iio/devices/device[n]/in_cct0[_input|_raw]
>>> +KernelVersion: 3.4.0
>>> +Contact: linux-iio@vger.kernel.org
>>> +Description:
>>> + This should return the correlated color temperature from the  light=
=20
>>> +sensor. If it comes back in SI units, it should also  include _input=
=20
>>> +else it should include _raw to signify it is not  in SI units.
>>> +
>>> What:=20
>>> /sys/.../device[n]/proximity_on_chip_ambient_infrared_supression
>>> KernelVersion: 2.6.37
>>> Contact: linux-iio@vger.kernel.org
>>> @@ -82,3 +91,40 @@ Contact: linux-iio@vger.kernel.org
>>> Description:
>>> This property gets/sets the table of coefficients used in calculating=
=20
>>> illuminance in lux.
>>> +
>>> +What: /sys/bus/iio/devices/device[n]/in_intensity_clear[_input|_raw]
>>> +KernelVersion: 3.4.0
>>> +Contact: linux-iio@vger.kernel.org
>>> +Description:
>>> + This property is supported by sensors that have a RGBC  sensing=20
>>> +mode. This value should be the output from a reading  and if=20
>>> +expressed in SI units, should include _input. If this  value is not=20
>>> +in SI units, then it should include _raw.
>>> +
>>> +What: /sys/bus/iio/devices/device[n]/in_intensity_red[_input|_raw]
>>> +KernelVersion: 3.4.0
>>> +Contact: linux-iio@vger.kernel.org
>>> +Description:
>>> + This property is supported by sensors that have a RGBC  sensing=20
>>> +mode. This value should be the output from a reading  and if=20
>>> +expressed in SI units, should include _input. If this  value is not=20
>>> +in SI units, then it should include _raw.
> Err. What are the SI units of intensity?
> irradiance ie. uW/sq Mil.
Fair enough. Can you add that to the description.
> =20
>>> +
>>> +What: /sys/bus/iio/devices/device[n]/in_intensity_green[_input|_raw]
>>> +KernelVersion: 3.4.0
>>> +Contact: linux-iio@vger.kernel.org
>>> +Description:
>>> + This property is supported by sensors that have a RGBC  sensing=20
>>> +mode. This value should be the output from a reading  and if=20
>>> +expressed in SI units, should include _input. If this  value is not=20
>>> +in SI units, then it should include _raw.
>>> +
>>> +What: /sys/bus/iio/devices/device[n]/in_intensity_blue[_input|_raw]
>>> +KernelVersion: 3.4.0
>>> +Contact: linux-iio@vger.kernel.org
>>> +Description:
>>> + This property is supported by sensors that have a RGBC  sensing=20
>>> +mode. This value should be the output from a reading  and if=20
>>> +expressed in SI units, should include _input. If this  value is not=20
>>> +in SI units, then it should include _raw.
>>> +
>>> --
>>> 1.7.4.1
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-iio"=20
>>> in the body of a message to majordomo@vger.kernel.org More majordomo=20
>>> info at http://vger.kernel.org/majordomo-info.html
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-iio"=20
>> in the body of a message to majordomo@vger.kernel.org More majordomo=20
>> info at http://vger.kernel.org/majordomo-info.html
>=20
> N=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BDr=EF=BF=BD=EF=BF=BDy=EF=BF=
=BD=EF=BF=BD=EF=BF=BDb=EF=BF=BDX=EF=BF=BD=EF=BF=BD=C7=A7v=EF=BF=BD^=EF=BF=
=BD)=DE=BA{.n=EF=BF=BD+=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD{=EF=BF=BD=EF=BF=
=BD*"=EF=BF=BD=EF=BF=BD^n=EF=BF=BDr=EF=BF=BD=EF=BF=BDz=EF=BF=BD=1A=EF=BF=BD=
=EF=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD&=EF=BF=BD=EF=BF=BD=1E=EF=BF=
=BDG=EF=BF=BD=EF=BF=BD=EF=BF=BDh=EF=BF=BD=03(=EF=BF=BD=E9=9A=8E=EF=BF=BD=DD=
=A2j"=EF=BF=BD=EF=BF=BD=1A=EF=BF=BD=1Bm=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=
=EF=BF=BDz=EF=BF=BD=DE=96=EF=BF=BD=EF=BF=BD=EF=BF=BDf=EF=BF=BD=EF=BF=BD=EF=
=BF=BDh=EF=BF=BD=EF=BF=BD=EF=BF=BD~=EF=BF=BDmml=3D=3D
