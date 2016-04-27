Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:50522 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbcD0P4d (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Apr 2016 11:56:33 -0400
Date: Wed, 27 Apr 2016 16:56:13 +0100
From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
To: Michael Welling <mwelling@ieee.org>
Cc: linux-kernel@vger.kernel.org, mranostay@gmail.com,
	jic23@kernel.org, daniel.baluta@intel.com,
	linux-iio@vger.kernel.org
Subject: Re: Regression in inv_mpu6050: 4.6.0-rc5
Message-ID: <20160427165613.4d464792@lxorguk.ukuu.org.uk>
In-Reply-To: <20160426230755.GA6235@deathstar>
References: <20160426232651.099a18d7@lxorguk.ukuu.org.uk>
	<20160426230755.GA6235@deathstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 26 Apr 2016 18:07:55 -0500
Michael Welling <mwelling@ieee.org> wrote:

> On Tue, Apr 26, 2016 at 11:26:51PM +0100, One Thousand Gnomes wrote:
> > 
> > This now causes us to crash and burn on the ASUS T100TA Baytrail/T
> > platforms
> >  
> 
> I believe this regression has already been patched.
> 
> Check the latest commits in linux-next.
> 
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/log/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> 
> See if the latest patches fix your issue.

It does - as this is a regression can we please get those fixes into the
next -rc ?

Alan
