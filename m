Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-he1eur01on0137.outbound.protection.outlook.com ([104.47.0.137]:48617
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752478AbdEENT7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 5 May 2017 09:19:59 -0400
Subject: Re: [PATCH v13 03/10] mux: minimal mux subsystem and gpio-based mux
 controller
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1492101794-13444-1-git-send-email-peda@axentia.se>
 <1492101794-13444-4-git-send-email-peda@axentia.se>
 <20170418085156.GA4773@kroah.com>
 <bdeecccf-02d6-226b-8516-1d41e3602a7a@axentia.se>
CC: <linux-kernel@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, <linux-i2c@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-doc@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, <kernel@pengutronix.de>
From: Peter Rosin <peda@axentia.se>
Message-ID: <a159179b-6e2f-ca92-20ce-898009773900@axentia.se>
Date: Fri, 5 May 2017 15:19:48 +0200
MIME-Version: 1.0
In-Reply-To: <bdeecccf-02d6-226b-8516-1d41e3602a7a@axentia.se>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-04-18 12:59, Peter Rosin wrote:
> On 2017-04-18 10:51, Greg Kroah-Hartman wrote:
>> On Thu, Apr 13, 2017 at 06:43:07PM +0200, Peter Rosin wrote:
>>> +/**
>>> + * devm_mux_chip_unregister() - Resource-managed version mux_chip_unregister().
>>> + * @dev: The device that originally registered the mux-chip.
>>> + * @mux_chip: The mux-chip to unregister.
>>> + *
>>> + * See mux_chip_unregister() for more details.
>>> + *
>>> + * Note that you do not normally need to call this function.
>>
>> Odd, then why is it exported???
> 
> You normally don't call the devm_foo_{free,release,unregister,etc} functions.
> The intention is of course that the resourse cleans up automatically. But there
> are no cases where the manual clean up is not available, at least not that I can
> find?

I had a second look and there are of course plenty of examples of missing clean up
versions for devm function. I simply hadn't looked very hard at all.

So, for v15 I intend to remove all of devm_mux_chip_unregister, devm_mux_chip_free
and devm_mux_control_put. They are all just sitting there with no callers. And the
mux-mmio/video-mux drivers by Philipp Zabel that build on top of this series don't
need them either. Besides, easy to resurrect if needed...

I will do v15 with the above, the change from mutex to semaphore for locking the
mux controller state [1] and a few small documentation improvements. That will be
rebased onto v4.12-rc1 and sent in 10 days or so, or whenever v4.12-rc1 is out.

Meanwhile, what I currently intend for v15 but based on v4.11 is available from
https://gitlab.com/peda-linux/mux.git in the "mux" branch.

Cheers,
peda

[1] https://lkml.org/lkml/2017/4/25/411
