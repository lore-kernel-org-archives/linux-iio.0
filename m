Return-Path: <SRS0=r51a=A5=rere.qmqm.pl=mirq-linux@kernel.org>
Date: Thu, 28 Sep 2017 16:09:41 +0200
From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 7/8] iio: accel: kxcjk1013: remove unused platform
 data struct
Message-ID: <20170928140941.7tkd3bzbjjw4vxrw@qmqm.qmqm.pl>
References: <cover.1505660069.git.mirq-linux@rere.qmqm.pl>
 <7bab949c05f3fb70014bda990d7217ac98b08cbd.1505660069.git.mirq-linux@rere.qmqm.pl>
 <20170924162952.405404b0@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
In-Reply-To: <20170924162952.405404b0@archlinux>
List-ID: <linux-iio@vger.kernel.org>

On Sun, Sep 24, 2017 at 04:29:52PM +0100, Jonathan Cameron wrote:
> On Sun, 17 Sep 2017 17:01:04 +0200
> Micha³ Miros³aw <mirq-linux@rere.qmqm.pl> wrote:
> > kxcjk1013's platform data has no in-kernel users. Remove it.
> > 
> > Signed-off-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
> 
> Hmm. I'm not particularly keen on breaking peoples out of tree
> board files just for the sake of removing a bit of code.

I can add a patch using DT if there are any users. Board files should go away.

Best Regards,
Micha³ Miros³aw
