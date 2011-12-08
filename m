Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:34654 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750855Ab1LHUYo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 8 Dec 2011 15:24:44 -0500
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7BA302124C
	for <linux-iio@vger.kernel.org>; Thu,  8 Dec 2011 15:24:43 -0500 (EST)
Date: Thu, 8 Dec 2011 12:14:57 -0800
From: Greg KH <greg@kroah.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de
Subject: Re: [PATCH 00/19] staging:iio:buffer clean ups.
Message-ID: <20111208201457.GA27664@kroah.com>
References: <1323123510-21388-1-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323123510-21388-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Dec 05, 2011 at 10:18:11PM +0000, Jonathan Cameron wrote:
> Hi Greg,
> 
> Dependent on previous two series:
> 
> Add scan demux unit..
> iio:staging:inkern pull interface for staging tree.

Hm, not really, it applied even though I didn't apply that second
series, hope I didn't mess anything really up now...

greg k-h
