Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr40090.outbound.protection.outlook.com ([40.107.4.90]:15171
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751162AbdFCVh0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Jun 2017 17:37:26 -0400
Subject: Re: [PATCH v15 00/13] mux controller abstraction and iio/i2c muxes
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Rosin <peda@lysator.liu.se>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Colin Ian King <colin.king@canonical.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, kernel@pengutronix.de
References: <1494791476-14599-1-git-send-email-peda@lysator.liu.se>
 <20170603102627.GA24274@kroah.com> <20170603103121.GA9599@kroah.com>
From: Peter Rosin <peda@axentia.se>
Message-ID: <b1de713b-2256-a67c-86bb-31439aa66e54@axentia.se>
Date: Sat, 3 Jun 2017 23:37:15 +0200
MIME-Version: 1.0
In-Reply-To: <20170603103121.GA9599@kroah.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-06-03 12:31, Greg Kroah-Hartman wrote:
> On Sat, Jun 03, 2017 at 07:26:27PM +0900, Greg Kroah-Hartman wrote:
>> On Sun, May 14, 2017 at 09:51:03PM +0200, Peter Rosin wrote:
>>> From: Peter Rosin <peda@axentia.se>
>>>
>>> Hi Greg,
>>>
>>> Philipp found problems in v14 with using a mutex for locking that was
>>> the outcome of the review for v13, so I'm now using a semaphore instead
>>> of the rwsem that was in v13. That at least got rid of the scary call
>>> to downgrade_write. However, I'm still unsure about what you actually
>>> meant with your comment about lack of sparse markings [1]. I did add
>>> __must_check to the funcs that selects the mux, but I've got this
>>> feeling that this is not what you meant?
>>
>> I thought there was a way to mark a function as requiring a lock be held
>> when it is being called.  Does sparse not support that anymore?
> 
> Anyway, not a big deal.  I still worry about the calls blocking when
> people are not expecting them to, but it is just the nature of th api I
> guess.

Yeah, first come first serve. I don't know what else I can do, except maybe
follow up with a timed version of mux_control_select()...

> All now queued up, nice work, thanks for sticking with this.

*big sigh of relief*

I was getting pretty fed up with the series to be honest :-), so thanks
a bunch for taking it!

Cheers,
peda

