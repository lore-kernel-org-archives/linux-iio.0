Return-Path: <SRS0=IaaV=ZY=axentia.se=peda@kernel.org>
Subject: Re: [PULL] IIO fixes for 4.10 set 3 - a couple of regression fixes.
To: Jonathan Cameron <jic23@kernel.org>, <linux-kernel@vger.kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
References: <1485981657-14586-1-git-send-email-peda@axentia.se>
 <1485981657-14586-2-git-send-email-peda@axentia.se>
 <2648bf01-840e-d555-8a65-03d1d13c6ed2@kernel.org>
CC: Ken Lin <ken.lin@advantech.com>, <linux-iio@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <2648bf01-840e-d555-8a65-03d1d13c6ed2@kernel.org>
Message-ID: <c080d4bb-9359-7218-cf30-1ea727b56184@axentia.se>
Date: Fri, 10 Feb 2017 23:35:35 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

> On Sun, Feb 05, 2017 at 10:35:02AM +0000, Jonathan Cameron wrote:
>> The following changes since commit 5c113b5e0082e90d2e1c7b12e96a7b8cf0623e27:
>> 
>>   iio: dht11: Use usleep_range instead of msleep for start signal (2017-01-22 13:35:40 +0000)
>> 
>> are available in the git repository at:
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-4.10c
> 
> It's a bit late for 4.10 for me, can I just pull this into my -next
> branch and will they get to 4.10.1 properly?  Meaning, do that have cc:
> stable markings on them?  Or do you want to fix that up and resend this
> request?

Hi Greg,

You should ask Ken Lin who has the HW and who is apparently affected.
I think it's bad that you are willing to have a known regression hit
v4.10 when all was fine in v4.9. Or perhaps you didn't realize that
the regression was from this cycle?

The fixes are obvious. I don't understand your hesitation.

Cheers,
peda
