Return-Path: <SRS0=Foea=3H=free-electrons.com=alexandre.belloni@kernel.org>
Date: Thu, 30 Mar 2017 19:23:12 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: jacopo <jacopo@jmondi.org>
Cc: Arushi Singhal <arushisinghal19971997@gmail.com>,
	outreachy-kernel@googlegroups.com,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: replace comma with a semicolon
Message-ID: <20170330172312.ooxwqmkz6sw7smgd@piout.net>
References: <20170330124603.GA29301@arushi-HP-Pavilion-Notebook>
 <20170330133046.GA7900@w540>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170330133046.GA7900@w540>
List-ID: <linux-iio@vger.kernel.org>

On 30/03/2017 at 15:30:46 +0200, jacopo wrote:
> Hi Arushi,
>    thanks for your patch
> 
> On Thu, Mar 30, 2017 at 06:16:03PM +0530, Arushi Singhal wrote:
> > Replace a comma between expression statements by a semicolon. This
> > changes the semantics of the code, but given the current indentation
> > appears to be what is intended.
> > A simplified version of the Coccinelle semantic patch that performs this
> > transformation is as follows:
> > 
> > // <smpl>
> > @r@
> > expression e1,e2;
> > @@
> > 
> >  e1
> > -,
> > +;
> >  e2;
> > // </smpl>
> > 
> 
> You can simply say that this fixes what appears to be a bug to me.
> I wonder how this does even compile..
> 

It is not a bug, it is perfectly valid and working as expected/intended.
This is just a cosmetic change.

See https://en.wikipedia.org/wiki/Comma_operator if you want to
understand.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
