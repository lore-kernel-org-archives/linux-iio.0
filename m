Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:43799 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745AbbHLTpJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 15:45:09 -0400
Date: Wed, 12 Aug 2015 12:45:08 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PULL v2] Second set of new drivers, functionality and cleanup
 for IIO in the 4.3 cycle (+ some fixes)
Message-ID: <20150812194508.GA4279@kroah.com>
References: <55CB9E42.907@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55CB9E42.907@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Aug 12, 2015 at 08:28:02PM +0100, Jonathan Cameron wrote:
> The following changes since commit b8d1f261fe7e4967593a5637d62991b6197a03f8:
> 
>   staging: dgap: remove duplicate code (2015-07-16 10:19:55 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-4.3b-2

I had to do a merge conflict resolution in one driver, it was pretty
trivial, but if you could check I got it right, that would be great.

thanks,

greg k-h
