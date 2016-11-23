Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:39085 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935712AbcKWLdq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 23 Nov 2016 06:33:46 -0500
Message-ID: <1479900792.17782.10.camel@perches.com>
Subject: Re: [PATCH] Staging: iio: adc: fix sysfs files modes in ad7192.c
From: Joe Perches <joe@perches.com>
To: Boyan Vladinov <nayobix@nayobix.org>, gregkh@linuxfoundation.org,
        lars@metafoo.de, Michael.Hennerich@analog.com
Cc: linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date: Wed, 23 Nov 2016 03:33:12 -0800
In-Reply-To: <1479885914-17615-1-git-send-email-nayobix@nayobix.org>
References: <1479885914-17615-1-git-send-email-nayobix@nayobix.org>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 2016-11-22 at 23:25 -0800, Boyan Vladinov wrote:
> Fixes sysfs entries user/group modes and coding style warnings
> found by checkpatch.pl tool
[]
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
[]
>  static ssize_t ad7192_show_ac_excitation(struct device *dev,
> @@ -412,11 +412,11 @@ static ssize_t ad7192_set(struct device *dev,
>  	return ret ? ret : len;
>  }
>  
> -static IIO_DEVICE_ATTR(bridge_switch_en, S_IRUGO | S_IWUSR,
> +static IIO_DEVICE_ATTR(bridge_switch_en, 0444 | 0200,

If you are going to submit S_<FOO> -> octal conversions,
please collapse the multiple octal values into one value

0444 | 0200 => 0644

