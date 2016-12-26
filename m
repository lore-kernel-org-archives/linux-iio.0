Return-Path: <viro@ftp.linux.org.uk>
Date: Mon, 26 Dec 2016 00:13:56 +0000
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Cc: Scott Matheina <scott@matheina.com>, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCHv4 2/8] Fixed variables not being consistently lower case
Message-ID: <20161226001356.GM1555@ZenIV.linux.org.uk>
References: <1482694902-7400-1-git-send-email-scott@matheina.com>
 <1482694902-7400-3-git-send-email-scott@matheina.com>
 <20161225201409.GL1555@ZenIV.linux.org.uk>
 <A813EAC4-FE7C-4A1A-AB60-FCF699194E7B@jic23.retrosnub.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A813EAC4-FE7C-4A1A-AB60-FCF699194E7B@jic23.retrosnub.co.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Dec 25, 2016 at 10:34:54PM +0000, Jonathan Cameron wrote:
> 
> 
> On 25 December 2016 20:14:09 GMT+00:00, Al Viro <viro@ZenIV.linux.org.uk> wrote:
> >On Sun, Dec 25, 2016 at 01:41:06PM -0600, Scott Matheina wrote:
> >> Across the file, variables were sometimes upper case, some times
> >> lower case, this fix addresses a few of the instances with this
> >> inconsistency.
> >
> >NAK.  Go learn C and don't come back until you've done that.  If
> >somebody
> >has told you that you can contribute without knowing the language,
> >they'd
> >lied - you really can't.  And I would *STRONGLY* recommend to stay away
> >from drivers/staging while you are learning C - it's like trying to use
> >a public restroom wall as a sex-ed textbook.
> 
> Please can we keep things polite.

In case you have not realized it,
	* Scott is -><- that close to joining the select group of kooks who
get filtered out within days of getting a new account.  At this point he
probably still can spend a while learning what needs to be learnt and
reappear with less inane patches after a while, with everything getting
forgotten.  A week more of the same kind of postings will almost certainly
cement the reputation of clue-resistant noise source beyond any chance of
repair.
	* I am 100% sure that he has not learnt C - hadn't even started doing
so.  This, BTW, is not a value judgement of any kind; it's just a highly
likely conclusion based on what he'd been posting.  This particular patch,
for example, changes identifiers in a bunch of places, none of which happens
to be a declaration.  The reasons why that cannot be correct become obvious
to anyone who had opened _any_ textbook after a few pages.  Or tried to
write and run any program in C.  Again, it's not "should" - it's really one
of the first things that gets learnt ("you need to declare all variables
explicitly and the names are case-sensitive").
	* One really cannot produce any useful patches without understanding
the language.  As this (and previous) patch series sent by Scott has
demonstrated, BTW.  Learning C is a hard prerequisite for doing any development
in a project written in C, including the kernel.  Fortunately, it is not
hard to do.
	* Trying to do that purely by osmosis is not the best way, but it's
doable.  HOWEVER, trying to do that by osmosis when swimming in drivers/staging
is really on par with using a WC wall as sex ed tutorial.  Results will be
awkward, painful and won't satisfy anybody.  Very odd ideas of how the things
work are also practically guaranteed.

	drivers/staging can serve as a playground for learning how to
produce patches, but only if you already know the language.  Otherwise
it really, really must be avoided - it's full of unidiomatic and very
badly written C.  It serves as quarantine barracks for much more serious
reasons than anything checkpatch.pl is capable of picking.  Directing the
folks new to kernel development towards that pile of code is not particularly
kind, but potentially useful.  Doing that to those who are still learning C
goes far beyond "not kind".  I can't stress it enough - don't go there if
you are still learning the language.
