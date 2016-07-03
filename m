Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57619 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752183AbcGCK40 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jul 2016 06:56:26 -0400
Subject: Re: [PATCH v3 4/4] iio: potentiometer: Fix typo in Kconfig
To: Florian Vaussard <florian.vaussard@gmail.com>,
	devicetree@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Peter Rosin <peda@axentia.se>
References: <1467272091-28087-1-git-send-email-florian.vaussard@heig-vd.ch>
 <1467272091-28087-5-git-send-email-florian.vaussard@heig-vd.ch>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Slawomir Stepien <sst@poczta.fm>,
	Joachim Eastwood <manabian@gmail.com>,
	Matt Ranostay <mranostay@gmail.com>,
	Cristina Moraru <cristina.moraru09@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <b11ceda3-fd8e-4dca-ca97-bac44d517018@kernel.org>
Date: Sun, 3 Jul 2016 11:56:24 +0100
MIME-Version: 1.0
In-Reply-To: <1467272091-28087-5-git-send-email-florian.vaussard@heig-vd.ch>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/06/16 08:34, Florian Vaussard wrote:
> Fix s/potentiomenter/potentiometer/.
> 
> Suggested-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Signed-off-by: Florian Vaussard <florian.vaussard@heig-vd.ch>
Applied.
> ---
>  drivers/iio/potentiometer/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/Kconfig b/drivers/iio/potentiometer/Kconfig
> index 55c2414..2e9da1c 100644
> --- a/drivers/iio/potentiometer/Kconfig
> +++ b/drivers/iio/potentiometer/Kconfig
> @@ -10,7 +10,7 @@ config DS1803
>  	depends on I2C
>  	help
>  	  Say yes here to build support for the Maxim Integrated DS1803
> -	  digital potentiomenter chip.
> +	  digital potentiometer chip.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ds1803.
> @@ -39,7 +39,7 @@ config MCP4131
>  	  MCP4241, MCP4242,
>  	  MCP4251, MCP4252,
>  	  MCP4261, MCP4262,
> -	  digital potentiomenter chips.
> +	  digital potentiometer chips.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called mcp4131.
> @@ -53,7 +53,7 @@ config MCP4531
>  	  MCP4551, MCP4552, MCP4561, MCP4562,
>  	  MCP4631, MCP4632, MCP4641, MCP4642,
>  	  MCP4651, MCP4652, MCP4661, MCP4662
> -	  digital potentiomenter chips.
> +	  digital potentiometer chips.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called mcp4531.
> 

