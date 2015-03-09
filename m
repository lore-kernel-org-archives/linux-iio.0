Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:49601 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbbCIIzu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2015 04:55:50 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [next:master 1712/3346] ERROR: "iio_trigger_notify_done" [drivers/staging/iio/iio_dummy.ko] undefined!
Date: Mon, 09 Mar 2015 09:55:35 +0100
Message-ID: <2530839.vrY3not473@wuerfel>
In-Reply-To: <20150309012706.GA4550@wfg-t540p.sh.intel.com>
References: <201503080501.uKS2e4HY%fengguang.wu@intel.com> <2452788.WEdufg3otZ@wuerfel> <20150309012706.GA4550@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Monday 09 March 2015 09:27:06 Fengguang Wu wrote:
> On Sun, Mar 08, 2015 at 11:11:31PM +0100, Arnd Bergmann wrote:
> > On Sunday 08 March 2015 05:31:03 kbuild test robot wrote:
> > > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > > head:   28855005be1d6a0a041de46fd2e61da2b796abff
> > > commit: 3608688973e8c85fbcd9b7e72b90e224b8d01526 [1712/3346] iio: ak8975: fix AK09911 dependencies
> > > config: x86_64-randconfig-iv1-03080434 (attached as .config)
> > > reproduce:
> > >   git checkout 3608688973e8c85fbcd9b7e72b90e224b8d01526
> > >   # save the attached .config to linux build tree
> > >   make ARCH=x86_64 
> > > 
> > > All error/warnings:
> > > 
> > > >> ERROR: "iio_trigger_notify_done" [drivers/staging/iio/iio_dummy.ko] undefined!
> > > >> ERROR: "iio_triggered_buffer_postenable" [drivers/staging/iio/iio_dummy.ko] undefined!
> > > >> ERROR: "iio_triggered_buffer_predisable" [drivers/staging/iio/iio_dummy.ko] undefined!
> > > >> ERROR: "iio_alloc_pollfunc" [drivers/staging/iio/iio_dummy.ko] undefined!
> > > >> ERROR: "iio_dealloc_pollfunc" [drivers/staging/iio/iio_dummy.ko] undefined!
> > > 
> > 
> > I don't understand what that error has to do with my patch, it
> > seems like a separate issue.
> 
> Arnd, they should be old link errors exposed by your build fix (which
> enables the build to progress further).
> 

Ok, makes sense. For some reason, I never see this particular error on ARM,
otherwise I'd already have a fix for it.

	Arnd
