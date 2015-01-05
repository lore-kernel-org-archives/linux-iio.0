Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:44547 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750959AbbAEGMj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jan 2015 01:12:39 -0500
Received: by mail-pd0-f178.google.com with SMTP id r10so27636431pdi.9
        for <linux-iio@vger.kernel.org>; Sun, 04 Jan 2015 22:12:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <54A91EBE.9030608@kernel.org>
References: <1420189375-19854-1-git-send-email-devendra.aaru@gmail.com>
	<54A91EBE.9030608@kernel.org>
Date: Mon, 5 Jan 2015 01:12:39 -0500
Message-ID: <CAHdPZaNNj-54aVhE-rCCg3xqq4tZo=S7n7=ikKWc9GQ6bghhtg@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] iio: meter: ade7754: add error handling in _reset
 and _stop_device
From: "devendra.aaru" <devendra.aaru@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Jan 4, 2015 at 6:06 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> On 02/01/15 09:02, Devendra Naga wrote:
>> This patch adds the error handling for the value returned from
>> ade7754_spi_read_reg_8. With this patch, the following randconfig
>> warnings get fixed automatically.
>>
>> drivers/staging/iio/meter/ade7754.c:222:6: warning: ‘val’ may be used
>> uninitialized in this function [-Wmaybe-uninitialized]
>> drivers/staging/iio/meter/ade7754.c:368:6: warning: ‘val’ may be used
>> uninitialized in this function [-Wmaybe-uninitialized]
>>
>> Signed-off-by: Devendra Naga <devendra.aaru@gmail.com>
> Looks good to me.  A Hartmut reviewed the original patch I'll leave it
> a few days to see if he wants to take a look at the update.
>
> Thanks,
>
> Jonathan
>> ---

Thanks for the review Jonathan.
