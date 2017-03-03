Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ve1eur01on0096.outbound.protection.outlook.com ([104.47.1.96]:45087
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751459AbdCCPvL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 3 Mar 2017 10:51:11 -0500
Subject: Re: [PATCH v9 00/10] mux controller abstraction and iio/i2c muxes
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1486568517-6997-1-git-send-email-peda@axentia.se>
 <6d87465f-b983-3f62-c7cf-41ed4e50170d@axentia.se>
 <20170228171842.GA11127@kroah.com>
CC: <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jonathan Corbet <corbet@lwn.net>, <linux-i2c@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <569c18b3-b1d8-f2e6-7fc4-897aa7df6775@axentia.se>
Date: Fri, 3 Mar 2017 16:30:45 +0100
MIME-Version: 1.0
In-Reply-To: <20170228171842.GA11127@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2017-02-28 18:18, Greg Kroah-Hartman wrote:
> On Tue, Feb 28, 2017 at 04:17:52PM +0100, Peter Rosin wrote:
>> Hi!
>>
>> The status of this series [1] is that Rob Herring has acked/reviewed all
>> devicetree changes, so I suppose that's ok. Jonathan Cameron has acked
>> the additions to the iio subsystem and reviewed the new iio driver.
>> Wolfram Sang has acked the i2c-mux driver. That's acks or reviews from
>> the maintainers for all changes to the maintained areas.
>>
>> What's not covered by the above is the mux subsystem itself. Jonathan
>> has also acked or reviewed those changes, but I get the feeling that
>> more tags are desired? So, please review the core of the mux subsystem
>> and the two drivers! It's small. Really. And much of it is boilerplate
>> devm functions. The relevant patches are:
>>
>>  3/10 "mux: minimal mux subsystem and gpio-based mux controller"
>> 10/10 "mux: adg792a: add mux controller driver for ADG792A/G"
>>
>> I also wonder how I should proceed next. Jonathan kindly provided some
>> hints. I have created a project on gitlab [2] to track future mux
>> changes and where this series is also available (in the "mux" branch,
>> of course subject to rebases, at least for now). I intend to create a
>> for-next branch that I hope Stephen Rothwell will be happy to add to
>> linux-next at some point after v4.11-rc1. Whomever I will feed future
>> changes to will also pull from that tree. Etc. At least that's my
>> picture of how this is going to work.
>>
>> The question then becomes to whom I will send pull requests? My guess is
>> that the plausible candidates are Greg K-H, Linus Torvalds and Andrew
>> Morton. Any taker? Are there other candidates? I don't have any particular
>> preference. If I don't hear anything I'll probably just send a pull
>> request to Linus for the next merge window (i.e. targeting 4.12-rc1).
>>
>> Or am I perhaps getting ahead of myself? Is a new tree overkill? I
>> don't expect it to be exactly busy...
> 
> I pull in lots of semi-random driver subsystems into my char-misc driver
> tree, and I can do that here for you as well if you want me to, to
> forward things on to Linus at the proper times.
> 
> Just let me know.

Ok, works for me. I'll send you the pull request when the time comes.

Jonathan, Wolfram, do you have any preferences on how this should be
coordinated regarding the new iio and i2c drivers (and iio changes)?

My plan is to at some point declare the branch immutable. Then both of
you can pull it in. Or? 

But now that I think about it I wonder what the point is of having
Greg pull it in also? Sure, third time's a charm and all that, but...

Cheers,
peda

