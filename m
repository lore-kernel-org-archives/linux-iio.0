Return-Path: <m.othacehe@gmail.com>
References: <87a7snd8r7.fsf@gmail.com>
From: Mathieu Othacehe <m.othacehe@gmail.com>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: linux-iio@vger.kernel.org
Subject: Re: isl29501 and multiple calibration registers
In-reply-to: <20180527095907.5aa173b0@archlinux>
Date: Mon, 28 May 2018 17:38:08 +0200
Message-ID: <876037dc4f.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
List-ID: <linux-iio@vger.kernel.org>

--=-=-=
Content-Type: text/plain


Hi Jonathan,

Thanks for you answer, it seems fine to me to use IIO ABI when possible
and extend it with iio_chan_spec_ext_info for exotic calibration
registers.

Here is a proposal for sysfs-bus-iio-isl29501 document. Would it be ok?

Thanks,

Mathieu

--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline;
 filename=0001-iio-isl29501-Add-documentation.patch

>From 6932a29f986a432ec591417b34e896351be6ce14 Mon Sep 17 00:00:00 2001
From: Mathieu Othacehe <m.othacehe@gmail.com>
Date: Mon, 28 May 2018 17:35:32 +0200
Subject: [PATCH] iio: isl29501: Add documentation.

The ISL29501 is a Time of Flight (ToF) based signal processing
integrated circuit. The sensor enables long range optical distance
sensing when combined with an external emitter and detector.
---
 Documentation/ABI/testing/sysfs-bus-iio-isl29501 | 230 +++++++++++++++++++++++
 1 file changed, 230 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-isl29501

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-isl29501 b/Documentation/ABI/testing/sysfs-bus-iio-isl29501
new file mode 100644
index 0000000..6f18f13
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-isl29501
@@ -0,0 +1,230 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_raw
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Get the distance from the obstacle in meters. The
+                distance is an integer between 0 and 65535.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_noise_approximation
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Get the measurement noise approximation in meters.
+		The approximation is an integer between 0 and 65535.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_magn0_raw
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Get the magnitude of the received signal in nA.
+		The magnitude is an integer between 0 and 65535.
+
+What:		/sys/bus/iio/devices/iio:deviceX/integration_time
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Control the length of each sample, which is equal to
+		the time during which the optical pulse is active.
+
+What:		/sys/bus/iio/devices/iio:deviceX/integration_time_available
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Reading returns the list of possible integration times.
+
+What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Control the sampling frequency of the sensor.
+
+What:		/sys/bus/iio/devices/iio:deviceX/sampling_frequency_available
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Reading returns the list of possible sampling frequencies.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_cs_i
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Set the Crosstalk I calibration value when written
+		to. The value must be an integer between -32768 and
+		32767 inclusive.
+
+		Get this value from hardware and show it when read
+		from.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_cs_i_exp
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Set the Crosstalk I calibration exponent value when
+		written to. The value must be an integer between
+		0 and 255 inclusive.
+
+		Get this value from hardware and show it when read
+		from.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_cs_q
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Set the Crosstalk Q calibration value when written
+		to. The value must be an integer between -32768 and
+		32767 inclusive.
+
+		Get this value from hardware and show it when read
+		from.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_cs_q_exp
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Set the Crosstalk Q calibration exponent value when
+		written to. The value must be an integer between
+		0 and 255 inclusive.
+
+		Get this value from hardware and show it when read
+		from.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_cs_gain
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Set the Crosstalk gain value when written to. The
+		value must be an integer between 0 and 65535
+		inclusive.
+
+		Get this value from hardware and show it when read
+		from.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_mag_ref
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Set the magnitude reference when written to. The
+		value must be an integer between 0 and 65535
+		inclusive.
+
+		Get this value from hardware and show it when read
+		from.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_calib_mag_exp
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Set the magnitude reference exponent when written
+		to. The value must be an integer between 0 and 15
+		inclusive.
+
+		Get this value from hardware and show it when read
+		from.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_phase_offset
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Set the fixed distance offset calibration value when
+		written to. The value must be an integer
+		between 0 and 65535 inclusive.
+
+		Get this value from hardware and show it when read
+		from.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_temp_ref
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Set the temperature reference value when written
+		to. The value must be an integer between 0 and 255
+		inclusive.
+
+		Get this value from hardware and show it when read
+		from.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_phase_exp
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Set the phase correction exponent value when written
+		to. The value must be an integer between 0 and 15
+		inclusive.
+
+		Get this value from hardware and show it when read
+		from.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_phase_temp_a
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Set the phase temperature A correction coefficient
+		value when written to. The value must be an integer
+		between 0 and 255 inclusive.
+
+		Get this value from hardware and show it when read
+		from.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_phase_amb_a
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Set the phase ambient A correction coefficient value
+		when written to. The value must be an integer between
+		0 and 255 inclusive.
+
+		Get this value from hardware and show it when read
+		from.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_phase_temp_b
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Set the phase temperature B correction coefficient
+		value when written to. The value must be an integer
+		between 0 and 255 inclusive.
+
+		Get this value from hardware and show it when read
+		from.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_phase_amb_b
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Set the phase ambient B correction coefficient value
+		when written to. The value must be an integer between
+		0 and 255 inclusive.
+
+		Get this value from hardware and show it when read
+		from.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_driver_range
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Set the current DAC scale when written to. The value
+		must be an integer between 0 and 255 inclusive.
+
+		Get this value from hardware and show it when read
+		from.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_emitter_dac
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Set the current DAC value when written to. The value
+		must be an integer between 0 and 255 inclusive.
+
+		Get this value from hardware and show it when read
+		from.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_proximity0_emitter_offset
+KernelVersion:	4.17
+Contact:	linux-iio@vger.kernel.org
+Description:
+                Set the emitter voltage measure offset when written
+		to. The value must be an integer between 0 and 255
+		inclusive.
+
+		Get this value from hardware and show it when read
+		from.
\ No newline at end of file
-- 
2.7.4


--=-=-=--
