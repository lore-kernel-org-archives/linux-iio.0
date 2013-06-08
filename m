Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41096 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab3FHIsb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Jun 2013 04:48:31 -0400
Message-ID: <51B2EFDE.1030702@kernel.org>
Date: Sat, 08 Jun 2013 09:48:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
CC: Sachin Kamat <sachin.kamat@linaro.org>, devel@driverdev.osuosl.org,
	linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
	jic23@cam.ac.uk
Subject: Re: [PATCH 1/1] staging: iio: spear_adc: Add missing CONFIG_OF macro
References: <1370603161-10992-1-git-send-email-sachin.kamat@linaro.org> <51B1C2E8.4040904@denx.de>
In-Reply-To: <51B1C2E8.4040904@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/07/2013 12:24 PM, Stefan Roese wrote:
> On 06/07/2013 01:06 PM, Sachin Kamat wrote:
>> The data structure is required only when DT is enabled.
>> Hence compile it conditionally.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Stefan Roese <sr@denx.de>
> 
> Acked-by: Stefan Roese <sr@denx.de>
> 
> Thanks,
> Stefan
Applied to the togreg branch of iio.git

Thanks,
