Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41256 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752856AbcHOOqq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 10:46:46 -0400
Subject: Re: [PATCH] iio: pressure: bmp280: Fix incorrect pointer access in PM
 callbacks
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
References: <1471002271-11426-1-git-send-email-jarkko.nikula@linux.intel.com>
 <CACRpkdYd2vp9KMMv8sW9iNsWkO-j2deKwY_vdzGvqyGanT91gg@mail.gmail.com>
 <e2104071-78df-e83d-4dcf-fbb37ee36eed@linux.intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <beadcc22-db37-8f5b-9ce0-0d85e935013f@kernel.org>
Date: Mon, 15 Aug 2016 15:46:44 +0100
MIME-Version: 1.0
In-Reply-To: <e2104071-78df-e83d-4dcf-fbb37ee36eed@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/08/16 13:36, Jarkko Nikula wrote:
> On 08/12/2016 03:21 PM, Linus Walleij wrote:
>> On Fri, Aug 12, 2016 at 1:44 PM, Jarkko Nikula
>> <jarkko.nikula@linux.intel.com> wrote:
>>
>>> BMP280 runtime PM callbacks are incorrectly casting dev_get_drvdata() to
>>> struct bmp280_data * while bmp280_common_probe() sets driver data to
>>> struct iio_dev *. Fix this and get the struct bmp280_data * from private
>>> data of struct iio_dev.
>>>
>>> Fixes: 3d838118c6aa ("iio: pressure: bmp280: add power management")
>>> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
>>> ---
>>> For v4.8-rc.
>>
>> Sent a fix for this already two weeks ago:
>> http://marc.info/?l=linux-iio&m=146965159217655&w=2
>>
>> Just waiting for it to be picked up and merged.
>>
> Ok, please feel free to add my tested by to your patch then
> 
> Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Added.
