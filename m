Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46214 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbbEGXdw (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 7 May 2015 19:33:52 -0400
Message-ID: <554BEF0A.2040805@kernel.org>
Date: Fri, 08 May 2015 00:02:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Daniel Baluta <daniel.baluta@gmail.com>,
	Antonio Ospite <ao2@ao2.it>
CC: Bastien Nocera <hadess@hadess.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: accel: kxcjk-1013: add the "KXCJ9000" ACPI id
References: <1430298111-20127-1-git-send-email-ao2@ao2.it>	<1430298111-20127-2-git-send-email-ao2@ao2.it>	<1430303320.2525.95.camel@hadess.net>	<20150429130132.27d00577390a4f0e37fbe1c9@ao2.it> <CAEnQRZD1aRJ8kr4xv8zWwopt_d2WJZOApnUihQbmvYiH68493g@mail.gmail.com>
In-Reply-To: <CAEnQRZD1aRJ8kr4xv8zWwopt_d2WJZOApnUihQbmvYiH68493g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/04/15 16:11, Daniel Baluta wrote:
> On Wed, Apr 29, 2015 at 2:01 PM, Antonio Ospite <ao2@ao2.it> wrote:
>> On Wed, 29 Apr 2015 12:28:40 +0200
>> Bastien Nocera <hadess@hadess.net> wrote:
>>
>>> On Wed, 2015-04-29 at 11:01 +0200, Antonio Ospite wrote:
>>>> This id has been seen in the DSTD for the Teclast X98 Air 3G tablet
>>>
>>> DSDT.
>>
>> Right. Thanks :)
>>
>> Jonathan, let me know if you want me to resend or if you plan to amend
>> the commit message yourself.
> 
> Please resend.
> 
> thanks,
> Daniel.
> 
Sorry, missed this thread entirely and pull request has gone out.
I'd have changed this if it was still in testing, but the moment
it hits the public togreg branch, typos in commit messages are
not a reason to rebase (so tough luck it'll probably be in the
git log forever :)

(there are loads of typos in there so don't worry about it :)

Jonathan
