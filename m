Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from thoth.sbs.de ([192.35.17.2]:56547 "EHLO thoth.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S980492AbdDYGGT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 25 Apr 2017 02:06:19 -0400
Subject: Re: [PATCH] iio: adc: Add support for TI ADC1x8s102
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <6e0f0b52-27a1-0ce5-c217-3aa941babe63@siemens.com>
 <1493064330.24567.180.camel@linux.intel.com>
Cc: linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sascha Weisenberger <sascha.weisenberger@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <d0882257-5fe9-4b1b-af3c-812972b68770@siemens.com>
Date: Tue, 25 Apr 2017 08:06:01 +0200
MIME-Version: 1.0
In-Reply-To: <1493064330.24567.180.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-04-24 22:05, Andy Shevchenko wrote:
>> +{
>> +	int ret;
>> +	struct adc1x8s102_state *st;
>> +
>> +	st = iio_priv(indio_dev);
>> +
>> +	switch (m) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		mutex_lock(&indio_dev->mlock);
>> +		if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
>> {
>> +			ret = -EBUSY;
> 
>> +			dev_warn(&st->spi->dev,
>> +			 "indio_dev->currentmode is
>> INDIO_BUFFER_TRIGGERED\n");
> 
> Indentation?

Actually, this block needs to be converted to
iio_device_claim_direct_mode / iio_device_release_direct_mode, instead
of doing the old open-coded locking way.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA ITP SES-DE
Corporate Competence Center Embedded Linux
