Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37629 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752135Ab1BWUKW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Feb 2011 15:10:22 -0500
Date: Wed, 23 Feb 2011 20:10:43 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jean Delvare <khali@linux-fr.org>
Cc: Jonathan Cameron <jic23@cam.ac.uk>, Andrew Chew <AChew@nvidia.com>,
	chinyeow.sim.xt@renesas.com, gregkh@suse.de,
	devel@driverdev.osuosl.org, linux-iio@vger.kernel.org
Subject: Re: [RFC PATCH] staging: ak8975: add platform data.
Message-ID: <20110223201043.GC2534@opensource.wolfsonmicro.com>
References: <1297764627-21077-1-git-send-email-chinyeow.sim.xt@renesas.com>
 <643E69AA4436674C8F39DCC2C05F763816BD96CFB5@HQMAIL03.nvidia.com>
 <4D628E66.5090900@cam.ac.uk>
 <20110222102955.52be2b94@endymion.delvare>
 <4D63AD81.5080903@cam.ac.uk>
 <20110222215552.GA28740@sirena.org.uk>
 <20110223091939.3ba0b190@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110223091939.3ba0b190@endymion.delvare>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Feb 23, 2011 at 09:19:39AM +0100, Jean Delvare wrote:
> On Tue, 22 Feb 2011 21:55:55 +0000, Mark Brown wrote:

> > There's no standard support for GPIOs as resources - this is always done
> > using platform data these days.

> Would it make sense to add this? I have no opinion on the question, not
> being a big user of GPIO, just wondering.

Possibly, yes.
