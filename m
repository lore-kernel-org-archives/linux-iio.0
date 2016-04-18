Return-Path: <vlad.dogaru@intel.com>
Date: Mon, 18 Apr 2016 15:01:22 +0300
From: Vlad Dogaru <vlad.dogaru@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-iio@vger.kernel.org,
	Christoph Mair <christoph.mair@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 1/2] iio: pressure: bmp280: add support for BMP180
Message-ID: <20160418120122.GC20350@vdogaru>
References: <1460742827-6502-1-git-send-email-akinobu.mita@gmail.com>
 <1460742827-6502-2-git-send-email-akinobu.mita@gmail.com>
 <57120E15.2020105@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57120E15.2020105@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

On Sat, Apr 16, 2016 at 11:04:05AM +0100, Jonathan Cameron wrote:
> On 15/04/16 18:53, Akinobu Mita wrote:
[...]
> > +static int bmp180_read_press(struct bmp280_data *data,
> > +			     int *val, int *val2)
> > +{
> > +	int ret;
> > +	s32 adc_press;
> > +	u32 comp_press;
> > +
> > +	/* Read and compensate temperature so we get a reading of t_fine. */
> > +	ret = bmp180_read_temp(data, NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = bmp180_read_adc_press(data, &adc_press);
> > +	if (ret)
> > +		return ret;
> > +
> > +	comp_press = bmp180_compensate_press(data, adc_press);
> > +
> > +	*val = comp_press;
> > +	*val2 = 1000;
> This would be better done using a _scale info_mask element to handle the divide
> by 1000.  That lets the decision on whether the conversion is even needed be
> moved to userspace.
> 
> Unfortunately that's also true for the bmp280 as it stands which is annoying
> as that makes it ABI which we shouldn't be changing.  Ah well, the device
> is slow anyway so not terrible to leave this as it is.  I should have picked
> that up when reviewing that driver originally - sometimes we have live with
> our mistakes!

I don't think that qualifies as breaking ABI.  The ABI specifies which
files *may* exist and how they should be interpreted, if they exist.
It does not guarantee that a specific sensor such as BMP280 exposes its
measurement as in_temp_input, rather than in_temp_raw and in_temp_scale.

That said, I don't feel strongly about the changes either way.  When I
initially wrote the driver I thought the operations were harmless enough
to do in the kernel.

Thanks,
Vlad
