Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-075.synserver.de ([212.40.185.75]:1083 "EHLO
	smtp-out-075.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751402AbbCTSpZ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 20 Mar 2015 14:45:25 -0400
Message-ID: <550C6ACF.3040902@metafoo.de>
Date: Fri, 20 Mar 2015 19:45:35 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>,
	Antoine Tenart <antoine.tenart@free-electrons.com>
CC: sebastian.hesselbarth@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
	zmxu@marvell.com, jszhang@marvell.com, yrliao@marvell.com,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: adc: add support for Berlin
References: <1426858565-31053-1-git-send-email-antoine.tenart@free-electrons.com> <1426858565-31053-2-git-send-email-antoine.tenart@free-electrons.com> <alpine.DEB.2.02.1503201819010.21628@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1503201819010.21628@pmeerw.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/20/2015 06:43 PM, Peter Meerwald wrote:
> Hello Antoine,
>
>> This patch adds the support of the Berlin ADC, available on Berlin SoCs.
>> This ADC has 8 channels available, with one connected to a temperature
>> sensor.
>>
>> The particularity here, is that the temperature sensor connected to the
>> ADC has its own registers, and both the ADC and the temperature sensor
>> must be configured when using it.
>
> some quick comments inline below;
> sometimes this refers to berlin, sometimes to berlin2?
>
> probably these regmap_read() / _write() pairs could be MACRO()'d away
> somehow

There is regmap_update_bits(), which does the read-modify-update cycle.

