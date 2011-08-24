Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:55355 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751354Ab1HXI2r (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Aug 2011 04:28:47 -0400
Message-ID: <4E54B826.7010305@cam.ac.uk>
Date: Wed, 24 Aug 2011 09:36:54 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Wanlong Gao <gaowanlong@cn.fujitsu.com>, gregkh@suse.de,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] drivers:staging:remove the unused label error_ret
References: <1312362628-27127-1-git-send-email-gaowanlong@cn.fujitsu.com> <20110823203830.GB11450@kroah.com>
In-Reply-To: <20110823203830.GB11450@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/23/11 21:38, Greg KH wrote:
> On Wed, Aug 03, 2011 at 05:10:28PM +0800, Wanlong Gao wrote:
>> remove the unused label error_ret in ad5791.c.
> 
> This no longer applies :(
It crossed with one of my series that included equivalent fix
so now all fine in your tree.

Thanks anyway Wanlong!

Jonathan
