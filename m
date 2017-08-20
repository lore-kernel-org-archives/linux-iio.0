Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:39878 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751019AbdHTK2i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Aug 2017 06:28:38 -0400
Date: Sun, 20 Aug 2017 11:28:29 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: magnetometer: ak8974: debug AMI306 calibration
 data
Message-ID: <20170820112829.011bf027@archlinux>
In-Reply-To: <20170820112552.7c287701@archlinux>
References: <cover.1502977929.git.mirq-linux@rere.qmqm.pl>
        <dcdabb72b58170fcfde9b7536522256e0d3a8540.1502977929.git.mirq-linux@rere.qmqm.pl>
        <20170820112552.7c287701@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 20 Aug 2017 11:25:52 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 17 Aug 2017 15:56:12 +0200
> Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:
> 
> > Use AMI306 calibration data for randomness and debugging.
> > 
> > Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>  
> Applied to the togreg branch of iio.git and pushed out as testing for the
> autobuilders to play with it.
> 
> Thanks,
> 
> Jonathan
> > ---
> >  drivers/iio/magnetometer/ak8974.c | 41 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> > 
> > diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> > index d8c45206ba00..b3221b34606b 100644
> > --- a/drivers/iio/magnetometer/ak8974.c
> > +++ b/drivers/iio/magnetometer/ak8974.c
> > @@ -445,6 +445,20 @@ static int ak8974_selftest(struct ak8974 *ak8974)
> >  	return 0;
> >  }
> >  
> > +static void ak8974_read_calib_data(struct ak8974 *ak8974, unsigned int reg,
> > +				   __le16 *tab, size_t tab_size)
> > +{
> > +	int ret = regmap_bulk_read(ak8974->map, reg, tab, tab_size);
> > +	if (ret) {
> > +		memset(tab, 0xFF, tab_size);
> > +		dev_warn(&ak8974->i2c->dev,
> > +			 "can't read calibration data (regs %u..%u): %d\n",
> > +			 reg, reg + tab_size - 1, ret);
Slight tweak made to avoid the warning:

drivers/iio/magnetometer/ak8974.c: In function ‘ak8974_read_calib_data’:
drivers/iio/magnetometer/ak8974.c:455:45: warning: format ‘%u’ expects argument of type ‘unsigned int’, but argument 4 has type ‘size_t {aka long unsigned int}’ [-Wformat=]
     "can't read calibration data (regs %u..%u): %d\n",
                                            ~^
                                            %lu
     reg, reg + tab_size - 1, ret);
          ~~~~~~~~~~~~~~~~~~                  

Did the obvious ;)

Jonathan

> > +	} else {
> > +		add_device_randomness(tab, tab_size);
> > +	}
> > +}
> > +
> >  static int ak8974_detect(struct ak8974 *ak8974)
> >  {
> >  	unsigned int whoami;
> > @@ -490,6 +504,33 @@ static int ak8974_detect(struct ak8974 *ak8974)
> >  	ak8974->name = name;
> >  	ak8974->variant = whoami;
> >  
> > +	if (whoami == AK8974_WHOAMI_VALUE_AMI306) {
> > +		__le16 fab_data1[9], fab_data2[3];
> > +		int i;
> > +
> > +		ak8974_read_calib_data(ak8974, AMI306_FINEOUTPUT_X,
> > +				       fab_data1, sizeof(fab_data1));
> > +		ak8974_read_calib_data(ak8974, AMI306_OFFZERO_X,
> > +				       fab_data2, sizeof(fab_data2));
> > +
> > +		for (i = 0; i < 3; ++i) {
> > +			static const char axis[3] = "XYZ";
> > +			static const char pgaxis[6] = "ZYZXYX";
> > +			unsigned offz = le16_to_cpu(fab_data2[i]) & 0x7F;
> > +			unsigned fine = le16_to_cpu(fab_data1[i]);
> > +			unsigned sens = le16_to_cpu(fab_data1[i + 3]);
> > +			unsigned pgain1 = le16_to_cpu(fab_data1[i + 6]);
> > +			unsigned pgain2 = pgain1 >> 8;
> > +
> > +			pgain1 &= 0xFF;
> > +
> > +			dev_info(&ak8974->i2c->dev,
> > +				 "factory calibration for axis %c: offz=%u sens=%u fine=%u pga%c=%u pga%c=%u\n",
> > +				 axis[i], offz, sens, fine, pgaxis[i * 2],
> > +				 pgain1, pgaxis[i * 2 + 1], pgain2);
> > +		}
> > +	}
> > +
> >  	return 0;
> >  }
> >    
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

