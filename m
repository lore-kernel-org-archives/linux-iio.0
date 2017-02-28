Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:36111 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752381AbdB1V0j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Feb 2017 16:26:39 -0500
MIME-Version: 1.0
In-Reply-To: <6780baa6-178a-111a-b6fb-30917beaa9dc@metafoo.de>
References: <20170228185117.GA10378@singhal-Inspiron-5558> <885c0c37-3709-7b56-a9cf-69a34c735bae@kernel.org>
 <a7be45a3-12e3-2074-b58f-d30494ba5955@kernel.org> <CALrZqyNWFtPzorYN--eQHyhvaZqgR51xgqcwpio+ZM_vB+ccRw@mail.gmail.com>
 <6780baa6-178a-111a-b6fb-30917beaa9dc@metafoo.de>
From: SIMRAN SINGHAL <singhalsimran0@gmail.com>
Date: Wed, 1 Mar 2017 01:07:18 +0530
Message-ID: <CALrZqyMXWEgR6seOHBgVL+cS7jPmPAGvyiWjFSrTmR5t9yhwtA@mail.gmail.com>
Subject: Re: [PATCH v2] staging: iio: accel: Move header file content to
 source file
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Michael.Hennerich@analog.com,
        knaack.h@gmx.de, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Mar 1, 2017 at 1:04 AM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> On 02/28/2017 08:32 PM, SIMRAN SINGHAL wrote:
>> On Wed, Mar 1, 2017 at 12:53 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>>> On 28/02/17 19:17, Jonathan Cameron wrote:
>>>> On 28/02/17 18:51, simran singhal wrote:
>>>>> The contents of the header file are used only by this single
>>>>> source file. Move content into .c and remove .h.
>>>>>
>>>>> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
>>>> Applied to the togreg branch of iio.git and pushed out as testing
>>>> for the autobuilders to play with it.
>>>>
>>>> Thanks,
>>>>
>>>> Jonathan
>>>
>>> One quick note:
>>>
>>> The title should include the name of the driver being modified
>>> as this is probably the bit interested people are most likely
>>> to pick up on in a long list of patches.
>>>
>>> I fixed this up.  Thanks,
>>>
>>> Jonathan
>>
>> I have included the name of driver being modified.
>> Due to want me to include the name of file i.e adis16201_core.c
>
> Not the full filename, but the partnumber. E.g.
>
>         'staging: iio: adis16201: ...'
>

Lars-Peter, I got it.

Jonathan, I got my mistake should I send v3.
