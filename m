Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33685 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbdE2Fka (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 May 2017 01:40:30 -0400
Received: by mail-lf0-f52.google.com with SMTP id m18so28985710lfj.0
        for <linux-iio@vger.kernel.org>; Sun, 28 May 2017 22:40:30 -0700 (PDT)
Subject: Re: [PATCH/RFC] iio: hi8435: do not enable all events by default
To: Jonathan Cameron <jic23@kernel.org>
References: <20170523080830.20571-1-nikita.yoush@cogentembedded.com>
 <20170524202735.3cf4e14e@kernel.org>
 <2e6019f5-94fc-bb13-f616-0c1cfe81a7db@cogentembedded.com>
 <20170528164846.3fa3d4d8@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Gregor Boirie <gregor.boirie@parrot.com>,
        Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chris Healy <Chris.Healy@zii.aero>,
        Jeff White <Jeff.White@zii.aero>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Message-ID: <b47aa21c-925d-7a83-7bd0-0d9d73f79017@cogentembedded.com>
Date: Mon, 29 May 2017 08:40:26 +0300
MIME-Version: 1.0
In-Reply-To: <20170528164846.3fa3d4d8@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

>> Still, isn't there subsystem-level default that all events are disabled
>> by default?  If such, then current hi8435 state breaks subsystem-level
>> rules, which is a [userspace-visible] bug.  I'm not sure how far should
>> we go in bug compatibility.
>
> It is indeed the subsystem default (as much as we have one)
> 
> This is a moderately obscure chip for linux systems, do we have a good handle
> on where it is being used - i.e. are most of the devices under control of
> people we can discuss this with?

Company I work with, uses this chip in several boards; what they need is
a service that monitors all connected chip's outputs and detects
changes.  They originally wanted gpio-style access to use with userspace
polling, and were not pleased with entire IIO thing. However it's
important for them to minimize required kernel patches against mainline,
thus if mainline supports this chip as IIO device that's ok for them.

Questions like default event enable state has little practical impact.
It's more about keeping architecture clean.

Nikita
