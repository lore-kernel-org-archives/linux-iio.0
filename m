Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49018 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbaIUMWf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Sep 2014 08:22:35 -0400
Message-ID: <541EC308.1020004@kernel.org>
Date: Sun, 21 Sep 2014 13:22:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: Peter Meerwald <pmeerw@pmeerw.net>,
	IIO <linux-iio@vger.kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Ramakrishna Pallala <ramakrishna.pallala@intel.com>
Subject: Re: [PATCH v2 4/4] iio/adc/axp288: add support for axp288 gpadc
References: <1410267775-4683-1-git-send-email-jacob.jun.pan@linux.intel.com>	<1410267775-4683-5-git-send-email-jacob.jun.pan@linux.intel.com>	<alpine.DEB.2.01.1409091509110.26919@pmeerw.net>	<20140919094310.6f045021@ultegra>	<1411147870.3829.31.camel@spandruv-hsb-test> <20140919124751.01c2de00@ultegra>
In-Reply-To: <20140919124751.01c2de00@ultegra>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/09/14 20:47, Jacob Pan wrote:
> On Fri, 19 Sep 2014 10:31:10 -0700
> Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:
> 
>> On Fri, 2014-09-19 at 09:43 -0700, Jacob Pan wrote:
>>> On Tue, 9 Sep 2014 15:46:31 +0200 (CEST)
>>> Peter Meerwald <pmeerw@pmeerw.net> wrote:
>>>
>>>>> +static int axp288_gpadc_remove(struct platform_device *pdev)
>>>>> +{
>>>>> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>>>>> +
>>>>> +	iio_device_unregister(indio_dev);
>>>>> +	iio_map_array_unregister(indio_dev);  
>>>>
>>>> axp288_gpadc_enable(axp2xx->regmap, false);
>>> on a second thought, we should not disable the adc even on driver
>>> removal. otherwise, internal fuel gauge will be affected.
>> As an independent driver it should disable when driver is removed and
>> bring back to state before init. You can check the state at init and
>> restore to that state on exit.
>> If the FG or other driver has dependency then either it should use the
>> driver model to take reference by not allowing removal of this driver.
>> Or use built in module so that it can never be removed.
>>  
> I share you opinion. But in this case, ideally ADCs should have been
> enabled by FW since it should be always on, independent of fuel gauge
> driver.
>> Isn't it a platform specific dependency not universal?
>>
> it is more PMIC specific since its internal fuel gauge depends on ADC
> to be available regardless of what platform.
Whilst irritating this isn't exactly uncommon.
Probably just don't touch it but put a comment in the driver to that
effect so it is obvious this wasn't just an omission.

Jonathan
>> Thanks,
>> Srinivas
>>  
>>
> 
> [Jacob Pan]
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
