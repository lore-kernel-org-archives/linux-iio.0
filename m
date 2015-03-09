Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:57313 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751847AbbCIB1J (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 8 Mar 2015 21:27:09 -0400
Date: Mon, 9 Mar 2015 09:27:06 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kbuild-all@01.org, Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [next:master 1712/3346] ERROR: "iio_trigger_notify_done"
 [drivers/staging/iio/iio_dummy.ko] undefined!
Message-ID: <20150309012706.GA4550@wfg-t540p.sh.intel.com>
References: <201503080501.uKS2e4HY%fengguang.wu@intel.com>
 <2452788.WEdufg3otZ@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <2452788.WEdufg3otZ@wuerfel>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Mar 08, 2015 at 11:11:31PM +0100, Arnd Bergmann wrote:
> On Sunday 08 March 2015 05:31:03 kbuild test robot wrote:
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> > head:   28855005be1d6a0a041de46fd2e61da2b796abff
> > commit: 3608688973e8c85fbcd9b7e72b90e224b8d01526 [1712/3346] iio: ak8975: fix AK09911 dependencies
> > config: x86_64-randconfig-iv1-03080434 (attached as .config)
> > reproduce:
> >   git checkout 3608688973e8c85fbcd9b7e72b90e224b8d01526
> >   # save the attached .config to linux build tree
> >   make ARCH=x86_64 
> > 
> > All error/warnings:
> > 
> > >> ERROR: "iio_trigger_notify_done" [drivers/staging/iio/iio_dummy.ko] undefined!
> > >> ERROR: "iio_triggered_buffer_postenable" [drivers/staging/iio/iio_dummy.ko] undefined!
> > >> ERROR: "iio_triggered_buffer_predisable" [drivers/staging/iio/iio_dummy.ko] undefined!
> > >> ERROR: "iio_alloc_pollfunc" [drivers/staging/iio/iio_dummy.ko] undefined!
> > >> ERROR: "iio_dealloc_pollfunc" [drivers/staging/iio/iio_dummy.ko] undefined!
> > 
> 
> I don't understand what that error has to do with my patch, it
> seems like a separate issue.

Arnd, they should be old link errors exposed by your build fix (which
enables the build to progress further).

Thanks,
Fengguang
