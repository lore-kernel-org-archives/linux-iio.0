Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37574 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbeKEAKV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Nov 2018 19:10:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id p6-v6so3181308pll.4
        for <linux-iio@vger.kernel.org>; Sun, 04 Nov 2018 06:55:05 -0800 (PST)
Date: Sun, 4 Nov 2018 20:24:56 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: Slawomir Stepien <sst@poczta.fm>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v5 1/1] staging: iio: adc: ad7280a: use devm_* APIs
Message-ID: <20181104145456.GA13773@himanshu-Vostro-3559>
References: <20181104104900.13997-1-sst@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20181104104900.13997-1-sst@poczta.fm>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, Nov 04, 2018 at 11:49:00AM +0100, Slawomir Stepien wrote:
> devm_* APIs are device managed and make code simpler.
> 
> Signed-off-by: Slawomir Stepien <sst@poczta.fm>
> ---

[]

> Since v4:
> * on devm_add_action fail, call the action on error handling

For such a use case, `devm_add_action_or_reset()` seems like a better
candidate.

> +	ret = devm_add_action(&spi->dev, ad7280_sw_power_down, st);
> +	if (ret) {
> +		ad7280_sw_power_down(st);
> +		return ret;
> +	}

Also, you can suppress the `1/1` in sunject [PATCH v5 1/1] by passing
`-N` flag to `git format-patch`.


-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
