Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45463 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755051AbcBWUym (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 23 Feb 2016 15:54:42 -0500
Date: Tue, 23 Feb 2016 14:54:37 -0600
From: Rob Herring <robh@kernel.org>
To: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	shawnguo@kernel.org, stefan@agner.ch, pmeerw@pmeerw.net
Subject: Re: [PATCH v3 2/2] iio: dac: vf610_dac: Add IIO DAC driver for
 Vybrid SoC
Message-ID: <20160223205437.GA27366@rob-hp-laptop>
References: <cover.1456121233.git.maitysanchayan@gmail.com>
 <1a70acdd3ffae273bbfe2f80c5e3952d152921df.1456121233.git.maitysanchayan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1a70acdd3ffae273bbfe2f80c5e3952d152921df.1456121233.git.maitysanchayan@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Feb 22, 2016 at 11:48:37AM +0530, Sanchayan Maity wrote:
> Add driver support for DAC peripheral on Vybrid SoC.
> 
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio-vf610      |   9 +
>  .../devicetree/bindings/iio/dac/vf610-dac.txt      |  20 ++

For the binding:

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/dac/Kconfig                            |  10 +
>  drivers/iio/dac/Makefile                           |   1 +
>  drivers/iio/dac/vf610_dac.c                        | 298 +++++++++++++++++++++
>  5 files changed, 338 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/vf610-dac.txt
>  create mode 100644 drivers/iio/dac/vf610_dac.c
