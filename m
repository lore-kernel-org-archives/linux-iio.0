Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34040 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756410AbdCGXYy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 7 Mar 2017 18:24:54 -0500
Received: by mail-qk0-f194.google.com with SMTP id v125so5688674qkh.1
        for <linux-iio@vger.kernel.org>; Tue, 07 Mar 2017 15:23:27 -0800 (PST)
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] iio: dac: Add support for ltc2632 DACs
From: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
In-Reply-To: <08c5ea7c-e7fd-3ff9-06b3-d84245ef71f4@kernel.org>
Date: Tue, 7 Mar 2017 10:59:53 -0500
Cc: Maxime Roussin-Belanger <maxime.roussinbelanger@gmail.com>,
        linux-iio@vger.kernel.org
Message-Id: <A7311725-BCB9-4321-9C11-945BE7FA13CA@gmail.com>
References: <20170302190127.23157-1-maxime.roussinbelanger@gmail.com> <08c5ea7c-e7fd-3ff9-06b3-d84245ef71f4@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Jonathan,

Thanks for the great feedback. I am working with Maxime on this driver.

> On Mar 4, 2017, at 14:03, Jonathan Cameron <jic23@kernel.org> wrote:
>=20
>> +static const struct iio_chan_spec_ext_info ltc2632_ext_info[] =3D {
>> +	{
>> +		.name =3D "powerdown",
> Why have this as a sysfs attribute? It's new ABI so should be =
documented
> and justified.
>=20
> Normally having explicit power up and powerdown of devices is somewhat
> frowned upon as it can often be implicitly done depending on the state
> of the machine etc (runtime pm and similar). If that's not the case =
here
> please provide some explanatory comments.

I understand what you mean. We just copy/pasted from a neighbouring =
driver but
plan on using the feature. I will give you our use case as an example. =
We use
this DAC to drive amplifiers in an acquisition subsystem. This subsystem =
may be
offline for long durations (when no acquisition is taking place). The =
system
still needs to be fully awake as the user is simply doing something else =
with
the unit at that moment.

Trying to bear with you I would ask: are there ways to define different =
alert
states with more granularity than "sleeping" and "awake", which would =
allow
us to tie the powerdown state of the chips? If so, quick pointers would =
be
appreciated.

>>=20
>> +#define LTC2632_CHANNEL(_chan, _bits) { \
>> +		.type =3D IIO_VOLTAGE, \
>> +		.indexed =3D 1, \
>> +		.output =3D 1, \
>> +		.channel =3D (_chan), \
>> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW), \
>> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE), =
\
>> +		.address =3D (_chan), \
>> +		.scan_type =3D { \
>> +			.sign		=3D 'u', \
>> +			.realbits	=3D (_bits), \
>> +			.storagebits	=3D 16, \
>> +			.shift		=3D 16 - (_bits), \
> Hmm. Without buffers for output devices some of this is never used, =
but
> it does provide 'documentation' of a type so fine to leave it here.

Guilty of plagiarism, we do not master the iio subsystem yet. We copied
5624r_spi.c and tweaked it for this chip. We did not intend to document =
by doing
this. Can you suggest a different version of this struct?

Thanks again!=
