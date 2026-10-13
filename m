Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD353DD86F
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 16:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909932; cv=none; b=cGkE/COtikCtkoTuN6uz4v3jtQRTc9GPf0xdsuTo/G5Yz8JwUir3VQc4JWmxkB2+I4+AYditdTryROukFxxc9dvFcNCWYz3GgsXIUIFDQiFihVODAs/Bmrqe+ptAH4iCZV7HV95KsS+2pCZujm1TcXZvGPS282J/ckHEUD9pWvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909932; c=relaxed/simple;
	bh=2jPCHhQYXRl27PTSjxxKiq+mBhD4g/zPuIPHha3DcoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VfvNTLXb5wUrdIAJDctccMNuCKLvDXFmMrqDBrWipHM6bK4Ex7Bw1nariAfexsbx6cxT9KLm/Iqwcio5nD5ot0mm9zMZwWe3tr9EqWMn3ejRskGV7skmT5iuzCNiyeDlLlgDuTkZfxcIXXUqfBBCF6do7tq9Wm3A2h6DAJZ9d/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lx2bpbEc; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lx2bpbEc"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc758830601so32627a12.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 09:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791909930; x=1792514730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QtZ5PzT+iVNvU2u5JnqRMNxH/iEEZQesxZqimXqa8Xs=;
        b=lx2bpbEckBxUwJceLTvCH5fPGnUIecKhaKFsbNIoGRcSxQ/3hY2Wd5NhQr7KVYrs3x
         9oRS9ImHOQDgAWlWoQ5rBh3zJbpGxuaKYrh7GKnQolVAryOrW7ouikVRKF//qWepMmTU
         9zEMv1g3ra0c6bVUUGzMd20cBOkrlpbtnMwWkXoAO9+jqEfQbgFrkhhTjKtTgSIOmt2g
         cA0txFwWliyQ62jyZByAvRFwREAGzCKIaMr/I0DoiJZcMpLVV0hI0nxG046jwuL02Zpt
         cQ0YHkubuPqfZc6aVWrxnoGBD0jiq6sFmEnCCi2qqu16Y3moNqh+tMAIZLGpGdOgTRC+
         mZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791909930; x=1792514730;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QtZ5PzT+iVNvU2u5JnqRMNxH/iEEZQesxZqimXqa8Xs=;
        b=dmGDFh/Y1PzMwG9bczMNi5f8UGYRiyyiyE+DSWPrFH8Ph92LVg45SH3tu4lzs6dCiB
         EoLC+wv3/iuzpq6hehB6QMi3CxgilZNi+Lo1H7x1ikz3B5+RM2AHKa+AdmeUr8o6F5f4
         wZ+AKSCMF5qYDgIqhI9MECvD7b6IO5ZHARRu073pso/FSQKYygWhT37eYuAUDRV1BPyz
         hsSnC2KYQZXUrWWMHFlC9z68AVzAdqAMvmGNrw5A9M7rRFUuBu08Qk6FdJHKJMYspJb5
         Z3/io2i/tYfeTV5rpufOIWROoQcF8DsKD8gjYuRz8gJ5SvPivUpZttr/YrhuXzaqw1TR
         9P3w==
X-Gm-Message-State: AFq9FYJ50HU7gl20057zUqb0HhvB8tw3BRIomo+IsaX4tjfHN5A+zdnX
	mnxU2b3Aq1bXUH9oot5DHoUQNTQKK/EmZtbRjtOHQP0TOVz3ASW9zis=
X-Gm-Gg: AYBFou2ZFQyArKFRVTPnZpgzQnD6nSpje2vbuk6Nygo890DE0AAPhPCfEkL6d99RA34
	pG4Wcnw4IiuaOgGdASPt638kmvVf8Ipj1nnpgrD3kkKLUUuFNYx7L2lDhkEDTvkOHJORdTA6gTV
	M3jhZxSRWZC2yLn4k8dNKknNb+T/eNPDC1OrBruhVI2cO/SM62jfrcFsQG3/rxb6MgcVwbrolDS
	CvrBlMJELDhX4MjtU8U6I6HumnCCjcFS9z5Vi1YqRJGTaZBOz9e5vfbvRIJXwLFQ6efQy0TJkgm
	nJgi8zrPRqtdPECaL5UQA1+4cheJqfrt3sfYTB6GC8JQrov5dm3HJt4OfaGf1XThaVDCvvNDHZ+
	CQrnl6Lj7Y57YVCOBNsC60zyekqAQodmPNAnGU2zrkOh3kwZlK+c69984T/cSnaybhPIb+510bz
	tLOECsqX4z1knVYZL+VAI3cTDrvFSTdwQZQgFQA++oUrgvN7ox4miTd+UkeuSWfafHs0uw6eM4v
	jXkDnnR0MIVO0WDehYyUcCD4vGNcIfhqJ24e+XOu6A=
X-Received: by 2002:a05:6a20:d492:b0:3cd:3e77:1dcd with SMTP id adf61e73a8af0-3e16bade0eamr11806760637.1.1791909930228;
        Tue, 13 Oct 2026 09:45:30 -0700 (PDT)
Received: from [192.168.1.45] ([101.0.62.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd3d9e26ddfsm5695150a12.17.2026.10.13.09.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 09:45:28 -0700 (PDT)
Message-ID: <ab328578-08a6-455d-a9bf-411aeb561c8c@gmail.com>
Date: Tue, 13 Oct 2026 22:15:23 +0530
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iio: atlas-ezo: Fix humidity channel read support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
References: <20261012114553.3327-1-nikhilgtr@gmail.com>
 <20261012114553.3327-2-nikhilgtr@gmail.com>
 <as1G0yGQ5wKhd-dh@ashevche-desk.local>
Content-Language: en-US
From: Nikhil Gautam <nikhilgtr@gmail.com>
In-Reply-To: <as1G0yGQ5wKhd-dh@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Joshua, Andy,

Thanks for the review and feedback.

I checked the Git history and found that the channel type check was 
already present
in commit dc3ebfc ("iio: chemical: atlas-ezo-sensor: add humidity sensor 
support").
It was not removed when humidity sensor support was introduced, and
I couldn't find any commit message explaining the original intent of the 
check.

Regarding the potential I2C read issue reported by Sashiko,
I'll investigate it and address it in a separate patch series.

I'll also omit the cover letter for future single-patch submissions.

Thanks,
Nikhil

On 13-10-2026 02:15 am, Andy Shevchenko wrote:
> On Mon, Oct 12, 2026 at 05:15:53PM +0530, Nikhil Gautam wrote:
>> The atlas_ezo_read_raw() function rejects channels that are not of
>> type IIO_CONCENTRATION, preventing the relative humidity channel
>> from reading raw and scale values.
>>
>> Remove the early channel type check to allow both concentration
>> and relative humidity channels to reach the mask-specific handling.
> Have you checked the Git history on this change? Anything interesting there?
>

