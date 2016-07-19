Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60622 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbcGSP64 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 19 Jul 2016 11:58:56 -0400
Subject: Re: Fwd: [PATCH] iio: accel: kxcjk-1013: add the "KIOX000A" ACPI id
To: Christophe Chapuis <chris.chapuis@gmail.com>,
	linux-iio@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <CACA7eURhTD8RzGOoYciOEp_oC2iuy+197gS7M3qnMhAEiH=v8A@mail.gmail.com>
 <CACA7eUSu8yY+0F_Dy+RE5magv+erZRZNO-ydNmvN8c5rT87SfA@mail.gmail.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4ca42ff1-7222-b0a4-daad-e591bc2892be@kernel.org>
Date: Tue, 19 Jul 2016 16:58:52 +0100
MIME-Version: 1.0
In-Reply-To: <CACA7eUSu8yY+0F_Dy+RE5magv+erZRZNO-ydNmvN8c5rT87SfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/07/16 11:01, Christophe Chapuis wrote:
> On the Cube i9 tablet, the ACPI id for the Kionix kxcj9 accelerometer
> is "KIOX000A" (as can be seen in the DSDT of the Cube i9 tablet).
> It is the same accelerometer, so only adding the ACPI id is needed.
> 
> Signed-off-by: Christophe Chapuis <chris.chapuis@gmail.com>
Hi Christophe,

Looks like it made it through fine this time!

Please cc the original driver author for any patches to a driver. Here
Srinivas (added)
Can't see why it would be an issue, but best to make sure thy are in the loop!

Funnily enough, not everyone keeps up with all the mails on the list ;)
> ---
>  drivers/iio/accel/kxcjk-1013.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index edec1d0..cf392c7 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1393,6 +1393,7 @@ static const struct acpi_device_id kx_acpi_match[] = {
>      {"KXCJ1013", KXCJK1013},
>      {"KXCJ1008", KXCJ91008},
>      {"KXCJ9000", KXCJ91008},
> +    {"KIOX000A", KXCJ91008},
>      {"KXTJ1009", KXTJ21009},
>      {"SMO8500",  KXCJ91008},
>      { },
> 

