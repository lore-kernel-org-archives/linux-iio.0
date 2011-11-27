Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48845 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752358Ab1K0Ti4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Nov 2011 14:38:56 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0EAF9213C7
	for <linux-iio@vger.kernel.org>; Sun, 27 Nov 2011 14:38:56 -0500 (EST)
Date: Mon, 28 Nov 2011 04:23:56 +0900
From: Greg KH <greg@kroah.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/3] Initial filtering (hardware) control for IIO.
Message-ID: <20111127192356.GA18601@kroah.com>
References: <1322393954-31525-1-git-send-email-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322393954-31525-1-git-send-email-jic23@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Nov 27, 2011 at 11:39:11AM +0000, Jonathan Cameron wrote:
> Hi Greg,
> 
> Thanks for merging all those patches yesterday.
> 
> These have been sitting in my tree and on linux-iio for far too long.
> I think all issues raised about the initial patch set were answered
> and fear this is not of sufficient interest to anyone to get a second
> review!
> 
> Anyhow fairly uncontroversial support for the low pass filters on
> the ADI imu units.

All now applied, thanks.

greg k-h
