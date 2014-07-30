Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-171.synserver.de ([212.40.185.171]:1035 "EHLO
	smtp-out-171.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753155AbaG3NBs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 30 Jul 2014 09:01:48 -0400
Message-ID: <53D8ECB9.1010503@metafoo.de>
Date: Wed, 30 Jul 2014 15:01:45 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Angelo Compagnucci <angelo.compagnucci@gmail.com>,
	linux-iio <linux-iio@vger.kernel.org>
Subject: Re: Why drivers don't depend on CONFIG_REGULATOR?
References: <CA+TH9VkYTQOEaV4OX2HAZcpvXhgcP8e+Mp1m1otnX5v=OPbBCw@mail.gmail.com>
In-Reply-To: <CA+TH9VkYTQOEaV4OX2HAZcpvXhgcP8e+Mp1m1otnX5v=OPbBCw@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/30/2014 11:51 AM, Angelo Compagnucci wrote:
> Hello List,
>
> I wasted a little bit of my time this morning understanding why the
> regulator I used in my device tree wasn't working, only to discover
> later that the regulator support was not enabled in my config.
>
> I think that all the drivers that use a regulator should depend on the
> CONFIG_REGULATOR.
>
> Is there a reason why any driver has "depends on REGULATOR" in their
> Kconfig entry?
>
> Thank you for your time!

Hi,

A lot of drivers work just fine without regulator support enabled. When 
disabled the regulator API stubs itself out with dummy function that always 
succeed.

- Lars

