Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46773 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751251AbbEDQGg (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 4 May 2015 12:06:36 -0400
Message-ID: <55474B9C.8080007@kernel.org>
Date: Mon, 04 May 2015 11:36:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Antonio Ospite <ao2@ao2.it>, linux-iio@vger.kernel.org
CC: Daniel Baluta <daniel.baluta@gmail.com>,
	Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCHv2 1/2] iio: accel: kxcjk-1013: add the "KXCJ9000" ACPI
 id
References: <1430730785-17833-1-git-send-email-ao2@ao2.it> <1430730785-17833-2-git-send-email-ao2@ao2.it>
In-Reply-To: <1430730785-17833-2-git-send-email-ao2@ao2.it>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/05/15 10:13, Antonio Ospite wrote:
> This id has been seen in the DSDT of the Teclast X98 Air 3G tablet based
> on Intel Bay Trail.
> 
> Signed-off-by: Antonio Ospite <ao2@ao2.it>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Bastien Nocera <hadess@hadess.net>
> Cc: linux-iio@vger.kernel.org
Hmm.  I'm not entirely sure what he convention on this is.  It's not
a regression fix as this never worked, so not subject to a quick send
on for this merge cycle.  It is however a new ID which is acceptable
stable material.

Anyhow, the IIO convention from now on (unless someone points me at
a more general doc that suggests something else) is to take these
for the next merge window, but mark them for stable so they propagate
down to the long term stable kernels.

So applied to the togreg branch of iio.git - initially pushed out as
testing when I'm somewhere convenient with reliable internet access.

Jonathan
> ---
>  drivers/iio/accel/kxcjk-1013.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 51da369..5b7a860 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -1418,6 +1418,7 @@ static const struct dev_pm_ops kxcjk1013_pm_ops = {
>  static const struct acpi_device_id kx_acpi_match[] = {
>  	{"KXCJ1013", KXCJK1013},
>  	{"KXCJ1008", KXCJ91008},
> +	{"KXCJ9000", KXCJ91008},
>  	{"KXTJ1009", KXTJ21009},
>  	{"SMO8500",  KXCJ91008},
>  	{ },
> 

