Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40369 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750863AbcBLOvH (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 12 Feb 2016 09:51:07 -0500
Date: Fri, 12 Feb 2016 08:51:00 -0600
From: Rob Herring <robh@kernel.org>
To: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	shawnguo@kernel.org, stefan@agner.ch
Subject: Re: [PATCH v1 2/2] iio: dac: vf610_dac: Add IIO DAC driver for
 Vybrid SoC
Message-ID: <20160212145100.GA12514@rob-hp-laptop>
References: <cover.1454939346.git.maitysanchayan@gmail.com>
 <5a699d45c89d239f3e49fa83d16a9b467016e219.1454939346.git.maitysanchayan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5a699d45c89d239f3e49fa83d16a9b467016e219.1454939346.git.maitysanchayan@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Feb 09, 2016 at 10:56:06AM +0530, Sanchayan Maity wrote:
> Add driver support for DAC peripheral on Vybrid SoC.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  .../devicetree/bindings/iio/dac/vf610-dac.txt      |  20 ++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/dac/Kconfig                            |   8 +
>  drivers/iio/dac/Makefile                           |   1 +
>  drivers/iio/dac/vf610_dac.c                        | 302 +++++++++++++++++++++
>  4 files changed, 331 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/vf610-dac.txt
>  create mode 100644 drivers/iio/dac/vf610_dac.c
