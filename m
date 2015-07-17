Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <20150716042417.5d0ead50@lwn.net>
References: <1436357088-30743-1-git-send-email-daniel.baluta@intel.com>
	<1436357088-30743-2-git-send-email-daniel.baluta@intel.com>
	<20150716042417.5d0ead50@lwn.net>
Date: Fri, 17 Jul 2015 11:49:12 +0300
Message-ID: <CAEnQRZDjkCKAx6K5Mzf1ETfr9yRGYCR2hecUcFJ2musJ5oWtXg@mail.gmail.com>
Subject: Re: [PATCH] DocBook: Add initial documentation for IIO
From: Daniel Baluta <daniel.baluta@intel.com>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Daniel Baluta <daniel.baluta@intel.com>, Jonathan Cameron <jic23@kernel.org>,
	Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Jul 16, 2015 at 1:24 PM, Jonathan Corbet <corbet@lwn.net> wrote:
> On Wed,  8 Jul 2015 15:04:48 +0300
> Daniel Baluta <daniel.baluta@intel.com> wrote:
>
>> This is intended to help developers faster find their way
>> inside the Industrial I/O core and reduce time spent on IIO
>> drivers development.
>
> Seems like good stuff to have, sorry it's taken me so long to have a look
> at it.  Any other IIO folks want to send comments or an ack?

Thanks a lot Jon for your time. I also missed to explicitly add you on the
Cc list. I will make use of get_maintainer.pl for v2.

>
> A few comments of mine below...

Will fix in v2. Few comments inline

<snip>

>> +
>> +      <para>
>> +        This program is distributed in the hope that it will be
>> +        useful, but WITHOUT ANY WARRANTY; without even the implied
>> +        warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
>> +        For more details see the file COPYING in the source
>> +        distribution of Linux.
>
> Do we really need this paragraph?  It's not even a "program" by some views,
> at least.

This paragraph is present in most of the already existing documentation.
E.g. First 6 docs from here: https://www.kernel.org/doc/htmldocs/ have it.

But you have a good point it doesn't make much sense here. I will
remove it in v2.

<snip>

>> +      Available standard attributes for IIO devices are described in the
>> +      <filename>Documentation/ABI/testing/sysfs-bus-iio </filename> file
>> +      in the Linux kernel sources.
>
> Should that move out of testing at some point?

This has been here for quite some time (4 years?), but IIO gets more and
more drivers with new features and new ABI attributes that are somehow
still in testing.

So, I think it should stay here for at least one more year. Or perhaps
we can split this file and move the stable part in ABI/stable and keep
the new ABI in testing.

Agree with all other comments will address them in v2.

thanks,
Daniel.
