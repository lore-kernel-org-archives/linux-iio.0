Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:47316 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751247Ab1CUNsa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 21 Mar 2011 09:48:30 -0400
Message-ID: <4D875776.7050008@cam.ac.uk>
Date: Mon, 21 Mar 2011 13:49:42 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: Mike Frysinger <vapier.adi@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Drivers <Drivers@analog.com>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [Device-drivers-devel] [PATCH] IIO: DDS: Remove deficient drivers.
References: <1300712210-7978-1-git-send-email-michael.hennerich@analog.com> <AANLkTim7Wpjr+p52C+eW2_rdxtX9HEvUjsGYgDbaJbU-@mail.gmail.com> <544AC56F16B56944AEC3BD4E3D591771375431588C@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D591771375431588C@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/21/11 13:15, Hennerich, Michael wrote:
> Mike Frysinger wrote on 2011-03-21:
>> On Mon, Mar 21, 2011 at 08:56,  <michael.hennerich@analog.com> wrote:
>>> From: Michael Hennerich <michael.hennerich@analog.com>
>>>
>>> These drivers don't conform with the API for such devices.
>>> Therefore they are temporarily removed until they are fixed up
>> anytime later.
>>
>> this is the staging tree ... wouldnt it be easier to leave them alone
>> until they get fixed ?
>> -mike
> 
> We want to move out of staging in the near future.
> There is no simple fix for them. A fix is to rewrite them from scratch.
> The only thing in common a fixed driver would share with the existing one, is the file name.
> No point in keeping them as bad examples.
Your call I guess.  Though the move out of staging is going to leave quite
a few drivers behind in the first instance anyway so I wouldn't worry about that.
Usual staging removal cases are:
1) It doesn't work and no one cares (no idea)
2) No one is working on it (arguably true here)
3) It's been replaced by something better (not yet)

The move is probably going to be more a case of submitting a fresh parallel version
of the core to mainline, then porting individual drivers across.

The issues raised by Arnd for starters are going to cause quite a few changes (and
he's just the first person from outside of normal IIO people to take a look).
I'll keep the old core api's in the staging version, but we won't want them in
the non staging version.

In the short term I'm working on a set that will completely change how the sysfs
stuff is registered.  Not entirely convinced it is the way to go yet, but it does
look fairly promising.  If we do decide to go with that, in some form, I don't
propose moving the whole driver set over to it before we start moving out of staging.

Jonathan
