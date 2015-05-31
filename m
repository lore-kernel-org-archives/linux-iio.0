Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35721 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753714AbbFAVQt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 1 Jun 2015 17:16:49 -0400
Message-ID: <556B3872.8060108@kernel.org>
Date: Sun, 31 May 2015 17:36:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: Re: [PATCH 11/32] tools:iio:generic_buffer: pass up right error code
References: <15952408423424396a4ace1522055e17da4afc80.1433072539.git.knaack.h@gmx.de> <5de1f1440a05a62bac6ecbddb63bd2de97583e20.1433072539.git.knaack.h@gmx.de>
In-Reply-To: <5de1f1440a05a62bac6ecbddb63bd2de97583e20.1433072539.git.knaack.h@gmx.de>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 31/05/15 13:39, Hartmut Knaack wrote:
> find_type_by_name() returns a valid error code in case of an error. Pass
> this code up instead of an artificial one.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
Applied.
> ---
>  tools/iio/generic_buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/iio/generic_buffer.c b/tools/iio/generic_buffer.c
> index 7e6f3f1..a3cf8e3 100644
> --- a/tools/iio/generic_buffer.c
> +++ b/tools/iio/generic_buffer.c
> @@ -202,7 +202,7 @@ int main(int argc, char **argv)
>  	dev_num = find_type_by_name(device_name, "iio:device");
>  	if (dev_num < 0) {
>  		printf("Failed to find the %s\n", device_name);
> -		ret = -ENODEV;
> +		ret = dev_num;
>  		goto error_ret;
>  	}
>  	printf("iio device number being used is %d\n", dev_num);
> @@ -228,7 +228,7 @@ int main(int argc, char **argv)
>  		trig_num = find_type_by_name(trigger_name, "trigger");
>  		if (trig_num < 0) {
>  			printf("Failed to find the trigger %s\n", trigger_name);
> -			ret = -ENODEV;
> +			ret = trig_num;
>  			goto error_free_triggername;
>  		}
>  		printf("iio trigger number being used is %d\n", trig_num);
> 

