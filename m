Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46363 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab3LXSsj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 24 Dec 2013 13:48:39 -0500
In-Reply-To: <20131224182258.GA4587@kroah.com>
References: <52B71A03.5000907@kernel.org> <20131224182258.GA4587@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PULL] IIO fixes 3.13 - set 4
From: Jonathan Cameron <jic23@kernel.org>
Date: Tue, 24 Dec 2013 18:48:34 +0000
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Message-ID: <ee29edca-ee76-46b4-8237-76e2f39f5705@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Greg KH <gregkh@linuxfoundation.org> wrote:
>On Sun, Dec 22, 2013 at 04:57:39PM +0000, Jonathan Cameron wrote:
>> The following changes since commit
>c6236c0ce39c809c336ca929f68cf8ad02cf94e0:
>> 
>>   staging: comedi: drivers: fix return value of
>comedi_load_firmware() (2013-12-17 13:05:53 -0800)
>> 
>> are available in the git repository at:
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
>tags/iio-fixes-for-3.13d
>> 
>> for you to fetch changes up to
>83d5f3246fc05a629278240c09688fd9960b97db:
>> 
>>   staging:iio:ad799x fix incorrect endianness specification for
>buffer elements (2013-12-17 21:50:54 +0000)
>> 
>> ----------------------------------------------------------------
>> 4th round of iio fixes for the 3.13 cycle.
>> 
>> * Another miss reported endian fix that missed the last pull request
>due
>>   to a bug in the first version posted (which made it look like a
>cleanup
>>   rather than a fix).
>
>Is this a regression fix? 
Nope. It was never right though I guess at one point it was not specified rather than incorrectly specified. Long ago though!

> Can it wait for 3.14-rc1 and then go into
>3.13-stable as I really didn't want to have any more pull requests for
>3.13-final due to vacations...

Sure.  Have a good vacation.

>
>thanks,
>
>greg k-h



-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
