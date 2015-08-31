Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:37900 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753128AbbHaPFR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Aug 2015 11:05:17 -0400
Subject: Re: IIO: ak8975: Why adding OF compatible string without vendor
 prefix?
To: Axel Lin <axel.lin@ingics.com>, linux-iio@vger.kernel.org
References: <1440996094.1500.1.camel@ingics.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Olof Johansson <olof@lixom.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <55E46D2D.1030303@kernel.org>
Date: Mon, 31 Aug 2015 16:05:17 +0100
MIME-Version: 1.0
In-Reply-To: <1440996094.1500.1.camel@ingics.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/08/15 05:41, Axel Lin wrote:
> Hi,
> I just found the ak8975_of_match table has compatible string without vendor
> prefix.
> 
> static const struct of_device_id ak8975_of_match[] = {
>         { .compatible = "asahi-kasei,ak8975", },
>         { .compatible = "ak8975", },
>         { .compatible = "asahi-kasei,ak8963", },
>         { .compatible = "ak8963", },
>         { .compatible = "asahi-kasei,ak09911", },
>         { .compatible = "ak09911", },
>         { .compatible = "asahi-kasei,ak09912", },
>         { .compatible = "ak09912", },
>         {}
> };
> 
> This seems unusual, just curious why below compatible strings are required?
>         { .compatible = "ak8975", },
>         { .compatible = "ak8963", },
>         { .compatible = "ak09911", },
>         { .compatible = "ak09912", },
> 
> Regards,
> Axel
> 
This is an historical artefact.  I2C (and for that matter SPI) 
subsystems handled device tree registration in their cores.
Unfortunately they did it by matching against the registered
driver names and those don't include vendors.

This is still being unwound, but the upshot is that we have
boards with device trees out in the wild using the version without
a vendor string.  Hence for backwards compatibility, both need
to be in the table.

Jonathan
