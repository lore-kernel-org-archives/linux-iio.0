Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from a.ns.miles-group.at ([95.130.255.143]:65275 "EHLO radon.swed.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751323AbbF3TkD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 30 Jun 2015 15:40:03 -0400
Message-ID: <5592F08E.8000702@nod.at>
Date: Tue, 30 Jun 2015 21:39:58 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
To: harald@ccbib.org, Hartmut Knaack <knaack.h@gmx.de>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCHv2 2/2] iio: dht11: Use new function ktime_get_resolution_ns()
References: <1428405156-6761-1-git-send-email-harald@ccbib.org> <1428405156-6761-3-git-send-email-harald@ccbib.org> <55267AEC.8000500@kernel.org> <E1Z9eHR-00014C-6g@stardust.g4.wien.funkfeuer.at> <55919E72.3010807@gmx.de> <02a909f41c0b1c16251d016d71ac86bc@imap.cosmopool.net>
In-Reply-To: <02a909f41c0b1c16251d016d71ac86bc@imap.cosmopool.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Am 30.06.2015 um 21:37 schrieb harald@ccbib.org:
> On Mon, 29 Jun 2015 21:37:22 +0200, Hartmut Knaack <knaack.h@gmx.de>
> wrote:
>> Harald Geyer schrieb am 29.06.2015 um 20:59:
>>> Hi Jonathan!
>>>
>>> Jonathan Cameron writes:
> [...]
>>>> Looks good to me.  Will wait for comments on the first patch though
>>>> before taking this... clearly that one will need a few acks if I take
>>>> it through IIO!
>>>
>>> The first patch has been merged via tip tree for 4.2 (is already
>>> available
>>> in staging-next tree). Are you going to pick up this patch or do I need
>>> to resend?
>>>
>>> Thanks,
>>> Harald
>>>
>>
>> Hi Harald,
>> there are a few small style issues, which checkpatch.pl --strict should
>> show you. 
> 
> Thanks for pointing out --strict - didn't know about that yet.

Don't take checkpatch.pl too seriously.

Thanks,
//richard
