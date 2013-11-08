Return-Path: <maggie.mae.roxas@gmail.com>
MIME-Version: 1.0
Date: Fri, 8 Nov 2013 15:21:53 +0800
Message-ID: <CAB8gEUuASCcNpqLVWoTG4LdcyZjZjbR3yGitvF1-op_H3GtQcg@mail.gmail.com>
Subject: How can I successfully port/use STMicroelectronics sensors' drivers
 available at drivers/iio/ from Linux Kernel v3.12 to Linux Kernel v3.0?
From: Maggie Mae Roxas <maggie.mae.roxas@gmail.com>
To: denis.ciocca@st.com, matteo.dameno@st.com
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org
Content-Type: multipart/alternative; boundary=047d7b3a7fca96c98b04eaa53c79
List-ID: <linux-iio@vger.kernel.org>

--047d7b3a7fca96c98b04eaa53c79
Content-Type: text/plain; charset=ISO-8859-1

Hi Denis, Matteo.
Good afternoon.

*[Background]*

I am currently developing a board with TI OMAP4470 SoC.
I am planning to use the following sensor modules:
    - STMicroelectronics LSM303D Accelerometer/Magnetometer (via I2C)
    - STMicroelectronics L3GD20 Gyroscope (via SPI)
    - STMicroelectronics LPS331AP Pressure (via SPI)

However, I found out that the drivers for these 3 modules were only
available in newer kernels (I checked v3.12).
# I am currently using Linux Kernel v3.0.31.

I tried to do a quick port by doing the following:
    - Copied drivers/iio to drivers/
    - Copied include/linux/iio to include/linux
    - Updated drivers/Kconfig and added "source drivers/iio/Kconfig"
    - Updated drivers/Makefile and added "obj-$(CONFIG_IIO)
+= iio/"
    - Enabled the following via menuconfig:
    <*> Device Drivers -> Industrial I/O support (CONFIG_IIO)
    <*> Device Drivers -> Industrial I/O support -> Accelerometers ->
STMicroelectronics accelerometers 3-Axis Driver (CONFIG_IIO_ST_ACCEL_3AXIS,
for ST LSM303D)
    <*> Device Drivers -> Industrial I/O support -> Digital gyroscope
sensors -> STMicroelectronics gyroscopes 3-Axis Driver
(CONFIG_IIO_ST_GYRO_3AXIS, for ST L3GD20)
    <*> Device Drivers -> Industrial I/O support -> Magnetometer sensors ->
STMicroelectronics magnetometers 3-Axis Driver (CONFIG_IIO_ST_MAGN_3AXIS,
for ST LSM303D)
    <*> Device Drivers -> Industrial I/O support -> Pressure sensors ->
STMicroelectronics pressure sensor Driver (CONFIG_IIO_ST_PRESS, for ST
LPS331AP)

But I ran into build errors (implicit declarations) due to inconsistencies
between the two kernels' header files.
For example, there are:
    - New functions at fs/libfs.c (simple_open)
    - New functions at drivers/base/devres.c (devres_release)
    - New functions at lib/idr.c (ida_simple_remove, ida_simple_get)

*[Question]*

I would like to ask how I can successfully build the drivers for these 3
modules in the linux kernel v3.0.31 that I am using?

*[Note]*

I already checked-out www.st.com/web/en/catalog/tools for standalone
drivers.
Problem is, only the LSM303D driver via I2C (STSW-MEMS025 v1.0.5) is there.
There is a L3GD20 driver via I2C (STSW-MEMS018 v1.2.1), but I need one via
SPI - so I can't use this one.
Since I found all the needed drivers in v3.12 for these 3 modules,
supporting the exact interfaces I need - I would like to use these built-in
drivers instead and port to v3.0.31 - if possible.
I asked for assistance because I noticed that you are the drivers' author
in both the built-in kernel driver and the standalone driver for these
sensor modules (anda that you're okay to be notified). :)

Please advise.

Any help is very much appreciated. :)
Thank you in advance.

# BTW, I don't know if this question should be posted in
linux-arm-kernel@lists.infradead.org, but if you ask me to, I will.

Regards,
Maggie Roxas

--047d7b3a7fca96c98b04eaa53c79
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Denis, Matteo.<br>Good afternoon.<br><br><b>[Backg=
round]</b><br><br>I am currently developing a board with TI OMAP4470 SoC.<b=
r>I am planning to use the following sensor modules:<br>=A0=A0=A0 - STMicro=
electronics LSM303D Accelerometer/Magnetometer (via I2C)<br>
=A0=A0=A0 - STMicroelectronics L3GD20 Gyroscope (via SPI)<br>=A0=A0=A0 - ST=
Microelectronics LPS331AP Pressure (via SPI)<br><br>However, I found out th=
at the drivers for these 3 modules were only available in newer kernels (I =
checked v3.12).<br>
# I am currently using Linux Kernel v3.0.31.<br><br>I tried to do a quick p=
ort by doing the following:<br>=A0=A0=A0 - Copied drivers/iio to drivers/
<br>=A0=A0=A0 - Copied include/linux/iio to include/linux
<br>=A0=A0=A0 - Updated drivers/Kconfig and added &quot;source drivers/iio/=
Kconfig&quot;<br>=A0=A0=A0 - Updated drivers/Makefile and added &quot;obj-$=
(CONFIG_IIO)=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 +=3D iio/&quot;
<br>=A0=A0=A0 - Enabled the following via menuconfig:
<br>=A0=A0=A0 &lt;*&gt; Device Drivers -&gt; Industrial I/O support (CONFIG=
_IIO)
<br>=A0=A0=A0 &lt;*&gt; Device Drivers -&gt; Industrial I/O support -&gt; A=
ccelerometers -&gt; STMicroelectronics accelerometers 3-Axis Driver (CONFIG=
_IIO_ST_ACCEL_3AXIS, for ST LSM303D)
<br>=A0=A0=A0 &lt;*&gt; Device Drivers -&gt; Industrial I/O support -&gt; D=
igital gyroscope sensors -&gt; STMicroelectronics gyroscopes 3-Axis Driver =
(CONFIG_IIO_ST_GYRO_3AXIS, for ST L3GD20)
<br>=A0=A0=A0 &lt;*&gt; Device Drivers -&gt; Industrial I/O support -&gt; M=
agnetometer sensors -&gt; STMicroelectronics magnetometers 3-Axis Driver (C=
ONFIG_IIO_ST_MAGN_3AXIS, for ST LSM303D)
<br>=A0=A0=A0 &lt;*&gt; Device Drivers -&gt; Industrial I/O support -&gt; P=
ressure sensors -&gt; STMicroelectronics pressure sensor Driver (CONFIG_IIO=
_ST_PRESS, for ST LPS331AP)<br><br>But I ran into build errors (implicit de=
clarations) due to inconsistencies between the two kernels&#39; header file=
s.<br>
For example, there are:<br>=A0=A0=A0 - New functions at fs/libfs.c (simple_=
open)<br>=A0=A0=A0 - New functions at drivers/base/devres.c (devres_release=
)<br>=A0=A0=A0 - New functions at lib/idr.c (ida_simple_remove, ida_simple_=
get)<br><br><b>[Question]</b><br>
<br>I would like to ask how I can successfully build the drivers for these =
3 modules in the linux kernel v3.0.31 that I am using?<br><br><b>[Note]</b>=
<br><br>I already checked-out <a href=3D"http://www.st.com/web/en/catalog/t=
ools">www.st.com/web/en/catalog/tools</a> for standalone drivers.<br>
Problem is, only the LSM303D driver via I2C (STSW-MEMS025 v1.0.5) is there.=
<br>There is a L3GD20 driver via I2C (STSW-MEMS018 v1.2.1), but I need one =
via SPI - so I can&#39;t use this one.<br>Since I found all the needed driv=
ers in v3.12 for these 3 modules, supporting the exact interfaces I need - =
I would like to use these built-in drivers instead and port to v3.0.31 - if=
 possible.<br>
I asked for assistance because I noticed that you are the drivers&#39; auth=
or in both the built-in kernel driver and the standalone driver for these s=
ensor modules (anda that you&#39;re okay to be notified). :)<br><br></div>
<div>Please advise.<br><br>Any help is very much appreciated. :)<br>Thank y=
ou in advance.<br><br># BTW, I don&#39;t know if this question should be po=
sted in <a href=3D"mailto:linux-arm-kernel@lists.infradead.org">linux-arm-k=
ernel@lists.infradead.org</a>, but if you ask me to, I will.<br>
<br>Regards,<br>Maggie Roxas<br></div></div>

--047d7b3a7fca96c98b04eaa53c79--
