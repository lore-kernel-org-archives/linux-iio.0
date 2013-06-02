Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52094 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754177Ab3FBQnh (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jun 2013 12:43:37 -0400
Message-ID: <51AB7636.4060901@kernel.org>
Date: Sun, 02 Jun 2013 17:43:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: at91_adc: Add missing CONFIG_OF macro
References: <1369286787-8448-1-git-send-email-sachin.kamat@linaro.org> <20130523145540.GH8595@lukather>
In-Reply-To: <20130523145540.GH8595@lukather>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/23/2013 03:55 PM, Maxime Ripard wrote:
> Hi Sachin,
> 
> On Thu, May 23, 2013 at 10:56:27AM +0530, Sachin Kamat wrote:
>> The data structure is required only when DT is enabled.
>> Hence compile it conditionally.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Thanks!
> 
> Maxime
> 
Applied to togreg branch of iio.git.
