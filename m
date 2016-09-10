Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58331 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753907AbcIJPBI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 10 Sep 2016 11:01:08 -0400
Subject: Re: [PATCH] iio: Use type header from kernel tree
To: Laura Abbott <labbott@redhat.com>,
        Daniel Baluta <daniel.baluta@gmail.com>
References: <1473434693-5495-1-git-send-email-labbott@redhat.com>
 <CAEnQRZBnw_s33+Bbtm9hrG5uqX0HYiCOPfo5RTa3oJ1OHT+dFg@mail.gmail.com>
 <6b71d792-5300-b0cc-9d64-5cd0d5767e92@redhat.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ben@decadent.org.uk
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f3c5a3f3-f05c-9d2f-ec82-0e664a859220@kernel.org>
Date: Sat, 10 Sep 2016 16:01:06 +0100
MIME-Version: 1.0
In-Reply-To: <6b71d792-5300-b0cc-9d64-5cd0d5767e92@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/09/16 16:47, Laura Abbott wrote:
> On 09/09/2016 08:35 AM, Daniel Baluta wrote:
>> On Fri, Sep 9, 2016 at 6:24 PM, Laura Abbott <labbott@redhat.com> wrote:
>>>
>>> The iio tools have been updated as new event types have been added to
>>> the kernel. The tools currently use the standard system headers which
>>> means that the system may not have the newest defintitions. This leads
>>> to build failures when building newer tools on older hosts:
>>>
>>> gcc -Wall -g -D_GNU_SOURCE   -c -o iio_event_monitor.o
>>> iio_event_monitor.c
>>> iio_event_monitor.c:59:3: error: ‘IIO_UVINDEX’ undeclared here (not in a
>>> function)
>>>   [IIO_UVINDEX] = "uvindex",
>>>    ^~~~~~~~~~~
>>> iio_event_monitor.c:59:3: error: array index in initializer not of
>>> integer type
>>> iio_event_monitor.c:59:3: note: (near initialization for
>>> ‘iio_chan_type_name_spec’)
>>> iio_event_monitor.c:97:3: error: ‘IIO_MOD_LIGHT_UV’ undeclared here (not
>>> in a function)
>>>   [IIO_MOD_LIGHT_UV] = "uv",
>>>    ^~~~~~~~~~~~~~~~
>>> iio_event_monitor.c:97:3: error: array index in initializer not of
>>> integer type
>>> iio_event_monitor.c:97:3: note: (near initialization for
>>> ‘iio_modifier_names’)
>>> <builtin>: recipe for target 'iio_event_monitor.o' failed
>>>
>>> Switch to using the header from the kernel tree to ensure the newest
>>> defintions are always picked up.
>>>
>>> Signed-off-by: Laura Abbott <labbott@redhat.com>
>>
>> Hi Laura,
>>
>> Thanks for your patch. The solution here would be to install the
>> headers for your
>> new kernel in order to use the updated types.
>>
>> That is you should run make headers_install.
>>
>> $ make help | grep headers
>>   headers_install - Install sanitised kernel headers to INSTALL_HDR_PATH
>>
>> You can use INSTALL_HDR_PATH to put the headers in a custom directory
>> and tell gcc to also include this directory when searching for include headers.
>>
> 
> That's a pretty ugly solution. We want to build this as part of Fedora
> and installing another local copy of the headers in the build environment
> complicates an already complicated build process. This is more work
> for users building on their own as well. Several other tools in the tools
> directory already use the headers from the kernel tree, is there a reason
> iio doesn't want to as well?
This got raised as a suggestion for discussion at the kernel summit this
year.  Clearly a somewhat contentious topic ;)

https://lists.linuxfoundation.org/pipermail/ksummit-discuss/2016-September/003829.html

I'd prefer to see some resolution on that discussion before making any changes.
Looks like there are some moves afoot to standardise a lot of this stuff in
tools.

I've cc'd Ben who raised this particular issue in the first place.

Jonathan
> 
> Thanks,
> Laura

