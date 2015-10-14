Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33683 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753025AbbJNLWO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 14 Oct 2015 07:22:14 -0400
Received: by wicge5 with SMTP id ge5so96245923wic.0
        for <linux-iio@vger.kernel.org>; Wed, 14 Oct 2015 04:22:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <56182DF5.2070507@gmx.de>
References: <CAEnQRZAf3Sp=NrC5S+4pW6=N4kS4cmqbXCesdd7e1b6mfKc-zA@mail.gmail.com>
	<56182DF5.2070507@gmx.de>
Date: Wed, 14 Oct 2015 14:22:12 +0300
Message-ID: <CAEnQRZCh-TKko++4BktBEFuD3OSu4zBMFb76hBYehDbrkX25ww@mail.gmail.com>
Subject: Re: Industrial I/O presentation at LinuxCon Europe
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Oct 10, 2015 at 12:13 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> Daniel Baluta schrieb am 09.10.2015 um 11:06:
>> Hi all,
>>
>> This Monday I presented an introduction to IIO at LinuxCon.
>>
>> The slides can be found here:
>>
>> * https://www.overleaf.com/articles/industrial-i-slash-o/dmqjqpzswtvb.pdf
>>
>> and soon they will be uploaded to Linux foundation site.
>>
>
> Awesome. Looks very good overall. But before uploading to Linux foundation,
> please consider the following remarks (I hope my brief notes make sense to you):
>
> Page 10: IIO_CHAN_PROCESSED => IIO_CHAN_INFO_PROCESSED
> Page 16: temp_channel => accel_channels? fill empty comment, IIO_CPU => IIO_LE?
> Page 21: several io => iio, highlighted "enable" in last line intended?
> Pages 20 and 25: deprecate terms "top half" and "bottom half" (IIRC there is now
> handler [h] for timing critical IRQ handling and thread [th] for uncritical work)?

Thanks Hartmut,

Fixed all of the above (except enable - which is reserved keyword in bash).

Slides are now on Linux Foundation website:

http://events.linuxfoundation.org/sites/events/files/slides/lceu15_baluta.pdf

Thanks all for the review.

Daniel.
