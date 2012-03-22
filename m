Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:52189
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755708Ab2CVJF5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Thu, 22 Mar 2012 05:05:57 -0400
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Jonathan Cameron <jic23@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>,
	Drivers <Drivers@analog.com>
Date: Thu, 22 Mar 2012 09:05:34 +0000
Subject: RE: [RFC] iio: amplifiers: New driver for AD8366 Dual-Digital
 Variable Gain Amplifier
Message-ID: <544AC56F16B56944AEC3BD4E3D5917714BCC4C6C30@LIMKCMBX1.ad.analog.com>
References: <1329914182-5428-1-git-send-email-michael.hennerich@analog.com>
 <4F6A2D2B.9050400@kernel.org>
 <20120321195942.GO3226@opensource.wolfsonmicro.com>
In-Reply-To: <20120321195942.GO3226@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Mark Brown wrote on 2012-03-21:
> On Wed, Mar 21, 2012 at 07:34:03PM +0000, Jonathan Cameron wrote:
>
>> I've pulled Mark into the cc as he might have come across similar
>> devices from the audio side of things and hence have some experience
>> around this question...
>
> How to represent gains from amplifiers?  Audio specifies gains as dB
> between input and output; generic stuff like IIO may want to do that
> using a linear scale (or have the option).

All VGAs I know describe the gain in dB.

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret Seif


