Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-194.synserver.de ([212.40.185.194]:1093 "EHLO
	smtp-out-194.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751083AbbHLPVu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 11:21:50 -0400
Message-ID: <55CB6475.4020506@metafoo.de>
Date: Wed, 12 Aug 2015 17:21:25 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: sdliyong@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
	pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
	cristina.opriceana@gmail.com, tolga.ceylan@gmail.com,
	k.kozlowski@samsung.com, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
	marek@goldelico.com
Subject: Re: [PATCH v2] staging: iio: hmc5843: Set iio name dynamically
References: <1439385946-28388-1-git-send-email-sdliyong@gmail.com>
In-Reply-To: <1439385946-28388-1-git-send-email-sdliyong@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/12/2015 03:25 PM, sdliyong@gmail.com wrote:
> From: Yong Li <sdliyong@gmail.com>
> 
> Load the driver using the below command:
> echo hmc5983 0x1e > /sys/bus/i2c/devices/i2c-?/new_device
> 
> In sysfs, the iio name is hmc5843, however the i2c name is hmc5983,
> they are inconsistent.
> 
> With this patch, the iio name will be the same as the i2c device name
> 
> Signed-off-by: Yong Li <sdliyong@gmail.com>

Looks good.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
