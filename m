Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:55691 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933386AbeCGQnS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 7 Mar 2018 11:43:18 -0500
Subject: Re: [PATCH] iio: ad7793: implement IIO_CHAN_INFO_SAMP_FREQ
To: Michael Nosthoff <committed@heine.so>, linux-iio@vger.kernel.org
References: <43f7cfe7bf868fb00e81a76246b9bc3a@heine.so>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <f90c4698-15bf-ce11-ded9-f00b6ac0a263@metafoo.de>
Date: Wed, 7 Mar 2018 17:43:16 +0100
MIME-Version: 1.0
In-Reply-To: <43f7cfe7bf868fb00e81a76246b9bc3a@heine.so>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/2018 05:17 PM, Michael Nosthoff wrote:
> This commit is a follow-up to changes made to ad_sigma_delta.h
> in staging: iio: ad7192: implement IIO_CHAN_INFO_SAMP_FREQ
> which broke ad7793 as it was not altered to match those changes.
> 
> This driver predates the availability of IIO_CHAN_INFO_SAMP_FREQ
> attribute wherein usage has some advantages like it can be accessed by
> in-kernel consumers as well as reduces the code size.
> 
> Therefore, use IIO_CHAN_INFO_SAMP_FREQ to implement the
> sampling_frequency attribute instead of using IIO_DEV_ATTR_SAMP_FREQ()
> macro.
> 
> Move code from the functions associated with IIO_DEV_ATTR_SAMP_FREQ()
> into respective read and write hooks with the mask set to
> IIO_CHAN_INFO_SAMP_FREQ.
> 
> Signed-off-by: Michael Nosthoff <committed@heine.so>

Hi,

Thanks for fixing this. Patch looks good. We should add the fixes tag to the
commit messages, so it gets picked up for the right stable branches.

Fixes: a13e831fcaa7 ("staging: iio: ad7192: implement IIO_CHAN_INFO_SAMP_FREQ")

Other than that just one minor comment inline.

[...]
> +    case IIO_CHAN_INFO_SAMP_FREQ:
> +        if (!val) {
> +            ret = -EINVAL;
> +            break;
> +        }
> +
> +        for (i = 0; i < 16; i++)
> +            if (val == st->chip_info->sample_freq_avail[i])
> +                break;
> +
> +        if (i == 16) {
> +            ret = -EINVAL;
> +            break;
> +        }
> +
> +        st->mode &= ~AD7793_MODE_RATE(-1);
> +        st->mode |= AD7793_MODE_RATE(i);
> +        ad_sd_write_reg(&st->sd, AD7793_REG_MODE, sizeof(st->mode), st->mode);
> +        ret = 0;

I don't think the ret = 0 is needed here, it should already be 0. But of
course it does not hurt either.

> +        break;
>     default:
>         ret = -EINVAL;
>     }
> -- 
> 2.7.4
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

