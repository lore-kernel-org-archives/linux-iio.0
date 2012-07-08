Return-Path: <jic23@kernel.org>
Message-ID: <4FF94BCF.5090205@kernel.org>
Date: Sun, 08 Jul 2012 09:58:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Peter Meerwald <pmeerw@pmeerw.net>,
 Jonathan Cameron <jic23@cam.ac.uk>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: Introduce iio_validate_scan_mask_onehot
References: <1341233083-8765-1-git-send-email-lars@metafoo.de> <1341233083-8765-2-git-send-email-lars@metafoo.de> <alpine.DEB.2.01.1207021451180.26435@pmeerw.net> <4FF19E69.9040009@metafoo.de>
In-Reply-To: <4FF19E69.9040009@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/02/2012 02:13 PM, Lars-Peter Clausen wrote:
> On 07/02/2012 02:52 PM, Peter Meerwald wrote:
>>
>>> Add a helper function for validating a scan mask for devices where at most one
>>> channel may be selected at a time. This is a common case among devices which
>>> have scan mask restrictions so it makes sense to provide this function in the
>>> core.
>>
>> personally, would find iio_validate_scan_mask_atmost_one clearer than
>> iio_validate_scan_mask_onehot, but it is a bit longer also
> 
> I think the code can even be changed to be more strict and just check if
> bitmap_weight == 1. A mask is only validating after enabling a channel and
> not after disabling it, so there will always be at least one bit set when
> the validate function is called.
Any of the above is fine with me.  I like this patch set as is, but if
you want to change things feel free!  Either way let me know.
> 
> - Lars
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
