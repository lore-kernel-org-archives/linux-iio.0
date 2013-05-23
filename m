Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45440 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757920Ab3EWOzz (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 23 May 2013 10:55:55 -0400
Date: Thu, 23 May 2013 16:55:40 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-iio@vger.kernel.org, jic23@cam.ac.uk, jic23@kernel.org
Subject: Re: [PATCH 1/1] iio: at91_adc: Add missing CONFIG_OF macro
Message-ID: <20130523145540.GH8595@lukather>
References: <1369286787-8448-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1369286787-8448-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Sachin,

On Thu, May 23, 2013 at 10:56:27AM +0530, Sachin Kamat wrote:
> The data structure is required only when DT is enabled.
> Hence compile it conditionally.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Thanks!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
