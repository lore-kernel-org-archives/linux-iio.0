Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH 1/2] staging:iio:adis16204: Remove adis16204 driver
To: Jonathan Cameron <jic23@kernel.org>
References: <1457360552-12314-1-git-send-email-lars@metafoo.de>
 <56E09075.5070202@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Peter Meerwald <pmeerw@pmeerw.net>,
 linux-iio@vger.kernel.org
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56E14209.60407@metafoo.de>
Date: Thu, 10 Mar 2016 10:44:41 +0100
MIME-Version: 1.0
In-Reply-To: <56E09075.5070202@kernel.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 03/09/2016 10:07 PM, Jonathan Cameron wrote:
> On 07/03/16 14:22, Lars-Peter Clausen wrote:
>> The ADIS16204 part has been obsoleted, which makes it hard to get the
>> hardware to even test the driver. Considering this there is no expectation
>> that the driver will be cleaned up and be able to move out of staging, so
>> remove the driver.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Applied. Pity in a way as these were interesting parts.
> (read that as downright odd/esoteric ;)

The interesting one was the 220, but there are others like it and I get
asked on a regular basis if it is supported yet, so they might come back at
some point.

- Lars
