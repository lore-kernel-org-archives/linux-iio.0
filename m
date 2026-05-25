Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D61E3DD522
	for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779696717; cv=pass; b=VRies07RAnUu3M+x/40lIDXZ7y3D0F7Ih35BmqiFfcMA+ovjt5noIQnPK2I1vAptZxl1W9F+3t9EOruldDdX1lSZuiFlPv/jsZWFp7ACJ44ZBSZvtl/vzhJjF5gntiH1RPEeCAX1Hv8LnKZkSgmDtxVpw6Q8+M15MRwy4wFY8pc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779696717; c=relaxed/simple;
	bh=JXF/NtNXqIudGUVL9dq1A2Ay+iM5y8zPNP9DPstfm74=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+FMwkG3SPD2ZmWwGLSW1MNWo+dCfpgm9klEY/nUYlIUWxg+7O3/viDMf0ruMv1aWi2BAohIzK3upOZzdLIPMvd6vSU6Auq1i9diYQ1EJCehs8KNAPMq10KDs+Ps7+Xv1USeH4D8fJmNRmqfwFBGTyEHjp1Mdhh5FvR2HnSVMiQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=aJ8ThKSD; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="aJ8ThKSD"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bd4f7f05e90so1629478166b.2
        for <linux-iio@vger.kernel.org>; Mon, 25 May 2026 01:11:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779696703; cv=none;
        d=google.com; s=arc-20240605;
        b=kMLletSjJKjhAlVJ/QCmB2s91vFh96cnnhloQHMJVschoHbReFkTYwNBzbsVXEEVFU
         rapjw3Hr37UMs4oAPV54PlL+ZF/4i5IDLiPVgEuPIxv5N0fUZdQjDeh+QnXaHHWKwaCL
         P7NsO1KPkWGbU8qwD5Jq9IML0MhjK7L2BzNaN2ipXI3quQmP+U0IYL2GytjXd9ls7Trd
         6/ER69t2PFF3vSpw78BSGgCE0eM/W9F4nNRMR2Q5LCQq2O3ORugVN4SU2s00iw9Q09bI
         mD3UiMdRIy/sPvwML4rcDp+0N26MRt20a6f/xOuSXC+Fdk5RjKHeH+nNQGKSkTwYXXSS
         xp2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:dkim-signature;
        bh=YYL5Rx1E2cwUzAfwlvFTjehRWwkmIxgXyzUFXFIYTfY=;
        fh=1Zk9LrwCWNwe4+CjvA6HoXHeV41HArrDz84gAYTyHCM=;
        b=fFtoIL13BaBlpQ2JBiBXF7kc1FWm/yaWTOB9GY7q/MuWrFwH63uDrV8i53dzF2XBaT
         Lkndkdb2VkyASW0oz+QkSv1nXuSKl4a++Vp1xDyTkXnDsO7zgjI06sjy1igdCnv+ipH3
         W3GBSuA+q11HDfSabHpTJPAMevEKzpA2hJ5YGtdSwQX1EKDjH1I7dnl//b5gHHNRv3R6
         Qyn/LQ+9oyAOmwsf6NZOpF7a/6IVnHR4J2HgVrxLdH6jEx3tg47R/8YVQ/RUdR5Vh49q
         thx6/2YKMvEc1Td3iTkYNZT0gj/RQ8HpzZW+Ei7r2ofPrihJEXmKy0Ie2U0Gp69eEqWo
         kmOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779696703; x=1780301503; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YYL5Rx1E2cwUzAfwlvFTjehRWwkmIxgXyzUFXFIYTfY=;
        b=aJ8ThKSDlfJDz4gQUZghcL/iWl/OfP/QqDTU4I+/Sqzb+bDa8ZdDGEJapKXDdqg0Bc
         BEppSpnxtSPiPPg0KHXqppOY+4JHwQzVYoIx54wIW/dciCn9L9Nkiap4CwnYSOE65VsO
         pwswsUxfvRl6RwuYCfMKVhHW8IQF58NkVGEElXBYshMXJpSrHXg15yl0T3IHtYgPcgwv
         yKP7tkHRZpgWYRPuSTZDd29xlUOmAHhQjvzVQN0L0DVS1H/OahpmXhoFNkF0VibQ5/SJ
         RicQzksyM1hEoQDMrRMBgvlBUVKvDkkfOc019skQe0p+/5ciSCzdPFo1AKrB/LI7BMGM
         zMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779696703; x=1780301503;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :mail-followup-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YYL5Rx1E2cwUzAfwlvFTjehRWwkmIxgXyzUFXFIYTfY=;
        b=jgfwqaEFOVx0zK4priCcUg451+5WE02btsVmh24n0DYwGslstLpMZ82LWk4g+3J25o
         Er/Y93BBUx/uwxiZ0KMAo8kJqWjcGbB+1DG4q4EG9GXIDgNinffrmd+tMb/6cIKi0unW
         c3xkmZCvQXwKa4OROya8ZY7dF08Qc/ChiiXucwJCoav9F/okIZPqwgCf4WV3OilaHeSj
         7kgKiROCtgJf5aCL93vQYRNCOaVDS+WsmSPt5whrZDqcyjrIyCwlXqflGwINPjnRrwVU
         Lk9cxFZb3u9G6XoXcVba59ZrD82iRBJHej4gd/Mb2a+T5ob/A6k8H/RaKljAMish1g0C
         qEpA==
X-Forwarded-Encrypted: i=1; AFNElJ8zRFpOX08tldJn38/0qNiFtCyuD9F5VuJZDRjUJp7LM8EtxNRI8HEhb4jImKLlQVZ2klmqyCtzLgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGgwvzjjD0I/zVR++bVwImKPow5CJjGOfdtCUvzYE4VGHAS6jI
	yBCCNfJZj3Am+3jfzq2qwxZqDP/fUigcq0sqL6Qmk4qpuSE3JQ1D0LhvnJQ0HJ5vQC0UIO+EP1F
	OykE9PLFU+o71rZzdutvu74kizK1jinFbcpIGiobuyA==
X-Gm-Gg: Acq92OHadIS7KGocssHbwXzAG7GYtqWTR1FdMmXCwkjH8+L6Qlttr2eAzWKFnSYlRHW
	6omNa/vW+27+Mj7gXH4GdgsyqGF8qGV3KDZ8MQ9h1F5xqWadN0vpa0mD072COya/Be8FXvDsees
	8av06n3HZAfI8hAHalBqum0WAIMNqcaDYHNmF8pP3W549F9JcqlTk9XoEFIBrYzw37Mgr5zTVtE
	WzQv4kgEYGxxhYm5W6EsQG1m5Vb+H5ya5t4CnMHVOjHbCecmcgn3xHOIqiWzPiKnCmUjtu6g4vh
	j5tqt9/7avMG373n8eFBlnTUn27vrI6fM/Jd
X-Received: by 2002:a17:906:4785:b0:bcb:a95d:f745 with SMTP id
 a640c23a62f3a-bdd2503c042mr769683166b.16.1779696703345; Mon, 25 May 2026
 01:11:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 May 2026 01:11:42 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 May 2026 01:11:42 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
Mail-Followup-To: Dan Carpenter <error27@gmail.com>, 
	Angelo Dureghello <adureghello@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
References: <ahP3IjYJ87bNc1De@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ahP3IjYJ87bNc1De@stanley.mountain>
Date: Mon, 25 May 2026 01:11:42 -0700
X-Gm-Features: AVHnY4L9gYruU_LyRfiNWVRq8svGeh4BM0woEevKh5vvYGIpbUKlfHo9jW6e9Ys
Message-ID: <CALSJ-wCcZ9XNTrcvq1TabT--vA5v0gritbpfNG6n0aKRXuSiKA@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad3552r-hs: fix uninitialized data ni ad3552r_hs_write_data_source()
To: Dan Carpenter <error27@gmail.com>
Cc: Angelo Dureghello <adureghello@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dan,

On Mon, May 25, 2026 at 10:15:46AM +0300, Dan Carpenter wrote:
> If the *ppos value is non-zero then the simple_write_to_buffer() function
> won't initialized the start of the buf[] buffer.  Non-zero values for
> *ppos won't work here generally, so just test for them and return -EINVAL
> at the start of the function.
>
> Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp")
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> ---
>  drivers/iio/dac/ad3552r-hs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> index a9578afa7015..6bc64f53bce9 100644
> --- a/drivers/iio/dac/ad3552r-hs.c
> +++ b/drivers/iio/dac/ad3552r-hs.c
> @@ -549,7 +549,7 @@ static ssize_t ad3552r_hs_write_data_source(struct file *f,
>
>  	guard(mutex)(&st->lock);
>
> -	if (count >= sizeof(buf))
> +	if (*ppos != 0 || count >= sizeof(buf))
>  		return -ENOSPC;
>
>  	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
> --

thanks for the fix,

Reviewed-by: Angelo Dureghello <adureghello@baylibre.com>

it looks like this may fix an additional overflow in case ppos is near the
end of buf[].
But i am actually missing the use case when ppos is non zero, can this
happen from shell "echo" ? Or some fseek/dd is needed to trigger it ?

Thanks,
regards,
angelo



> 2.53.0
>
