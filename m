Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:36495 "EHLO
	mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751752AbcFUWBn (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2016 18:01:43 -0400
Date: Tue, 21 Jun 2016 16:49:51 -0500
From: Rob Herring <robh@kernel.org>
To: Florian Vaussard <florian.vaussard@gmail.com>
Cc: devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Martin Kepplinger <martink@posteo.de>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
Subject: Re: [PATCH 2/3] iio: adc: max1363: Add device tree binding
 documentation
Message-ID: <20160621214951.GA11679@rob-hp-laptop>
References: <1466492969-2185-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1466492969-2185-3-git-send-email-florian.vaussard@heig-vd.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466492969-2185-3-git-send-email-florian.vaussard@heig-vd.ch>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jun 21, 2016 at 09:09:28AM +0200, Florian Vaussard wrote:
> Add the device tree documentation for all the supported parts. Mandatory
> binding is the compatible string and the slave I2C address.
> 
> Optional properties can be used to specify the Vcc / Vref regulators, as
> well as the IRQ line if available.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
> ---
>  .../devicetree/bindings/iio/adc/max1363.txt        | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/max1363.txt

Acked-by: Rob Herring <robh@kernel.org>
