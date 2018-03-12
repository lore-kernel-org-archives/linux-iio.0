Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:52501 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751104AbeCLM4I (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Mar 2018 08:56:08 -0400
Subject: Re: [PATCH 2/2] iio: adc: ad7791: implement IIO_CHAN_INFO_SAMP_FREQ
To: Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org
Cc: michael.hennerich@analog.com, jic23@kernel.org
References: <20180312120654.1806-1-alexandru.ardelean@analog.com>
 <20180312120654.1806-2-alexandru.ardelean@analog.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <8c3ee9d4-fc17-653e-ab4e-94ca2bffc50c@metafoo.de>
Date: Mon, 12 Mar 2018 13:56:06 +0100
MIME-Version: 1.0
In-Reply-To: <20180312120654.1806-2-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/12/2018 01:06 PM, Alexandru Ardelean wrote:
[...]
> +		for (i = 0; i < ARRAY_SIZE(ad7791_sample_freq_avail); i++) {
> +			if (ad7791_sample_freq_avail[i][0] == val &&
> +			    ad7791_sample_freq_avail[i][1] == val2)
> +				break;
> +		}

Unrelated to this patch. But we should really add a helper function for
looking up entries in these val,val2 arrays.

[...]

