Return-Path: <leonard.crestez@intel.com>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: Re: [RFC] iio: st: Add lsm9ds0 support for gyro accel and magny
To: Denis Ciocca <denis.ciocca@st.com>, Jonathan Cameron <jic23@kernel.org>
References: <2bcce23e64d53f542a9436b11509b107d63cb8dc.1460573498.git.leonard.crestez@intel.com>
 <57137732.40507@kernel.org> <20160418060742.GA2981@beicxl1122>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Giuseppe BARBA <giuseppe.barba@st.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Daniel Baluta <daniel.baluta@intel.com>, Peter Rosin <peda@lysator.liu.se>,
 Wolfram Sang <wsa@the-dreams.de>
Message-ID: <5714B609.4020502@intel.com>
Date: Mon, 18 Apr 2016 13:25:13 +0300
MIME-Version: 1.0
In-Reply-To: <20160418060742.GA2981@beicxl1122>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 04/18/2016 09:07 AM, Denis Ciocca wrote:
> Hi Leonard and Jonathan,
>
> basically the patch can not work.
Well, it can work as long as you don't initialize both the accel and the
magn at the same time. There is no issue with the gyro driver. Would it
be OK if I resend this as a [PATCH] intended for inclusion?

There are small some issues that I found in further testing and fixed
locally.

> Current ST infrastructure needs to use one i2c slave per driver (accel or magn or gyro).
> All sensors currently supported (including lsm303agr) have one i2c address per sensor type (for example in lsm303agr, accel has one i2c address, magn has another one).

I was skimming multiple datasheets from ST and missed the fact that
lsm303agr has two I2C addresses. The accel and magn parts have distinct
register ranges (despite being separated by address anyway) and that
threw me off

> What you are doing now it is not possible with current implementation. You can't have two drivers that manage one singol i2c device.
> A possible solution is to use MDF device that let IIO drivers probe, the only driver that really manage i2c is MDF (check HID implementation), But I'm not sure it is ok because in combo device (two sensors sharing same i2c address) maybe you have some constrains you should verify (for example one odr is related to the other one, ...), you can't basically try to use those as totally separated.
>
> I've started months ago to modify ST infrastructure in order to manage combo device but so far it is still work in progess...

This device has some bits and registers that are shared between the
accel/magn part and this kind of stuff will have to be dealt with.
Attempting to treat the two parts can sort of work but it's not a very
good solution.

I agree that the good solution would be to create some sort of st_combo
infrastructure (perhaps in drivers/iio/imu) and have a single iio_dev
which contains multiple st_sensor_data structs inside priv. Something
like this:

struct st_combo_sensor_data {
    struct st_sensor_data *accel;
    struct st_sensor_data *magn;
}

Then st_combo_* implementation functions would forward to st_magn_* or
st_accel_* depending on chan->type. Does this make sense?

--
Regards,
Leonard
