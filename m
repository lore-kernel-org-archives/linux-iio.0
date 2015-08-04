Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35849 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683AbbHDHue (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 4 Aug 2015 03:50:34 -0400
MIME-Version: 1.0
In-Reply-To: <1438635410-3757-3-git-send-email-mporter@konsulko.com>
References: <1438635410-3757-1-git-send-email-mporter@konsulko.com>
	<1438635410-3757-3-git-send-email-mporter@konsulko.com>
Date: Tue, 4 Aug 2015 10:50:32 +0300
Message-ID: <CAEnQRZDRNr5n3+QVoKRP5prZ0kQn07DgvvgDEvEVJimRVyTZpA@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: temperature: add max6675 thermocouple converter driver
From: Daniel Baluta <daniel.baluta@intel.com>
To: Matt Porter <mporter@konsulko.com>
Cc: Linux IIO List <linux-iio@vger.kernel.org>,
	Devicetree List <devicetree@vger.kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Aug 3, 2015 at 11:56 PM, Matt Porter <mporter@konsulko.com> wrote:
> Add a driver for the MAX6675 thermocouple converter. This
> device interfaces with K-type thermocouples and provides
> cold-junction compensated temperature readings via a
> SPI interface.

./scripts/checkpatch.pl --strict says:

CHECK: braces {} should be used on all arms of this statement
#118: FILE: drivers/iio/temperature/max6675.c:61:

thanks,
Daniel.
