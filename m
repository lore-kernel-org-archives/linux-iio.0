Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:29417 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605AbaIKW1v (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 11 Sep 2014 18:27:51 -0400
Date: Thu, 11 Sep 2014 15:26:50 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Mark Brown <broonie@debian.org>
Cc: IIO <linux-iio@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	DEVICE TREE <devicetree@vger.kernel.org>,
	Lee Jones <lee.jones@linaro.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Aaron Lu <aaron.lu@intel.com>, Alan Cox <alan@linux.intel.com>,
	Jean Delvare <khali@linux-fr.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Grant Likely <grant.likely@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Fugang Duan <B38611@freescale.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Zubair Lutfullah <zubair.lutfullah@gmail.com>,
	Sebastian Reichel <sre@debian.org>,
	Johannes Thumshirn <johannes.thumshirn@men.de>,
	Philippe Reynes <tremyfr@yahoo.fr>,
	Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH 3/4] regulator/axp20x: use axp2xx consolidated header
Message-ID: <20140911152650.74767024@ultegra>
In-Reply-To: <20140909112516.GR2601@sirena.org.uk>
References: <1410215046-31751-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1410215046-31751-4-git-send-email-jacob.jun.pan@linux.intel.com>
	<20140909112516.GR2601@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 9 Sep 2014 12:25:16 +0100
Mark Brown <broonie@debian.org> wrote:

> On Mon, Sep 08, 2014 at 03:24:05PM -0700, Jacob Pan wrote:
> > AXP20x driver has been extended to support axp288 variant. Header
> > file and common data structures has also been renamed to suit the
> > new scope of devices supported.
> > 
> > This patch makes use of the renamed header and structure.
> 
> > -#include <linux/mfd/axp20x.h>
> > +#include <linux/mfd/axp2xx.h>
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> 
> but is it really worth the effort of renaming everything?  That's
> going to cause problems for things like the stable workflow.

sorry for the late reply. IMHO, consistent and correct naming has
longer term benefit. how can i help to make the stable workflow easier?
