Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:40466 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751731AbdCSQG3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 19 Mar 2017 12:06:29 -0400
Date: Sun, 19 Mar 2017 09:06:16 -0700
From: Tony Lindgren <tony@atomide.com>
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] iio: adc: cpcap: Add minimal support for CPCAP PMIC ADC
Message-ID: <20170319160616.GY20572@atomide.com>
References: <20170317014344.27201-1-tony@atomide.com>
 <alpine.DEB.2.20.1703170721350.2053@vps.pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1703170721350.2053@vps.pmeerw.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

* Peter Meerwald-Stadler <pmeerw@pmeerw.net> [170316 23:44]:
> > Signed-off-by: Tony Lindgrne <tony@atomide.com>
> 
> Lindgren

Hmm yeah there are slight variations to my signature it seems :)
...

> > +/* Register CPCAP_REG_ADCC1 bits */
> > +#define CPCAP_BIT_ADEN_AUTO_CLR		BIT(15)	/* Currently unused */
> > +#define CPCAP_BIT_CAL_MODE		BIT(14) /* Set with BIT_RAND0 */
> > +#define CPCAP_BIT_ADC_CLK_SEL1		BIT(13)	/* Currently unused */
> > +#define CPCAP_BIT_ADC_CLK_SEL0		BIT(12)	/* Currently unused */
> > +#define CPCAP_BIT_ATOX			BIT(11)	/* in/out ps factor */
> 
> wondering what a 'ps' factor is...

I guess I have no idea at this point with no documentation. I'll
just drop the comments for now for the mystery registers.

> > +#define CPCAP_CHAN(_type, _index, _address, _datasheet_name) {	\
> > +	.type = (_type), \
> > +	.address = (_address), \
> > +	.indexed = 1, \
> > +	.channel = (_index), \
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | \
> > +			      BIT(IIO_CHAN_INFO_SCALE), \
> > +	.info_mask_shared_by_dir = BIT(IIO_CHAN_INFO_SAMP_FREQ) | \
> > +				   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO), \
> 
> I don't see SAMP_FREQ and _OVERSAMPLING handled?

OK will drop for now.

> > +			dev_info(ddata->dev,
> > +				 "cpcap_adc_probe: CHRGI Cal complete!\n");
> 
> maybe calibration instead of Cal

Yup thanks, also can use __func__ or just driver name.

> > +			break;
> > +		}
> > +
> > +		msleep(5);
> 
> I guess this will trigger a checkpatch warning
> 
> > +		i++;
> > +	} while (i > 5);
> 
> should be < 5????
> why not just use a for look?

Heheh yeah that looks really weird :) I guess I was too chicken to mess
with the calibration for the battery ADCs earlier so I tried to keep it
as it was in the Motorola driver. But now things are working and I can
compare the results so it should not be a problem.

> can't this code duplication be avoided?

Yeah so it seems, I'll take a look.

> > +/* Looks up temperatures in a table and calculates averages if needed */
> > +static unsigned short cpcap_adc_table_to_millicelcius(unsigned short value)
> 
> why unsigned if it returns millicelcius, shouldn't this be int to cover 
> the temperature rate?

Thanks yes. It was Kelvins in the Motorola driver.

Will fix up the rest of your comments and repost. Thanks for looking
and thanks for the good comments.

Regards,

Tony
