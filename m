Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:55466 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368AbaKDXn3 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Nov 2014 18:43:29 -0500
Message-ID: <54596441.6060009@imgtec.com>
Date: Tue, 4 Nov 2014 20:41:53 -0300
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, <linux-iio@vger.kernel.org>,
	<lars@metafoo.de>, <jic23@kernel.org>,
	<Naidu.Tellapati@imgtec.com>, <james.hartley@imgtec.com>,
	<abrestic@chromium.org>
CC: Phani Movva <Phani.Movva@imgtec.com>
Subject: Re: [PATCH 1/2] iio: adc: Cosmic Circuits 10001 ADC driver
References: <1414615531-26172-1-git-send-email-ezequiel.garcia@imgtec.com> <1414615531-26172-2-git-send-email-ezequiel.garcia@imgtec.com> <54556892.7010805@gmx.de>
In-Reply-To: <54556892.7010805@gmx.de>
Content-Type: text/plain; charset="iso-8859-15"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Hartmut,

Thanks for the review. It seems I missed lots of details in this driver!

On 11/01/2014 08:11 PM, Hartmut Knaack wrote:
[..]

>> +
>> +	dev->dev.parent = &pdev->dev;
>> +	dev->name = dev_name(&pdev->dev);
>> +	dev->info = &cc_10001_adc_info;
>> +	dev->modes = INDIO_DIRECT_MODE;
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> Check for error?

Nope, this one is used like this. See the comment in lib/devres.c.

Thanks again!
-- 
Ezequiel
