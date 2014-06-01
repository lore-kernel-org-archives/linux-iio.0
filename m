Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-124.synserver.de ([212.40.185.124]:1315 "EHLO
	smtp-out-124.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751346AbaFAJP1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 1 Jun 2014 05:15:27 -0400
Message-ID: <538AEF16.5070904@metafoo.de>
Date: Sun, 01 Jun 2014 11:15:02 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
CC: Jonathan Cameron <jic23@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad_sigma_delta.c:  Cleaning up uninitialized
 variables
References: <1401577904-4764-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
In-Reply-To: <1401577904-4764-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/01/2014 01:11 AM, Rickard Strandqvist wrote:
> There is a risk that the variable will be used without being initialized.
>
> This was largely found by using a static code analysis program called cppcheck.

This looks like a false positive. And if it was not a false positive the 
correct fix certainly is not to initialize the variable to some random value 
to silence the warning.

- Lars

