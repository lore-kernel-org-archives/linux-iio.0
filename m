Return-Path: <SRS0=KsDE=GP=perches.com=joe@kernel.org>
Message-ID: <1521997449.24655.22.camel@perches.com>
Subject: Re: [PATCH v5 1/8] counter: Introduce the Generic Counter interface
From: Joe Perches <joe@perches.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, benjamin.gaignard@st.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 25 Mar 2018 10:04:09 -0700
In-Reply-To: <20180325175624.4cdaaefe@archlinux>
References: <cover.1520614431.git.vilhelm.gray@gmail.com>
	 <e64e423c19d69a9578e95de9db6ca41e231d63da.1520614431.git.vilhelm.gray@gmail.com>
	 <20180324173358.571e2fd8@archlinux> <1521963970.24655.16.camel@perches.com>
	 <20180325175624.4cdaaefe@archlinux>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sun, 2018-03-25 at 17:56 +0100, Jonathan Cameron wrote:
> On Sun, 25 Mar 2018 00:46:10 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > On Sat, 2018-03-24 at 17:33 +0000, Jonathan Cameron wrote:
> > > checkpatch.pl --strict (but take into account some of the warnings will
> > > be silly so don't fix them all).  
> > 
> > What checkpatch output is silly?
> 
> Sorry - bad word choice.

No worries.  Just checking.

> It guides you to where you should look very
> well, but sometimes the patch author should consider the warning and
> decide to ignore it.  

Very true.  It's a brainless tool and all who use
it should seriously consider ignoring its output
whenever they deem appropriate.
