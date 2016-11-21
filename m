Return-Path: <lee.jones@linaro.org>
Date: Mon, 21 Nov 2016 10:50:23 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, marex@denx.de,
	linux-iio@vger.kernel.org, harald@ccbib.org, stefan.wahren@i2se.com,
	fabio.estevam@freescale.com
Subject: Re: [PATCH v10 5/5] mfd: Move binding document
Message-ID: <20161121105023.GH32509@dell>
References: <cover.1479638191.git.ksenija.stanojevic@gmail.com>
 <ed11371e67fb76fc6c6f347ec779e620412a339f.1479638191.git.ksenija.stanojevic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <ed11371e67fb76fc6c6f347ec779e620412a339f.1479638191.git.ksenija.stanojevic@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

On Sun, 20 Nov 2016, Ksenija Stanojevic wrote:

> The bindings, which are now used in MFD, need also to be
> documented in the MFD binding document.
> 
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
> ---
> Changes in v10:
>  - none
> 
> Changes in v9:
>  - format patch using -M option
> 
> Changes in v8:
>  - rebase onto 4.9-rc1
> 
> Changes in v7:
>  - add to the patchset
> 
>  Documentation/devicetree/bindings/{iio/adc => mfd}/mxs-lradc.txt | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  rename Documentation/devicetree/bindings/{iio/adc => mfd}/mxs-lradc.txt (100%)

For my own reference:
  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

> diff --git a/Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt b/Documentation/devicetree/bindings/mfd/mxs-lradc.txt
> similarity index 100%
> rename from Documentation/devicetree/bindings/iio/adc/mxs-lradc.txt
> rename to Documentation/devicetree/bindings/mfd/mxs-lradc.txt

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
