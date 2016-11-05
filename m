Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49989 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753623AbcKEM6E (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 5 Nov 2016 08:58:04 -0400
Subject: Re: [PATCH 1/6] staging: iio: set proper supply name to
 devm_regulator_get()
To: Lars-Peter Clausen <lars@metafoo.de>,
        Matt Ranostay <matt@ranostay.consulting>,
        Eva Rachel Retuya <eraretuya@gmail.com>
References: <1477933475-21914-1-git-send-email-eraretuya@gmail.com>
 <1477933475-21914-2-git-send-email-eraretuya@gmail.com>
 <CAJ_EiSTU_z_fNSLSUSTpzU+v5F5f-JEe7p2fUms3LKEd+wftDw@mail.gmail.com>
 <73bc1e52-d728-a61b-69f3-a567c0b05e28@metafoo.de>
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Michael.Hennerich@analog.com, knaack.h@gmx.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <fff961b3-3ad7-77c3-87ec-90ef622caaa6@kernel.org>
Date: Sat, 5 Nov 2016 12:58:04 +0000
MIME-Version: 1.0
In-Reply-To: <73bc1e52-d728-a61b-69f3-a567c0b05e28@metafoo.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/11/16 19:58, Lars-Peter Clausen wrote:
> On 11/01/2016 05:03 AM, Matt Ranostay wrote:
>> On Mon, Oct 31, 2016 at 10:04 AM, Eva Rachel Retuya <eraretuya@gmail.com> wrote:
>>> The name passed to devm_regulator_get() should match the name of the
>>> supply as specified in the device datasheet. This makes it clear what
>>> power supply is being referred to in case of presence of other
>>> regulators.
>>>
>>> Currently, the supply name specified on the affected devices is 'vcc'.
>>> Use lowercase version of the datasheet name to specify the supply
>>> voltage.
>>>
>>
>> Aren't we possibly breaking current device tree definitions that
>> people may have? We should still check the old name after the new
>> datasheet name in my opinion.
> 
> None of those drivers have DT bindings, so I think we are OK. And they are
> in staging anyway.
> 
I agree on this.  These are technically in kernel interfaces so we
are fine to change them.  Would have been more interesting if
there were DT bindings however and we would have had to support
the old and new naming for a while at least (i.e. probably forever
as we'd never get around to cleaning it up!)

Jonathan
