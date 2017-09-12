Return-Path: <SRS0=mGUp=AN=gmail.com=himshijain.hj@kernel.org>
Date: Wed, 13 Sep 2017 00:01:35 +0530
From: himanshi <himshijain.hj@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Julia Lawall <julia.lawall@lip6.fr>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	outreachy-kernel <outreachy-kernel@googlegroups.com>,
	"Hennerich, Michael" <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	driverdev <devel@driverdev.osuosl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	nick.desaulniers@gmail.com
Subject: Re: [Outreachy kernel] [PATCH] Fixed IIO_DEVICE_ATTR_NAMED API to
 take name as a string and added "" around names
Message-ID: <20170912183135.GA5329@himanshi-Inspiron-5558>
References: <20170911224348.GA13259@himanshi-Inspiron-5558>
 <CAEnQRZDgXj85OTQAoEpij_3bSUnmcx1owNyeg10WCmiBGURURg@mail.gmail.com>
 <20170912180132.GB4607@himanshi-Inspiron-5558>
 <alpine.DEB.2.20.1709122004550.3149@hadrien>
 <629315d5-6de4-4531-7f25-e1764b9a0513@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <629315d5-6de4-4531-7f25-e1764b9a0513@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Okay. This way with each commit the version can compile and I will
be able to define the subsystem appropriately. Thank you for the
clarification Lars. 

On Tue, Sep 12, 2017 at 08:14:18PM +0200, Lars-Peter Clausen wrote:
> On 09/12/2017 08:06 PM, Julia Lawall wrote:
> > 
> > 
> > On Tue, 12 Sep 2017, himanshi wrote:
> > 
> >> Thanks for the review Daniel! I will change the imperative mood for the commit
> >> message once the other changes are finalised too and as suggested by Julia,
> >> would try to make the description specific than general.
> >>
> >> I tried to think of adding subsystem to the commit subject but could not
> >> conclude any because of the files involved.
> >> I like the idea of splitting the patch into 2 as you suggested but I
> >> have a doubt that adding the new MACROS to different sysfs files can be put into 1
> >> patch with the subsystem you mentioned but changing the existing
> >> IIO_DEVICE_ATTR_NAMED to use IIO_ATTR_NAMED (sysfs file again) would be included
> >> in the second patch if I am not wrong. So would it be fine to keep the
> >> subsystem as iio for the second patch?
> > 
> > Indeed, the kernel has to compile after every commit.  Unless you change
> > the name of the macro, to allow the old and new versions to co-exist, it
> > seems hard to break up such a patch.
> 
> We can still split things into two parts. One patch introducing __ATTR_NAMED
> in the device driver core and then another patch making use of that macro in
> the IIO subsystem.
