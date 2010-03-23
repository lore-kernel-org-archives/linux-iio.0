Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:37897 "EHLO
	ppsw-0.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753302Ab0CWNnn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 23 Mar 2010 09:43:43 -0400
Message-ID: <4BA8C622.6090505@cam.ac.uk>
Date: Tue, 23 Mar 2010 13:46:10 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] iio_trigger_find_by_name: Skip trailing newline if available
References: <544AC56F16B56944AEC3BD4E3D5917712D6B1D944F@LIMKCMBX1.ad.analog.com> <4BA7D50D.2080202@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917712E5660F259@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712E5660F259@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/23/10 12:23, Hennerich, Michael wrote:
> Jonathan Cameron wrote on 2010-03-22:
>> On 03/08/10 09:31, Hennerich, Michael wrote:
>>> Skip trailing newline if available.
>>>
>>> From: Michael Hennerich <Michael.Hennerich@analog.com>
>>
>> Dear Michael,
>>
>> Just found this one whilst trying to sort out a clean iio tree.
>> (sorry I completely failed to reply originally)
>>
>> Anyhow, I agree with the principal that we should be ignoring the
>> newline.  Actually we should be ignoring whitespace before and after
>> the string we are actually after.
> 
> Well - in most cases people use #echo so there shouldn't be a problem with white space before and after.
> However the newline is going to bug in case you don't use #echo -n.
> I've seen many sysfs_set functions also stripping the '\n' from the string.
Actually most uses beyond the debugging drivers stage are likely to be via
userspace libraries, but admittedly these aren't going to have excess white
space so it doesn't matter!


> 
>> Perhaps a cleaner approach is to
>> use sscanf to pull out the string alone?
> 
> sscanf() is certainly a alternative here.
> 
>> I don't think we need to
>> allow for whitespace in the trigger name (though obviously it should
>> be documented if we do not).  Technically I believe (via the
>> convenient lwn article last week on the topic) we should ignore white
>> space but return -EINVAL if there is say one word, some white space
>> and then another word...  Not sure if there is a particularly clean
>> way to do that however.
>>
>> What do you think?
> 
> I agree - Don't allow whitespace in the trigger name.

Alright, I don't really care how we do it, though agree dealing with the newline
is useful, so please send this onto Greg KH (if you haven't?) 

Jonathan
