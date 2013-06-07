Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:42462 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755226Ab3FGLYl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 7 Jun 2013 07:24:41 -0400
Message-ID: <51B1C2E8.4040904@denx.de>
Date: Fri, 07 Jun 2013 13:24:24 +0200
From: Stefan Roese <sr@denx.de>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
	gregkh@linuxfoundation.org, jic23@cam.ac.uk, jic23@kernel.org
Subject: Re: [PATCH 1/1] staging: iio: spear_adc: Add missing CONFIG_OF macro
References: <1370603161-10992-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1370603161-10992-1-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/07/2013 01:06 PM, Sachin Kamat wrote:
> The data structure is required only when DT is enabled.
> Hence compile it conditionally.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Stefan Roese <sr@denx.de>

Acked-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

