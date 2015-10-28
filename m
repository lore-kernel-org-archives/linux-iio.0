Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48648 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbbJ1Rv0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 28 Oct 2015 13:51:26 -0400
Subject: Re: [PATCH 0/2] Remove .owner from spi_drivers
To: Sebastian Reichel <sre@ring0.de>
References: <1445608751-8432-1-git-send-email-afd@ti.com>
 <20151023182911.GA14674@earth>
CC: Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
	<alsa-devel@alsa-project.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <56310B15.3000103@ti.com>
Date: Wed, 28 Oct 2015 12:51:17 -0500
MIME-Version: 1.0
In-Reply-To: <20151023182911.GA14674@earth>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/23/2015 01:29 PM, Sebastian Reichel wrote:
> Hi,
>
> On Fri, Oct 23, 2015 at 08:59:09AM -0500, Andrew F. Davis wrote:
>> This series adds a helper macro to the SPI core that assigns the owner
>> in spi_drivers so individual drivers do not have to do this, this is
>> similar to other subsystems like platform_driver and i2c_driver that
>> have made this change.
>
> Probably it makes sense to also update the related coccinelle
> script: scripts/coccinelle/api/platform_no_drv_owner.cocci
>
> -- Sebastian
>

Makes sense, patch submitted.

Thanks,
Andrew
