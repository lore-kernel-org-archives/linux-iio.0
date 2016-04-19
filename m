Return-Path: <leonard.crestez@intel.com>
Subject: Re: [RFC] iio: st: Add lsm9ds0 support for gyro accel and magny
To: Lucas De Marchi <lucas.de.marchi@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
References: <2bcce23e64d53f542a9436b11509b107d63cb8dc.1460573498.git.leonard.crestez@intel.com>
 <57137732.40507@kernel.org> <20160418060742.GA2981@beicxl1122>
 <5714B609.4020502@intel.com> <57153AC3.9020603@kernel.org>
 <CAKi4VAKExQPMFgFv+VGvqxGsu47aF1UxDtoExWWh5DXY36B=LA@mail.gmail.com>
Cc: Denis Ciocca <denis.ciocca@st.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Giuseppe BARBA <giuseppe.barba@st.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
 Daniel Baluta <daniel.baluta@intel.com>, Peter Rosin <peda@lysator.liu.se>,
 Wolfram Sang <wsa@the-dreams.de>
From: Crestez Dan Leonard <leonard.crestez@intel.com>
Message-ID: <57160E37.2040401@intel.com>
Date: Tue, 19 Apr 2016 13:53:43 +0300
MIME-Version: 1.0
In-Reply-To: <CAKi4VAKExQPMFgFv+VGvqxGsu47aF1UxDtoExWWh5DXY36B=LA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 04/19/2016 08:10 AM, Lucas De Marchi wrote:
> On Mon, Apr 18, 2016 at 4:51 PM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 18/04/16 11:25, Crestez Dan Leonard wrote:
>>> On 04/18/2016 09:07 AM, Denis Ciocca wrote:
>>> Then st_combo_* implementation functions would forward to st_magn_* or
>>> st_accel_* depending on chan->type. Does this make sense?
>> Perhaps. If you have a short term need for this perhaps Denis and you can
>> work together to speed up what he has 'in the works' for this?
>> No point in duplicating work!
>>
>> The gyro element can go forward separately in the meantime.
> 
> Isn't LSM9DS0 just a package of LSM303D and L3GD20 that could reuse
> the drivers already present?

That doesn't seem to be mentioned in the datasheets but I guessed that
is a repacking of existing devices.

The gyro part of the patch only adds IDs. It's ~10 lines spread around
many files.

For accel/magn parts there is a WHOAMI different from all others present
and some registers also seem to be different. There doesn't seem to be
explicit support for "LSM303D".

I have no urgent need for this to work, I'm fine with waiting some time
for st_sensor combo support.

I can repost the gyro and accel+magn parts separately. But it's not
clear that supporting an accel-only device would still make sense once
combo support is available. So maybe I should just repost the gyro patch
adding IDs?

Regards,
Leonard
