Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96AE3E1212
	for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759577; cv=none; b=LyR2jf/dQeXU0gphrbNQ5gZx+Jw/wsEe/Sn5wE9/ddKic4e4gHEDQdN5oMvLwWeGr+6H1oeGTWhWmgurILeZFdvaxgmCCXdHid1NJdLE5y33c/Jw3Myq8mTy2K25MNFkPvuMWuBAi7W2+wlGh8qyjeTc5Ejb/OYAEDdRl9av4V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759577; c=relaxed/simple;
	bh=rUTojCZuqPlbT8TmP1stlKMR0/7wIMn4bg1YzKidpcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7kDy9fo+QVJRTBnowgujXivWn9jJ/fhtR8Vpd0lS0Fx1K9mayuh2YU6gn1+frT2H2GYeJ+Z1EiT50QSGHdM4CeaEdqFrd9cX+N8eB/o7/OOtr/PT/C7AA7nBGseL8QLYMspyf04AwjnMHOJy5sLag9EnhP9sVSOOhaE2YjE99Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=J1ZmXgt8; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J1ZmXgt8"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4671cbce2feso2459184b6e.3
        for <linux-iio@vger.kernel.org>; Tue, 17 Mar 2026 07:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773759574; x=1774364374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZVSDrbvwel6uKQw3+Tq7/00i6DjO3Jc9G+zPvWgsFbI=;
        b=J1ZmXgt8H4wl8SfJ+xJGJrmJiwwTPLwtDCdwGS07Wax4bHYn3Tf2GiMdIFAhpWVLOv
         Yma+n25khK6OcV2/uf/Az3w+p7FlK/GkeRhkj0uMbTjnHmwVp7SGOcDKb4tAeW2NC5Fp
         XMitc+eWilL1hINGUEtk3o1bRl18vkNW078hTV8BoBhSJ3QWcm3qeVi/6K15zDfAbZ36
         GeL8QyzLamXOR7PEbnK44GoHyZeypJRBVntw9NB6l5EHo9GyeSYwMo4aOKrw46cIt/Jw
         Hytt8CIlua3Z4JRT5UF4t5AsCha4NXZ9obOKi4TzO7huocqB1EhcD6fqEMjTCULwDzrY
         zOyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773759574; x=1774364374;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZVSDrbvwel6uKQw3+Tq7/00i6DjO3Jc9G+zPvWgsFbI=;
        b=H+AvjqEfxubTbf6/bB26F0NyIAQ15F037zm4PutukvwCnrOXxx3k91O1/jraTTJ2Ez
         JVSJS2HlrAyc+acvzbZOvHmTCSVHSJlTRk7f3D8Y5DY0Mi3EdF0fpkh11lvv/E2Qm8QD
         6d3X8fAudtIE8T4HjIX8Yow+XCQDcXqCrg1fAscI+xhD5p1XDmcdKGGlmOMUfTwxcW4h
         NcQZ8CiuTejvC9+5sxIpnqXljg7l1SrCOx8HjfxRUQHw/oq83uxdS4Ib1zpBE9VfsMLP
         pl6KwPx6+2w3IYOcu9T9wRUbRqx7iI40qTDVzu5cVCj6VX8XCxTMkw5g2UJiHCEjW629
         6eiQ==
X-Gm-Message-State: AOJu0YwDsRYkH5iCrOue+NcLSPMx0U5FetraLA/+ghwr6IQXv5+Oe/8Y
	JV3sjtMdx36Yj7TzdVgcL9AbquFVBU1IMbS2Ed9OWf+BzGX8s3rdH4ilr0mSFkVVNYQ=
X-Gm-Gg: ATEYQzzZDIrsvktjPKOhY0MgKDPRea7TRyak3GVBXH6lpZUUUnUa7xEoiDu1uWo8pWn
	hbjDLO3m2k+BNaTIMwIJ1h15OftYi/pXkiuuNV/wsKcRntTQrT2n5159Br8ct5qkFpkcXLb0TmE
	MYDZ2/NzlXTmW1kyW3aPDutRkhSE7KkMASe/XTE2rjkKZqdMGZS8o4YmN5+ZDeiMmF0nmlbt2s1
	HPpcaRgdjEglGKVIDrGXRKl7KM98txW9cBtIIv4oBDoQpNgQxxYiZ1Y98adtCm6XuL5YBmrm49e
	BUQ7EVXNL3qHDuHxQrIQEHKxuEnsJgIeaH5WS5u6/Fny48edCpNW9oRH1SpFcc63Fxeea391WO0
	56C1Vs2mhGlMOy42JuIzXmLjNR88/ilJlZr/75V5LUnvhlW/XBkJ8L7m/+yRbh9KpgsvojKQ9Ki
	WRKg7keXWTiVyRjhRyubyRUsuMoxB7nTcq2Uug7EAeEyjI5gRaN4u+HBHs+GCqy5h4VGR00oo=
X-Received: by 2002:a05:6808:179a:b0:467:3f4:9077 with SMTP id 5614622812f47-4675752d2ebmr9803196b6e.51.1773759574496;
        Tue, 17 Mar 2026 07:59:34 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:6995:28aa:eeda:102? ([2600:8803:e7e4:500:6995:28aa:eeda:102])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4177e5e94b4sm18335102fac.11.2026.03.17.07.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 07:59:34 -0700 (PDT)
Message-ID: <968b4ae6-23cb-40fd-942c-66b82ae14544@baylibre.com>
Date: Tue, 17 Mar 2026 09:59:33 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] iio: iio-mux: use flexible array member
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Rosen Penev <rosenp@gmail.com>
Cc: linux-iio@vger.kernel.org, Peter Rosin <peda@axentia.se>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260316232942.46641-1-rosenp@gmail.com>
 <abkCIJ-u7s3OVhfm@ashevche-desk.local>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <abkCIJ-u7s3OVhfm@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/26 2:26 AM, Andy Shevchenko wrote:
> On Mon, Mar 16, 2026 at 04:29:42PM -0700, Rosen Penev wrote:
>> Make it clear that there's trailing data
>>
>> Removes a pointer from the struct.
>>
>> Use array_size for the sizeof calculations. Slightly cleaner.
> 
> array_size()
> sizeof()
> 
> This commit message is poorly written. Please, consult with
> https://chris.beams.io/git-commit on how to write better commit
> messages.
> 
> ...
> 
>> struct mux {
> 
>>  	struct iio_channel *parent;
>>  	struct iio_chan_spec *chan;
>>  	struct iio_chan_spec_ext_info *ext_info;
>> -	struct mux_child *child;
>>  	u32 delay_us;
>> +	struct mux_child child[];
>>  };
> 
> What's the point now to make it VLA? Again, why this and not the other one?

I agree with Andy here. It doesn't make much sense to use a variable length
array for one when there are other similar arrays in the same struct.


> 
> ...
> 
>>  	mux = iio_priv(indio_dev);
>> -	mux->child = (struct mux_child *)(mux + 1);
>>  	mux->chan = (struct iio_chan_spec *)(mux->child + children);
> 
> (This piece linked to the above comment.)
> 

