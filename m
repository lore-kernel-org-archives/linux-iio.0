Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailcl2.heig-vd.ch ([193.134.216.183]:53003 "EHLO heig-vd.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750787AbcFVGSV (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 22 Jun 2016 02:18:21 -0400
Subject: Re: [PATCH 2/3] iio: adc: max1363: Add device tree binding
 documentation
To: Rob Herring <robh@kernel.org>
References: <1466492969-2185-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1466492969-2185-3-git-send-email-florian.vaussard@heig-vd.ch>
 <20160621214951.GA11679@rob-hp-laptop>
CC: <devicetree@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Martin Kepplinger <martink@posteo.de>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Florian Vaussard <florian.vaussard@heig-vd.ch>
Message-ID: <b48960b5-1965-b2cc-037b-eba4e7bbb7cb@heig-vd.ch>
Date: Wed, 22 Jun 2016 08:18:06 +0200
MIME-Version: 1.0
In-Reply-To: <20160621214951.GA11679@rob-hp-laptop>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Rob,

Le 21. 06. 16 à 23:49, Rob Herring a écrit :
> On Tue, Jun 21, 2016 at 09:09:28AM +0200, Florian Vaussard wrote:
>> Add the device tree documentation for all the supported parts. Mandatory
>> binding is the compatible string and the slave I2C address.
>>
>> Optional properties can be used to specify the Vcc / Vref regulators, as
>> well as the IRQ line if available.
>>
>> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
>> ---
>>  .../devicetree/bindings/iio/adc/max1363.txt        | 63 ++++++++++++++++++++++
>>  1 file changed, 63 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/adc/max1363.txt
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 

Thanks for the review.

Florian
