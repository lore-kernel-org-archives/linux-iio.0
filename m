Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34673 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752583AbbJOKUn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 15 Oct 2015 06:20:43 -0400
Date: Thu, 15 Oct 2015 11:20:37 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Martin Kepplinger <martink@posteo.de>, robh+dt@kernel.org,
	pawel.moll@arm.com, ijc+devicetree@hellion.org.uk,
	galak@codeaurora.org, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, mfuzzey@parkeon.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>
Subject: Re: [PATCH v3] iio: mma8452: support either of the available
 interrupt pins
Message-ID: <20151015102037.GB8825@leverpostej>
References: <1444828542-28861-1-git-send-email-martink@posteo.de>
 <561E70E0.1010508@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <561E70E0.1010508@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Oct 14, 2015 at 05:12:32PM +0200, Lars-Peter Clausen wrote:
> On 10/14/2015 03:15 PM, Martin Kepplinger wrote:
> [...]
> > +			if (irq1 > 0)
> > +				client->irq = irq1;
> 
> You must not overwrite client->irq, that field is manged by the I2C core and
> is supposed to be read only for device drivers.

Ok.

I think for the moment the simlpest thing to do would be to check which
of INT1 and INT2 match client->irq, and use that.

Thanks,
Mark.
