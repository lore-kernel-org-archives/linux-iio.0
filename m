Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53354 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751542AbcDQL42 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Apr 2016 07:56:28 -0400
Subject: Re: [PULL] First round of new device support, features and cleanups
 for IIO in the 4.7 cycle.
To: Greg KH <gregkh@linuxfoundation.org>
References: <57018AAA.8070800@kernel.org> <57018BBB.7040106@kernel.org>
 <20160411165657.GA27572@kroah.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Irina Tirdea <irina.tirdea@intel.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <571379E9.2020307@kernel.org>
Date: Sun, 17 Apr 2016 12:56:25 +0100
MIME-Version: 1.0
In-Reply-To: <20160411165657.GA27572@kroah.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/04/16 17:56, Greg KH wrote:
> On Sun, Apr 03, 2016 at 10:31:39PM +0100, Jonathan Cameron wrote:
>> Hi Greg,
>>
>> Note there is a merge conflict with one of the patches in the second lot of fixes
>> I sent early today.  This is because the change got queued up here first then
>> we noticed and issue which it fixed by accident.
>>
>> Anyhow, conflict is in bmg160-core.c and you want the 'short option'.
>> For comparison, the code is pretty much identical to bmc150-accel-core.c.
>>
>> Otherwise, various automerged corners that seem to be fine. My build tests
>> failed on a random thermal driver which I'll assume has long since been fixed,
>> but otherwise seemed fine.
> 
> I've done the merge now, can you verify I got it correct?
> 
Sorry for slow reply - looks good as it matches what I have locally.

Thanks,

Jonathan
> thanks,
> 
> greg k-h
> 

