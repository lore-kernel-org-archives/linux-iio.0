Return-Path: <SRS0=b0KL=KO=gmail.com=himanshujha199640@kernel.org>
Date: Mon, 30 Jul 2018 23:23:41 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	Daniel Baluta <daniel.baluta@gmail.com>, matt.ranostay@konsulko.com
Subject: Re: Buffert trigger and Power management support for BME680 ?
Message-ID: <20180730175341.GA27304@himanshu-Vostro-3559>
References: <20180730121241.GA4362@himanshu-Vostro-3559>
 <20180730140746.0000337a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20180730140746.0000337a@huawei.com>
List-ID: <linux-iio@vger.kernel.org>

On Mon, Jul 30, 2018 at 02:07:46PM +0100, Jonathan Cameron wrote:
> On Mon, 30 Jul 2018 17:42:41 +0530
> Himanshu Jha <himanshujha199640@gmail.com> wrote:
> 
> > Hi,
> > 
> > The initial minimal driver has been recently merged[1] and irrespective
> > of the ending week of Google Summer of Code'18, I would like to extend this
> > driver and work on it.
> > 
> > I have a few queries for the community:
> > 
> > 1. Buffered Trigger Support:
> > ----------------------------
> > 
> > Is it worth to add buffer support for this device ?
> > The device has 1Hz Forced mode which we need to enable everytime
> > we need a reading.
> > 
> > Bosch provides[1] BSEC: Bosch Software Environmental Cluster binaries for
> > different platforms, and the software has various modes:
> > 
> > 	* Ultra-low power mode.
> > 	* Ultra-low power mode.
> > 	* Continuous mode.
> > 
> > According to datasheet "1.2 Gas sensor specification"
> > 
> > Response time		Continuous mode		0.75s
> > 
> > Now, these details are worth noting and confusing at the same to me!
> > Since, we only have 1Hz mode, so would it be a problem when adding this
> > interface to get continuous measurements ?
> > What other factors/caveats should I look for before proceeding further ?
> 
> Technically there is no problem with adding buffered mode, but there may
> be no real usecases at these very low rates.

Alright!

> The main convenience is that you could read out the various channels in one
> pass (I think - haven't checked the datasheet).
> 
> > 
> > 2. Power Management:
> > -------------------
> > 
> > 3.1 Sensor modes
> > 
> > 	Forced mode:
> > 		* Single TPHG cycle is performed
> > 		* Sensor *automatically* returns to sleep mode afterwards
> > 		* Gas sensor heater only operates during gas measurement
> > 	Sleep mode:
> > 		* No measurements are performed
> > 		* Minimal power consumption
> > 
> > So, in my opinion this device is already power managed.
> > Comments ?
> 
> It seems like there is little purpose in sleep mode, are there power
> numbers to indicate what 'minimal' means here?

There are no such statistics described in the datasheet, neither is
after how much time does the sensor goes automatically to sleep!
Maybe in coming revision, not sure though.

> > 
> > 3. Adding more sysfs interface:
> > -------------------------------
> > 
> > Currently in the driver I have supplied default values to the sensor
> > at probe which are:
> > 
> >         data->heater_temp = 320; /* degree Celsius */
> >         data->heater_dur = 150;  /* milliseconds */
> > 
> > Now, these values are:
> > 
> > 1. Target heater temperature for the heater plate to be supplied for the
> >    sensor. This value can be supplied by the user and value should lie
> >    typically between 200 °C and 400 °C.
> > 2. Target heater duration time for which heater plate would be heated
> >    before initiating gas sensing measurements. Value lying between
> >    200-4032ms.
> > 
> > But there is a caveat!
> > If the sensor doesn't get the right combination of above two values, if
> > will likely abort since:
> > [ comment from the current code ]
> >         
> > 	/*
> >          * occurs if either the gas heating duration was insuffient
> >          * to reach the target heater temperature or the target
> >          * heater temperature was too high for the heater sink to
> >          * reach.
> >          */
> > 
> > So, what should be the appropriate channel types for these two
> > interfaces ?
> 
> Hmm. I guess this issue here is that the temperature rise time is
> dependent on the environment (moisture / temperature etc) so we can't
> do the obvious and just put in reasonable defaults (assuming the temperature
> is the only controlled channel). 

Yes, gas sensor in influenced by the temperature channel and yes, of
course, on the environment. I experienced this behavior while testing,
that if you solely take gas readings(with say some improper combination
of heater temp & duration) then it would a few iterations to fetch
readings. On the other hand, if done in T->P->H->G fashion then its more
likely failsafe. Ultimately it helps in reaching the target temperature
easily.

As a sidenote: in the code there is a macro for ambient temperature
	
	#define BME680_AMB_TEMP                         25

and should be changed according to the environment.

> I wonder if we can get 'close' enough and retry a few times if we get
> an abort?

Yes! Infact I thought of retrying, for say about 10 iterations(in my
case) but later the default values worked perfectly fine. Testing from well
Air Conditioned room to deadly 47 degC New Delhi heat ;)

> > I had the same question on my RFC patch and Matt Ranostay suggested[2]
> > 
> > 	"Just use IIO_TEMP and signal it is an output channel."
> > 
> > Now, I clearly doesn't understand the rationale behind the channel type?
> > And what does direction(input/output) signify ?
> 
> input is something you read, output is something that is forced.  So
> in this case you are literally setting the temperature of the plate.
> 
> It's not a perfect interface for this, but it is compliant with the ABI
> and reasonably obvious what it is doing to anyone who is familiar with
> this sort of sensor.

Ah, I also had attributes to supply oversampling ratio for temp,
press & humid channels from userspace. So, does that make it an output
channel ? Forcing ?

> > Anyway, digging further I found that Matt had a slighlty similar situation
> > in 'TI HDC100x temperature + humidity sensors' driver, where it was
> > required to enable heater to drive condensation off the sensor. And Matt
> > used:
> > 
> >                 .type = IIO_CURRENT,
> >                 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> >                 .extend_name = "heater",
> >                 .output = 1,
> >                 .scan_index = -1,
> > 
> > IIO_CURRENT ? And .output = 1, ? Please shed some insight on this.
> > And why was extended_name necessary here and creating a new ABI. We
> > already had an ABI to handle such situation:
> 
> In this case it is a rather more stupid device and all you control is
> the current output that feeds the heater.
> 
> > 
> > Documentation/ABI/testing/sysfs-bus-iio
> > 
> > What:           /sys/bus/iio/devices/iio:deviceX/heater_enable
> > KernelVersion:  4.1.0
> > Contact:        linux-iio@vger.kernel.org
> > Description:
> >                 '1' (enable) or '0' (disable) specifying the enable
> >                 of heater function. Same reading values apply
> >                 This ABI is especially applicable for humidity sensors
> >                 to heatup the device and get rid of any condensation
> >                 in some humidity environment
> > 
> > Documentation/ABI/testing/sysfs-bus-iio-humidity-hdc100x
> > 
> > What:           /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw
> > What:           /sys/bus/iio/devices/iio:deviceX/out_current_heater_raw_available
> > KernelVersion:  4.3 
> > Contact:        linux-iio@vger.kernel.org
> > Description:
> >                 Controls the heater device within the humidity sensor to get 
> >                 rid of excess condensation.
> > 
> >                 Valid control values are 0 = OFF, and 1 = ON. 
> > 
> > Was this necessary ?
> 
> That does seem like somewhat of a mess.  We shouldn't have ended up with both
> ABIs, but now we are stuck with them.

Fine.

> > Just curious about these information. It will help me decide how should
> > I proceed further.
> 
> The heater enable doesn't make sense here as you have a range of values
> rather than a boolean.  Hence the second one would be valid if you were controlling
> the current.  As it is a target temperature, it'll need to be a temperature
> channel with more docs added to explain what it is.

Hmm. For heater duration we are supplying time(ms)
And out_current_heater_raw is definitely not valid here.
Still unsure about the channel type and the corresponding
sysfs entry.

> > 4. Algorith behind Compensation functions:
> > ------------------------------------------
> > 
> > Jonathan suggested[3] to reverse engineer the compensation function and
> > document the equation/algorithm.
> > 
> > But the compensation are really complex calculations, and I will try to
> > decipher if possible.
> 
> This is more for interest of anyone coming along later than anything else ;)
> 
> > 
> > As a better solution, I contacted Bosch Sensortec again for the
> > algorithm and let's hope they reply back soon. I don't have a direct
> > contact to Bosch developers but to someone at their office. So, it takes
> > a while to get constructive feedback.
> 
> That would be great if they'll provide the info!  Maybe we can even
> persuade them to put it in an updated data sheet or an app note or similar!

I got a reply from them about the formula they use to calculate the IAQ
but not how compensation function is designed.

Will forward the email after their permission as the background
watermark text in the formula image says "Confidential!!"
Sometimes you need to be careful ;)

> > Thanks Jonathan, Daniel, Matt, Andy, David and all the reviewers. It was
> > truly a great experience and would need your patience and help for some
> > more time :)
> 
> You are welcome and hope you stay around the kernel in the future!

I am certainly around for a year until I graduate and not sure about
the future :)

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
