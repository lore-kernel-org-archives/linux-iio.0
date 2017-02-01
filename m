Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42581 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754367AbdBASun (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 1 Feb 2017 13:50:43 -0500
Subject: Re: [PATCH 5/5] iio: stx104: Add GPIO set_multiple callback function
 support
To: William Breathitt Gray <vilhelm.gray@gmail.com>
References: <cover.1484838095.git.vilhelm.gray@gmail.com>
 <53039e49d1421a6f070c691988eb22ef0987eba4.1484838095.git.vilhelm.gray@gmail.com>
 <1690f497-7b6a-f82d-b0d9-c395c42e9694@kernel.org>
 <20170131200335.GA4355@sophia>
Cc: linus.walleij@linaro.org, gnurou@gmail.com,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <a0b435a5-159a-14c6-534d-6478436004e8@kernel.org>
Date: Wed, 1 Feb 2017 18:50:33 +0000
MIME-Version: 1.0
In-Reply-To: <20170131200335.GA4355@sophia>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/01/17 20:03, William Breathitt Gray wrote:
> On Sun, Jan 22, 2017 at 01:23:07PM +0000, Jonathan Cameron wrote:
>> On 19/01/17 15:06, William Breathitt Gray wrote:
>>> The Apex Embedded Systems STX104 series provides a digital output
>>> register where 4 lines may be set at a time. This patch add support for
>>> the set_multiple callback function, thus allowing multiple digital
>>> output lines to be set more efficiently in groups.
>>>
>>> Cc: Jonathan Cameron <jic23@kernel.org>
>>> Cc: Hartmut Knaack <knaack.h@gmx.de>
>>> Cc: Lars-Peter Clausen <lars@metafoo.de>
>>> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
>>> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>> Acked-by: Jonathan Cameron <jic23@kernel.org>
> 
> Jonathan Cameron,
> 
> Would you pick this patch up in one of your iio.git branches?
Sure.  For some reason I got into my head this should go via the gpio
tree, but no reason why really.

Anyhow, applied, but there was some fuzz.

Applied to the toreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks.

Jonathan
> 
> Thanks,
> 
> William Breathitt Gray
> 

