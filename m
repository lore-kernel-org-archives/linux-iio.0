Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B419C546
	for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 19:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773517549; cv=none; b=t3lnMWvte/RxH16vAZevFtrOeQHcOIjiW61NSSG1k5V5BcX2Vl9bP0KqQkE40b0B5x2ofwok3jlkTZ6+MxZaO/LCMri7k3+RxMO+1XfNFAIxeif3HBhX5eVDNfGqVDAQdi8P1++NPetQVdUPEQ5yePNeZBnhJ9uMm9G2pZIoZko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773517549; c=relaxed/simple;
	bh=gxR5I/Cw7ri4X7gacYfnt6UdXddao9DjKdfjPmi9+Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3R9pues38qUImceaMnrKQOwErWjUebzigOqnqw+NRAGs+BF7LvUjzUCoCzG0/hJrIBKpkmYQ4n/IPPcYJVolfLaq7AIixXudquAQEPku4JwLfyF56qfBb4fwfFGLEYTOllogWXw5FgXmZ6QGk/42N3vgsEaku8Ku4BV8WacpWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HIYgHjo4; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HIYgHjo4"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-466ec4c6852so2142805b6e.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Mar 2026 12:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773517546; x=1774122346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u0MLNTB4XLLA60/5fVGsQSATrXUs6qS3+xDBwwtavMs=;
        b=HIYgHjo4z2LlZGpFjKxCRqT9Pyz8lgbed/nx3QOEQNonIK9SWQ5FOPCuO6bGH3jQ7r
         fSgpvb8Qqy8fqPyaGYTOf2folON6OcBtPScqlaLooKzHYti/aQxMbNCyCd/HC/r8PTFM
         78CzzMn+vnssZjPFXILitQL5V5KkPrtglDqQck8Yy5b+x93OW1/EYlouHyQq761kWP9f
         uoj4wh965ctvYkOjXdFQWhVdn7rIloZTPaWi6mTVUf2c3/qqrtrCqtitFQMp2LnnJjSC
         kNMdDGAfumQGeEXw9F5WKhD3+Ji/ZWkJbTEYeP4FEl5hL/LgZbHoVPUIwYfkhM4amlY4
         SKhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773517546; x=1774122346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u0MLNTB4XLLA60/5fVGsQSATrXUs6qS3+xDBwwtavMs=;
        b=e6Y3I1k77vN1GVF0gJkCIg1EadMKLIfpFvaExuFF2H8VXAWB8ouK1nVPRBKbyW13C0
         8K3bcqYSyw+MPzcxjBnUc3mg/h4Go2xcASpQs2i200I/DtT3fL6DEO/P+uNcU5JCrZTk
         dXyVko2sG63rsgQ1iMGk6pTrcXQjJT4dPGcBV20RTpS8fFy8IWdLiIWo1VYPR2WXLQn6
         vvEK/1sZ1a9AtW4chdLC7qnnFm6Hv1qVX0/0hU8skzigpnXuCjhq3NZlHXOjmmk4I+YY
         EGV8g1NgQAPTDkRXzhZ2H+S4ne+RPuXRtWjVSu6PJAB5GHO9yIbdw03qyjZbkDnTtAQg
         uI6A==
X-Gm-Message-State: AOJu0YwEt/Pm1FrIJPnGyqSJtHcOHDn96U4Yq/agqn1P86TKnmwKJgEI
	auk04WPttLtPAtNSq/BmXYDVstZ6EMcygcvnIGnQiEdu50H2TBs7/yFVIfKtttvZrvM=
X-Gm-Gg: ATEYQzzEhhC3b44MdoaBzKdkmhZ32A9pA7CXoHqfyGwGg837QAVZzBV5EtCPH8gomYQ
	NZH8VBNwyLZOacGQxipD2ekOHBXNBRzbxSt7JvTrqCizPQd+V4FxbYbDn/vH5k6ico95xS20U/R
	gPutiM66leRpiYhJm/4/41/ltbfeNMl4S9Y6CmjWdOfofiTH8L8vEsAEvOBDZaCs3hDUftGduT9
	6do/7I1onqyVZqWeTdNu9UMwwPhMRJ5GdAWSm7VU7gVrEEiBMSxk3X234MK0vdE6SB5skhtTAcw
	zLITLGLl7rLJYqRL7Vyqm8rafCMdK6exCjYnITAjZmHlwd4JdQMNgbA7GGsbrRVR1QZi1xGzzoh
	NBxxVTAjmar6pviqOkcF3E9Y5E4fHELnP9rmBbX/PYB6c5T9tuoHkVjL3xe1ZVctoFT+gyc81vh
	vKfHLxMd6f7eds3TcHzeIKbeIf0Q9JFR9XDQXzm8Idqz8qY/FLx0TvR/RXckU+AQkB46fP0vLby
	g==
X-Received: by 2002:a05:6808:5291:b0:467:2a6e:adb3 with SMTP id 5614622812f47-4675713d63amr3911579b6e.23.1773517546490;
        Sat, 14 Mar 2026 12:45:46 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:14a9:db6c:e65a:4287? ([2600:8803:e7e4:500:14a9:db6c:e65a:4287])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e6c7885sm10950936fac.17.2026.03.14.12.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2026 12:45:45 -0700 (PDT)
Message-ID: <bc6c21a0-e324-471a-917b-bf0c3d34d504@baylibre.com>
Date: Sat, 14 Mar 2026 14:45:44 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] iio: accel: sca3000: convert to guard(mutex)
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>, jic23@kernel.org,
 nuno.sa@analog.com, andy@kernel.org, waqar.hameed@axis.com,
 linusw@kernel.org, sakari.ailus@linux.intel.com,
 harshit.m.mogalapalli@oracle.com, antoniu.miclaus@analog.com,
 andrew.ijano@gmail.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260314170609.26827-1-rajveer.chaudhari.linux@gmail.com>
 <20260314170609.26827-9-rajveer.chaudhari.linux@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260314170609.26827-9-rajveer.chaudhari.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/26 12:06 PM, Rajveer Chaudhari wrote:
> Replace manual mutex_lock/mutex_unlock pair with guard(mutex) in
> sca3000_print_rev(), sca3000_ring_int_process(),
> sca3000_read_event_config(), __sca3000_hw_ring_state_set(),
> sca3000_hw_ring_preenable(), sca3000_hw_ring_postdisable(),
> sca3000_clean_setup(), sca3000_stop_all_interrupts().
> This ensures the mutex is released on all return paths and
> allows returning directly without a goto label.
> 
> Signed-off-by: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
> ---

...

> @@ -1132,24 +1131,18 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
>  		 */
>  		if ((st->rx[0] & SCA3000_REG_MODE_MODE_MASK)
>  		    != SCA3000_REG_MODE_MEAS_MODE_MOT_DET) {

can drop this { now.

> -			ret = 0;
> -		} else {
> -			ret = sca3000_read_ctrl_reg(st,
> -						SCA3000_REG_CTRL_SEL_MD_CTRL);
> -			if (ret < 0)
> -				goto error_ret;
> -			/* only supporting logical or's for now */
> -			ret = !!(ret & sca3000_addresses[chan->address][2]);
> +			return 0;
>  		}
> -		break;
> +
> +		ret = sca3000_read_ctrl_reg(st,
> +					SCA3000_REG_CTRL_SEL_MD_CTRL);
> +		if (ret < 0)
> +			return ret;
> +		/* only supporting logical or's for now */
> +		return !!(ret & sca3000_addresses[chan->address][2]);
>  	default:
> -		ret = -EINVAL;
> +		return -EINVAL;
>  	}
> -
> -error_ret:
> -	mutex_unlock(&st->lock);
> -
> -	return ret;
>  }
>  
