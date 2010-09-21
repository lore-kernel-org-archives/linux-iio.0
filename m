Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:60407 "EHLO
	ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755761Ab0IUNjW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Sep 2010 09:39:22 -0400
Message-ID: <4C98B6C7.9040200@cam.ac.uk>
Date: Tue, 21 Sep 2010 14:44:39 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: linux-iio@vger.kernel.org, drivers@analog.com
Subject: Re: [PATCH 00/22 V2ish] staging:iio: implement _type (v2) and _index
 for scan elements
References: <1284991987-12407-1-git-send-email-jic23@cam.ac.uk> <4C977C26.2020602@iis.fraunhofer.de>
In-Reply-To: <4C977C26.2020602@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/20/10 16:22, Manuel Stahl wrote:
> Am 20.09.2010 16:12, schrieb Jonathan Cameron:
>> This set combines v2 of the addtion of _type attrs and v1 for that
>> of _index attrs.  With both of these present all current buffer data
>> layouts are fully described.
>>
>> The _type attr patches have been updated as per Manuel's suggestion
>> (using the variant I posted earlier today for constant _type)
>> I have left those drivers with variable formats to specify their
>> own functions locally.  These may be worth combining into some core
>> functionality in the future.
>>
>> Manuel, if you are happy can I have your sign off on these
>> (as it was your idea!)
> 
> Sure, do that!
Done and sent on to Greg KH.

Given it is just an interface change, I didn't wait for Acks from
others.  I wanted to merge these asap as whilst compact, they
will mean rebasing pretty much every other set I've posted recently.

Next, to start a flame war on lkml about naming of event related sysfs
parameters.

Jonathan
