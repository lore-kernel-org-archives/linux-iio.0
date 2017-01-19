Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:36305 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751507AbdASNJ7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2017 08:09:59 -0500
Date: Thu, 19 Jan 2017 07:09:23 -0600
From: Rob Herring <robh@kernel.org>
To: Slawomir Stepien <sst@poczta.fm>
Cc: linux-iio@vger.kernel.org, matthew.weber@rockwellcollins.com,
        maury.anderson@rockwellcollins.com, devicetree@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>
Subject: Re: [PATCH v3] iio: max5481: Add support for Maxim digital
 potentiometers
Message-ID: <20170119130923.zaro5vgl7l7kidr6@rob-hp-laptop>
References: <20170114212139.GA3418@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170114212139.GA3418@x220.localdomain>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jan 14, 2017 at 10:21:39PM +0100, Slawomir Stepien wrote:
> From: Matt Weber <matthew.weber@rockwellcollins.com>
> 
> Add implementation for Maxim Integrated 5481, 5482, 5483,
> and 5484 digital potentiometer devices.
> 
> Datasheet:
> http://datasheets.maximintegrated.com/en/ds/MAX5481-MAX5484.pdf
> 
> Signed-off-by: Maury Anderson <maury.anderson@rockwellcollins.com>
> Signed-off-by: Matthew Weber <matthew.weber@rockwellcollins.com>
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> ---
> 
> This is my resubmission of this patch after original authors decided not to
> pursuit it inclusion into kernel.
> 
> Tested using signal analyzer.
> 
> Changes since v2:
> * spi write buffer moved to struct max5481_data and ____cacheline_aligned.
> * max5481_write_cmd now uses pointer to struct max5481_data as a first argument.
> 
> Changes since v1:
> * removed not needed '``' and 'c' chars
> * includes are now sorted
> * added coma to last item in enum max5481_variant
> * removed maxpos from struct max5481_cfg
> * max5481_CHANNEL is no MAX5481_CHANNEL and it does not have 'ch' argument
> * max5481_write_cmd is now based around switch
> * removed not needed cast in max5481_write_cmd
> * wpier state is saved after iio_device_unregister
> * changed names in spi_device_id and acpi_device_id to be equal to names in of_device_id
> 
> ---
>  .../bindings/iio/potentiometer/max5481.txt         |  23 +++

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/potentiometer/Kconfig                  |  11 ++
>  drivers/iio/potentiometer/Makefile                 |   1 +
>  drivers/iio/potentiometer/max5481.c                | 216 +++++++++++++++++++++
>  4 files changed, 251 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/potentiometer/max5481.txt
>  create mode 100644 drivers/iio/potentiometer/max5481.c
