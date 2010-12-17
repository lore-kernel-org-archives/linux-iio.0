Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Fri, 17 Dec 2010 13:47:20 +0000
Subject: different ring buffer usage scenario
Message-ID: <544AC56F16B56944AEC3BD4E3D591771324BEA42CB@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

I'm currently working on a high speed ADC driver, that requires a different=
 ring buffer use case scenario.
Let me explain a little bit the setup. I'm running Linux on a Microblaze so=
ftcore inside an Virtex6 FPGA.
Part of the system is a peripheral interface block, we call it the ADC Inte=
rface Module (AIM).
External to the FPGA we connect a single channel high speed ADC AD9649, to =
the AIM signals.

The AIM features a FIFO, with watermark interrupt capabilities. There are t=
wo modes that need to be supported.
Continues Sampling Mode and Single Shot Sample Mode. In Single Shot Sample =
Mode, the user reads an arbitrary
Number of samples from the ADC, and then the sampling stops. This mode does=
 not need to have a ringbuffer at all.
A simple chardev might be sufficient.

Any objections creating a driver private chardev?

In Continues Sampling Mode we store continuously data into the ringbuffer, =
and assume that userspace reader can catch up.
Now looking at the existing sw_ring, we don't need the scan element concept=
s, no timestamps and bytes_per_datum is going to be used in a different fas=
hion.
Ideally bytes_per_datum defaults to the ADC width. However right now it is =
used to set the number of bytes stored into the ring by a call to ring->acc=
ess.store_to().
bytes_per_datum currently must be constant while the ring is enabled.
However we need to store an arbitrary number of elements into the buffer.

Following example:
The AIM internal fifo can hold 512 elements, we set the fifo almost full wa=
termark to 400 elements. In the ISR we read the number of elements that are=
 currently in the fifo. This number will be > the fifo almost full watermar=
k (e.g. 400 elements) but likely less than the fifo size.

Do you think it is possible to modify iio_store_to_sw_ring(), without break=
ing the implementation, to support this kind of use?

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036
Geschaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif
