Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:48682 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750869AbdGLMvF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Jul 2017 08:51:05 -0400
Date: Wed, 12 Jul 2017 14:51:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Gromm <christian.gromm@microchip.com>,
        linux-iio@vger.kernel.org
Cc: driverdev-devel@linuxdriverproject.org
Subject: Re: New Driver for electrical energy measurement
Message-ID: <20170712125101.GA27567@kroah.com>
References: <20170712141854.018293e7@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20170712141854.018293e7@xps13>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jul 12, 2017 at 02:18:54PM +0200, Christian Gromm wrote:
> 
> Hi,
> 
> Microchip is planning to introduce a driver for a new companion chip series
> capable of electical energy measurement. However, we are not sure which
> location in the source tree is the most suitable. First thought was to put
> it into /drivers/powercap. But now we are in discussions whether it would
> make even more sense to introduce a new driver for electrical energy
> measuring or monitoring.

Why not just have it be an IIO device, I think they have energy sensors
already (adding the iio mailing list to find out...)

> 
> Following is a rough overview of the part we want the driver for. Any
> input on this will be appreciated.
> 
> thanks,
> Chris
> 
> === Introduction
> 
> Following the recent focus on low-power systems, Microchip has designed a
> companion chip series capable of measuring the electrical energy flow of an
> electrical system.  The series in question, EM Chip  is capable of
> measuring the energy flow (in or out) of an electrical system by monitoring
> one or more power rails.  The 1st chip of the series, EM Chip is able to
> measure the net energy flow over 4 different power rails.  The chip itself
> is a small QFN16 (4mm x 4mm x 0.5mm) or WLCSP16 (2.25mm x 2.2mm) package.
> 
> === Theory of Operation
> 
> In order to measure the amount of energy entering/exiting a system, a small
> shunt resistor is interleaved on a power rail. By measuring the small
> voltage drop across the shunt resistor (a known value), the electrical
> current is measured.
> 
> 	I = U/R
> 
> Depending on whether the system is consuming or producing energy, the
> measured current value can be either a positive or negative number.
> 
> To get the instantaneous power figure we will have to measure the power
> rail’s voltage and multiply it with the measured value for the current
> 
> 	P = V * I = V * U_shunt/R
> 
> Knowing the instantaneous power and by making a high enough sample rate
> (for measuring the current and the power rail voltage), we can assume the
> measured value for power is equal to the average power figure for the
> amount of time between 2 sampling moments.
> 
> Now that we also know the average power for a given time interval (dt_x =
> time between 2 sampling moments; sampling speed is known), we can measure
> the energy amount entering or exiting the system between 2 sampling moments
> 
> 	E_partial_x = P * dt_x
> 
> Having the energy information available, we can continue to add the
> subsequent energy values for as long as the system is active. The amount of
> energy is the sum of all the partial energy values measured for each time
> interval E = Sum (E_partial_x), where x can take values from 0 till
> infinite.
> 
> 
> === Chip Operation
> 
> The EM Chip chip uses the same principles of operation as presented in the
> “Theory of Operation” and it does so for a number of 4 channels. 4
> independent power rails can be energy monitored in the same time.  The chip
> is controlled over I2C/SMBus by an I2C/SMBus master.
> 
> In order to reduce the amount of information traffic between the EM Chip
> and the entity asking for its information, the chip features large
> accumulator energy registers for the accumulated energy values. It can
> accumulate up to 2^24 power values. Depending on the selected chip’s
> sampling speed, such a number of samples are produced in about 4.5 hours
> (fastest sampling speed) up to 582.5 hours or more than 24 days (lowest
> sampling speed).
> 
> EM Chip measures the power as a 28-bits number. The 28-bits number is the
> multiplication result of the 16-bits number used to measure the power rail
> voltage and the 12-bits number used for measuring the voltage drop across
> the power rail shunt resistor. 
> 
> If bidirectional energy flow is required, the power is measured as a
> 27-bits number and 1 bit for the sign. When no bidirectional flow is
> needed, the power value is measured as an unsigned 28-bits number.
> 
> Due to the relatively large size of the accumulated energy registers inside
> the chip (48 bits), in the worst case scenario (power values are full scale
> numbers), a number of 2^20 full-scale power values can be measured before
> energy register’s overflow. Using the fastest sampling speed, the
> accumulated energy registers overflows only after a bit over 17 minutes,
> while at the lowest sampling speed, it would overflow in over 36 hours.
> 
> Thus, the chip requires infrequent reads of the accumulated energy
> registers. Even in the worst case scenario, the time between 2 consecutive
> energy accumulator reads can be over 17 minutes !
> 
> In order to keep a longer history of energy measurements, an I2C/SMBus
> master (e.g. SoC) would read the accumulated energy register values and
> then use larger “soft” accumulated energy registers to extend the maximum
> overflow period.
> 
> The EM Chip chip can monitor rails up to 32V. It can monitor the energy
> amounts used by various sub-components of a system (e.g. CPU, GPU, memory,
> hard-drives, USB ports, backlight, wireless adapters, cameras, displays, …)
> 
> EM Chip is able to start operating immediately after power-up with no CPU
> intervention at all. Such a feature is useful, because it can show the
> amount of energy consumed by a system before the latter finished booting
> its operating system.
> 
> The chip’s own current draw is around 20uA (in low-power mode, lowest
> sampling speed - 8 samples/sec) to 675uA (for the highest sampling speed -
> 1024 samples/sec)
> 
> When operated in low-power mode, it can be used to monitor the stand-by
> energy draw of the system. As an example, such a mode is useful when a
> system is suspended to RAM or to measure the energy usage from the power on
> till the booting process is finished.
> 
> === Linux Driver
> 
> While the chip is due to be publicly released in Q3 2017, a selected number
> of PC OEM manufacturers will include one or more EM Chip chips on their
> systems.  We would like to include a driver for EM Chip chip and its
> follow-up products, such that Linux Kernel will be able to provide the
> energy information as soon as computing systems using this series of chips
> will become available.
> 
> By providing accurate energy measurements, the computing systems along with
> their operating systems will be able to run more efficiently.


Do you have any kernel code already to show how this will get hooked up
to the device?  Do you need device tree bindings for the sensors, or are
they on a discoverable bus?

thanks,

greg k-h
