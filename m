Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:58790 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759974AbcIZJ0i (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 26 Sep 2016 05:26:38 -0400
Subject: Re: [PATCH] drivers: iio: dac: Fix sparse warning
To: Jonathan Cameron <jic23@kernel.org>,
        Sandhya Bankar <bankarsandhya512@gmail.com>,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org
References: <20160923192022.GA10786@localhost.localdomain>
 <04f40c36-9a05-f439-6d01-e59729e655e1@kernel.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e3910722-a8b8-9289-67a0-f0d0d64b8841@metafoo.de>
Date: Mon, 26 Sep 2016 11:26:29 +0200
MIME-Version: 1.0
In-Reply-To: <04f40c36-9a05-f439-6d01-e59729e655e1@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/24/2016 06:18 PM, Jonathan Cameron wrote:
> On 23/09/16 20:20, Sandhya Bankar wrote:
>> Fixing below warnings:
>>
>> drivers/iio/dac/ad5592r.c:58:41: warning: incorrect type in argument 2 (different base types)
>> drivers/iio/dac/ad5592r.c:58:41:    expected unsigned short [usertype] *buf
>> drivers/iio/dac/ad5592r.c:58:41:    got restricted __be16 *<noident>
>> drivers/iio/dac/ad5592r.c:62:41: warning: incorrect type in argument 2 (different base types)
>> drivers/iio/dac/ad5592r.c:62:41:    expected unsigned short [usertype] *buf
>> drivers/iio/dac/ad5592r.c:62:41:    got restricted __be16 *<noident>
>> drivers/iio/dac/ad5592r.c:92:41: warning: incorrect type in argument 2 (different base types)
>> drivers/iio/dac/ad5592r.c:92:41:    expected unsigned short [usertype] *buf
>> drivers/iio/dac/ad5592r.c:92:41:    got restricted __be16 *<noident>
>> drivers/iio/dac/ad5592r.c:110:41: warning: incorrect type in argument 2 (different base types)
>> drivers/iio/dac/ad5592r.c:110:41:    expected unsigned short [usertype] *buf
>> drivers/iio/dac/ad5592r.c:110:41:    got restricted __be16 *<noident>
>>
>> Signed-off-by: Sandhya Bankar <bankarsandhya512@gmail.com>
> Looks good to me.  Lars, will be a while before I send next pull if
> you want to comment on this as well.

Looks good, thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

