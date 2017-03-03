Return-Path: <SRS0=YzwV=2M=axentia.se=peda@kernel.org>
Subject: Re: [PATCH v9 00/10] mux controller abstraction and iio/i2c muxes
To: Wolfram Sang <wsa@the-dreams.de>
References: <1486568517-6997-1-git-send-email-peda@axentia.se>
 <6d87465f-b983-3f62-c7cf-41ed4e50170d@axentia.se>
 <20170228171842.GA11127@kroah.com>
 <569c18b3-b1d8-f2e6-7fc4-897aa7df6775@axentia.se>
 <20170303165247.el4mcsmo4fbnkjir@ninjato>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<linux-kernel@vger.kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Jonathan Corbet <corbet@lwn.net>,
	<linux-i2c@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-iio@vger.kernel.org>, <linux-doc@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <92e37b84-d368-f161-322e-3f9709cb2ccf@axentia.se>
Date: Fri, 3 Mar 2017 19:44:46 +0100
MIME-Version: 1.0
In-Reply-To: <20170303165247.el4mcsmo4fbnkjir@ninjato>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

On 2017-03-03 17:52, Wolfram Sang wrote:
> 
>> Jonathan, Wolfram, do you have any preferences on how this should be
>> coordinated regarding the new iio and i2c drivers (and iio changes)?
> 
> You got the acks, all is fine, I think.
> 
>> My plan is to at some point declare the branch immutable. Then both of
>> you can pull it in. Or? 
> 
> Yup, sounds good.
> 
>> But now that I think about it I wonder what the point is of having
>> Greg pull it in also? Sure, third time's a charm and all that, but...
> 
> AFAIU, Greg will be your "upstream", so he should definately pull the
> branch. I will just pull it in to avoid merge conflicts in my tree.
> Or did I misunderstand your question?

You got the gist of it. The piece I was missing was the conditional
pull into iio/i2c. If you only pull in order to resolve conflicts
it of course makes total sense, thanks.

And conflicts -- if they show up -- will probably be trivial given the
nature of the series. Famous last words...

Cheers,
peda
