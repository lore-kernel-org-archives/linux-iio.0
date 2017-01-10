Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34280 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032635AbdAJFgH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jan 2017 00:36:07 -0500
Date: Mon, 9 Jan 2017 23:36:03 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannanece23@gmail.com>
Cc: jic23@kernel.org, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4] iio:temperature: Add support for TI TMP007 sensor
Message-ID: <20170110053603.n6ihrg3r6z4244g5@rob-hp-laptop>
References: <20170109025526.GA9601@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170109025526.GA9601@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, Jan 09, 2017 at 08:25:26AM +0530, Manivannan Sadhasivam wrote:
> This patch adds support for TI TMP007 - 16 bit IR thermopile sensor with integrated Math engine.
> Sensor takes care of calculating the object temperature with the help of calibrated constants stored in non-volatile memory,
> thereby reducing the calculation overhead.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannanece23@gmail.com>
> ---
> 
> Changes since v3:
> 
> 1. Removed caching of status register
> 2. Modified comments for data validity
> 3. Added possible address combinations in dTree bindings file
> 
>  .../devicetree/bindings/iio/temperature/tmp007.txt |  27 ++

This could be documented under trivial-devices.txt, but doesn't hurt to 
have it here.

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/temperature/Kconfig                    |  10 +
>  drivers/iio/temperature/Makefile                   |   1 +
>  drivers/iio/temperature/tmp007.c                   | 345 +++++++++++++++++++++
>  4 files changed, 383 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/tmp007.txt
>  create mode 100644 drivers/iio/temperature/tmp007.c
