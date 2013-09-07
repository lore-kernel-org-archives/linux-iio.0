Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:58199 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812Ab3IGUFf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Sep 2013 16:05:35 -0400
Message-ID: <522B9528.9000104@kernel.org>
Date: Sat, 07 Sep 2013 22:05:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@linaro.org>
CC: linux-iio@vger.kernel.org, lars@metafoo.de,
	"J. August Brenner" <jbrenner@taosinc.com>
Subject: Re: [PATCH 10/12] staging: iio: tsl2x7x_core: Use devm_* APIs
References: <1378373397-22919-1-git-send-email-sachin.kamat@linaro.org> <1378373397-22919-10-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378373397-22919-10-git-send-email-sachin.kamat@linaro.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/05/13 10:29, Sachin Kamat wrote:
> devm_* APIs are device managed and make code simpler.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: J. August Brenner <jbrenner@taosinc.com>
Applied
