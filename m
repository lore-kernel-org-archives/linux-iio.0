Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47304 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbcFZOyC (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 10:54:02 -0400
Subject: Re: [PATCH 0/3] iio: potentiometer: mcp4531: New parts and device
 tree
To: Florian Vaussard <florian.vaussard@gmail.com>,
	devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>
References: <1466492137-32683-1-git-send-email-florian.vaussard@heig-vd.ch>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Peter Rosin <peda@axentia.se>,
	Slawomir Stepien <sst@poczta.fm>,
	Joachim Eastwood <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <dc5c67de-56bb-ee6a-1783-be9062cc1e7c@kernel.org>
Date: Sun, 26 Jun 2016 15:53:59 +0100
MIME-Version: 1.0
In-Reply-To: <1466492137-32683-1-git-send-email-florian.vaussard@heig-vd.ch>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/06/16 07:55, Florian Vaussard wrote:
> Hello,
> 
> This series first adds support for parts missing from mcp4531 driver
> (MCP454x, MCP456x, MCP464x and MCP466x). It then introduces the necessary
> device tree binding to perform DT boot.
> 
> Tested with MCP4561-103 and MCP4561-503 (DT boot).
> 
Series looks good to me other than the various bits Peter pointed out.

Thanks,

Jonathan
> Best regards,
> Florian
> 
> Florian Vaussard (3):
>   iio: potentiometer: mcp4531: Add support for MCP454x, MCP456x, MCP464x
>     and MCP466x
>   iio: potentiometer: mcp4531: Add device tree binding documentation
>   iio: potentiometer: mcp4531: Add device tree binding
> 
>  .../bindings/iio/potentiometer/mcp4531.txt         |  84 +++++++++++
>  drivers/iio/potentiometer/Kconfig                  |   6 +-
>  drivers/iio/potentiometer/mcp4531.c                | 155 ++++++++++++++++++++-
>  3 files changed, 242 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/mcp4531.txt
> 

