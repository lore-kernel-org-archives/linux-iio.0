Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53146 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3G0KIM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 06:08:12 -0400
Message-ID: <51F3AA1D.2030609@kernel.org>
Date: Sat, 27 Jul 2013 12:08:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org,
	jic23@cam.ac.uk
Subject: Re: [PATCH 09/11] iio: adc: nau7802: Use devm_iio_device_alloc
References: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org> <1374569897-3858-10-git-send-email-sachin.kamat@linaro.org> <20130723093119.GA10389@lukather>
In-Reply-To: <20130723093119.GA10389@lukather>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/23/13 10:31, Maxime Ripard wrote:
> Hi,
> 
> On Tue, Jul 23, 2013 at 02:28:15PM +0530, Sachin Kamat wrote:
>> Using devm_iio_device_alloc makes code simpler.
>> 
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Applied to the togreg branch of iio.git

> 
> Thanks, Maxime
> 
