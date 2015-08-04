Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:59638 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752316AbbHDQwm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2015 12:52:42 -0400
In-Reply-To: <1438635410-3757-1-git-send-email-mporter@konsulko.com>
References: <1438635410-3757-1-git-send-email-mporter@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 0/3] MAX6675 IIO temperature driver
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Tue, 04 Aug 2015 17:52:17 +0100
To: Matt Porter <mporter@konsulko.com>,
	Linux IIO List <linux-iio@vger.kernel.org>,
	Devicetree List <devicetree@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <897A4C3B-DF7E-4AEE-A117-00CCB510F4DD@jic23.retrosnub.co.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 3 August 2015 21:56:47 BST, Matt Porter <mporter@konsulko.com> wrote:
>This series adds a driver for the MAX6675 SPI thermocouple converter.
>The device supports temperature measurements via type-K thermocouples
>and implements cold-junction compensation within the part. The
>datasheet
>can be found at http://datasheets.maximintegrated.com/en/ds/MAX6675.pdf
For a device like this where perhaps it's position wrt iio/hwmon boundary is unclear
I want to see an argument for why IIO makes more sense in the cover letter + cc
 at least the hwmon MAINTAINERS if not the list...
>
>Matt Porter (3):
>  iio: temperature: add max6675 dt binding
>  iio: temperature: add max6675 thermocouple converter driver
>  MAINTAINERS: add max6675 driver
>
> .../bindings/iio/temperature/max6675.txt           |  19 +++
> MAINTAINERS                                        |   7 +
> drivers/iio/temperature/Kconfig                    |  11 ++
> drivers/iio/temperature/Makefile                   |   1 +
>drivers/iio/temperature/max6675.c                  | 155
>+++++++++++++++++++++
> 5 files changed, 193 insertions(+)
>create mode 100644
>Documentation/devicetree/bindings/iio/temperature/max6675.txt
> create mode 100644 drivers/iio/temperature/max6675.c

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
