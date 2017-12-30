Return-Path: <SRS0=bgF8=D2=tobin.cc=me@kernel.org>
Date: Sat, 30 Dec 2017 20:58:12 +1100
From: "Tobin C. Harding" <me@tobin.cc>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: add kernel-doc '@owner'
Message-ID: <20171230095812.GB6042@caerus>
References: <1513664270-29523-1-git-send-email-me@tobin.cc>
 <20171229173640.5fd6e649@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171229173640.5fd6e649@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Fri, Dec 29, 2017 at 05:36:40PM +0000, Jonathan Cameron wrote:
> On Tue, 19 Dec 2017 17:17:50 +1100
> "Tobin C. Harding" <me@tobin.cc> wrote:
> 
> > When building kernel documentation sphinx emits the following warning
> > 
> > 	warning: No description found for parameter 'owner'
> > 
> > Add description for struct member 'owner'.
> > 
> > Signed-off-by: Tobin C. Harding <me@tobin.cc>
> > ---
> > 
> > I couldn't work out what DRIVER/INTERN were for so I took a guess.
> Try the other one ;)
> 
> They refer to whether the driver should be directly accessing the
> field or not.  In the case of owner they shouldn't be so it is INTERN.
> 
> Were I writing the subsystem from scratch again I'd probably make the
> separation of the two cleaner, but there we are.

Thanks, will re-spin after Christmas break.

	Tobin
        
