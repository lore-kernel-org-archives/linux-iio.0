Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:36418 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751759AbdAWRKQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Jan 2017 12:10:16 -0500
Date: Mon, 23 Jan 2017 11:10:08 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannanece23@gmail.com>
Cc: jic23@kernel.org, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] iio:temperature:Add irq and threshold events support for
 TI TMP007 sensor
Message-ID: <20170123171008.s3hkvmxhro4qycia@rob-hp-laptop>
References: <20170121150147.GA7781@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170121150147.GA7781@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jan 21, 2017 at 08:31:47PM +0530, Manivannan Sadhasivam wrote:
> This patch adds support for ALERT irq and limit threshold events for TI TMP007 - 16 bit IR thermopile sensor
> with integrated math engine.
> 
> Following threshold events are supported:
> 1. TObj high limit
> 2. TObj low limit
> 3. TDie high limit
> 4. TDie low limit
> 
> Signed-off-by: Manivannan Sadhasivam <manivannanece23@gmail.com>
> ---
>  .../devicetree/bindings/iio/temperature/tmp007.txt |   8 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/temperature/tmp007.c                   | 334 ++++++++++++++++++---
>  2 files changed, 304 insertions(+), 38 deletions(-)
