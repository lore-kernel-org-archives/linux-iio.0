Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40715 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754953Ab1KZW4V (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 26 Nov 2011 17:56:21 -0500
From: Federico Vaga <federico.vaga@gmail.com>
To: Greg KH <greg@kroah.com>
Cc: Alessandro Rubini <rubini@gnudd.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, dcobas@cern.ch, siglesia@cern.ch,
	manohar.vanga@cern.ch
Subject: Re: [RFC PATCH 3/7] drivers/zio: core files for the ZIO input/output
Date: Sat, 26 Nov 2011 23:58:41 +0100
Message-ID: <7431481.TL8TOhprdN@harkonnen>
In-Reply-To: <20111126200341.GD11421@kroah.com>
References: <cover.1322328073.git.rubini@gnudd.com> <51ba376321edbd0bcbd206cb28abb14a68a05a2b.1322328075.git.rubini@gnudd.com> <20111126200341.GD11421@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

In data sabato 26 novembre 2011 12:03:41, Greg KH ha scritto:
> On Sat, Nov 26, 2011 at 06:30:42PM +0100, Alessandro Rubini wrote:
> > +static struct kobj_type zdktype = { /* For standard and extended
> > attribute */ +	.release   = NULL,
> 
> Sweet!
> 
> As-per the in-kernel documentation, I now get to mock you for doing
> this :)
> 
> Please NEVER DO THIS, you are ignoring the messages that the kernel
> sends you when you remove one of these devices, and causing a memory
> leak.

Honestly we never see any messages about this.

> Not nice at all, yet another reason to use a 'struct device'.

I don't think is a valid reason, because device_release implementation require 
us to implement a release method within device, or device_type or class; so we 
can use kobj_type as well.

> thanks,
> 
> greg k-h
-- 
Federico Vaga
