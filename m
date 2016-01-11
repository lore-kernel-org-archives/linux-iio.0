Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35466 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757173AbcAKCco (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 10 Jan 2016 21:32:44 -0500
Date: Sun, 10 Jan 2016 20:32:39 -0600
From: Rob Herring <robh@kernel.org>
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: jic23@kernel.org, nicolas.ferre@atmel.com,
	alexandre.belloni@free-electrons.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org,
	pmeerw@pmeerw.net
Subject: Re: [PATCH v2 1/5] iio:adc:at91_adc8xx: introduce new atmel adc
 driver
Message-ID: <20160111023239.GA27025@rob-hp-laptop>
References: <1452096759-19438-1-git-send-email-ludovic.desroches@atmel.com>
 <1452096759-19438-2-git-send-email-ludovic.desroches@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1452096759-19438-2-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Jan 06, 2016 at 05:12:35PM +0100, Ludovic Desroches wrote:
> This driver supports the new version of the Atmel ADC device introduced
> with the SAMA5D2 SoC family.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> ---
>  .../devicetree/bindings/iio/adc/at91_adc8xx.txt    |  28 ++

For the binding:

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/iio/adc/Kconfig                            |  11 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/at91_adc8xx.c                      | 461 +++++++++++++++++++++
>  4 files changed, 501 insertions(+)
