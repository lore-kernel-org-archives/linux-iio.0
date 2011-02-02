Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:38550 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752384Ab1BBUbJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 2 Feb 2011 15:31:09 -0500
Date: Wed, 2 Feb 2011 20:31:07 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Greg KH <greg@kroah.com>
Cc: michael.hennerich@analog.com, jic23@cam.ac.uk,
	linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] IIO: TRIGGER: New sysfs based trigger
Message-ID: <20110202203107.GE28705@opensource.wolfsonmicro.com>
References: <1296674468-24251-1-git-send-email-michael.hennerich@analog.com>
 <20110202194318.GB27065@kroah.com>
 <20110202195001.GH9810@sirena.org.uk>
 <20110202202641.GA28479@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110202202641.GA28479@kroah.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Feb 02, 2011 at 12:26:41PM -0800, Greg KH wrote:
> On Wed, Feb 02, 2011 at 07:50:01PM +0000, Mark Brown wrote:

> > - the MFD subsystem is one of the most obvious examples here.

> Don't make a device a "platform" device unless it really is one.  This
> one isn't one, it's a "virtual" device, right?

The discussion then always comes down to the fact that this then means
we have to define a new bus type which ends up being an exact copy of
the platform bus which isn't exactly ideal.
