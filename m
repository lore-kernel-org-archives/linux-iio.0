Return-Path: <SRS0=6Um6=LE=gmail.com=himanshujha199640@kernel.org>
Date: Wed, 22 Aug 2018 00:16:44 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: David Frey <dpfrey@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, joe@perches.com
Subject: Re: [PATCH v3 2/7] iio: chemical: bme680: cleanup bme680_read_calib
 formatting
Message-ID: <20180821184644.GB17750@himanshu-Vostro-3559>
References: <20180817190319.13119-1-dpfrey@gmail.com>
 <20180817190319.13119-3-dpfrey@gmail.com>
 <20180818110655.GC24920@himanshu-Vostro-3559>
 <78bee2e8-c686-b2d1-b2c7-1681764095e4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <78bee2e8-c686-b2d1-b2c7-1681764095e4@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

CC'ing Joe

On Mon, Aug 20, 2018 at 12:24:43PM -0700, David Frey wrote:
> On 8/18/2018 4:06 AM, Himanshu Jha wrote:
> > On Fri, Aug 17, 2018 at 12:03:14PM -0700, David Frey wrote:
> >> Signed-off-by: David Frey <dpfrey@gmail.com>
> > 
> > One minor comment below.
> 
> <snip>
> 
> >> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> >> index 35cbcb16c9f9..cde08d57e7d5 100644
> >> --- a/drivers/iio/chemical/bme680_core.c
> >> +++ b/drivers/iio/chemical/bme680_core.c
> <snip>
> >> @@ -208,30 +200,26 @@ static int bme680_read_calib(struct bme680_data *data,
> >>  		dev_err(dev, "failed to read BME680_H1_MSB_REG\n");
> >>  		return ret;
> >>  	}
> >> -
> >>  	ret = regmap_read(data->regmap, BME680_H1_LSB_REG, &tmp_lsb);
> >>  	if (ret < 0) {
> >>  		dev_err(dev, "failed to read BME680_H1_LSB_REG\n");
> >>  		return ret;
> >>  	}
> >> -
> >>  	calib->par_h1 = (tmp_msb << BME680_HUM_REG_SHIFT_VAL) |
> >> -				(tmp_lsb & BME680_BIT_H1_DATA_MSK);
> >> +	                (tmp_lsb & BME680_BIT_H1_DATA_MSK);
> > 
> > Prefer tabs instead of spaces!
> > Please run checkpatch on the patch to get those warnings.
> 
> Thanks for telling me about the existence of checkpatch.pl.  The
> official docs
> (https://www.kernel.org/doc/html/v4.18/process/coding-style.html) are
> pretty light on information about indentation/alignment, but there is
> this relevant quote: "Outside of comments, documentation and except in
> Kconfig, spaces are never used for indentation, and the above example is
> deliberately broken."
> 
> I thought that the way I indented it was optimal because I used spaces a
> tab for indentation and then spaces for alignment, but checkpatch.pl
> seems to disagree.  Based on a quick read of the code, it seems that it
> will complain about more than 7 spaces in a row.
> 
> I guess you could achieve visually identical alignment (where "------->"
> is tab and "_" is space) and this would still pass checkpatch.pl.  Note
> that I changed the identifier name slightly to demonstrate a mix of tabs
> and spaces.
> 
> ------->calib->par_h123 = (tmp_msb << BME680_HUM_REG_SHIFT_VAL) |
> ------->------->------->__(tmp_lsb & BME680_BIT_H1_DATA_MSK);
> 
> What I don't understand is the logic used to justify the original
> indentation:
> ------->calib->par_h1 = (tmp_msb << BME680_HUM_REG_SHIFT_VAL) |
> ------->------->------->------->(tmp_lsb & BME680_BIT_H1_DATA_MSK);

Hmm.
Which looks more readable to you ?

This:
        var1 = (calib->par_p9 * (((press_comp >> 3) *
                        (press_comp >> 3)) >> 13)) >> 12;
        var2 = ((press_comp >> 2) * calib->par_p8) >> 13;
        var3 = ((press_comp >> 8) * (press_comp >> 8) *
                        (press_comp >> 8) * calib->par_p10) >> 17;

Or this:
        var1 = (calib->par_p9 * (((press_comp >> 3) *
                (press_comp >> 3)) >> 13)) >> 12;
        var2 = ((press_comp >> 2) * calib->par_p8) >> 13;
        var3 = ((press_comp >> 8) * (press_comp >> 8) *
                (press_comp >> 8) * calib->par_p10) >> 17;

Not sure if my rationale of "readablilty" applies to you and others.
But first case looks more appropriate to me and I don't know why!

> Why not?
> ------->calib->par_h1 = (tmp_msb << BME680_HUM_REG_SHIFT_VAL) |
> ------->------->------->(tmp_lsb & BME680_BIT_H1_DATA_MSK);

This looks better too.
Can't decide.

> Or?
> ------->calib->par_h1 = (tmp_msb << BME680_HUM_REG_SHIFT_VAL) |
> ------->------->(tmp_lsb & BME680_BIT_H1_DATA_MSK);

No.
This is fairly simple, why would anyone do it like that ?
It should be atleast to the right of assignment operator with
a space.

Rationale is: Use tabs as far as possible and if tabs make it
look ugly then use spacaes instead of "a" tab and align properly.

Mix of tabs + few spaces:
static int bme680_read_raw(struct iio_dev *indio_dev,
			   struct iio_chan_spec const *chan,
			   int *val, int *val2, long mask)
Use of only tabs:
static int bme680_read_raw(struct iio_dev *indio_dev,
				struct iio_chan_spec const *chan,
				int *val, int *val2, long mask)

> I'm not trying to turn this into a crazy bike shedding thread.  I just
> want to understand the rules a bit better.

Joe will provide a much better answer for checkpatch and rules.

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
