Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:49679 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751519Ab1LRTof (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 18 Dec 2011 14:44:35 -0500
Message-ID: <4EEE4286.5040101@metafoo.de>
Date: Sun, 18 Dec 2011 20:44:06 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: Greg KH <greg@kroah.com>, Greg Kroah-Hartman <gregkh@suse.de>,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 3/3] staging:iio: Fix scan mask update
References: <1323365753-7645-1-git-send-email-lars@metafoo.de> <1323365753-7645-3-git-send-email-lars@metafoo.de> <20111208201841.GA338@kroah.com> <4EE1D9B9.3000309@metafoo.de> <20111209151102.GA18821@kroah.com> <4EEE2A9F.4080602@kernel.org>
In-Reply-To: <4EEE2A9F.4080602@kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/18/2011 07:02 PM, Jonathan Cameron wrote:
> On 12/09/2011 03:11 PM, Greg KH wrote:
>> On Fri, Dec 09, 2011 at 10:49:45AM +0100, Lars-Peter Clausen wrote:
>>> On 12/08/2011 09:18 PM, Greg KH wrote:
>>>> On Thu, Dec 08, 2011 at 06:35:53PM +0100, Lars-Peter Clausen wrote=
:
>>>>> When updating the scan mask we have to check the actual scan mask=
 for if the
>>>>> channel is already enabled, not the matching scan mask from the a=
vailable
>>>>> scan masks. The bit will already be set there and as a result the=
 actual
>>>>> scan mask will not get updated and the channel stays disabled.
>>>>>
>>>>> Also fix the return value of iio_scan_el_store which would return=
 1 instead of
>>>>> the number of bytes written if the channel was already active in =
the scan mask.
>>>>
>>>> You just added a complier warning with this patch:
>>>>   CC [M]  drivers/staging/iio/industrialio-buffer.o
>>>> drivers/staging/iio/industrialio-buffer.c: In function =E2=80=98ii=
o_scan_mask_query=E2=80=99:
>>>> drivers/staging/iio/industrialio-buffer.c:621:8: warning: unused v=
ariable =E2=80=98mask=E2=80=99 [-Wunused-variable]
>>>>
>>>> So I didn't apply it.
>>>
>>> Actually you did. At least it is in staging-next. Should I resend a=
 updated
>>> patch or just a patch removing the now unused mask variable.
>>
>> Ugh, you are right, I was messing with my scripts to apply patches a=
t
>> the time, and forgot to delete this branch.
>>
>> So, please send a follow-on patch to fix the warning.
>>
> Lars-Peter, have you sent such a patch to Greg?  I'm still seeing thi=
s
> warning hence the bump! Just wondering if this got lost in amongst
> everything else that is going on.

Haven't send it out yet. Will do tomorrow.
