Return-Path: <denis.ciocca@st.com>
Date: Tue, 19 Apr 2016 14:05:10 +0800
From: Denis Ciocca <denis.ciocca@st.com>
To: Lucas De Marchi <lucas.de.marchi@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>,
        Crestez Dan Leonard
	<leonard.crestez@intel.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        Giuseppe BARBA <giuseppe.barba@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hartmut Knaack
	<knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter
 Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel Baluta
	<daniel.baluta@intel.com>,
        Peter Rosin <peda@lysator.liu.se>, Wolfram Sang
	<wsa@the-dreams.de>
Subject: Re: [RFC] iio: st: Add lsm9ds0 support for gyro accel and magn
Message-ID: <20160419060510.GB9712@beicxl1122>
References: <2bcce23e64d53f542a9436b11509b107d63cb8dc.1460573498.git.leonard.crestez@intel.com>
 <57137732.40507@kernel.org>
 <20160418060742.GA2981@beicxl1122>
 <5714B609.4020502@intel.com>
 <57153AC3.9020603@kernel.org>
 <CAKi4VAKExQPMFgFv+VGvqxGsu47aF1UxDtoExWWh5DXY36B=LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <CAKi4VAKExQPMFgFv+VGvqxGsu47aF1UxDtoExWWh5DXY36B=LA@mail.gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Hi Lucas,

yup. Just need to add the lsm9ds0_gyro entry in the same table of l3gd20.

Thanks,
Denis


On |19 Apr 16 @ 07:10|, Lucas De Marchi wrote:
> On Mon, Apr 18, 2016 at 4:51 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> > On 18/04/16 11:25, Crestez Dan Leonard wrote:
> >> On 04/18/2016 09:07 AM, Denis Ciocca wrote:
> >> Then st_combo_* implementation functions would forward to st_magn_* or
> >> st_accel_* depending on chan->type. Does this make sense?
> > Perhaps. If you have a short term need for this perhaps Denis and you can
> > work together to speed up what he has 'in the works' for this?
> > No point in duplicating work!
> >
> > The gyro element can go forward separately in the meantime.
> 
> Isn't LSM9DS0 just a package of LSM303D and L3GD20 that could reuse
> the drivers already present?
> 
> 
> Lucas De Marchi
