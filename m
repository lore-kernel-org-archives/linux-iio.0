Return-Path: <SRS0=4Ymb=NB=poczta.fm=sst@kernel.org>
Date: Sun, 21 Oct 2018 11:30:02 +0200
From: Slawomir Stepien <sst@poczta.fm>
To: Nishad Kamdar <nishadkamdar@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [PATCH] staging: iio: ad2s1210: Switch to the gpio descriptor
 interface
Message-ID: <20181021093002.GC7662@x220.localdomain>
References: <20181021061924.GA11073@nishad>
 <20181021083138.GB7662@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20181021083138.GB7662@x220.localdomain>
List-ID: <linux-iio@vger.kernel.org>

On paź 21, 2018 10:31, Slawomir Stepien wrote:
> On paź 21, 2018 11:49, Nishad Kamdar wrote:
> > -static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
> > +static int ad2s1210_setup_gpios(struct spi_device *spi,
> > +				struct ad2s1210_state *st)
> 
> This change is not needed. The st has the spi_device inside. Use container_of()
> macro here.

Wait...what? I mean use direct access using st->sdev.

-- 
Slawomir Stepien
