Return-Path: <SRS0=BMX7=AN=metafoo.de=lars@kernel.org>
Subject: Re: [Outreachy kernel] [PATCH] Fixed IIO_DEVICE_ATTR_NAMED API to
 take name as a string and added "" around names
To: Julia Lawall <julia.lawall@lip6.fr>, himanshi <himshijain.hj@gmail.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
 outreachy-kernel <outreachy-kernel@googlegroups.com>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald <pmeerw@pmeerw.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 driverdev <devel@driverdev.osuosl.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 nick.desaulniers@gmail.com
References: <20170911224348.GA13259@himanshi-Inspiron-5558>
 <CAEnQRZDgXj85OTQAoEpij_3bSUnmcx1owNyeg10WCmiBGURURg@mail.gmail.com>
 <20170912180132.GB4607@himanshi-Inspiron-5558>
 <alpine.DEB.2.20.1709122004550.3149@hadrien>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <629315d5-6de4-4531-7f25-e1764b9a0513@metafoo.de>
Date: Tue, 12 Sep 2017 20:14:18 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1709122004550.3149@hadrien>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 09/12/2017 08:06 PM, Julia Lawall wrote:
> 
> 
> On Tue, 12 Sep 2017, himanshi wrote:
> 
>> Thanks for the review Daniel! I will change the imperative mood for the commit
>> message once the other changes are finalised too and as suggested by Julia,
>> would try to make the description specific than general.
>>
>> I tried to think of adding subsystem to the commit subject but could not
>> conclude any because of the files involved.
>> I like the idea of splitting the patch into 2 as you suggested but I
>> have a doubt that adding the new MACROS to different sysfs files can be put into 1
>> patch with the subsystem you mentioned but changing the existing
>> IIO_DEVICE_ATTR_NAMED to use IIO_ATTR_NAMED (sysfs file again) would be included
>> in the second patch if I am not wrong. So would it be fine to keep the
>> subsystem as iio for the second patch?
> 
> Indeed, the kernel has to compile after every commit.  Unless you change
> the name of the macro, to allow the old and new versions to co-exist, it
> seems hard to break up such a patch.

We can still split things into two parts. One patch introducing __ATTR_NAMED
in the device driver core and then another patch making use of that macro in
the IIO subsystem.
