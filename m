Return-Path: <denis.ciocca@st.com>
Date: Tue, 19 Apr 2016 19:22:17 +0800
From: Denis Ciocca <denis.ciocca@st.com>
To: Crestez Dan Leonard <leonard.crestez@intel.com>
CC: Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Giuseppe BARBA <giuseppe.barba@st.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter
 Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel
 Baluta <daniel.baluta@intel.com>,
        Peter Rosin <peda@lysator.liu.se>, Wolfram
 Sang <wsa@the-dreams.de>
Subject: Re: [RFC] iio: st: Add lsm9ds0 support for gyro accel and magny
Message-ID: <20160419112217.GC9712@beicxl1122>
References: <2bcce23e64d53f542a9436b11509b107d63cb8dc.1460573498.git.leonard.crestez@intel.com>
 <57137732.40507@kernel.org>
 <20160418060742.GA2981@beicxl1122>
 <5714B609.4020502@intel.com>
 <57153AC3.9020603@kernel.org>
 <CAKi4VAKExQPMFgFv+VGvqxGsu47aF1UxDtoExWWh5DXY36B=LA@mail.gmail.com>
 <57160E37.2040401@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <57160E37.2040401@intel.com>
List-ID: <linux-iio@vger.kernel.org>

Hi Leonard,

On |19 Apr 16 @ 12:53|, Crestez Dan Leonard wrote:
> On 04/19/2016 08:10 AM, Lucas De Marchi wrote:
> > On Mon, Apr 18, 2016 at 4:51 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> >> On 18/04/16 11:25, Crestez Dan Leonard wrote:
> >>> On 04/18/2016 09:07 AM, Denis Ciocca wrote:
> >>> Then st_combo_* implementation functions would forward to st_magn_* or
> >>> st_accel_* depending on chan->type. Does this make sense?
> >> Perhaps. If you have a short term need for this perhaps Denis and you can
> >> work together to speed up what he has 'in the works' for this?
> >> No point in duplicating work!
> >>
> >> The gyro element can go forward separately in the meantime.
> > 
> > Isn't LSM9DS0 just a package of LSM303D and L3GD20 that could reuse
> > the drivers already present?
> 
> That doesn't seem to be mentioned in the datasheets but I guessed that
> is a repacking of existing devices.

There is no such info. But since whoIam and register map is same, we can use
same table of l3gd20.



> 
> The gyro part of the patch only adds IDs. It's ~10 lines spread around
> many files.
> 
> For accel/magn parts there is a WHOAMI different from all others present
> and some registers also seem to be different. There doesn't seem to be
> explicit support for "LSM303D".

lsm303d is a combo device, not currently supported into ST architecture.
When it will be ok, we can support in same table lsm303d and lsm9ds0 (accel & magn)
if I remember corretly (since are sharing ID and register map).



> 
> I have no urgent need for this to work, I'm fine with waiting some time
> for st_sensor combo support.

That's great. I will keep you updated.



> 
> I can repost the gyro and accel+magn parts separately. But it's not
> clear that supporting an accel-only device would still make sense once
> combo support is available. So maybe I should just repost the gyro patch
> adding IDs?

I think we can proceed with gyro patch. So, you can provide a patch that adds
lsm9ds0_gyro part.


Thanks,
Denis


> 
> Regards,
> Leonard
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
