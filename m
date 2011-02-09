Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:50857 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755187Ab1BIXBS (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 9 Feb 2011 18:01:18 -0500
Date: Wed, 9 Feb 2011 14:58:24 -0800
From: Greg KH <greg@kroah.com>
To: michael.hennerich@analog.com
Cc: jic23@cam.ac.uk, linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] Staging: IIO: TRIGGER: New sysfs based trigger
Message-ID: <20110209225824.GA23566@kroah.com>
References: <1297073146-10411-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297073146-10411-1-git-send-email-michael.hennerich@analog.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Feb 07, 2011 at 11:05:46AM +0100, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> This patch adds a new trigger that can be invoked by writing
> the sysfs file: trigger_now. This approach can be valuable during
> automated testing or in situations, where other trigger methods
> are not applicable. For example no RTC or spare GPIOs.
> Last but not least we can allow user space applications to produce triggers.
> 
> IIO: TRIGGER: Apply review feedback by Greg Kroah-Hartman

Well, I don't really like it, as I still don't know, as a distro
maintainer, if I need to enable this or not, and there's no auto-load
capability, but hey, my distro(s) don't enable these drivers anyway, so
I don't have to worry about it :)

thanks,

greg k-h
