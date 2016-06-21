Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-am1on0105.outbound.protection.outlook.com ([157.56.112.105]:57486
	"EHLO emea01-am1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751573AbcFUNHz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 21 Jun 2016 09:07:55 -0400
Subject: Re: [PATCH 1/3] iio: potentiometer: mcp4531: Add support for MCP454x,
 MCP456x, MCP464x and MCP466x
To: Florian Vaussard <florian.vaussard@gmail.com>,
	<devicetree@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	"Hartmut Knaack" <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>
References: <1466492137-32683-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1466492137-32683-2-git-send-email-florian.vaussard@heig-vd.ch>
CC: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	"Mark Rutland" <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Slawomir Stepien <sst@poczta.fm>,
	"Joachim Eastwood" <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	"Cristina Moraru" <cristina.moraru09@gmail.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
From: Peter Rosin <peda@axentia.se>
Message-ID: <a3f0425e-8286-7389-6fd8-013d309cb623@axentia.se>
Date: Tue, 21 Jun 2016 09:28:02 +0200
MIME-Version: 1.0
In-Reply-To: <1466492137-32683-2-git-send-email-florian.vaussard@heig-vd.ch>
Content-Type: text/plain; charset="windows-1252"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 2016-06-21 08:55, Florian Vaussard wrote:
> This patch adds support for MCP454x, MCP456x, MCP464x and MCP466x parts.
> The main difference with currently supported parts (MCP453x and alike) is
> the addition of a non-volatile memory in order to recall the wiper setting
> at power-on. This feature is currently not supported and only the
> volatile memory is used to set the wiper.
> 
> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

