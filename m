Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:4878 "EHLO
	mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbaKDXba (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Nov 2014 18:31:30 -0500
Message-ID: <54596172.9090908@imgtec.com>
Date: Tue, 4 Nov 2014 20:29:54 -0300
From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>, <pmeerw@pmeerw.net>,
	<knaack.h@gmx.de>
CC: <linux-iio@vger.kernel.org>, <jic23@kernel.org>,
	<james.hartley@imgtec.com>, <abrestic@chromium.org>,
	Phani Movva <Phani.Movva@imgtec.com>
Subject: Re: [PATCH 1/2] iio: adc: Cosmic Circuits 10001 ADC driver
References: <1414615531-26172-1-git-send-email-ezequiel.garcia@imgtec.com> <1414615531-26172-2-git-send-email-ezequiel.garcia@imgtec.com> <5453C494.4030906@metafoo.de>
In-Reply-To: <5453C494.4030906@metafoo.de>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi everyone,

Thanks for the review. I've fixed most of the comments except for the
invalid sample representation issue.

On 10/31/2014 02:19 PM, Lars-Peter Clausen wrote:
> On 10/29/2014 09:45 PM, Ezequiel Garcia wrote:
>> From: Phani Movva <Phani.Movva@imgtec.com>
>>
>> This commit adds support for Cosmic Circuits 10001 10-bit ADC device.
>>
>> Signed-off-by: Phani Movva <Phani.Movva@imgtec.com>
>> Signed-off-by: Naidu Tellapati <Naidu.Tellapati@imgtec.com>
>> [Ezequiel: code style cleaning]
>> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
> 
> Looks very good. Just a few very minor issues.
> 
> [...]
>> +static int cc_adc_poll_done(struct iio_dev *dev, int channel,
>> +                unsigned int delay)
>> +{
>> +    struct cc_10001_adc_device *adc_dev = iio_priv(dev);
>> +    int val = INVALID_SAMPLED_OUTPUT;
> 
> I'm not so sure that returning a fake sample is such a good idea. When
> reading from sysfs we should definitely return an error if there is one.

Right.

> For buffer reading dropping the sample is probably not such a good idea,
> but we should agree on and document a standard representation of invalid
> samples.
> 

Hm, sure. What do you suggest? I can't see other drivers doing anything
like this.

-- 
Ezequiel
