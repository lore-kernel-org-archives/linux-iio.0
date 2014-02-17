Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bl2lp0210.outbound.protection.outlook.com ([207.46.163.210]:39792
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752982AbaBQBdP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 16 Feb 2014 20:33:15 -0500
From: "fugang.duan@freescale.com" <fugang.duan@freescale.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
	"sachin.kamat@linaro.org" <sachin.kamat@linaro.org>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"lars@metafoo.de" <lars@metafoo.de>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v5 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc
 driver
Date: Mon, 17 Feb 2014 01:32:55 +0000
Message-ID: <83fb2bb728594631a7b13be7211aa895@BLUPR03MB373.namprd03.prod.outlook.com>
References: <1390714773-23066-1-git-send-email-B38611@freescale.com>
 <1390714773-23066-3-git-send-email-B38611@freescale.com>
 <52FF3EEA.30606@kernel.org> <52FF4160.8010909@kernel.org>
In-Reply-To: <52FF4160.8010909@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Jonathan Cameron <jic23@kernel.org>
Data: Saturday, February 15, 2014 6:29 PM

>To: Duan Fugang-B38611
>Cc: shawn.guo@linaro.org; sachin.kamat@linaro.org; pmeerw@pmeerw.net;
>lars@metafoo.de; mark.rutland@arm.com; linux-iio@vger.kernel.org
>Subject: Re: [PATCH v5 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc driver
>
>On 15/02/14 10:18, Jonathan Cameron wrote:
>> On 26/01/14 05:39, Fugang Duan wrote:
>>> Add Freescale Vybrid vf610 adc driver. The driver only support ADC
>>> software trigger.
>>>
>>> VF610 ADC device documentation is available at below reference manual
>>> (chapter 37):
>>> http://cache.freescale.com/files/32bit/doc/ref_manual/VYBRIDRM.pdf?
>>> fpsp=1&WT_TYPE=Reference%20Manuals&WT_VENDOR=FREESCALE&WT_FILE_FORMAT
>>> =pdf&WT_ASSET=Documentation
>>>
>>> CC: Shawn Guo <shawn.guo@linaro.org>
>>> CC: Jonathan Cameron <jic23@kernel.org>
>>> CC: Mark Rutland <mark.rutland@arm.com>
>>> CC: Otavio Salvador <otavio@ossystems.com.br>
>>> CC: Peter Meerwald <pmeerw@pmeerw.net>
>>> CC: Lars-Peter Clausen <lars@metafoo.de>
>>> Signed-off-by: Fugang Duan <B38611@freescale.com>
>>
>> I very much like the simplified approach you have taken for this
>> initial merge.  Much easier to start simple and build up to the more
>> complex functionality.
>>
>> There was one missing mutex unlock in an error path (noted below). I have
>> fixed that and applied to the togreg branch of iio.git.   This will initially
>> go out as the testing branch for the autobuilders to play with it.
>>
>> Also devm_irq requests always make me nervous, but I think this one is
>> fine so have left it alone
>>
>> Jonathan
>As an update I also fixed up the build - see below.  One day I'll no send out
>applied messages until after my local build tests have finished!
>
>Note that it is this sort of thing that has led me to pushing out a testing
>branch as that catches all the weird combinations that I don't.
>
>>> +
>>> +static const struct iio_info vf610_adc_iio_info = {
>>> +    .driver_module = THIS_MODULE,
>>> +    .read_raw = &vf610_read_raw,
>>> +    .write_raw = &vf610_write_raw,
>>> +    .debugfs_reg_access = &vf610_adc_reg_access,
>>> +    .attrs = &vf610_attribute_group, };
>>> +
>>> +static const struct of_device_id vf610_adc_match[] = {
>>> +    { .compatible = "fsl,vf610-adc", },
>>> +    { /* sentinel */ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, vf610_adc_dt_ids);
>Your MODULE_DEVICE_TABLE needs to take a second variable that actually exists...
>Also needs to depend in the KCONFIG on OF to avoid build issues on other
>platforms.
>
>I've added both.
>

Jonathan,  thanks!
