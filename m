Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:44991 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751364AbdEEKXr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 May 2017 06:23:47 -0400
Subject: Re: [PATCH v3] iio: adc: Add support for TI ADC108S102 and ADC128S102
To: Mika Westerberg <mika.westerberg@linux.intel.com>
References: <6d6bf102-1bc9-7019-13fa-b8f86b002dc8@siemens.com>
 <20170505094009.GP2697@lahna.fi.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh@kernel.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <5d96337b-df40-b3eb-8d03-cdb2b55af9b3@siemens.com>
Date: Fri, 5 May 2017 12:23:26 +0200
MIME-Version: 1.0
In-Reply-To: <20170505094009.GP2697@lahna.fi.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-05-05 11:40, Mika Westerberg wrote:
> On Fri, May 05, 2017 at 08:31:32AM +0200, Jan Kiszka wrote:
>> +static int adc108s102_probe(struct spi_device *spi)
>> +{
>> +	struct adc108s102_state *st;
>> +	struct iio_dev *indio_dev;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	st = iio_priv(indio_dev);
>> +
>> +	if (ACPI_COMPANION(&spi->dev)) {
>> +		st->reg = NULL;
>> +		ret = device_property_read_u32(&spi->dev, "va-millivolt",
>> +					    &st->va_millivolt);
> 
> Please try to avoid things like this for now. You can just hard code the
> voltage now and we can think how to solve this in ACPI if there will be
> an actual user needing anything else than the voltage you are using on
> your board.

OK, so I will set a static 5V in case of ACPI. Fine as well.

> 
>> +		if (ret < 0) {
>> +			dev_err(&spi->dev,
>> +				"Missing va-millivolt device property\n");
>> +			return -ENODEV;
>> +		}
>> +	} else {
>> +		st->reg = devm_regulator_get(&spi->dev, "vref");
>> +		if (IS_ERR(st->reg))
>> +			return PTR_ERR(st->reg);
> 
> This should be an optional regulator and in case of ACPI you just don't
> have it.

It's mandatory for this DT case, so I will not change that.

Thanks,
Jan

> 
>> +
>> +		ret = regulator_enable(st->reg);
>> +		if (ret < 0) {
>> +			dev_err(&spi->dev, "Cannot enable vref regulator\n");
>> +			return ret;
>> +		}
>> +	}

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
