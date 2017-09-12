Return-Path: <SRS0=BMX7=AN=metafoo.de=lars@kernel.org>
Subject: Re: [Outreachy kernel] [PATCH] Fixed IIO_DEVICE_ATTR_NAMED API to
 take name as a string and added "" around names
To: Daniel Baluta <daniel.baluta@gmail.com>,
 Himanshi Jain <himshijain.hj@gmail.com>
Cc: outreachy-kernel <outreachy-kernel@googlegroups.com>,
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
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <130cbd01-265e-dafe-02d1-96de4d62ff12@metafoo.de>
Date: Tue, 12 Sep 2017 20:12:47 +0200
MIME-Version: 1.0
In-Reply-To: <CAEnQRZDgXj85OTQAoEpij_3bSUnmcx1owNyeg10WCmiBGURURg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 09/12/2017 09:53 AM, Daniel Baluta wrote:
> Hi Himanshi,
> 
> On Tue, Sep 12, 2017 at 1:43 AM, Himanshi Jain <himshijain.hj@gmail.com> wrote:
>> Fixed IIO_DEVICE_ATTR_NAMED API to take name as a
>> string instead of implicit conversion to string using
>> preprocessors. Added double quotes around names in
>> existing usage of IIO_DEVICE_ATTR_NAMED.
> 
> Always use imperative mood in commit subject (Fix instead of Fixed).
> 
> The subject should contain a tag, which describes the subsytem/files affected.
> 
> I would split this patch into:
> 
> 1) sysfs: iio: Introduce *_ATTR_NAMED
> 
> and explain here why do we need  __ATTR_NAMED and IIO_ATTR_NAMED
> 
> 2) iio: Use new IIO_DEVICE_ATTR_NAMED API
> 
> But of course, lets wait to see Lars and Jonathan's opinions.

Fully agreed with what you wrote.
