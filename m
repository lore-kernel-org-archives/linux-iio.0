Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-oa0-f52.google.com ([209.85.219.52]:55460 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934Ab3HTNr7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 20 Aug 2013 09:47:59 -0400
Received: by mail-oa0-f52.google.com with SMTP id n12so738517oag.11
        for <linux-iio@vger.kernel.org>; Tue, 20 Aug 2013 06:47:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <521272FA.8050904@kernel.org>
References: <1376912305-6423-1-git-send-email-sachin.kamat@linaro.org>
	<1376912305-6423-10-git-send-email-sachin.kamat@linaro.org>
	<521272FA.8050904@kernel.org>
Date: Tue, 20 Aug 2013 19:17:59 +0530
Message-ID: <CAK9yfHxprhocZLN9AkLivQ9=p_h4fWQkpSHh5pNbFZnqFZNwwQ@mail.gmail.com>
Subject: Re: [PATCH 10/14] iio: dac: ad5755: Use devm_iio_device_alloc
From: Sachin Kamat <sachin.kamat@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	jic23@cam.ac.uk
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20 August 2013 01:03, Jonathan Cameron <jic23@kernel.org> wrote:
> On 08/19/13 12:38, Sachin Kamat wrote:
>> Using devm_iio_device_alloc makes code simpler.
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> I made an ever so tiny mod in this one before applying.
> Don't like the removal of the white space before the return
> in the remove function.  Guessing you didn't mean to do that.

Must be due to an oversight from my side. Thanks for fixing and applying.


-- 
With warm regards,
Sachin
