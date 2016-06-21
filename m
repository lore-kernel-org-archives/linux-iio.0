Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ns.pmeerw.net ([84.19.176.92]:39719 "EHLO pmeerw.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225AbcFUHNf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 21 Jun 2016 03:13:35 -0400
Date: Tue, 21 Jun 2016 09:04:56 +0200 (CEST)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Florian Vaussard <florian.vaussard@gmail.com>
cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	Florian Vaussard <florian.vaussard@heig-vd.ch>
Subject: Re: [PATCH 1/3] iio: potentiometer: mcp4531: Add support for MCP454x,
 MCP456x, MCP464x and MCP466x
In-Reply-To: <1466492137-32683-2-git-send-email-florian.vaussard@heig-vd.ch>
Message-ID: <alpine.DEB.2.02.1606210859150.20893@pmeerw.net>
References: <1466492137-32683-1-git-send-email-florian.vaussard@heig-vd.ch> <1466492137-32683-2-git-send-email-florian.vaussard@heig-vd.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


> @@ -49,8 +49,10 @@ config MCP4531
>  	depends on I2C
>  	help
>  	  Say yes here to build support for the Microchip
> -	  MCP4531, MCP4532, MCP4551, MCP4552,
> -	  MCP4631, MCP4632, MCP4651, MCP4652
> +	  MCP4531, MCP4532, MCP4541, MCP4542,
> +	  MCP4551, MCP4552, MCP4561, MCP4562,
> +	  MCP4631, MCP4632, MCP4641, MCP4642,
> +	  MCP4651, MCP4652, MCP4661, MCP4662
>  	  digital potentiomenter chips.

unrelated typo: potentiometer
could you please fix it up as a separate patch in you series?

some whitespace around /*sentinel*/ in patch 3/3 would be nice, looks good 
otherwise

thanks, p.

-- 

Peter Meerwald-Stadler
+43-664-2444418 (mobile)
