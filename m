Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58957 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751818AbbGMJWm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 13 Jul 2015 05:22:42 -0400
In-Reply-To: <55A371DB.1020105@posteo.de>
References: <1436186062-5766-1-git-send-email-martink@posteo.de> <559E35F4.8010304@posteo.de> <55A371DB.1020105@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH v4 0/8] iio:mma8452: improve driver and support more chips
From: Jonathan Cameron <jic23@kernel.org>
Date: Mon, 13 Jul 2015 10:22:32 +0100
To: Martin Kepplinger <martink@posteo.de>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, mfuzzey@parkeon.com,
	roberta.dobrescu@gmail.com, robh+dt@kernel.org, pawel.moll@arm.com,
	mark.rutland@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org
CC: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	christoph.muellner@theobroma-systems.com
Message-ID: <A17CB9B2-D4D4-42EC-B51A-A5C7D864EDC4@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 13 July 2015 09:07:55 BST, Martin Kepplinger <martink@posteo.de> wrote:
>Am 2015-07-09 um 10:51 schrieb Martin Kepplinger:
>> Am 2015-07-06 um 14:34 schrieb Martin Kepplinger:
>>> This is version 4 of the mma8452 driver improvements. This version
>removes
>>> one patch that changed the iio event type for existing users. It can
>be
>>> dealt with seperately and this series applies without it.
>>>
>>> Also, changes according to Jonathan's review are applied and a few
>>> devicetree maintainers are added as recipients.
>>>
>>>
>>> These changes add support for motion interrupts and 3 more
>accelerometer
>>> chips, two of which use them because they don't support the until
>now
>>> included transient interrupt sources:
>>>
>>> MMA8453Q, MMA8652FC and MMA8653FC; datasheets are in the commit
>messages.
>>>
>>> The driver and module name remains the same, seperating it from the
>device
>>> names it now supports.
>>>
>>> On top of this, there are minor documentation additions, and more
>notably,
>>>  it allows to use the driver, no matter how the interrupt pins are
>wired
>>> on your board.
>>>
>>> Please review and test if you can. For MMA8452Q, nothing should have
>>> changed.
>> 
>> Any thoughts or reviewed-bys for these changes?
>> 
>> Since there are many more possible users of this driver after these
>> changes, see the devicetree bindings documentation file, maybe you
>are
>> among them and can quickly run it? ;)
>> 
>> thanks a lot,
>> 
>>                      martin
>
>Yes, no, maybe? Anyways. This series applies to the current -next.
>
>thanks
>                           martin
Sorry Martin

Combination of stupid day job week last week. (Of the jump on a plane and 18
 hour days variety) also a rather large IKEA build (more fun!) have given me a
 fair backlog.  Will hopefully catch up during this week.

Initial work though will be getting pull requests out for stuff that has been in
 tree for ages so may be later in the week.

Jonathan
>
>> 
>>>
>>> revision history
>>> ----------------
>>> v4   cleanup; one bugfix patch removed from series; DT people added
>>> v3   adds one patch to allow all possible pin wirings; adds more
>email
>>>      recipients
>>> v2   splits the work into a series of smaller pieces
>>> v1   initial post
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe
>linux-kernel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe
>linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>> 

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
