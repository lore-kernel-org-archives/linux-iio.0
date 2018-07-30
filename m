Return-Path: <SRS0=b0KL=KO=gmail.com=himanshujha199640@kernel.org>
Date: Mon, 30 Jul 2018 17:42:41 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: Daniel Baluta <daniel.baluta@gmail.com>, matt.ranostay@konsulko.com
Subject: Buffert trigger and Power management support for BME680 ?
Message-ID: <20180730121241.GA4362@himanshu-Vostro-3559>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi,

The initial minimal driver has been recently merged[1] and irrespective
of the ending week of Google Summer of Code'18, I would like to extend this
driver and work on it.

I have a few queries for the community:

1. Buffered Trigger Support:
----------------------------

Is it worth to add buffer support for this device ?
The device has 1Hz Forced mode which we need to enable everytime
we need a reading.

Bosch provides[1] BSEC: Bosch Software Environmental Cluster binaries for
different platforms, and the software has various modes:

	* Ultra-low power mode.
	* Ultra-low power mode.
	* Continuous mode.

According to datasheet "1.2 Gas sensor specification"

Response time		Continuous mode		0.75s

Now, these details are worth noting and confusing at the same to me!
Since, we only have 1Hz mode, so would it be a problem when adding this
interface to get continuous measurements ?
What other factors/caveats should I look for before proceeding further ?

2. Power Management:
-------------------

3.1 Sensor modes

	Forced mode:
		* Single TPHG cycle is performed
		* Sensor *automatically* returns to sleep mode afterwards
		* Gas sensor heater only operates during gas measurement
	Sleep mode:
		* No measurements are performed
		* Minimal power consumption

So, in my opinion this device is already power managed.
Comments ?

3. Adding more sysfs interface:
-------------------------------

Currently in the driver I have supplied default values to the sensor
at probe which are:

        data->heater_temp = 320; /* degree Celsius */
        data->heater_dur = 150;  /* milliseconds */

Now, these values are:

1. Target heater temperature for the heater plate to be supplied for the
   sensor. This value can be supplied by the user and value should lie
   typically between 200 °C and 400 °C.
2. Target heater duration time for which heater plate would be heated
   before initiating gas sensing measurements. Value lying between
   200-4032ms.

But there is a caveat!
If the sensor doesn't get the right combination of above two values, if
will likely abort since:
[ comment from the current code ]
        
	/*
         * occurs if either the gas heating duration was insuffient
         * to reach the target heater temperature or the target
         * heater temperature was too high for the heater sink to
         * reach.
         */

So, what should be the appropriate channel types for these two
interfaces ?
I had the same question on my RFC patch and Matt Ranostay suggested[2]

	"Just use IIO_TEMP and signal it is an output channel."

Now, I clearly doesn't understand the rationale behind the channel type?
And what does direction(input/output) signify ?

Isn't it that channel type is based on the "what measurement the channel
is actually producing" ?

Anyway, digging further I found that Matt had a slighlty similar situation
in 'TI HDC100x temperature + humidity sensors' driver, where it was
required to enable heater to drive condensation off the sensor. And Matt
used:

                .type = IIO_CURRENT,
                .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
                .extend_name = "heater",
                .output = 1,
                .scan_index = -1,

IIO_CURRENT ? And .output = 1, ? Please shed some insight on this.
And why was extended_name necessary here and creating a new ABI. We
already had an ABI to handle such situation:

Documentation/ABI/testing/sysfs-bus-iio

What:           /sys/bus/iio/devices/iio:deviceX/heater_enable
KernelVersion:  4.1.0
Contact:        linux-iio@vger.kernel.org
Description:
                '1' (enable) or '0' (disable) specifying the enable
                of heater function. Same reading values apply
                This ABI is especially applicable for humidity sensors
                to heatup the device and get rid of any condensation
                in some humidity environment

Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x

What:           /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw
What:           /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available
KernelVersion:  4.3 
Contact:        linux-iio@vger.kernel.org
Description:
                Controls the heater device within the humidity sensor to get 
                rid of excess condensation.

                Valid control values are 0 = OFF, and 1 = ON. 

Was this necessary ?
Just curious about these information. It will help me decide how should
I proceed further.

4. Algorith behind Compensation functions:
------------------------------------------

Jonathan suggested[3] to reverse engineer the compensation function and
document the equation/algorithm.

But the compensation are really complex calculations, and I will try to
decipher if possible.

As a better solution, I contacted Bosch Sensortec again for the
algorithm and let's hope they reply back soon. I don't have a direct
contact to Bosch developers but to someone at their office. So, it takes
a while to get constructive feedback.


Thanks Jonathan, Daniel, Matt, Andy, David and all the reviewers. It was
truly a great experience and would need your patience and help for some
more time :)

[1] https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=1b3bd8592780c87c5eddabbe98666b086bbaee36
[2] https://marc.info/?l=linux-iio&m=152968608230844&w=2
[3] https://marc.info/?l=linux-iio&m=153277443604044&w=2
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
