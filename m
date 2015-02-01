Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35184 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751016AbbBAKCq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 Feb 2015 05:02:46 -0500
Message-ID: <54CDF9C1.40202@kernel.org>
Date: Sun, 01 Feb 2015 10:02:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "devendra.aaru" <devendra.aaru@gmail.com>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
Subject: Re: [PATCH V2 1/2] iio: meter: ade7754: add error handling in _reset
 and _stop_device
References: <1420189375-19854-1-git-send-email-devendra.aaru@gmail.com>	<54A91EBE.9030608@kernel.org> <CAHdPZaNNj-54aVhE-rCCg3xqq4tZo=S7n7=ikKWc9GQ6bghhtg@mail.gmail.com>
In-Reply-To: <CAHdPZaNNj-54aVhE-rCCg3xqq4tZo=S7n7=ikKWc9GQ6bghhtg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/01/15 06:12, devendra.aaru wrote:
> On Sun, Jan 4, 2015 at 6:06 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 02/01/15 09:02, Devendra Naga wrote:
>>> This patch adds the error handling for the value returned from
>>> ade7754_spi_read_reg_8. With this patch, the following randconfig
>>> warnings get fixed automatically.
>>>
>>> drivers/staging/iio/meter/ade7754.c:222:6: warning: ‘val’ may be used
>>> uninitialized in this function [-Wmaybe-uninitialized]
>>> drivers/staging/iio/meter/ade7754.c:368:6: warning: ‘val’ may be used
>>> uninitialized in this function [-Wmaybe-uninitialized]
>>>
>>> Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
>> Looks good to me.  A Hartmut reviewed the original patch I'll leave it
>> a few days to see if he wants to take a look at the update.
>>
>> Thanks,
>>
>> Jonathan
>>> ---
> 
> Thanks for the review Jonathan.
Applied to the togreg branch of iio.git.  These have missed the
merge window for this cycle (sorry, I forgot about them!)

Anyhow, will get queued up for after the window closes.

J
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

