Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:35099 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751246AbbJYIfX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 25 Oct 2015 04:35:23 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 68E50205D3
	for <linux-iio@vger.kernel.org>; Sun, 25 Oct 2015 04:35:20 -0400 (EDT)
Date: Sat, 24 Oct 2015 19:33:39 -0700
From: Greg KH <greg@kroah.com>
To: Alison Schofield <amsfield22@gmail.com>
Cc: outreachy-kernel@googlegroups.com, jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH] staging: iio: dummy: clean up the
 define and usage of dummy_scan_elements
Message-ID: <20151025023339.GA24521@kroah.com>
References: <20151023165418.GA18718@Ubuntu-D830>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151023165418.GA18718@Ubuntu-D830>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Oct 23, 2015 at 09:54:27AM -0700, Alison Schofield wrote:
> Cleanups related to the usage of dummy_scan_elements in the
> iio dummy driver:
> - change enum names to upper case INDEX_*
> - use the enum for IIO_CHAN_SOFT_TIMESTAMP (rm hard coded value)
> - comment edited to match changes & follow preferred kernel style

That's 3 different things, so this should be 3 different patches, right?

Please break it up and resend.

thanks,

greg k-h
