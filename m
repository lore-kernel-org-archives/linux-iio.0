Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:39354 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753984Ab1KZUEg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 26 Nov 2011 15:04:36 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7F2EF20C4C
	for <linux-iio@vger.kernel.org>; Sat, 26 Nov 2011 15:04:35 -0500 (EST)
Date: Sat, 26 Nov 2011 12:03:41 -0800
From: Greg KH <greg@kroah.com>
To: Alessandro Rubini <rubini@gnudd.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	federico.vaga@gmail.com, dcobas@cern.ch, siglesia@cern.ch,
	manohar.vanga@cern.ch
Subject: Re: [RFC PATCH 3/7] drivers/zio: core files for the ZIO input/output
Message-ID: <20111126200341.GD11421@kroah.com>
References: <cover.1322328073.git.rubini@gnudd.com>
 <51ba376321edbd0bcbd206cb28abb14a68a05a2b.1322328075.git.rubini@gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51ba376321edbd0bcbd206cb28abb14a68a05a2b.1322328075.git.rubini@gnudd.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Nov 26, 2011 at 06:30:42PM +0100, Alessandro Rubini wrote:
> +static struct kobj_type zdktype = { /* For standard and extended attribute */
> +	.release   = NULL,

Sweet!

As-per the in-kernel documentation, I now get to mock you for doing
this :)

Please NEVER DO THIS, you are ignoring the messages that the kernel
sends you when you remove one of these devices, and causing a memory
leak.

Not nice at all, yet another reason to use a 'struct device'.

thanks,

greg k-h
