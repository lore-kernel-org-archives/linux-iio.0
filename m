Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:32859 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751613Ab2BAXbW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 1 Feb 2012 18:31:22 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 7FFFA209B6
	for <linux-iio@vger.kernel.org>; Wed,  1 Feb 2012 18:21:42 -0500 (EST)
Date: Wed, 1 Feb 2012 15:21:06 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 0/6] staging:iio: Event handling updates
Message-ID: <20120201232106.GB8246@kroah.com>
References: <1328121956-29596-1-git-send-email-lars@metafoo.de>
 <4F299764.8090605@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4F299764.8090605@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Feb 01, 2012 at 08:49:56PM +0100, Lars-Peter Clausen wrote:
> On 02/01/2012 07:45 PM, Lars-Peter Clausen wrote:
> > Hi Greg,
> > 
> > This series is a resend of the same series form early January, with two minor
> > issues in patch 4 and 5 being fixed. Also the order of patch 5 and 6 in the
> > series has been changed.
> > 
> > The series starts with fixing some documentation issues for the
> > iio_event_interface struct. The second patch moves the IIO event handling code
> > from the IIO core file to its own file with the next patches containing some
> > cleanups to the event handling code. The last patch implements poll support for
> > IIO event handling fds.
> > 
> > - Lars
> > 
> 
> 
> Sorry for the noise, greg's old email address is already dead, I'll have to
> resend this series.

No, I got it through the 2 mailing lists you sent it to, don't worry.

greg k-h
