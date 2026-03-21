Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714EC4317D
	for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 17:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114017; cv=none; b=ecGhCnRdAOTxQLxWyMiDvQiOXac5lOShegnmQ5vpHve+Ifb4snC9AxarB3GMMhaNsrV5x4d+HyftD0t1VG25KW7wym7z3f3atXGKaCVoqtHrEoS5Q5cbJvuUrwsrBKU9AlH4rCgbLpjx+/mBmxQHW6IUkrtvc7VihFRs4tieOY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114017; c=relaxed/simple;
	bh=8STvlffSBOFcVuETJ7aD/euRLRUQcoW2XYRd7Uv8q2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rw/WSU36tyg+VMJBFfwLMLCXgS2vJUd/qSmzXWBjjbC5jE5JLKx2MDSMIepzOGgxvA/ueBbswmVtOb/iDJdy53Drs3GirnF5WeMxT/L5PQhttDgi0nxp5JQ8q1RVJrExUyZ4plVsLdNQIyvGrXiVsZNmfpVgllTmhEu+le5zJKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=jyGJRSol; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jyGJRSol"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-466ec4c6846so505515b6e.3
        for <linux-iio@vger.kernel.org>; Sat, 21 Mar 2026 10:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774114015; x=1774718815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2bz3NefBzCP8NZ5pL6LLQOXoF/AjuC/CvvoJNzpwfLk=;
        b=jyGJRSolAzqQqwQfGLp1fTMKlU6v6bbofBCGQ6bTzTSp7f/MQkvRmosf96E7DukNaT
         Q1DxXkl98QR8PeAAOs3duUwNYjzNW68fBWUv6Q+14BTTrKFM4SrGQoCL9p5tXPOVNxNf
         leHUH99bdj2KkhmclYFSdIF0dlWAZMqVsNd73eLRHNthcJyo3o9kMd2dwnyzOZPeCdNT
         RdY9WQA238hUqGWYLSR7oYAD8y/9AJ+VSvPJkDuJ7b502JfEW82qVubtcrZo+bpP05sA
         vvSuuWN6zua4rZnaVQRFGAf1oNmUTlqB9mN64/v7Oq3HOUOQxtY1mB9gGChJqlS38gjm
         hH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774114015; x=1774718815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2bz3NefBzCP8NZ5pL6LLQOXoF/AjuC/CvvoJNzpwfLk=;
        b=eT8BAug/2Q4ESM3vXqplt1qsLhkDXEE+H9VFwELIv965/YSzpMSOtMoZCvNFYw3nCB
         BoVtA6lhA0JTZ+MOsz1gqRVMHDrkt4xPRSgyrgilJd6hPE9VBAVtVaP/824HuGo/tHvh
         FG68tKOAY28E2t6vYxmSLcm9paRPo4wbTdVmrQJsqeerMcklgZ/8WdDq+OuExlvMcoQP
         5XGOIWgSOIIUrBi3jJbqicjVF7qBp50K54jH/Z0dv0HgAT2u4esy7IWYvmYCS0mtjs6c
         YOcAMeHE1BNNVywRZMPiOt6e7dgwR6jlWSlD8ENlDJiLPW7MepGJVxbAQ85sUev/mxB8
         a9fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWTX9D6+VBCSm8REM0mR0GSe0Hev7Y2gHu8e52VRFFhjyic5yLmUrlRQUXw749fQHsWhUTHPG0SCA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZE1OA5wh47d2Kjbzw+Kdmmgnc5TW1jsC4n7z7Q+H2AR9I6V20
	i35l+MnPfQQwWioe8t2kXPuTIrcqMeWZTIAhiM6ygTrORjIPROwweKLMwXfcCZMGQew=
X-Gm-Gg: ATEYQzxY2pxwkidA7TNTd3h0iBrLVsuDxcZIikkVcnHP85zV8oRrpKQtXbi7eaOeD7E
	85ItqheX8GxkxFYh+9bRT20aThL0KdoZODCyBBVp0SEQ1eHLvAIksc4D5/b+Hyqik3+D0zQCOWR
	YSbRwvBVQnpJKUQACYIrrgae0Y5cjmqCpfG8Kt2L7eGBCdqbyXw1fDJq0VbeNNq9GNeLhSKZTpE
	WUAqDUNR07YgmkP+C/VyZC55Zdx4Z6DWtPRdLwyhjvxVwKd4nCKxiajV2JJRtqYu0YjioLyp2yI
	ZBeUIP/t7P0RxOp/VvtkoCvrARlDGo/LD0eF2bDn46kGmLgVr4oSvWd7NLG4H41P9bPohZXo6tM
	KqC7URe0Sn0s6+D+i0I7ljuAxG9Uo2YFui/gHKBbb8B/yrJl9ALxvpLgQ42k/yjnZbPxAdL2+oI
	0qX6MLM0oxMGasYVu6Gh4UfzojPGPMOlZsyXFyaPyWxiEUCDZrU72et61lPFp44CkhS0RqG2HeJ
	g==
X-Received: by 2002:a54:4397:0:b0:466:fac7:d717 with SMTP id 5614622812f47-467e5fe67aamr3156733b6e.55.1774114015339;
        Sat, 21 Mar 2026 10:26:55 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:8e89:f58e:e4e6:5567? ([2600:8803:e7e4:500:8e89:f58e:e4e6:5567])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-467e7ecaf2esm3713570b6e.10.2026.03.21.10.26.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Mar 2026 10:26:53 -0700 (PDT)
Message-ID: <1413cabe-f08c-48cc-b4d5-975790225f08@baylibre.com>
Date: Sat, 21 Mar 2026 12:26:52 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/6] iio: tools: Add support for floating-point types
 in buffer scan elements
To: Francesco Lavra <flavra@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260317150316.3878107-1-flavra@baylibre.com>
 <20260317150408.3878335-1-flavra@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260317150408.3878335-1-flavra@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/26 10:04 AM, Francesco Lavra wrote:
> A subsequent commit will add floating-point support to the ABI; enhance
> the iio_generic_buffer tool to be able to parse this new data format.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  tools/iio/iio_generic_buffer.c | 59 ++++++++++++++++++++++++++++++----
>  tools/iio/iio_utils.c          |  8 ++---
>  tools/iio/iio_utils.h          |  4 +--
>  3 files changed, 58 insertions(+), 13 deletions(-)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index bc82bb6a7a2a..a21552c2b190 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -26,6 +26,7 @@
>  #include <string.h>
>  #include <poll.h>
>  #include <endian.h>
> +#include <float.h>
>  #include <getopt.h>
>  #include <inttypes.h>
>  #include <stdbool.h>
> @@ -89,7 +90,7 @@ static void print1byte(uint8_t input, struct iio_channel_info *info)
>  	 */
>  	input >>= info->shift;
>  	input &= info->mask;
> -	if (info->is_signed) {
> +	if (info->format == 's') {

To be consistent, maybe change this one to a switch case too and print
an error if we accidentally have a 1-byte float format.

>  		int8_t val = (int8_t)(input << (8 - info->bits_used)) >>
>  			     (8 - info->bits_used);
>  		printf("%05f ", ((float)val + info->offset) * info->scale);
> @@ -112,12 +113,28 @@ static void print2byte(uint16_t input, struct iio_channel_info *info)
>  	 */
>  	input >>= info->shift;
>  	input &= info->mask;
> -	if (info->is_signed) {
> +	switch (info->format) {
> +	case 's': {
>  		int16_t val = (int16_t)(input << (16 - info->bits_used)) >>
>  			      (16 - info->bits_used);
>  		printf("%05f ", ((float)val + info->offset) * info->scale);
> -	} else {
> +		break;
> +	}
> +	case 'u':
>  		printf("%05f ", ((float)input + info->offset) * info->scale);
> +		break;
> +#if defined(__FLT16_MAX__)
> +	case 'f': {
> +		union {
> +			uint16_t u;
> +			_Float16 f;
> +		} converter;
> +
> +		converter.u = input;
> +		printf("%05f ", ((float)converter.f + info->offset) * info->scale);
> +		break;
> +	}

Should we have #else here and print an error if it isn't supported?

> +#endif
>  	}
>  }
>  
> @@ -135,12 +152,26 @@ static void print4byte(uint32_t input, struct iio_channel_info *info)
>  	 */
>  	input >>= info->shift;
>  	input &= info->mask;
> -	if (info->is_signed) {
> +	switch (info->format) {
> +	case 's': {
>  		int32_t val = (int32_t)(input << (32 - info->bits_used)) >>
>  			      (32 - info->bits_used);
>  		printf("%05f ", ((float)val + info->offset) * info->scale);
> -	} else {
> +		break;
> +	}
> +	case 'u':
>  		printf("%05f ", ((float)input + info->offset) * info->scale);
> +		break;
> +	case 'f': {
> +		union {
> +			uint32_t u;
> +			float f;
> +		} converter;
> +
> +		converter.u = input;
> +		printf("%05f ", (converter.f + info->offset) * info->scale);
> +		break;
> +	}
>  	}
>  }
>  
> @@ -158,7 +189,8 @@ static void print8byte(uint64_t input, struct iio_channel_info *info)
>  	 */
>  	input >>= info->shift;
>  	input &= info->mask;
> -	if (info->is_signed) {
> +	switch (info->format) {
> +	case 's': {
>  		int64_t val = (int64_t)(input << (64 - info->bits_used)) >>
>  			      (64 - info->bits_used);
>  		/* special case for timestamp */
> @@ -167,8 +199,21 @@ static void print8byte(uint64_t input, struct iio_channel_info *info)
>  		else
>  			printf("%05f ",
>  			       ((float)val + info->offset) * info->scale);
> -	} else {
> +		break;
> +	}
> +	case 'u':
>  		printf("%05f ", ((float)input + info->offset) * info->scale);
> +		break;
> +	case 'f': {
> +		union {
> +			uint64_t u;
> +			double f;
> +		} converter;
> +
> +		converter.u = input;
> +		printf("%05f ", (converter.f + info->offset) * info->scale);
> +		break;
> +	}
>  	}
>  }
>  
> diff --git a/tools/iio/iio_utils.c b/tools/iio/iio_utils.c
> index c5c5082cb24e..f1d58db69942 100644
> --- a/tools/iio/iio_utils.c
> +++ b/tools/iio/iio_utils.c
> @@ -70,7 +70,7 @@ int iioutils_break_up_name(const char *full_name, char **generic_name)
>  
>  /**
>   * iioutils_get_type() - find and process _type attribute data
> - * @is_signed: output whether channel is signed
> + * @format: output channel format
>   * @bytes: output how many bytes the channel storage occupies
>   * @bits_used: output number of valid bits of data
>   * @shift: output amount of bits to shift right data before applying bit mask
> @@ -83,7 +83,7 @@ int iioutils_break_up_name(const char *full_name, char **generic_name)
>   *
>   * Returns a value >= 0 on success, otherwise a negative error code.
>   **/
> -static int iioutils_get_type(unsigned int *is_signed, unsigned int *bytes,
> +static int iioutils_get_type(char *format, unsigned int *bytes,
>  			     unsigned int *bits_used, unsigned int *shift,
>  			     uint64_t *mask, unsigned int *be,
>  			     const char *device_dir, int buffer_idx,
> @@ -162,7 +162,7 @@ static int iioutils_get_type(unsigned int *is_signed, unsigned int *bytes,
>  			else
>  				*mask = (1ULL << *bits_used) - 1ULL;
>  
> -			*is_signed = (signchar == 's');
> +			*format = signchar;

Should we also rename signchar to formatchar?

>  			if (fclose(sysfsfp)) {
>  				ret = -errno;
>  				fprintf(stderr, "Failed to close %s\n",
> @@ -487,7 +487,7 @@ int build_channel_array(const char *device_dir, int buffer_idx,
>  			if ((ret < 0) && (ret != -ENOENT))
>  				goto error_cleanup_array;
>  
> -			ret = iioutils_get_type(&current->is_signed,
> +			ret = iioutils_get_type(&current->format,
>  						&current->bytes,
>  						&current->bits_used,
>  						&current->shift,
> diff --git a/tools/iio/iio_utils.h b/tools/iio/iio_utils.h
> index 663c94a6c705..8c72f002d050 100644
> --- a/tools/iio/iio_utils.h
> +++ b/tools/iio/iio_utils.h
> @@ -32,7 +32,7 @@ extern const char *iio_dir;
>   * @shift: amount of bits to shift right data before applying bit mask
>   * @mask: a bit mask for the raw output
>   * @be: flag if data is big endian
> - * @is_signed: is the raw value stored signed
> + * @format: format of the raw value
>   * @location: data offset for this channel inside the buffer (in bytes)
>   **/
>  struct iio_channel_info {
> @@ -46,7 +46,7 @@ struct iio_channel_info {
>  	unsigned shift;
>  	uint64_t mask;
>  	unsigned be;
> -	unsigned is_signed;
> +	char format;
>  	unsigned location;
>  };
>  

