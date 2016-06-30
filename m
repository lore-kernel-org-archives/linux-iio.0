Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43232 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752480AbcF3TgW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2016 15:36:22 -0400
Subject: Re: [PATCH 4/6 v3] iio: magn: ak8975: allow a delay after enabling
 regulators
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1467202118-10386-1-git-send-email-linus.walleij@linaro.org>
 <1467202118-10386-5-git-send-email-linus.walleij@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Gwendal Grignou <gwendal@chromium.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4f998b8b-a76d-4b68-a40f-871196c6c1c9@kernel.org>
Date: Thu, 30 Jun 2016 20:36:20 +0100
MIME-Version: 1.0
In-Reply-To: <1467202118-10386-5-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/06/16 13:08, Linus Walleij wrote:
> The datasheet actually specifies that we need to wait atleast
> 500us after powering on the device before trying to set mode.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied. thanks
> ---
> ChangeLog v2->v3:
> - Rebase
> ChangeLog v1->v2:
> - No changes.
> ---
>  drivers/iio/magnetometer/ak8975.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index f72f51d1f3f5..c67cf3a6128d 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -399,6 +399,12 @@ static int ak8975_power_on(const struct ak8975_data *data)
>  			 "Failed to enable specified Vid supply\n");
>  		return ret;
>  	}
> +	/*
> +	 * According to the datasheet the power supply rise time i 200us
> +	 * and the minimum wait time before mode setting is 100us, in
> +	 * total 300 us. Add some margin and say minimum 500us here.
> +	 */
> +	usleep_range(500, 1000);
>  	return 0;
>  }
>  
> 

