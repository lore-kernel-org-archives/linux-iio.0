Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52421 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752039AbaLCWZU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 3 Dec 2014 17:25:20 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Linux PM list <linux-pm@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio / PM: Replace CONFIG_PM_RUNTIME with CONFIG_PM
Date: Wed, 03 Dec 2014 23:46:45 +0100
Message-ID: <5292660.MpQBlxNLlG@vostro.rjw.lan>
In-Reply-To: <1417623491.2043.320.camel@spandruv-desktop.jf.intel.com>
References: <202529361.GBbZ7zGgn8@vostro.rjw.lan> <1417623491.2043.320.camel@spandruv-desktop.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wednesday, December 03, 2014 08:18:11 AM Srinivas Pandruvada wrote:
> On Wed, 2014-12-03 at 03:06 +0100, Rafael J. Wysocki wrote: 
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> > selected) PM_RUNTIME is always set if PM is set, so #ifdef blocks
> > depending on CONFIG_PM_RUNTIME may now be changed to depend on
> > CONFIG_PM.
> > 
> > Replace CONFIG_PM_RUNTIME with CONFIG_PM everywhere under
> > drivers/iio/.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> > ---
> > 
> > Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if
> > PM_SLEEP is selected) which is only in linux-next at the moment (via the
> > linux-pm tree).
> > 
> > Please let me know if it is OK to take this one into linux-pm.
> 
> There are some other drivers using this define, we need to change all
> those.

Yes, I'm doing this everywhere, this patch is just one part of it.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
