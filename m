Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:57964 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755071AbcFTOUn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2016 10:20:43 -0400
Date: Mon, 20 Jun 2016 15:19:54 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Jiri Kosina <jikos@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	jic23@kernel.org, benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, chaya.golan@intel.com,
	daniel.drubin@intel.com, A.Bhattacharya@ulg.ac.be
Subject: Re: [PATCH 2/6] hid: intel_ish-hid: ISH Transport layer
Message-ID: <20160620151954.0c9094db@lxorguk.ukuu.org.uk>
In-Reply-To: <alpine.LNX.2.00.1606201129060.6874@cbobk.fhfr.pm>
References: <1465647219-7798-1-git-send-email-srinivas.pandruvada@linux.intel.com>
	<1465647219-7798-3-git-send-email-srinivas.pandruvada@linux.intel.com>
	<alpine.LNX.2.00.1606172236520.6874@cbobk.fhfr.pm>
	<1466197963.24319.110.camel@linux.intel.com>
	<alpine.LNX.2.00.1606201129060.6874@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 20 Jun 2016 11:29:28 +0200 (CEST)
Jiri Kosina <jikos@kernel.org> wrote:

> On Fri, 17 Jun 2016, Srinivas Pandruvada wrote:
> 
> > > > +config INTEL_ISH_HID_TRANSPORT
> > > > +     bool
> > > > +     default n
> > > > +
> > > > +config INTEL_ISH_HID
> > > > +     bool "Intel Integrated Sensor Hub"  
> > > 
> > > Why can't the transport driver be built as a module?  
> > In current use case for PM, we don't want anyone to unload and
> > complain.  
> 
> Sorry, I don't understand this explanation, could you please elaborate?

If the driver isn't loaded your machine doesn't do power management.
There are a small set of drivers that need to be loaded to get pm even if
not using that device. ISH is one of them, and unlike the others not
sucked into a standard configuration.

If it's going to get loaded due to the presence of the PCI identifiers on
any normal distribution then it's in the same category as graphics and
ADSP based audio, both of which can be modules and the only real world
impact is they get loaded a second or two later during boot.

Alan
