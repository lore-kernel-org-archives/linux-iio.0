Return-Path: <peda@lysator.liu.se>
Subject: Re: [RFC] iio: st: Add lsm9ds0 support for gyro accel and magn
To: Jonathan Cameron <jic23@kernel.org>,
 Crestez Dan Leonard <leonard.crestez@intel.com>, linux-iio@vger.kernel.org,
 Giuseppe Barba <giuseppe.barba@st.com>, Denis Ciocca <denis.ciocca@st.com>
References: <2bcce23e64d53f542a9436b11509b107d63cb8dc.1460573498.git.leonard.crestez@intel.com>
 <57137732.40507@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Daniel Baluta <daniel.baluta@intel.com>, Wolfram Sang <wsa@the-dreams.de>
From: Peter Rosin <peda@lysator.liu.se>
Message-ID: <57139BF1.5060200@lysator.liu.se>
Date: Sun, 17 Apr 2016 16:21:37 +0200
MIME-Version: 1.0
In-Reply-To: <57137732.40507@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>



On 2016-04-17 13:44, Jonathan Cameron wrote:
> On 13/04/16 20:01, Crestez Dan Leonard wrote:
>> Device is an integrated gyro/accel/magn and temperature sensor. The
>> device has two i2c/spi interfaces: one for the gyro and one for the
>> accel/magn/temp sensor.
>>
>> Datasheet: http://www2.st.com/resource/en/datasheet/lsm9ds0.pdf
>>
>> The patch uses existing iio st_sensor infrastructure and just adds a
>> bunch of new device IDs and the new register mappings.
>>
>> Temperature support is not included.
>>
>> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> This looks fine to me.  Needs acks from Denis though.
> Also, clearly your questions need addressing.
>> ---
>>
>> I tested basic reading of values using software triggers and i2c and the values
>> seems plausible.
>>
>> I tested lsm9ds0-accel and lsm9ds0-magn separately because I don't know how to
>> instantiate two iio drivers for the same I2C device using devicetree. Can you
>> provide a sample of this or is this not currently supported?
>>
>> It seems to me that the LSM303AGR device has the same problem: it's an
>> accel+magn combo behind a single I2C address. How is that supposed to be
>> instantiated? Other supported combo devices seem to have multiple I2C
>> addresses.
> Excellent question. I'd not picked up on this before.
> It could be done with a 'dummy mux' I guess though that's messy.
> Guiseppe how are you doing it for the lsm303agr?
> 
> Cc'd Peter Rosin who has kindly walked into maintainer I2C mux
> support recently ;) An Wolfram for obvious reasons..
> To bring you two up to date, we have effectively two separate devices
> (very nearly) sat behind a single i2c address.  They have non overlapping
> register maps.
> We have a big overarching st_sensors driver framework which contains numerous
> examples of parts with just a magnetometer or just an accelerometer but in this
> case they have combined these two.  It would be nice to reuse the infrastructure
> without having to have a separate version for the two cases that exist so far. 
> I suppose such a separate handling wouldn't be too terrible if we have to do it
> though - just a new device implementation of magnaccel for the st-sensors.

My knee-jerk was also mfd, just like Wolfram already said, but I do not know
if mfd covers sub-devices with the same i2c address?

The reason I also answered is to say that adding a dummy i2c-mux to the
device tree just so that you can instantiate two drivers for one device
is (ab)using the dt to describe the software, where its purpose is to
describe hw. I think that is frown upon by the dt crowd?

Cheers,
Peter
