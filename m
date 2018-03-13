Return-Path: <SRS0=lFjb=GD=gmail.com=rodrigosiqueiramelo@kernel.org>
Date: Tue, 13 Mar 2018 11:33:24 -0300
From: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@driverdev.osuosl.org, Graff Yang <graff.yang@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>, daniel.baluta@nxp.com,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/3] staging:iio:ad2s1210: Add write_raw to handle
 frequency
Message-ID: <20180313143324.vlusixa522rqaeoy@smtp.gmail.com>
References: <cover.1520878492.git.rodrigosiqueiramelo@gmail.com>
 <ae60ca5cf37d1678cb6b498450f75f93f3d498d2.1520878492.git.rodrigosiqueiramelo@gmail.com>
 <20180313090249.cdurikolfwc5qyol@mwanda>
 <20180313130629.c6zmvoy5o7a5ax2c@smtp.gmail.com>
 <20180313135957.jfgxmq7gtcfgwdhe@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180313135957.jfgxmq7gtcfgwdhe@mwanda>
List-ID: <linux-iio@vger.kernel.org>

On 03/13, Dan Carpenter wrote:
> On Tue, Mar 13, 2018 at 10:06:29AM -0300, Rodrigo Siqueira wrote:
> > On 03/13, Dan Carpenter wrote:
> >
> > > Ah...  I see why you did the ERROR_MESSAGE define, to get around the 80
> > > character limit.  Don't do that.  Just go over 80 characters if you need
> > > to.
> > > 
> > > 
> > > > +					"fclkin");
> > > > +				ret = -EINVAL;
> > > > +				goto error_ret;
> > > 
> > > Direct returns are better.  Less chance of bugs statistically.
> > 
> > I totally get your point here, and I will fix it. However, just for
> > curiosity, why goto in this situation has more chance to generate bugs
> > statically?
> > 
> 
> This is a do-nothing goto.  I normally consider do-nothing gotos and
> do-everything gotos basically cousins but in this case it's probably
> unfair since it already has other labels.
> 
> Do-everything gotos are the most error prone way of doing error
> handling.  I've reviewed a lot of static checker warnings and it really
> is true.  I can't give you like a percent figure but do-everything error
> handling is a lot buggier than normal kernel style.
> 
> This style of error handling is supposed to prevent returning without
> unlocking bugs.  I once looked through the git log and counted missing
> unlock bugs and my conclusion was that it basically doesn't work for
> preventing bugs.  The kind of people who just add random returns will do
> it regardless of the error handling style.  There was even one driver
> that indented locked code like this:
> 
> 	lock(); {
> 		blah blah blah;
> 	} unlock();
> 
> When the driver was first submitted, it already had a missing unlock
> bug.  I don't think style helps slow people down who are in a hurry.
> 
> The other thing about do-nothing gotos is that you introduce the
> possibility of "forgot to set the error code" bugs which wasn't there
> before.
> 
> regards,
> dan carpenter
> 
> 
> 
> 
> 
> 
> 
> 
> So actually "error_ret" seems like a pretty reasonable name for a
> do-nothing goto.  I no
> 
> I've looked at a lot of error handling and this kind of error handling
> is more error prone.  The single exit path thing is supposed to prevent
> bugs like not dropping the lock on exit and I've looked through the logs
> and counted bugs to see if it works and I don't think it does.  The
> people who forget to unlock will forget to unlock regardless of the
> error handling style.
> 

Thanks for the great explanation :)
 
> 
> 
> 
> > I will send a v2 with your recommendantions.
> > Thanks for the review and feedbacks :)
> >  
> > > regards,
> > > dan carpenter
> > > 
> > _______________________________________________
> > devel mailing list
> > devel@linuxdriverproject.org
> > http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
