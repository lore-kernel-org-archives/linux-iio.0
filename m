Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from [212.40.180.149] ([212.40.180.149]:54012 "EHLO
	smtp-out-124.synserver.de" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S932555AbcA0OqX (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 27 Jan 2016 09:46:23 -0500
Subject: Re: [PATCH] iio:dac:ad5755 fixed SPI_MODE
To: Sean Nyekjaer <sean.nyekjaer@prevas.dk>, linux-iio@vger.kernel.org
References: <1453905547-27938-1-git-send-email-sean.nyekjaer@prevas.dk>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <56A8D800.3030804@metafoo.de>
Date: Wed, 27 Jan 2016 15:45:20 +0100
MIME-Version: 1.0
In-Reply-To: <1453905547-27938-1-git-send-email-sean.nyekjaer@prevas.dk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/27/2016 03:39 PM, Sean Nyekjaer wrote:
> According to datasheet data is latched on the falling edge of the SCK.
> 
> I agree it works in SPI_MODE_0 on the eval kit, but in other configurations
> with optic isolators (that adds a small delay). We are falling out of spec.
> 
> Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>

Hi,

The SPI mode is usually specified in the spi_board_info struct or devicetree
rather than hardcoding it in the driver.

- Lars
