Return-Path: <SRS0=8Li7=4L=linux.intel.com=mika.westerberg@kernel.org>
Date: Fri, 5 May 2017 13:40:26 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sascha Weisenberger <sascha.weisenberger@siemens.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3] iio: adc: Add support for TI ADC108S102 and ADC128S102
Message-ID: <20170505104026.GS2697@lahna.fi.intel.com>
References: <6d6bf102-1bc9-7019-13fa-b8f86b002dc8@siemens.com>
 <20170505094009.GP2697@lahna.fi.intel.com>
 <5d96337b-df40-b3eb-8d03-cdb2b55af9b3@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5d96337b-df40-b3eb-8d03-cdb2b55af9b3@siemens.com>
List-ID: <linux-iio@vger.kernel.org>

On Fri, May 05, 2017 at 12:23:26PM +0200, Jan Kiszka wrote:
> >> +	} else {
> >> +		st->reg = devm_regulator_get(&spi->dev, "vref");
> >> +		if (IS_ERR(st->reg))
> >> +			return PTR_ERR(st->reg);
> > 
> > This should be an optional regulator and in case of ACPI you just don't
> > have it.
> 
> It's mandatory for this DT case, so I will not change that.

Well, it would be better if you don't need to deviate in the driver like
this. And it clearly is optional because in case of ACPI you don't need
it.

Not my call, though.
