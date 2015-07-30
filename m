Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from lb1-smtp-cloud3.xs4all.net ([194.109.24.22]:57771 "EHLO
	lb1-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751177AbbG3Ktc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jul 2015 06:49:32 -0400
Message-ID: <1438253368.15571.31.camel@tiscali.nl>
Subject: Re: [PATCH 2/7] iio: bmg160: Use i2c regmap instead of direct i2c
 access
From: Paul Bolle <pebolle@tiscali.nl>
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vlad Dogaru <vlad.dogaru@intel.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Date: Thu, 30 Jul 2015 12:49:28 +0200
In-Reply-To: <20150729183738.GL30895@pengutronix.de>
References: <1438177569-18772-1-git-send-email-mpa@pengutronix.de>
	 <1438177569-18772-3-git-send-email-mpa@pengutronix.de>
	 <20150729183738.GL30895@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On wo, 2015-07-29 at 20:37 +0200, Markus Pargmann wrote:
> On Wed, Jul 29, 2015 at 03:46:04PM +0200, Markus Pargmann wrote:
> > +struct regmap_config bmg160_regmap_i2c_conf = {
> 
> This should probably be static const ...

Likewise for "bmg160_regmap_conf", which you add in 7/7, right?

Thanks,


Paul Bolle
