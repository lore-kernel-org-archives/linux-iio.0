Return-Path: <SRS0=kMj/=ED=huawei.com=jonathan.cameron@kernel.org>
Date: Mon, 8 Jan 2018 11:32:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Sumit Pundir
	<pundirsumit11@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, "Michael
 Hennerich" <Michael.Hennerich@analog.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <linux-iio@vger.kernel.org>,
	<devel@driverdev.osuosl.org>, Linux Kernel Mailing List
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Staging: iio: Prefer using BIT macro
Message-ID: <20180108113237.0000080d@huawei.com>
In-Reply-To: <CAHp75VfFh9mrF1xPfnspJ=cWs=URFrF2sjdbBMV-p36-AjkcKA@mail.gmail.com>
References: <1515083791-19049-1-git-send-email-pundirsumit11@gmail.com>
	<20180106124232.5f6609fb@archlinux>
	<CAHp75VfFh9mrF1xPfnspJ=cWs=URFrF2sjdbBMV-p36-AjkcKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
List-ID: <linux-iio@vger.kernel.org>

On Mon, 8 Jan 2018 01:30:29 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Jan 6, 2018 at 2:42 PM, Jonathan Cameron <jic23@kernel.org> wrote:
> > On Thu,  4 Jan 2018 22:06:31 +0530  
> 
> >>  /* Setup Register Bit Designations (AD7152_REG_CHx_SETUP) */
> >> -#define AD7152_SETUP_CAPDIFF         (1 << 5)
> >> +#define AD7152_SETUP_CAPDIFF         BIT(5)  
> >
> > This is indeed a 1 bit field so fine.  
> 
> But shouldn't we prevent style over the module? Otherwise it might be
> hard to decode one field from the other because of style differences.

I'm not sure using BIT for single bit fields really makes it much harder
to read, but perhaps you are right.  Anyhow, can't say I feel strongly
about this one either way!

Jonathan

> 
> >>  #define AD7152_SETUP_RANGE_2pF               (0 << 6)
> >> -#define AD7152_SETUP_RANGE_0_5pF     (1 << 6)
> >> +#define AD7152_SETUP_RANGE_0_5pF     BIT(6)  
> > This is clearly putting the value 1 in a 2 bit field within
> > the register - BIT macro obscures this compeltely.  
> 
