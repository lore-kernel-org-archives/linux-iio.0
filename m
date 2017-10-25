Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:49808 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751702AbdJYSIL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 25 Oct 2017 14:08:11 -0400
Subject: Re: iio/accel/bmc150: Improve unlocking of a mutex in two functions
To: Hans de Goede <hdegoede@redhat.com>, linux-iio@vger.kernel.org
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <66d582a4-a77e-cd78-4215-49587ec2259e@users.sourceforge.net>
 <fb223eb2-ddab-396e-372e-e9496be8bf0f@redhat.com>
 <c32ea2ea-5961-6589-6b51-1184d9565a38@users.sourceforge.net>
 <6a2c614a-4d0d-f2d2-1689-4c67a2fc3eea@redhat.com>
 <7a76d804-797c-8a7f-a755-9e42f9157287@users.sourceforge.net>
 <26467a3c-00e7-7358-5087-bf35469feb06@redhat.com>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <12013256-ad6a-86ed-9bc1-e5d868189914@users.sourceforge.net>
Date: Wed, 25 Oct 2017 20:07:48 +0200
MIME-Version: 1.0
In-Reply-To: <26467a3c-00e7-7358-5087-bf35469feb06@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> What you are suggesting breaks this pattern

I might be looking for an other balance between involved implementation
details after your constructive feedback for my first approach
in this software module.


> (not using a goto in the last if (err) case)

I would find it nice when a bit more code reduction is feasible.


> which makes the code harder to read and makes things harder
> (and potentially leads to introducing bugs) when
> a step4() gets added.

There is a choice between conservative adjustments and progressive
software refactoring where both directions can lead to similar
development risks.


>>> because that way the error handling is consistent between all steps
>>> and if another step is later added at the end, the last step will
>>> not require modification.

Such a view might express a change resistance.


>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/iio/accel/kxcjk-1013.c?id=1540d0106bcbc4e52013d759a0a0752ae7b4a09d#n760
> 
> So I just checked this one,

Thanks for your interest.


> this one is tricky because the lock is taking inside
> a switch-case and doing gotos inside the case is not pretty.

I imagine that I would like to use scoped lock objects
in affected source files. (Other programming languages support
such synchronisation constructs directly.)


> Basically I believe there is no one-size fits all solution
> here and refactoring like this may introduce bugs, so one
> needs to weight the amount of work + regression risk vs
> the benefits of the code being cleaner going forward.

It seems that our software development discussion can be
continued in a constructive way then.

Regards,
Markus
