Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51078 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751482AbcBHRhc (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 8 Feb 2016 12:37:32 -0500
Date: Mon, 8 Feb 2016 11:37:27 -0600
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sean Nyekjaer <sean.nyekjaer@prevas.dk>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH v2 4/4] iio: ad5755: Add full DT binding documentation
Message-ID: <20160208173727.GA823@rob-hp-laptop>
References: <1454509864-32285-1-git-send-email-sean.nyekjaer@prevas.dk>
 <1454509864-32285-2-git-send-email-sean.nyekjaer@prevas.dk>
 <1454509864-32285-3-git-send-email-sean.nyekjaer@prevas.dk>
 <1454509864-32285-4-git-send-email-sean.nyekjaer@prevas.dk>
 <56B63BAC.2040001@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56B63BAC.2040001@kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Feb 06, 2016 at 06:30:04PM +0000, Jonathan Cameron wrote:
> On 03/02/16 14:31, Sean Nyekjaer wrote:
> > Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
> Hmm. Complex beast.  Going to want Lars to look at this in particular.
> Also a device tree review would be good on this one.
> 
> My personal gut feeling is not to wrap up things that are really numeric
> with names, but rather to provide docs on the valid values for them.
> Not sure what is the preferred by the device tree guys??

Agreed. I'm not such a fan of defines in DT.

Also, if there is some possibility that bindings could be generic, I 
prefer to see them use the native units rather than the enumerated 
register values. The downside is adding the translation into the driver. 
These look like they could possibly be generic DAC properties.

Rob
