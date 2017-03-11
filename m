Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33458 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbdCKJTQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2017 04:19:16 -0500
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1703110741530.2202@hadrien>
References: <1489203401-17518-1-git-send-email-singhalsimran0@gmail.com> <alpine.DEB.2.20.1703110741530.2202@hadrien>
From: SIMRAN SINGHAL <singhalsimran0@gmail.com>
Date: Sat, 11 Mar 2017 14:49:13 +0530
Message-ID: <CALrZqyODTiF+gdwwYnmL1W1oi-R0u2rM4c40jb5iWXFxJpfdJw@mail.gmail.com>
Subject: Re: [Outreachy kernel] [PATCH 00/10] staging: iio: Remove exceptional
 & on functions name
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael.Hennerich@analog.com,
        Jonathan Cameron <jic23@kernel.org>, knaack.h@gmx.de,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Mar 11, 2017 at 12:12 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
> On Sat, 11 Mar 2017, simran singhal wrote:
>
>> This patch-series removes exceptional & on functions name.
>
> The semantic patch shown does nothing to check that the use of & is
> exception in the given file.  It just removes all the & on function names.
>
yes, I used this semantic patch only for only finding the functions with &
and then I find out this drivers and use semantic patch for removing &.

> julia
>
>>
>> simran singhal (10):
>>   staging: iio: ad7192: Remove exceptional & on function name
>>   staging: iio: ad7780: Remove exceptional & on function name
>>   staging: iio: cdc: ad7746: Remove exceptional & on function name
>>   staging: iio: cdc: ad7152: Remove exceptional & on function name
>>   staging: iio: adis16240: Remove exceptional & on function name
>>   staging: iio: adis16201: Remove exceptional & on function name
>>   staging: iio: adis16209: Remove exceptional & on function name
>>   staging: iio: adis16203: Remove exceptional & on function name
>>   staging: iio: resolver: Remove exceptional & on function name
>>   staging: iio: gyro: Remove exceptional & on function name
>>
>>  drivers/staging/iio/accel/adis16201.c     |  4 ++--
>>  drivers/staging/iio/accel/adis16203.c     |  4 ++--
>>  drivers/staging/iio/accel/adis16209.c     |  4 ++--
>>  drivers/staging/iio/accel/adis16240.c     |  4 ++--
>>  drivers/staging/iio/adc/ad7192.c          | 12 ++++++------
>>  drivers/staging/iio/adc/ad7780.c          |  2 +-
>>  drivers/staging/iio/cdc/ad7152.c          |  6 +++---
>>  drivers/staging/iio/cdc/ad7746.c          |  4 ++--
>>  drivers/staging/iio/gyro/adis16060_core.c |  2 +-
>>  drivers/staging/iio/resolver/ad2s1200.c   |  2 +-
>>  drivers/staging/iio/resolver/ad2s90.c     |  2 +-
>>  11 files changed, 23 insertions(+), 23 deletions(-)
>>
>> --
>> 2.7.4
>>
>> --
>> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
>> To post to this group, send email to outreachy-kernel@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1489203401-17518-1-git-send-email-singhalsimran0%40gmail.com.
>> For more options, visit https://groups.google.com/d/optout.
>>
