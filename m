Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C93240B6E9;
	Wed,  4 Feb 2026 13:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770213200; cv=none; b=iYm31L7zHwpP721/Zv/4FGtEJml1wVeClA6wLV150bolbMrxPMcdqPCMJZkSJ9OLsMDKx/rwai9jKNqW6sInSb/VN13FGKjZCZ4usUPEDz/ccogOQmw5O45CwU1lqa2VhTg6pZkstzT1dNmMh0A1ADr5pnoBoKcggUVCV4r9fsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770213200; c=relaxed/simple;
	bh=AyDdDS/jQ4yauqN/tXFOUgSOY6AXjL0WWGxl265xn9s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kwk9M953E/lyHrxDHcgu/MdZsF048heYr4XRKpJ0fYTs6nDKVzVZrcOFSL470E88PuuoFTVswENaUE1WO2ex2+kvjMaw4E3hmM1niIDQkvoQm8uhLahUY803H6Czc3ySOSr7OuXBOj7/hP+kTsWvBR5l5Abw0EQ3SVy8AiTii8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f5hcX2F2mzJ4692;
	Wed,  4 Feb 2026 21:52:28 +0800 (CST)
Received: from dubpeml500005.china.huawei.com (unknown [7.214.145.207])
	by mail.maildlp.com (Postfix) with ESMTPS id 66D4540569;
	Wed,  4 Feb 2026 21:53:17 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml500005.china.huawei.com
 (7.214.145.207) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 4 Feb
 2026 13:53:16 +0000
Date: Wed, 4 Feb 2026 13:53:15 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Mark Brown <broonie@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, Michael Hennerich
	<michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S?= =?ISO-8859-1?Q?=E1?=
	<nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko
	<andy@kernel.org>, Sean Anderson <sean.anderson@linux.dev>,
	<linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v6 0/9] spi: add multi-lane support
Message-ID: <20260204135315.0000580b@huawei.com>
In-Reply-To: <ed1331d4-2e34-4b30-a0d7-f0e1d6093af8@sirena.org.uk>
References: <20260123-spi-add-multi-bus-support-v6-0-12af183c06eb@baylibre.com>
	<ed1331d4-2e34-4b30-a0d7-f0e1d6093af8@sirena.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 dubpeml500005.china.huawei.com (7.214.145.207)

On Mon, 2 Feb 2026 23:22:59 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Jan 23, 2026 at 02:37:23PM -0600, David Lechner wrote:
> > This series is adding support for SPI controllers and peripherals that
> > have multiple SPI data lanes (data lanes being independent sets of
> > SDI/SDO lines, each with their own serializer/deserializer).  
> 
> The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:
> 
>   Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-multi-lane

Thanks. Given timing, I plan to hold the last two patches until next cycle.
I'll pick them up nice and early though so they'll be in next shortly after
rc1.

Thanks,

Jonathan

> 
> for you to fetch changes up to 0ec5ed7c95d1ba6a74491928ff38abb351dbed36:
> 
>   spi: axi-spi-engine: support SPI_MULTI_LANE_MODE_STRIPE (2026-02-02 12:12:47 +0000)
> 
> ----------------------------------------------------------------
> spi: Add multi-lane support
> 
> This series is adding support for SPI controllers and peripherals that
> have multiple SPI data lanes (data lanes being independent sets of
> SDI/SDO lines, each with their own serializer/deserializer).
> 
> ----------------------------------------------------------------
> CL Wang (1):
>       spi: dt-bindings: Add support for ATCSPI200 SPI controller
> 
> David Lechner (7):
>       spi: dt-bindings: change spi-{rx,tx}-bus-width to arrays
>       spi: dt-bindings: add spi-{tx,rx}-lane-map properties
>       spi: support controllers with multiple data lanes
>       spi: add multi_lane_mode field to struct spi_transfer
>       spi: Documentation: add page on multi-lane support
>       spi: dt-bindings: adi,axi-spi-engine: add multi-lane support
>       spi: axi-spi-engine: support SPI_MULTI_LANE_MODE_STRIPE
> 
>  .../bindings/display/panel/sitronix,st7789v.yaml   |   5 +-
>  .../devicetree/bindings/iio/adc/adi,ad4030.yaml    |  42 +++-
>  .../devicetree/bindings/iio/adc/adi,ad4695.yaml    |   5 +-
>  .../bindings/spi/adi,axi-spi-engine.yaml           |  15 ++
>  .../bindings/spi/allwinner,sun4i-a10-spi.yaml      |   6 +-
>  .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |   6 +-
>  .../bindings/spi/andestech,ae350-spi.yaml          |  87 +++++++++
>  .../bindings/spi/nvidia,tegra210-quad.yaml         |   6 +-
>  .../bindings/spi/spi-peripheral-props.yaml         |  40 +++-
>  Documentation/spi/index.rst                        |   1 +
>  Documentation/spi/multiple-data-lanes.rst          | 217 +++++++++++++++++++++
>  drivers/spi/spi-axi-spi-engine.c                   | 145 +++++++++++++-
>  drivers/spi/spi.c                                  | 144 +++++++++++++-
>  include/linux/spi/spi.h                            |  30 +++
>  14 files changed, 724 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
>  create mode 100644 Documentation/spi/multiple-data-lanes.rst
> 

