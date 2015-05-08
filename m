Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52561 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932187AbbEHSa0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 8 May 2015 14:30:26 -0400
Message-ID: <554CD0AA.1030705@kernel.org>
Date: Fri, 08 May 2015 11:05:14 -0400
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] iio: hid-sensor-press: Constify platform_device_id
References: <1430495618-31807-1-git-send-email-k.kozlowski.k@gmail.com> <1430495618-31807-9-git-send-email-k.kozlowski.k@gmail.com>
In-Reply-To: <1430495618-31807-9-git-send-email-k.kozlowski.k@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/05/15 11:53, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Whole series applied to the togreg branch of iio.git.  This will
get pushed out as testing for the autobuilders to play with it
(tomorrow probably).

Jonathan
> ---
>  drivers/iio/pressure/hid-sensor-press.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
> index 7bb8d4c1f7df..f3305d80c0b8 100644
> --- a/drivers/iio/pressure/hid-sensor-press.c
> +++ b/drivers/iio/pressure/hid-sensor-press.c
> @@ -362,7 +362,7 @@ static int hid_press_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static struct platform_device_id hid_press_ids[] = {
> +static const struct platform_device_id hid_press_ids[] = {
>  	{
>  		/* Format: HID-SENSOR-usage_id_in_hex_lowercase */
>  		.name = "HID-SENSOR-200031",
> 

