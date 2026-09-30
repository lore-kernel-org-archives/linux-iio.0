Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FACB4CE688;
	Wed, 30 Sep 2026 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770565; cv=none; b=dglFTjOuzRcXBrR5wdnw6stPlBcsD+8IvS9O7QdDNefKZlqGv/JaRe1zq83luXDXAG6RN5JpR5gx3ITTX3qaXwbcu6o13lEWDgZS+CzFuoRm9i1d/1M7Z3broTUWViguXH89BClAUvQn3PpMAE6FqlDL0YP1Q8bF5cciV5+WHrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770565; c=relaxed/simple;
	bh=O2T7cgLC7o0DlEiWg1oByORFowPDVnrqcwK/iNI/Udw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQKVfVnd05DTdUyQlF0K7vulJeoSIREQndF+DwhmC3/2HRmMPOqzh+EBQpCJx13UcLaertXnX9XUfsNNseq6iLkG/5da8fF4NUSyRHZ4QYn5u791YFIZJD/QnD2FTsRG89c3oQ9qTnwYmM3B/I2K6Ya1q5aD4keB/8lIoyMih1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOI5pq/h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOI5pq/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CFB1F000FF;
	Wed, 30 Sep 2026 12:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790770564;
	bh=H4zXzPrnJja1BHKDHtq5BxDIJftOHm+1n2VssXkb234=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nOI5pq/h0txyI18c+h/bCV9PuUjVb4+ME26pgb6r4PjLF+7OhidsG1JbxpRhDtw2v
	 54+L0EnPa1449AKTlT3pufKrvxDz453fqUexrChx6ciWPBxYFGWpVaq7GcE+MxVU9P
	 1uyYmPDusXLpbqHuGcpjipIG8tuHq85hrQ8+c/zM62rs1GEcMtB0qI7AXVuvJzcxl3
	 ct86envx4ATsUcEMZfzttOGLGbEClCSr6ISa5gpLnqDWrYDRo+SPyuYB08B5P1cNH9
	 LKWLAfSJ8Z11xUBgqdT5S1N1aZjDxURpMkingW12k2j2rKq3vyCh5OVJKBEd/mXc2y
	 CYRse6GPqc4xg==
Date: Wed, 30 Sep 2026 07:16:02 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: jic23@kernel.org, krzk+dt@kernel.org, dlechner@baylibre.com,
	linux-kernel@vger.kernel.org, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt1@gmail.com, skhan@linuxfoundation.org,
	Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
	conor+dt@kernel.org, linux@analog.com, corbet@lwn.net,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 09/13] dt-bindings: iio: adc: adi,ad4134: Document
 external multiplexer usage
Message-ID: <179077056179.2288166.13408399366910214654.robh@kernel.org>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
 <4c6b88d4332a3fd6d4c3f7a65478b24d2015226f.1790719425.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c6b88d4332a3fd6d4c3f7a65478b24d2015226f.1790719425.git.marcelo.schmitt@analog.com>


On Tue, 29 Sep 2026 19:44:42 -0300, Marcelo Schmitt wrote:
> The AD4134 design has two data interfaces. One interface allows register
> access for device configuration while the other (separate interface)
> provides ADC sample data. One way of handling both peripheral interfaces is
> to merge them into a single SPI interface by switching between register
> access and sample access according to device user requests. Though, such
> solution requires extra hardware, external to the ADC chip. The access mode
> switch can be done with an external multiplexer selecting either AD4134 SDO
> or AD4134 DOUT0 to connect to the controller. The external multiplexer
> becomes part of hardware requested for AD4134 device operation and thus
> must be provided for operating the peripheral in such merged interface
> schema. Still, there are alternative ways of handling the two AD4134 data
> interfaces so the multiplexer is not always required.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v2 -> v3:
> - Included the example right away with the doc update that documents it.
> - Dropped mux provider from offload example.
> 
> Currently, SPI offloading is only supported in 4 wire mode. So, offloading
> wouldn't be usable if added before the 4-wire patch.
> 
> 
> Detailed reasoning for the external multiplexer usage.
> 
> Before coming to the current solution, the following configuration was tried.
> 
>   +-----------------------+                           +-----------------+
>   |       AD4134          |                           | SPI Controller  |
>   |                       |                           |                 |
>   | SPI interface         |                           |                 |
>   | for register     SCLK |<--------------------------| SCLK            |
>   | access             CS |<--------------------------| CS              |
>   |                   SDI |<--------------------------| SDO             |
>   |                   SDO |---+                       |                 |
>   |                       |   |                       |                 |
>   | Data interface  DOUT0 |---+---------------------->| SDI0            |
>   | for ADC data    DOUT1 |-------------------------->| SDI1            |
>   | read back       DOUT2 |-------------------------->| SDI2            |
>   |                 DOUT3 |-------------------------->| SDI3            |
>   |                 DCLK  |<--------------------------| DCLK
>   |                 ODR   |<------------------+    +->| Offload Trigger |
>   +-----------------------+                   |    |  +-----------------+
>                                               |    +--| PWM1            |
>                                               +-------| PWM0            |
>                                               +-------| GPIO            |
>                                                       +-----------------+
> 
> Though, because DOUT0 never goes high-Z, the DOUT0 pin keeps driving the data
> line, causing register reads to fail.
> 
> Alternatively, we could have something like
> 
>   +-----------------------+                           +-----------------+
>   |       AD4134          |                           | SPI Controller  |
>   |                       |                           |                 |
>   | SPI interface         |                           |                 |
>   | for register     SCLK |<--------------------------| SCLK            |
>   | access             CS |<--------------------------| CS              |
>   |                   SDI |<--------------------------| SDO             |
>   |                   SDO |-------------------------->| SDI0            |
>   |                       |                           |                 |
>   | Data interface  DOUT0 |-------------------------->| SDI1            |
>   | for ADC data    DOUT1 |-------------------------->| SDI2            |
>   | read back       DOUT2 |-------------------------->| SDI3            |
>   |                 DOUT3 |-------------------------->| SDI4            |
>   |                 DCLK  |<--------------------------| DCLK
>   |                 ODR   |<------------------+    +->| Offload Trigger |
>   +-----------------------+                   |    |  +-----------------+
>                                               |    +--| PWM1            |
>                                               +-------| PWM0            |
>                                               +-------| GPIO            |
>                                                       +-----------------+
> 
> The downside of the above is the peripheral would need fine-grained config of
> controller SDI lines to only read SDI0 for register access, and only read SDI1,
> SDI2, SDI3, SDI4 for ADC sample data (currently available
> SPI_MULTI_LANE_MODE_STRIPE reads from all SDI lines).
> 
> The currently proposed solution looks like the following
> 
>   +-----------------------+                         +-----------------+
>   |         AD4134        |                         | SPI Controller  |
>   |                       |                         |                 |
>   | SPI interface    SCLK |<------------------------| SCLK            |
>   | for register       CS |<------------------------| CS              |
>   | access            SDI |<------------------------| SDO             |
>   |                   SDO |------->|¯¯¯¯\           |                 |
>   |                       |        |MUX  >--------->| SDI0            |
>   | Data interface  DOUT0 |------->|____/           |                 |
>   | for ADC sample        |          ^              |                 |
>   | data read       DOUT1 |------------------------>| SDI1            |
>   |                 DOUT2 |------------------------>| SDI2            |
>   |                 DOUT3 |------------------------>| SDI3            |
>   |                  DCLK |<------------------------| DCLK            |
>   |                   ODR |<----------------+    +->| Offload Trigger |
>   +-----------------------+          |      |    |  +-----------------+
>                                      |      |    +--| PWM1            |
>                                      |      +-------| PWM0            |
>                                      |      +-------| GPIO0           |
>                                      +--------------| GPIO1           |
>                                                     +-----------------+
> 
> By being able to mux between AD4134 SDO and AD4134 DOUT0, the peripheral can be
> connected to a single bus such that controllers able to read from multiple lines
> will be able to gather ADC sample data from all SDI lines (SPI_MULTI_LANE_MODE_STRIPE).
> With that, AD4134 maximum data throughput can be supported with what is already
> available from the SPI core. See additional details on the AD4134 IIO
> documentation (patch 13).
> 
> Yet another possibility would be to have the peripheral sitting in two buses.
> 
>   +-----------------------+                           +-----------------+
>   |       AD4134          |                           | SPI Controller A|
>   |                       |                           |                 |
>   | SPI interface    SCLK |<--------------------------| SCLK            |
>   | for register       CS |<--------------------------| CS              |
>   | access            SDI |<--------------------------| SDO             |
>   |                   SDO |-------------------------->| SDI             |
>   |                       |                           +-----------------+
>   |                       |                           | SPI Controller B|
>   |                       |                           |                 |
>   | Data interface  DOUT0 |-------------------------->| SDI0            |
>   | for ADC sample  DOUT1 |-------------------------->| SDI1            |
>   | data read       DOUT2 |-------------------------->| SDI2            |
>   |                 DOUT3 |-------------------------->| SDI3            |
>   |                 DCLK  |<--------------------------| DCLK            |
>   |                 ODR   |<------------------+    +->| Offload Trigger |
>   +-----------------------+                   |    |  +-----------------+
>                                               |    +--| PWM1            |
>                                               +-------| PWM0            |
>                                               +-------| GPIO            |
>                                                       +-----------------+
> 
> That may be a fallback option if what's currently being proposed fails to comply
> to Linux code standards.
> 
> 
>  .../bindings/iio/adc/adi,ad4134.yaml          | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

