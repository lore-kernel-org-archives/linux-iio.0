Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51086 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752485AbcBXUzM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 24 Feb 2016 15:55:12 -0500
Subject: Re: [PATCH v3 2/2] iio: dac: vf610_dac: Add IIO DAC driver for Vybrid
 SoC
To: Rob Herring <robh@kernel.org>,
	Sanchayan Maity <maitysanchayan@gmail.com>
References: <cover.1456121233.git.maitysanchayan@gmail.com>
 <1a70acdd3ffae273bbfe2f80c5e3952d152921df.1456121233.git.maitysanchayan@gmail.com>
 <20160223205437.GA27366@rob-hp-laptop>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, shawnguo@kernel.org, stefan@agner.ch,
	pmeerw@pmeerw.net
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56CE18AC.6020603@kernel.org>
Date: Wed, 24 Feb 2016 20:55:08 +0000
MIME-Version: 1.0
In-Reply-To: <20160223205437.GA27366@rob-hp-laptop>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 23/02/16 20:54, Rob Herring wrote:
> On Mon, Feb 22, 2016 at 11:48:37AM +0530, Sanchayan Maity wrote:
>> Add driver support for DAC peripheral on Vybrid SoC.
>>
>> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
>> ---
>>  Documentation/ABI/testing/sysfs-bus-iio-vf610      |   9 +
>>  .../devicetree/bindings/iio/dac/vf610-dac.txt      |  20 ++
> 
> For the binding:
> 
> Acked-by: Rob Herring <robh@kernel.org>
Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.

Note the dts change probably wants to go via the relevant arch trees.
I can take it with an appropriate ack if not.

Jonathan
> 
>>  drivers/iio/dac/Kconfig                            |  10 +
>>  drivers/iio/dac/Makefile                           |   1 +
>>  drivers/iio/dac/vf610_dac.c                        | 298 +++++++++++++++++++++
>>  5 files changed, 338 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/dac/vf610-dac.txt
>>  create mode 100644 drivers/iio/dac/vf610_dac.c
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

