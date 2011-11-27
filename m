Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:52652 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751241Ab1K0KYe (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2011 05:24:34 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7E76C21A98
	for <linux-iio@vger.kernel.org>; Sun, 27 Nov 2011 05:24:34 -0500 (EST)
Date: Sun, 27 Nov 2011 01:33:21 -0800
From: Greg KH <greg@kroah.com>
To: Federico Vaga <federico.vaga@gmail.com>
Cc: Alessandro Rubini <rubini@gnudd.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, dcobas@cern.ch, siglesia@cern.ch,
	manohar.vanga@cern.ch
Subject: Re: [RFC PATCH 3/7] drivers/zio: core files for the ZIO input/output
Message-ID: <20111127093321.GC31086@kroah.com>
References: <cover.1322328073.git.rubini@gnudd.com>
 <51ba376321edbd0bcbd206cb28abb14a68a05a2b.1322328075.git.rubini@gnudd.com>
 <20111126200341.GD11421@kroah.com>
 <7431481.TL8TOhprdN@harkonnen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <7431481.TL8TOhprdN@harkonnen>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Nov 26, 2011 at 11:58:41PM +0100, Federico Vaga wrote:
> In data sabato 26 novembre 2011 12:03:41, Greg KH ha scritto:
> > On Sat, Nov 26, 2011 at 06:30:42PM +0100, Alessandro Rubini wrote:
> > > +static struct kobj_type zdktype = { /* For standard and extended
> > > attribute */ +	.release   = NULL,
> > 
> > Sweet!
> > 
> > As-per the in-kernel documentation, I now get to mock you for doing
> > this :)
> > 
> > Please NEVER DO THIS, you are ignoring the messages that the kernel
> > sends you when you remove one of these devices, and causing a memory
> > leak.
> 
> Honestly we never see any messages about this.

Really?  Then you never removed that kobject from memory.  Please go
read the kobject documentation for more details.

> > Not nice at all, yet another reason to use a 'struct device'.
> 
> I don't think is a valid reason, because device_release implementation require 
> us to implement a release method within device, or device_type or class; so we 
> can use kobj_type as well.

True, but it tries to make things easier to not get wrong, like you are
here.

Please fix this.

greg k-h
