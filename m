Return-Path: <SRS0=jBGm=MX=poczta.fm=sst@kernel.org>
Date: Thu, 11 Oct 2018 17:31:52 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: Gabriel Capella <gabriel@capella.pro>
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] staging: iio: adc: ad7280a: fix 2 checks
Message-ID: <20181011153152.GA1544@x220.localdomain>
References: <20181006162715.GA8476@mantaray>
 <20181006202542.GC5035@x220.localdomain>
 <20181011073203.iesapekyqkma2cqa@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20181011073203.iesapekyqkma2cqa@mwanda>
List-ID: <linux-iio@vger.kernel.org>

On paź 11, 2018 10:32, Dan Carpenter wrote:
> On Sat, Oct 06, 2018 at 10:25:42PM +0200, Slawomir Stepien wrote:
> > On paź 06, 2018 13:27, Gabriel Capella wrote:
> > > This patch does not change the logic, it only
> > > corrects the checkpatch checks.
> > > 
> > > The patch fixes 2 checks of type:
> > > "CHECK: spaces preferred around that '-'"
> > 
> > I've made the same mistake few days ago. This change is incorrect.
> > Please see: https://lore.kernel.org/patchwork/patch/635994/.
> >
> 
> You could add a comment.  /* do not put spaces around the hyphen.  #checkpatch.pl */
> 
> These are the only places which use this style and a lot of people
> bump into it.

Gabriel go ahead if you want to. If not then I would be happy to prepare this
patch.

-- 
Slawomir Stepien
