Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0107.outbound.protection.outlook.com ([104.47.2.107]:12017
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751311AbcFVHHF (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 22 Jun 2016 03:07:05 -0400
Subject: Re: [PATCH 3/3] iio: potentiometer: mcp4531: Add device tree binding
To: Florian Vaussard <florian.vaussard@heig-vd.ch>,
	<devicetree@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1466492137-32683-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1466492137-32683-4-git-send-email-florian.vaussard@heig-vd.ch>
 <bf4dbd64-aac8-aba3-ec5c-4cd4d0e848f6@axentia.se>
 <829a4507-39d7-e04a-9672-6309def89ee2@heig-vd.ch>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Slawomir Stepien <sst@poczta.fm>,
	Joachim Eastwood <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: Peter Rosin <peda@axentia.se>
Message-ID: <dfdbc7dd-8457-c0ef-9f0e-e2c1d96e5b11@axentia.se>
Date: Wed, 22 Jun 2016 09:06:16 +0200
MIME-Version: 1.0
In-Reply-To: <829a4507-39d7-e04a-9672-6309def89ee2@heig-vd.ch>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2016-06-22 08:22, Florian Vaussard wrote:
> Hello Peter,
> 
> Le 21. 06. 16 à 09:51, Peter Rosin a écrit :
>> That is, if you need this patch at all, see my reply to 2/3...
>>
> 
> This seems necessary in order to have the vendor ID in the compatible string.

Hmm, I don't think so. The way I read the response from Rob was that
*my* device tree snippet should not assume that the i2c subsystem
ignores the vendor. So, I think that even w/o this patch a DT entry
like

		mcp4651-104@28 {
			compatible = "microchip,mcp4651-104";
			reg = <0x28>;
		};

will work, precisely since i2c ignores the microchip, part (and thus
allows you to omit/misspell it). I.e. I think that Rob is concerned
with how the DT is documented/defined, and not so much about how it
is then implemented in Linux.

I haven't actually tested that though, so I may be completely wrong
in all of the above statements...

Cheers,
Peter


