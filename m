Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43067 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbcF3TQ4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2016 15:16:56 -0400
Subject: Re: [PULL] Second set of new device, new features and cleanups for
 IIO in the 4.8 cycle
To: Greg KH <gregkh@linuxfoundation.org>
References: <37ca1a90-006f-8a58-e28d-401a3e13562f@kernel.org>
 <071b2c5d-5de4-48cf-81a8-b943084dce09@kernel.org>
 <20160629223540.GA20281@kroah.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9dc027d1-23a0-52cc-f197-139da24f96fb@kernel.org>
Date: Thu, 30 Jun 2016 20:16:54 +0100
MIME-Version: 1.0
In-Reply-To: <20160629223540.GA20281@kroah.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/06/16 23:35, Greg KH wrote:
> On Wed, Jun 29, 2016 at 07:54:54PM +0100, Jonathan Cameron wrote:
>> Hi Greg,
>>
>> A few merge conflicts on this.  Two are the obvious choice.
>> The third is in industrialio-trigger.c and you want the version that
>> doesn't check for trig->ops (as it is no longer considered optional so
>> must exist by that point).
> 
> Odd, I only had a conflict in a Kconfig and the .mailmap file.  Can you
> check that I got this all right?
odd indeed.  I go the issue merging the fixes branch into the new
stuff branch.  I guess something got ever so slightly scrambled and
git could figure it out done in a slightly different order.

Anyhow, all seems fine to me!

Thanks

Jonathan
> 
> thanks,
> 
> greg k-h
> 

