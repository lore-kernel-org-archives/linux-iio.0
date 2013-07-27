Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53172 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3G0KJj (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 27 Jul 2013 06:09:39 -0400
Message-ID: <51F3AA74.8000908@kernel.org>
Date: Sat, 27 Jul 2013 12:09:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Thierry Reding <thierry.reding@gmail.com>
CC: Sachin Kamat <sachin.kamat@linaro.org>, linux-iio@vger.kernel.org,
	jic23@cam.ac.uk
Subject: Re: [PATCH 10/11] iio: adc: ti-adc081c: Use devm_* APIs
References: <1374569897-3858-1-git-send-email-sachin.kamat@linaro.org> <1374569897-3858-11-git-send-email-sachin.kamat@linaro.org> <20130723153328.GB2066@dhcp-172-17-186-34.nvidia.com>
In-Reply-To: <20130723153328.GB2066@dhcp-172-17-186-34.nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/23/13 16:33, Thierry Reding wrote:
> On Tue, Jul 23, 2013 at 02:28:16PM +0530, Sachin Kamat wrote:
>> devm_* APIs are device managed and make code simpler.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> ---
>>  drivers/iio/adc/ti-adc081c.c |   18 +++++-------------
>>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> Looks good to me:
> 
> Reviewed-by: Thierry Reding <thierry.reding@gmail.com>
Applied to the togreg branch of iio.git

Thanks,
> 
