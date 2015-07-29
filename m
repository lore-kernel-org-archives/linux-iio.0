Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:34344 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752900AbbG2H6v (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jul 2015 03:58:51 -0400
Date: Wed, 29 Jul 2015 00:58:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, cory.tusar@pid1solutions.com
Subject: Re: [PATCH v2 5/5] iio: Support triggered events
Message-ID: <20150729075834.GA20718@infradead.org>
References: <1438038300-12855-1-git-send-email-vladimir.barinov@cogentembedded.com>
 <1438038442-13082-1-git-send-email-vladimir.barinov@cogentembedded.com>
 <1438156610.5106.4.camel@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438156610.5106.4.camel@tiscali.nl>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jul 29, 2015 at 09:56:50AM +0200, Paul Bolle wrote:
> 
> > +MODULE_LICENSE("GPL");
> 
> And, according to include/linux/module.h, this states the license is GPL
> v2 or later. So either the comment or the ident used in the
>
Btw, who came up with that meaning?  The default Linux license is GPLv2
only and unless othewise specified that's what we should get by default.
