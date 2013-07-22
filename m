Return-Path: <jic23@kernel.org>
Message-ID: <51ED804E.1000701@kernel.org>
Date: Mon, 22 Jul 2013 19:56:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Oleksandr Kravchenko <x0199363@ti.com>
CC: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, grant.likely@linaro.org,
 rob.herring@calxeda.com, rob@landley.net, jic23@cam.ac.uk,
 pmeerw@pmeerw.net, holler@ahsoftware.de, srinivas.pandruvada@intel.com,
 devicetree-discuss@lists.ozlabs.org, grygorii.strashko@ti.com,
 Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: Re: [PATCH v3 1/2] of: Add Avago Technologies vendor prefix
References: <1374498688-24701-1-git-send-email-x0199363@ti.com>
In-Reply-To: <1374498688-24701-1-git-send-email-x0199363@ti.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/22/13 14:11, Oleksandr Kravchenko wrote:
> From: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
> 
> This commit adds a device tree vendor prefix for Avago Technologies.
> 
> Signed-off-by: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
applied to the togreg branch of iio.git
Thanks

> ---
>  .../devicetree/bindings/vendor-prefixes.txt        |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index d5a79ca..8aab9c6 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -11,6 +11,7 @@ amcc	Applied Micro Circuits Corporation (APM, formally AMCC)
>  apm	Applied Micro Circuits Corporation (APM)
>  arm	ARM Ltd.
>  atmel	Atmel Corporation
> +avago	Avago Technologies
>  bosch	Bosch Sensortec GmbH
>  brcm	Broadcom Corporation
>  cavium	Cavium, Inc.
> 
