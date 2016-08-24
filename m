Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:33599 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754902AbcHXOLJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 24 Aug 2016 10:11:09 -0400
Subject: Re: [PATCH] iio: dac: AD8801: add Analog Devices AD8801/AD8803
 support
To: Gwenhael Goavec-Merou <gwenhael.goavec-merou@trabucayre.com>,
        linux-iio@vger.kernel.org
References: <20160824135301.6263-1-gwenhael.goavec-merou@trabucayre.com>
 <20160824135301.6263-2-gwenhael.goavec-merou@trabucayre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Paul Cercueil <paul.cercueil@analog.com>,
        Gwenhael <gwe@trabucayre.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <24d5753e-3b80-e4e1-c323-0fa6a80237d8@metafoo.de>
Date: Wed, 24 Aug 2016 16:11:06 +0200
MIME-Version: 1.0
In-Reply-To: <20160824135301.6263-2-gwenhael.goavec-merou@trabucayre.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Forgot one thing.

> +config AD8801
> +	tristate "Analog Devices AD8801/AD8803 DAC driver"
> +	depends on SPI

Should be depends on SPI_MASTER

> +	help
> +	  Say yes here to build support for Analog Devices AD8801, ad8803 Digital to
> +	  Analog Converters (DAC).
> +
> +	  To compile this driver as module choose M here: the module will be called
> +	  ad8801.

