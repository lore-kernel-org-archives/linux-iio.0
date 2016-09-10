Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from pruts.nl ([82.94.235.106]:57333 "EHLO fe2.pruts.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754249AbcIJPz0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Sep 2016 11:55:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by fe2.pruts.nl (Postfix) with ESMTP id 7BF0B140065
        for <linux-iio@vger.kernel.org>; Sat, 10 Sep 2016 17:55:23 +0200 (CEST)
Received: from fe2.pruts.nl ([IPv6:::ffff:127.0.0.1])
        by localhost (fe2.local [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4s7peJEiuVal for <linux-iio@vger.kernel.org>;
        Sat, 10 Sep 2016 17:55:21 +0200 (CEST)
Content-Type: text/plain; charset=UTF-8
From: Ico Doornekamp <ico@pruts.nl>
To: linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] Tiny whitespace fix to make ad7192.c cleanly pass checkpatch.pl
In-reply-to: <cfb0e4da-7f6c-da8e-441d-3027b18c2ec2@kernel.org>
References: <20160909134026.12055-1-ico@pruts.nl> <d848e8a4-d21d-8221-9e36-e89f653f9a35@metafoo.de> <cfb0e4da-7f6c-da8e-441d-3027b18c2ec2@kernel.org>
Date: Sat, 10 Sep 2016 17:55:21 +0200
Message-Id: <1473522671-sup-6934@pruts.nl>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

* On 2016-09-10 17:39:27 +0200, Jonathan Cameron wrote:
 
> On 09/09/16 14:59, Lars-Peter Clausen wrote:

> Just to explain a bit more.  Checkpatch is assuming that it is looking
> at two parameters. It's not. That's a string being passed into the macro.
> It ultimately forms a file name in sysfs.

Yeah, I figured that out eventually, after submitting the patch. Thanks
for explaining, though.

-- 
:wq
^X^Cy^K^X^C^C^C^C
