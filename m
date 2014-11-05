Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42603 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751198AbaKENlX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 5 Nov 2014 08:41:23 -0500
Message-ID: <545A2901.1000802@kernel.org>
Date: Wed, 05 Nov 2014 13:41:21 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ezequiel Garcia <ezequiel.garcia@imgtec.com>,
	Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org,
	lars@metafoo.de, Naidu.Tellapati@imgtec.com,
	james.hartley@imgtec.com, abrestic@chromium.org
CC: Phani Movva <Phani.Movva@imgtec.com>
Subject: Re: [PATCH 1/2] iio: adc: Cosmic Circuits 10001 ADC driver
References: <1414615531-26172-1-git-send-email-ezequiel.garcia@imgtec.com> <1414615531-26172-2-git-send-email-ezequiel.garcia@imgtec.com> <54556892.7010805@gmx.de> <54596441.6060009@imgtec.com>
In-Reply-To: <54596441.6060009@imgtec.com>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/11/14 23:41, Ezequiel Garcia wrote:
> Hi Hartmut,
> 
> Thanks for the review. It seems I missed lots of details in this driver!
*laughs*

Actually a pretty clean driver - these guys just do a very good job
of a fine detail review!  (a lot less gets through than used to when
it was mostly myself doing the reviewing) Which is good because I get
far fewer little cleanups.


> 
> On 11/01/2014 08:11 PM, Hartmut Knaack wrote:
> [..]
> 
>>> +
>>> +	dev->dev.parent = &pdev->dev;
>>> +	dev->name = dev_name(&pdev->dev);
>>> +	dev->info = &cc_10001_adc_info;
>>> +	dev->modes = INDIO_DIRECT_MODE;
>>> +
>>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> Check for error?
> 
> Nope, this one is used like this. See the comment in lib/devres.c.
> 
> Thanks again!
> 
