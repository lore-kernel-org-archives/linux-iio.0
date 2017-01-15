Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:37370 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750946AbdAOMXd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jan 2017 07:23:33 -0500
Subject: Re: [PATCH v9 3/3] iio: adc: add support for Allwinner SoCs ADC
To: Quentin Schulz <quentin.schulz@free-electrons.com>,
        linux@armlinux.org.uk, maxime.ripard@free-electrons.com,
        wens@csie.org, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org
References: <20161213143332.24988-1-quentin.schulz@free-electrons.com>
 <20161213143332.24988-4-quentin.schulz@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, antoine.tenart@free-electrons.com,
        thomas.petazzoni@free-electrons.com
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <64744012-d26a-2b85-b9d9-1ad1c4e2f84a@metafoo.de>
Date: Sun, 15 Jan 2017 13:23:15 +0100
MIME-Version: 1.0
In-Reply-To: <20161213143332.24988-4-quentin.schulz@free-electrons.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 12/13/2016 03:33 PM, Quentin Schulz wrote:

> +	indio_dev->name = dev_name(&pdev->dev);

The name is supposed to be the type of the device, e.g. part name, not the
name of parent device instance. This could e.g. come from a name field in
the gpadc_data struct.

