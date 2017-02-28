Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:48851 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbdB1Tfn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Feb 2017 14:35:43 -0500
Subject: Re: [PATCH v2] staging: iio: accel: Move header file content to
 source file
To: SIMRAN SINGHAL <singhalsimran0@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
References: <20170228185117.GA10378@singhal-Inspiron-5558>
 <885c0c37-3709-7b56-a9cf-69a34c735bae@kernel.org>
 <a7be45a3-12e3-2074-b58f-d30494ba5955@kernel.org>
 <CALrZqyNWFtPzorYN--eQHyhvaZqgR51xgqcwpio+ZM_vB+ccRw@mail.gmail.com>
Cc: Michael.Hennerich@analog.com, knaack.h@gmx.de,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <6780baa6-178a-111a-b6fb-30917beaa9dc@metafoo.de>
Date: Tue, 28 Feb 2017 20:34:36 +0100
MIME-Version: 1.0
In-Reply-To: <CALrZqyNWFtPzorYN--eQHyhvaZqgR51xgqcwpio+ZM_vB+ccRw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/28/2017 08:32 PM, SIMRAN SINGHAL wrote:
> On Wed, Mar 1, 2017 at 12:53 AM, Jonathan Cameron <jic23@kernel.org> wrote:
>> On 28/02/17 19:17, Jonathan Cameron wrote:
>>> On 28/02/17 18:51, simran singhal wrote:
>>>> The contents of the header file are used only by this single
>>>> source file. Move content into .c and remove .h.
>>>>
>>>> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
>>> Applied to the togreg branch of iio.git and pushed out as testing
>>> for the autobuilders to play with it.
>>>
>>> Thanks,
>>>
>>> Jonathan
>>
>> One quick note:
>>
>> The title should include the name of the driver being modified
>> as this is probably the bit interested people are most likely
>> to pick up on in a long list of patches.
>>
>> I fixed this up.  Thanks,
>>
>> Jonathan
> 
> I have included the name of driver being modified.
> Due to want me to include the name of file i.e adis16201_core.c

Not the full filename, but the partnumber. E.g.

	'staging: iio: adis16201: ...'

