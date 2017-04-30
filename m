Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:34794 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425253AbdD3Q1M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Apr 2017 12:27:12 -0400
Subject: Re: [PATCH] staging: iio: isl29028: add isl29030 support
To: Brian Masney <masneyb@onstation.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
References: <20170428155558.17723-1-sebastian.reichel@collabora.co.uk>
 <20170428161716.GA3075@607924cbbc93>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d76123a7-36aa-df14-5a2f-12ab17224c57@kernel.org>
Date: Sun, 30 Apr 2017 17:27:07 +0100
MIME-Version: 1.0
In-Reply-To: <20170428161716.GA3075@607924cbbc93>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/04/17 17:17, Brian Masney wrote:
> On Fri, Apr 28, 2017 at 05:55:58PM +0200, Sebastian Reichel wrote:
>> isl29030 is basically the same chip. The only difference
>> is the chip's first pin. For isl29028 its named ADDR0 and
>> can be used to change the chip's i2c address. For isl29030
>> on the other hand that pin is named Ials and is an analog
>> current output proportional to ALS/IR. This change is
>> irrelevant for the Linux driver.
>>
>> This has been tested on Motorola Droid 4.
>>
>> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>> ---
>>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
>>  drivers/staging/iio/light/isl29028.c                      | 6 ++++++
>>  2 files changed, 7 insertions(+)
> 
> Hi Sebastian,
> 
> I moved this driver out of the staging directory earlier this week.
> You'll need to base your patch off of IIO testing:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/log/?h=testing
> 
> Your patch should apply cleanly once you update the file path.
I did it rather than having this bounce around for a trivial rebase.

Applied to the togreg branch of iio.git and pushed out as testing of
the autobuilders to play with it.

Thanks,

Jonathan
> 
> Brian
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

