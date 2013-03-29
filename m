Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46633 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754017Ab3C2JaH (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Mar 2013 05:30:07 -0400
Message-ID: <51555F1E.2070407@kernel.org>
Date: Fri, 29 Mar 2013 09:30:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Marek Vasut <marex@denx.de>
CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	jimwall@q.com, brian@crystalfontz.com,
	Maxime Rpard <maxime.ripard@free-electrons.com>,
	Fabio Estevam <fabio.estevam@freescale.com>
Subject: Re: [PATCH v2] iio: mxs-lradc: Do hardware initialization earlier
References: <1364508273-14955-1-git-send-email-alexandre.belloni@free-electrons.com> <201303282358.08630.marex@denx.de>
In-Reply-To: <201303282358.08630.marex@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/28/2013 10:58 PM, Marek Vasut wrote:
> Dear Alexandre Belloni,
> 
>> We need to initialize hardware before registering the touchscreen. Else,
>> we end up setting registers in mxs_lradc_ts_open(), getting called just
>> after registering the touchscreen with input_register_device() and by
>> the end of mxs_lradc_probe(), we reset the LRADC block hence losing the
>> correct configuration.
>>
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> Cc: Fabio Estevam <fabio.estevam@freescale.com>
>> Cc: Jonathan Cameron <jic23@kernel.org>
>> Cc: Marek Vasut <marex@denx.de>
> 
> Acked-by: Marek Vasut <marex@denx.de>
Applied to togreg branch of iio.git. Thanks.
> 
> Best regards,
> Marek Vasut
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
