Return-Path: <SRS0=ZYyO=GG=gmail.com=john3909@kernel.org>
From: John Syne <john3909@gmail.com>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: [rfc] staging:iio:meter: IIO ABI issues
Message-Id: <6BD44826-5F90-4377-8C15-230ED4014B27@gmail.com>
Date: Thu, 15 Mar 2018 21:00:11 -0700
Cc: Jonathan Cameron <jic23@kernel.org>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com
To: linux-iio@vger.kernel.org
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

Since this is probably doing to require a few rounds, I have created a =
new thread for this issue.

I have been looking at the IIO ABI docs and if I understand correctly, =
the idea is to use consistent naming conventions? So for example, =
looking at the ADE7854 datasheet, the naming matching the ADE7854 =
registers would be as follows:

{direction}_{type}_{index}_{modifier}_{info_mask}

AIGAIN	-	In_current_a_gain
AVGAIN	-	in_voltage_a_gain
BIGAIN	-	in_current_b_gain
BVGAIN	-	in_voltage_b_gain
=E2=80=94
How do we represent the rms and offset
AIRMSOS	-	in_current_a_rmsoffset
AVRMSOS	-	in_voltage_a_rmsoffset
=E2=80=94
Here I don=E2=80=99t understand how to represent both the phase and the =
active/reactive/apparent power components. Do we combine the phase and =
quadrature part like this
AVAGAIN		-	in_power_a_gain				/* =
apparent power */
=E2=80=94
AWGAIN		-	in_power_ai_gain				=
/* active power */
=E2=80=94
AVARGAIN	-	in_power_aq_gain				=
/* reactive power */
=E2=80=94
Now here it becomes more complicated. Not sure how this gets handled.=20
AFWATTOS	-	in_power_a_active/fundamental/offset
=E2=80=94
AWATTHR	-	in_energy_ai_accumulation
=E2=80=94


Thinking about this a little more, perhaps only the attributes that =
would be used in a user space app need to be this descriptive. Let me =
explain. Most of the registers on the ADE7878 and even more so on the =
ADE9000, would have nothing to do with the user space app. Most of these =
registers are used purely for configuration, settings and calibration.

For these registers, maybe we should use the register name as the =
modifier. For example:

AIGAIN	-	register_AIGAIN

For measurement registers, we adhere to the traditional naming =
convention:

AIRMS		-	in_current_a_rms
AVRMS		-	in_voltage_a_rms
AWATTHR	-	in_energy_a
AFWATTHR	-	in_energy_a_fundamental
AVARHR		-	in_energy_aq				/* I =
still have a problem with this one */
AFVARHR	-	in_energy_aq_fundamental	/* See the problem here? =
*/
AIMAV		-	in_current_a_mean-abolute-value	/* I=E2=80=99m =
having a difficult time trying to make this work */

When I look at the ADE9000, the functionality is even more complex, so =
I=E2=80=99m hoping everyone can offer suggestions on how to resolve =
this.

Regards,
John


AVARHR		-	in_energy_aq_accumulation
=E2=80=94
IPEAK		-	in_current_peak
=E2=80=94

I=E2=80=99ll leave it there, because there are some even more =
complicated register naming issues.

Regards,
John


Regards,
John
