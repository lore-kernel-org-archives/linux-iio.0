Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:36873 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750924AbcGSIf7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2016 04:35:59 -0400
Subject: Re: [PATCH v2 3/4] mfd: add support for Allwinner SoCs ADC
To: Jonathan Cameron <jic23@kernel.org>, jdelvare@suse.com,
	linux@roeck-us.net, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org
References: <1468576754-3273-1-git-send-email-quentin.schulz@free-electrons.com>
 <1468576754-3273-4-git-send-email-quentin.schulz@free-electrons.com>
 <de8ebab2-cde9-d209-3c9a-e1868fafb84b@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	thomas.petazzoni@free-electrons.com,
	antoine.tenart@free-electrons.com
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <578DE662.90007@free-electrons.com>
Date: Tue, 19 Jul 2016 10:35:46 +0200
MIME-Version: 1.0
In-Reply-To: <de8ebab2-cde9-d209-3c9a-e1868fafb84b@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/07/2016 15:25, Jonathan Cameron wrote:
> On 15/07/16 10:59, Quentin Schulz wrote:
>> The Allwinner SoCs all have an ADC that can also act as a touchscreen
>> controller and a thermal sensor. For now, only the ADC and the thermal
>> sensor drivers are probed by the MFD, the touchscreen controller support
>> will be added later.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> Hmm. Previous patch includes the header this one creates.  Ordering issue?
> The depends kind of prevents build failures by ensuring that can't be built
> until this one is in place, but it is certainly an ugly way to do it.
> 
> Few little bits innline.
[...]
>> +static int sunxi_gpadc_mfd_probe(struct platform_device *pdev)
>> +{
>> +	struct sunxi_gpadc_mfd_dev *sunxi_gpadc_mfd_dev = NULL;
>> +	struct resource *mem = NULL;
> Neither of the above assignments is necessary as both will be explicitly
> assigned before they are otherwise used.

ACK.

[...]
>> +	dev_info(&pdev->dev, "successfully loaded\n");
> Seems like noise to me, but not my subsystem :)

ACK.
[...]
