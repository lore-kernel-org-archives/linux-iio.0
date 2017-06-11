Return-Path: <SRS0=S0G0=5Q=gmail.com=lorenzo.bianconi83@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170611120952.17624c24@jic23.retrosnub.co.uk>
References: <CAA2SeNJKoERD=ejx8ip=4fhdjB7AY8-9KZyndnnFyvcfU0TohQ@mail.gmail.com>
 <20170611120952.17624c24@jic23.retrosnub.co.uk>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date: Sun, 11 Jun 2017 21:50:52 +0200
Message-ID: <CAA2SeNKBMrhOtp_paL+OACC695=voOBoiZzx6+VRs_VCnjs9ng@mail.gmail.com>
Subject: Re: spi 3wire support for ST MEMs sensors
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

> On Fri, 9 Jun 2017 11:30:00 +0200
> Lorenzo Bianconi <lorenzo.bianconi83@gmail.com> wrote:
>
>> Hi all,
>>
>> I started working on supporting spi-3wire mode in some STM MEMs
>> drivers and I am facing a tricky issue. Let's consider the driver for
>> LSM303AGR accel device
>> (http://www.st.com/resource/en/datasheet/lsm303agr.pdf). The sensor is
>> configured by default in spi 4 wire mode (BIT 0 in register 0x23) but
>> the package does not export the MISO line for accelerometer. The only
>> way to support spi is to enable 3-wire at bootstrap. I am wondering
>> how to figure out the correct register address since it is not
>> possible to read the device whoami. The only way that come up to my
>> mind is to add a lookup table in st_accel_spi.c based on
>> spi_device_id. Is there something better? Or should I just remove the
>> spi support for LSM303AGR? Thanks
>>
>> Regards,
>> Lorenzo
>>
>
> Hi Lorenzo,
>

Hi Jonathan,

> Look up table is probably the best option when a device only supports
> 3 wire mode.
>
> However, don't we need DT of ACPI to provide info on whether a 3 wire
> bus is being used?  If so can we query it from the spi core?
>

Right, the user has to request the 3-wire mode using the standard
spi-3wire property.

> Jonathan

Regards,
Lorenzo

-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
