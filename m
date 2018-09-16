Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ve1eur01on0104.outbound.protection.outlook.com ([104.47.1.104]:58244
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726840AbeIPVJP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 16 Sep 2018 17:09:15 -0400
Date: Sun, 16 Sep 2018 17:45:40 +0200
In-Reply-To: <20180916103657.10cfb5ed@archlinux>
References: <20180915105241.22584-1-yuehaibing@huawei.com> <9f3c9f9a-6bb4-19ba-65ad-53f7edd2af20@axentia.se> <20180916103657.10cfb5ed@archlinux>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [PATCH -next] iio: potentiometer: mcp4018: merge calls to of_match_device and of_device_get_match_data
To: Jonathan Cameron <jic23@kernel.org>
CC: YueHaibing <yuehaibing@huawei.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
From: Peter Rosin <peda@axentia.se>
Message-ID: <36FE1E29-F807-44F8-B172-5EBB2C4A3455@axentia.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On September 16, 2018 11:36:57 AM GMT+02:00, Jonathan Cameron <jic23@kernel=
=2Eorg> wrote:
>On Sat, 15 Sep 2018 13:35:06 +0200
>Peter Rosin <peda@axentia=2Ese> wrote:
>
>> On 2018-09-15 12:52, YueHaibing wrote:
>> > Drop call to of_match_device, which is subsumed by the subsequent
>> > call to of_device_get_match_data=2E  The code becomes simpler, and a
>> > temporary variable can be dropped=2E
>> >=20
>> > Found by coccinelle=2E
>> >=20
>> > Signed-off-by: YueHaibing <yuehaibing@huawei=2Ecom> =20
>>=20
>> Acked-by: Peter Rosin <peda@axentia=2Ese>
>Similar change already in place from Julia Lawall back in May but
>looks like that just missed the last set for the merge window
>after I managed to loose it and only picked up again when Peter
>pointed it out in August=2E
>
>However, something odd is going on as these are not currently in
>next=2E
>
>Ah, looks line staging-next was updated 2 days ago and last linux-next
>is just before that=2E=20

Heh=2E I sure thought it looked familiar but assumed the old thing had hit=
 next a long time ago and that this was something else=2E=2E=2E

Cheers,
Peter
