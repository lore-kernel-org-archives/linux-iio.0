Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mo-p05-ob.rzone.de ([81.169.146.181]:58353 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080Ab3FFJvq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Jun 2013 05:51:46 -0400
Message-ID: <51B05BA7.1010002@denx.de>
Date: Thu, 06 Jun 2013 11:51:35 +0200
From: Stefan Roese <sr@denx.de>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: devel@driverdev.osuosl.org, linux-iio@vger.kernel.org,
	gregkh@linuxfoundation.org, jic23@cam.ac.uk
Subject: Re: [PATCH 2/3] staging: iio: spear_adc: Remove redundant platform_set_drvdata()
References: <1370510844-23603-1-git-send-email-sachin.kamat@linaro.org> <1370510844-23603-2-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1370510844-23603-2-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/06/2013 11:27 AM, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Stefan Roese <sr@denx.de>

Acked-by: Stefan Roese <sr@denx.de>

Thanks,
Stefan

