Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35974 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751032AbaALVia (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 12 Jan 2014 16:38:30 -0500
Message-ID: <52D30B59.3020705@kernel.org>
Date: Sun, 12 Jan 2014 21:38:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: Add Lite-On ltr501 ambient light / proximity
 sensor driver
References: <1389391305-9686-1-git-send-email-pmeerw@pmeerw.net> <52D130E9.4000508@kernel.org> <52D26AB3.2060500@metafoo.de>
In-Reply-To: <52D26AB3.2060500@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 12/01/14 10:13, Lars-Peter Clausen wrote:
> On 01/11/2014 12:54 PM, Jonathan Cameron wrote:
>>
>>
>> On 10/01/14 22:01, Peter Meerwald wrote:
>>> combined ambient light (two channels) and proximity sensor with I2C
>>> interface; the ALS channels are visible+IR and IR
>>>
>>> datasheet is here
>>> http://optoelectronics.liteon.com/upload/download/DS86-2012-0006/P_100_LTR-501ALS-01_PrelimDS_ver1.1.pdf
>>>
>>>
>>> v3:
>>> * fix use of sizeof in _read_als()
>>> v2: (thanks to Lars-Peter Clausen)
>>> * cannot use devm_iio_device_register() due to cleanup order in _remove()
>>> * mutex around data wait/read
>>> * turn info message in _probe() into check for part number
>>> * change copyright year to 2014
>>>
>>> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
>> Lets pretend I noticed this email before replying to V2.
>> I'll apply this one in a few days after Lars has had time to comment if he
>> wants to!
>
> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git - pushed out as testing for now.

Thanks,

Jonathan
>
