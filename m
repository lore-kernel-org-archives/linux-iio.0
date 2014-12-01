Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33238 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932160AbaLAVDM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Dec 2014 16:03:12 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so18866441wiv.8
        for <linux-iio@vger.kernel.org>; Mon, 01 Dec 2014 13:03:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <547CD4C0.80304@metafoo.de>
References: <1416919687-14271-1-git-send-email-vlad.dogaru@intel.com>
	<5474B01D.8020701@metafoo.de>
	<CAEnQRZC_ax0n2b+pTiTVLk=0m+AzX7JkRHdB=8a70d8hQ3eD-Q@mail.gmail.com>
	<5474B59B.8000101@metafoo.de>
	<5D8E0479-F926-424A-B931-8A33BD99EC31@kernel.org>
	<CAEnQRZBURtX3=d9-sy1AvgipgqcYTiiL5TCjaSwMkeJd-XYh0w@mail.gmail.com>
	<547CCA2E.8010705@metafoo.de>
	<CAEnQRZAghZOXdut4vZr-HzRqhMSF3Dv+XccWAhY_NS65BxhUVg@mail.gmail.com>
	<547CD4C0.80304@metafoo.de>
Date: Mon, 1 Dec 2014 23:03:10 +0200
Message-ID: <CAEnQRZDkjvzWov46wG9f3f5d3omjEPM4q55+pZQEpwXUO2tHzw@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add valid sample channel
From: Daniel Baluta <daniel.baluta@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Daniel Baluta <daniel.baluta@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Vlad Dogaru <vlad.dogaru@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Dec 1, 2014 at 10:51 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 12/01/2014 09:46 PM, Daniel Baluta wrote:
> [...[
>>>>
>>>> User space application will read /dev/iio:deviceX to get data
>>>> samples. How would they know the source of the data samples?
>>>
>>>
>>>
>>> What exactly do you mean by source?
>>
>>
>> By source I mean accelerometer or magnetometer in the case of KMX61
>> sensor.
>
>
> The channel type of the iio device should make it pretty clear which one it
> is ;) You can also add a suffix to the IIO device name.

Well, this question was asked in the context of using a single IIO device
for both accel / magnetometer.

The user will open /dev/iio:deviceX and read accel/magnetometer samples.
In the case were sampling frequency is the same for both devices everything
is easy. The interesting case is the one when having a single IIO device
with 2 channels (accel/magn) with different sampling rates.

Anyhow, my implementation know uses 2 IIO devices and everything is clear.

Daniel.
