Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47705 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760054AbcCEEZ7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 4 Mar 2016 23:25:59 -0500
Date: Fri, 4 Mar 2016 22:25:46 -0600
From: Rob Herring <robh@kernel.org>
To: Gregor Boirie <gregor.boirie@parrot.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Mark Brown <broonie@kernel.org>,
	"Andrew F. Davis" <afd@ti.com>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH v4 2/3] iio:pressure:ms5611: complete DT support
Message-ID: <20160305042546.GF13525@rob-hp-laptop>
References: <cover.1456828051.git.gregor.boirie@parrot.com>
 <6cbaba17e57b0bdc6c3550f49af9161e33438f84.1456828051.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <6cbaba17e57b0bdc6c3550f49af9161e33438f84.1456828051.git.gregor.boirie@parrot.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Mar 01, 2016 at 11:31:37AM +0100, Gregor Boirie wrote:
> From: Grégor Boirie <gregor.boirie@parrot.com>
> 
> Add device-tree ID tables and document bindings.
> 
> Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
> ---
>  .../devicetree/bindings/iio/pressure/ms5611.txt       | 19 +++++++++++++++++++
>  Documentation/devicetree/bindings/vendor-prefixes.txt |  1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/pressure/ms5611_i2c.c                     | 13 +++++++++++++
>  drivers/iio/pressure/ms5611_spi.c                     | 13 +++++++++++++
>  4 files changed, 46 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/ms5611.txt
