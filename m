Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35028 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbcG0O5m (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jul 2016 10:57:42 -0400
Date: Wed, 27 Jul 2016 09:57:40 -0500
From: Rob Herring <robh@kernel.org>
To: Aleksei Mamlin <mamlinav@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: accel: Add support for Domintech DMARD06
 accelerometer
Message-ID: <20160727145740.GA23467@rob-hp-laptop>
References: <1469460078-6460-1-git-send-email-mamlinav@gmail.com>
 <1469460078-6460-3-git-send-email-mamlinav@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469460078-6460-3-git-send-email-mamlinav@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jul 25, 2016 at 06:21:18PM +0300, Aleksei Mamlin wrote:
> This patch add support for Domintech DMARD05, DMARD06 and DMARD07
> accelerometers.
> 
> Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
> ---
>  .../devicetree/bindings/iio/accel/dmard06.txt      |  19 ++

This could go into trivial-devices.txt, but this is fine too:

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/accel/Kconfig                          |  11 +
>  drivers/iio/accel/Makefile                         |   1 +
>  drivers/iio/accel/dmard06.c                        | 241 +++++++++++++++++++++
>  4 files changed, 272 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/dmard06.txt
>  create mode 100644 drivers/iio/accel/dmard06.c
