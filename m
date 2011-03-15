Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:55069 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757836Ab1CONba (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Mar 2011 09:31:30 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Add STMicroelectronics LPS001WP pressure sensor device driver into misc
Date: Tue, 15 Mar 2011 14:31:21 +0100
Cc: Jonathan Cameron <jic23@cam.ac.uk>,
	Jean Delvare <khali@linux-fr.org>,
	mems applications <mems.applications@st.com>,
	rdunlap@xenotime.net, carmine.iascone@st.com, matteo.dameno@st.com,
	rubini@ipvvis.unipv.it, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <guenter.roeck@ericsson.com>,
	Greg KH <greg@kroah.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <1300128906-1066-1-git-send-email-matteo.dameno@st.com> <4D7F4944.4070507@cam.ac.uk> <20110315125149.GC17277@sirena.org.uk>
In-Reply-To: <20110315125149.GC17277@sirena.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201103151431.22052.arnd@arndb.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tuesday 15 March 2011, Mark Brown wrote:
> > 2) Basically make a copy.  This would look like the original patch set did when we went
> 
> A third option is just to lift everything out of staging roughly as it
> is now with anything that definitely needs redoing dropped, addressing
> any review comments for mainline but not doing much else, and then
> resume working on adding additional stuff.  It sounds like the userspace
> interfaces that are there at present are mostly OK and most of the
> issues are in-kernel?
> 
> You could perhaps have a Kconfig control for disabling any experimental
> features in the API if you want to give people hints about areas that
> are likely to churn.

I agree, that sounds like a good idea for preparing the code before a split.

	Arnd
