Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-043.synserver.de ([212.40.185.43]:1045 "EHLO
	smtp-out-043.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531AbbAUKTU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 21 Jan 2015 05:19:20 -0500
Message-ID: <54BF7D24.5090009@metafoo.de>
Date: Wed, 21 Jan 2015 11:19:16 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: varkabhadram@gmail.com, linux-iio@vger.kernel.org
CC: jic23@kernel.org, Varka Bhadram <varkab@cdac.in>
Subject: Re: [PATCH iio 1/3] imu: inv_mpu6050: use devm_request_irq
References: <1421819977-32232-1-git-send-email-varkabhadram@gmail.com>
In-Reply-To: <1421819977-32232-1-git-send-email-varkabhadram@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/21/2015 06:59 AM, varkabhadram@gmail.com wrote:
[...]
>   void inv_mpu6050_remove_trigger(struct inv_mpu6050_state *st)
>   {
>   	iio_trigger_unregister(st->trig);
> -	free_irq(st->client->irq, st->trig);
>   	iio_trigger_free(st->trig);

You are changing the relative order between free_irq() and 
iio_trigger_free() here and by doing so introduce a use-after-free race 
condition. The IRQ handler uses the trigger, so the IRQ has to be released 
before the trigger is freed.

This can be easily fixed though by changing the order of patch 1 and patch 2 
in this series.



