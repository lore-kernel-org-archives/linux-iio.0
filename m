Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC0A3C5DD2
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 10:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773917256; cv=none; b=TNCDn6NYIooX1a0acNcxJId0gd/jg35T7egrgz1z7Iug8wNEaq9PAIZVaxKFzWdUdSEeUZ8eft4zapvbCcDtxg7jN3GnXhTG02WlE/cMebaDbg7JlT+9sywemWGardzur+UcnJ9Aw/OEeVusDEUF6XJTfpvni9tlb2t77lF1vw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773917256; c=relaxed/simple;
	bh=hDdHmp6y0sm7eYwGhDoXVFIrc14YpS33mX0ynVrnTHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QvqsxLiSinsnFPmwwqZKCoyoq+BWegwH6GGF1HpDbSm3SKvP7ODR4FFoBwtkCqs7Bh/6q89f4OpNGS03t+CeCyUPIQNms1Fv3rerBXXdiD4zRFxik6LVCgYvyhCzYnWWemU/CfeUePI9Wek4EfiaXeCY4fuZ9A5uSivTBcdma68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2h3vGTB; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2h3vGTB"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-356337f058aso310635a91.2
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 03:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773917255; x=1774522055; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4NgBBVmgJFvWTdpx/sZIjxnQnfSfkQj1lwQk3RKd+LM=;
        b=J2h3vGTBeIEHBt49z5f4YU+RGVw4Nbi0wVQ6jRs2/emhQX2ZzkkVFiZvnv8DQWeK3t
         +un6JvBkUYguw1+n4Ibm6jaU9HLLUe9R7y2P16IjHjDWf55ycfSzP8xbenuegiUYG/5V
         5JSg5S3UWoIhkvmXByPaUyzy0nkY/4BC0kal05Sju4erLnoswEWTgwKJGylw9uH+yvPr
         pgILPB6mLeL0CB92xtsrxQfKWELnUGlc3k1X40zCVZiH54oa35vnmq1PBLKLf2S4vSGS
         /wUWnvPhOOTs8207BFeaqps0etvH+N0/M9OOak0q2uqno5WrDVGVpTqEZE5iZ4L48oeO
         8x4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773917255; x=1774522055;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4NgBBVmgJFvWTdpx/sZIjxnQnfSfkQj1lwQk3RKd+LM=;
        b=rYnEcEG35dbUcuWn2UyLMerzVZMpPE2YfCvUKp0b6XY9qANf/QN9vzQ/4KbcDmjQFm
         +Suk1MI+TL6J7O3b8PolU/PyO3bn/kitb76xY/x/duB9xWjQaw7iFqL1f/SwPqHHb8tG
         nW+eU0R4g/7J9xgPn65wWRPeOlCcQGW8eEXdHWQXqBuy7BYSAVAWp3B3XVPwA76lbKP2
         Vaed/RW9vK1q7jgsOfMZs+RUNG/zzinft2sTgqnFon1FVmGXYcmqoPxG0EfS83FLxzha
         iInu6dsx3DZhTsyNqELCgRRaRqDmBUbH6NErO5NcYNkR7zy4nXKPKqaSwaCXAOLxnD0p
         Nf6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXp3q0VKQeyrpTpfV8bSUIxMCm5UH/7KvPCGvqEpyxptIuUkeGF6KXH8p4D4oMRJxe12fVaK53iPKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY3Co+4qosk3YRgNXsownpxNGh4V0HMpUH6h4rnbU6CISO1dhs
	YOfC8MTRQN2Zp7vzDdhdu9gl3ghA7bwyk4uTNbhE3HMH8tHjeONFAWmA
X-Gm-Gg: ATEYQzy/yJEY15VQL5g7gkOmOe7HnRVLp/2wifUh5A65qgbH4UpNp/emeZuIi0pZ1Xj
	3UHJdYaHur3wFQKo+qiKAC0cIEirswm88RtLFORLFepeytVQyM6/L3pJAVikiQA1ghxo9TTaZYV
	MKprPLKRWMTrcFAd//COAK79iq3gKBVbKNujeYB3emzOOUoF3hQrjJ1LkwP8W5B+niAuhZJiLkh
	O5qqXFbYkKDiWmihSVIVVrn9X9so9q917k0Pf8gDFEOBUWl3owBRk/vCWMVqaXL1HYN3jyz3Jfz
	P+oh9nsVHmzkY0IxksWOGUnGZUgO/vb8Lgd7hBzLOGF4/pkc0MOyaqUnfMlq3R/hr8/c2lTp9P1
	KvtVcbS87Rbav9erGTpgVzDbKMWu2QDbvtWMLoSqHlgdkbyA50RZfdZxw84dMBh3WrQ5zHT7+Dj
	TSOmrEu47VIk7MDAcZOqpiOy1OIricJRo=
X-Received: by 2002:a17:90b:510f:b0:35b:945d:752a with SMTP id 98e67ed59e1d1-35bb9ef607cmr5986302a91.17.1773917254700;
        Thu, 19 Mar 2026 03:47:34 -0700 (PDT)
Received: from [192.168.0.106] ([103.216.213.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c741e0b3c43sm5073500a12.4.2026.03.19.03.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 03:47:34 -0700 (PDT)
Message-ID: <cda6e549-271e-451b-a266-218d5af0ffc0@gmail.com>
Date: Thu, 19 Mar 2026 16:17:27 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] iio: adc: replace deprecated
 iio_push_to_buffers_with_timestamp()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, marcelo.schmitt@analog.com, mazziesaccount@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260316172735.11430-1-atharvd440@gmail.com>
 <20260316172735.11430-2-atharvd440@gmail.com>
 <abhgZkJu4ERvmS_S@ashevche-desk.local>
Content-Language: en-US
From: Atharv Dubey <atharvd440@gmail.com>
In-Reply-To: <abhgZkJu4ERvmS_S@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andy,

On 3/17/26 01:26, Andy Shevchenko wrote:
> On Mon, Mar 16, 2026 at 10:57:26PM +0530, Atharv Dubey wrote:
>> Hello ,
>>
>> The helper iio_push_to_buffers_with_timestamp() is deprecated in the IIO
>> subsystem. The recommended replacement is
>> iio_push_to_buffers_with_ts().
>>
>> This patch series updates multiple ADC drivers to use the newer helper
>> API. No functional changes are intended; the patches only replace the
>> deprecated calls and adjust arguments where required.
>>
>> The goal is to remove usage of the deprecated helper and keep the
>> drivers aligned with the current IIO buffer interface.
> You need to do this very carefully.
> Besides that your email thread is broken:
> - you have sent 2 time cover letter
> - the patches 10 and 11 are detached from email thread.
>
> On top of that there is wrong indentation in many places.
> I recommend you to choose something less tricky to begin
> with.
>
>   

I'll recitfy these mistakes and perhaps send a smaller patch for the 
same. If you have some more simpler things in mind , please let me know. 
I'll be happy to help out.

Regards,
Atharv

